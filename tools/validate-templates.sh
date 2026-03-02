#!/usr/bin/env bash
set -euo pipefail

# validate-templates.sh — Validate template repos against template-manifest.yaml
#
# Usage:
#   tools/validate-templates.sh              # Validate all targets
#   tools/validate-templates.sh --target root  # Validate one target
#
# Checks performed:
#   1. Completeness — all copy/scaffold rules have matching files in targets
#   2. Drift — copy-action files in targets match workspace source
#   3. Scaffold — scaffold-action files in targets match scaffold source
#   4. Leakage — no workspace-specific content in template repos
#   5. Structure — required directories and files exist

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_DIR="$(dirname "$SCRIPT_DIR")"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

ERRORS=0
WARNINGS=0

pass() { echo -e "  ${GREEN}✓${NC} $1"; }
fail() { echo -e "  ${RED}✗${NC} $1"; ERRORS=$((ERRORS + 1)); }
warn() { echo -e "  ${YELLOW}⚠${NC} $1"; WARNINGS=$((WARNINGS + 1)); }

# ─── Parse arguments ──────────────────────────────────────
TARGET_FILTER=""
for arg in "$@"; do
  case "$arg" in
    --target)   shift; TARGET_FILTER="${1:-}" ;;
    --target=*) TARGET_FILTER="${arg#*=}" ;;
    -h|--help)
      echo "Usage: tools/validate-templates.sh [--target <id>]"
      exit 0
      ;;
  esac
done

# ─── Read manifest ────────────────────────────────────────
MANIFEST="$WORKSPACE_DIR/template-manifest.yaml"
if [[ ! -f "$MANIFEST" ]]; then
  echo -e "${RED}ERROR: template-manifest.yaml not found${NC}"
  exit 1
fi

SCAFFOLD_DIR=$(grep '^scaffold-dir:' "$MANIFEST" | awk '{print $2}' | tr -d '"' | tr -d "'")
SCAFFOLD_DIR="${SCAFFOLD_DIR%/}"

# Parse targets
declare -a TARGET_IDS=()
declare -a TARGET_PATHS=()

in_targets=false
while IFS= read -r line; do
  if [[ "$line" =~ ^targets: ]]; then in_targets=true; continue; fi
  if $in_targets && [[ "$line" =~ ^[a-z] ]] && [[ ! "$line" =~ ^[[:space:]] ]]; then
    in_targets=false; continue
  fi
  if $in_targets; then
    if [[ "$line" =~ ^[[:space:]]*-[[:space:]]*id:[[:space:]]*(.*) ]]; then
      TARGET_IDS+=("${BASH_REMATCH[1]}")
    fi
    if [[ "$line" =~ ^[[:space:]]*path:[[:space:]]*(.*) ]]; then
      TARGET_PATHS+=("${BASH_REMATCH[1]}")
    fi
  fi
done < "$MANIFEST"

# Parse rules
declare -a RULE_PATTERNS=()
declare -a RULE_ACTIONS=()
declare -a RULE_TARGETS=()

in_rules=false
current_pattern=""
current_action=""
current_targets=""

flush_rule() {
  if [[ -n "$current_pattern" ]]; then
    RULE_PATTERNS+=("$current_pattern")
    RULE_ACTIONS+=("${current_action:-ignore}")
    RULE_TARGETS+=("${current_targets:-all}")
    current_pattern=""
    current_action=""
    current_targets=""
  fi
}

while IFS= read -r line; do
  if [[ "$line" =~ ^rules: ]]; then in_rules=true; continue; fi
  if ! $in_rules; then continue; fi
  stripped="${line#"${line%%[![:space:]]*}"}"
  if [[ -z "$stripped" ]] || [[ "$stripped" == \#* ]]; then continue; fi
  if [[ "$line" =~ ^[[:space:]]*-[[:space:]]*pattern:[[:space:]]*\"(.*)\" ]]; then
    flush_rule
    current_pattern="${BASH_REMATCH[1]}"
  elif [[ "$line" =~ ^[[:space:]]*action:[[:space:]]*(.*) ]]; then
    current_action="${BASH_REMATCH[1]}"
  elif [[ "$line" =~ ^[[:space:]]*targets:[[:space:]]*\[(.*)\] ]]; then
    current_targets="${BASH_REMATCH[1]}"
  fi
done < "$MANIFEST"
flush_rule

# ─── Glob matching ───────────────────────────────────────
matches_glob() {
  local filepath="$1"
  local pattern="$2"
  if [[ "$pattern" == *"**"* ]]; then
    local regex="${pattern//\*\*/DOUBLEWILD}"
    regex="${regex//\*/[^/]*}"
    regex="${regex//DOUBLEWILD/.*}"
    regex="^${regex}$"
    [[ "$filepath" =~ $regex ]]
  else
    [[ "$filepath" == $pattern ]]
  fi
}

MATCH_ACTION=""

find_rule() {
  local filepath="$1"
  local target_id="$2"
  MATCH_ACTION=""
  for i in "${!RULE_PATTERNS[@]}"; do
    if matches_glob "$filepath" "${RULE_PATTERNS[$i]}"; then
      local rule_targets="${RULE_TARGETS[$i]}"
      if [[ "$rule_targets" != "all" ]]; then
        if [[ ! "$rule_targets" =~ (^|,)[[:space:]]*$target_id[[:space:]]*(,|$) ]]; then
          continue
        fi
      fi
      MATCH_ACTION="${RULE_ACTIONS[$i]}"
      return
    fi
  done
}

# ─── Enumerate workspace files ────────────────────────────
enumerate_workspace_files() {
  {
    find "$WORKSPACE_DIR" \
      -path "$WORKSPACE_DIR/repos" -prune -o \
      -path "$WORKSPACE_DIR/scaffolds" -prune -o \
      -path "$WORKSPACE_DIR/.tmp" -prune -o \
      -path "$WORKSPACE_DIR/.git" -prune -o \
      -path "$WORKSPACE_DIR/archive" -prune -o \
      -path "$WORKSPACE_DIR/node_modules" -prune -o \
      -type f -print
    find "$WORKSPACE_DIR/repos" -maxdepth 1 -type f 2>/dev/null || true
    find "$WORKSPACE_DIR/sandbox" -maxdepth 1 -type f 2>/dev/null || true
  } | sed "s|$WORKSPACE_DIR/||" | sort -u
}

# ─── Check 1: Completeness ───────────────────────────────
check_completeness() {
  local tid="$1"
  local tpath="$2"
  local missing=0

  while IFS= read -r filepath; do
    find_rule "$filepath" "$tid"
    if [[ -n "$MATCH_ACTION" ]] && [[ "$MATCH_ACTION" != "ignore" ]]; then
      local dst="$WORKSPACE_DIR/$tpath/$filepath"
      if [[ ! -f "$dst" ]]; then
        fail "MISSING in $tid: $filepath (action: $MATCH_ACTION)"
        missing=$((missing + 1))
      fi
    fi
  done < <(enumerate_workspace_files)

  if [[ $missing -eq 0 ]]; then
    pass "All propagated files present in $tid"
  fi
}

# ─── Check 2: Drift (copy-action files match source) ─────
check_drift() {
  local tid="$1"
  local tpath="$2"
  local drifted=0

  while IFS= read -r filepath; do
    find_rule "$filepath" "$tid"
    if [[ "$MATCH_ACTION" == "copy" ]]; then
      local src="$WORKSPACE_DIR/$filepath"
      local dst="$WORKSPACE_DIR/$tpath/$filepath"
      if [[ -f "$src" ]] && [[ -f "$dst" ]]; then
        if ! diff -q "$src" "$dst" > /dev/null 2>&1; then
          fail "DRIFT in $tid: $filepath differs from workspace source"
          drifted=$((drifted + 1))
        fi
      fi
    fi
  done < <(enumerate_workspace_files)

  if [[ $drifted -eq 0 ]]; then
    pass "No copy-action drift in $tid"
  fi
}

# ─── Check 3: Scaffold match ─────────────────────────────
check_scaffolds() {
  local tid="$1"
  local tpath="$2"
  local drifted=0

  while IFS= read -r filepath; do
    find_rule "$filepath" "$tid"
    if [[ "$MATCH_ACTION" == "scaffold" ]]; then
      local dst="$WORKSPACE_DIR/$tpath/$filepath"
      if [[ ! -f "$dst" ]]; then continue; fi

      # Resolve scaffold source
      local src=""
      if [[ -f "$WORKSPACE_DIR/$SCAFFOLD_DIR/$tid/$filepath" ]]; then
        src="$WORKSPACE_DIR/$SCAFFOLD_DIR/$tid/$filepath"
      elif [[ -f "$WORKSPACE_DIR/$SCAFFOLD_DIR/common/$filepath" ]]; then
        src="$WORKSPACE_DIR/$SCAFFOLD_DIR/common/$filepath"
      fi

      if [[ -n "$src" ]] && ! diff -q "$src" "$dst" > /dev/null 2>&1; then
        warn "SCAFFOLD DRIFT in $tid: $filepath differs from scaffold source"
        drifted=$((drifted + 1))
      fi
    fi
  done < <(enumerate_workspace_files)

  if [[ $drifted -eq 0 ]]; then
    pass "No scaffold drift in $tid"
  fi
}

# ─── Check 4: Leakage ────────────────────────────────────
check_leakage() {
  local tid="$1"
  local tpath="$2"
  local target_dir="$WORKSPACE_DIR/$tpath"
  local leaked=0

  # Patterns that indicate workspace-specific content leaked into templates
  local patterns=(
    "GENERATED by tools/render-instructions.sh"
    "_agentic-system"
  )

  for pattern in "${patterns[@]}"; do
    local hits
    hits=$(grep -rl "$pattern" "$target_dir" \
      --include="*.md" --include="*.yaml" --include="*.sh" \
      2>/dev/null | grep -v 'validate-templates\.sh$' || true)
    if [[ -n "$hits" ]]; then
      while IFS= read -r hitfile; do
        local relpath="${hitfile#$target_dir/}"
        fail "LEAKAGE in $tid: '$pattern' found in $relpath"
        leaked=$((leaked + 1))
      done <<< "$hits"
    fi
  done

  if [[ $leaked -eq 0 ]]; then
    pass "No workspace-specific content leakage in $tid"
  fi
}

# ─── Check 5: Structure ──────────────────────────────────
check_structure() {
  local tid="$1"
  local tpath="$2"
  local target_dir="$WORKSPACE_DIR/$tpath"

  # Required directories for all workspace templates
  local required_dirs=(".github" ".github/agents" ".github/instructions" ".github/prompts" ".claude" "docs" "tools")
  for dir in "${required_dirs[@]}"; do
    if [[ ! -d "$target_dir/$dir" ]]; then
      fail "Missing directory in $tid: $dir"
    fi
  done

  # Required files
  local required_files=(".github/copilot-instructions.md" "CLAUDE.md" "workspace.config.yaml" "CONTRIBUTING.md" "LICENSE")
  for file in "${required_files[@]}"; do
    if [[ ! -f "$target_dir/$file" ]]; then
      fail "Missing file in $tid: $file"
    fi
  done

  # Target-specific checks
  if [[ "$tid" == "root" ]]; then
    if [[ ! -d "$target_dir/repos" ]]; then
      fail "Missing repos/ directory in root template"
    fi
  fi

  pass "Structure check complete for $tid"
}

# ─── Main ────────────────────────────────────────────────
cd "$WORKSPACE_DIR"

echo "Template Validation (manifest-based)"
echo "====================================="

for t in "${!TARGET_IDS[@]}"; do
  tid="${TARGET_IDS[$t]}"
  tpath="${TARGET_PATHS[$t]}"

  if [[ -n "$TARGET_FILTER" ]] && [[ "$tid" != "$TARGET_FILTER" ]]; then
    continue
  fi

  if [[ ! -d "$WORKSPACE_DIR/$tpath" ]]; then
    fail "Target path not found: $tpath"
    continue
  fi

  echo ""
  echo "=== $tid ($tpath) ==="

  check_completeness "$tid" "$tpath"
  check_drift "$tid" "$tpath"
  check_scaffolds "$tid" "$tpath"
  check_leakage "$tid" "$tpath"
  check_structure "$tid" "$tpath"
done

echo ""
echo "====================================="
if [[ $ERRORS -gt 0 ]]; then
  echo -e "${RED}FAILED: $ERRORS errors, $WARNINGS warnings${NC}"
  exit 1
elif [[ $WARNINGS -gt 0 ]]; then
  echo -e "${YELLOW}PASSED with $WARNINGS warnings${NC}"
  exit 0
else
  echo -e "${GREEN}PASSED: All checks succeeded${NC}"
  exit 0
fi
