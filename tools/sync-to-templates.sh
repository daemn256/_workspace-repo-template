#!/usr/bin/env bash
set -euo pipefail

# sync-to-templates.sh — Sync workspace files to template repos per template-manifest.yaml
#
# Usage:
#   tools/sync-to-templates.sh              # Sync all targets
#   tools/sync-to-templates.sh --dry-run    # Show what would change without writing
#   tools/sync-to-templates.sh --target root  # Sync only the 'root' target
#
# Reads template-manifest.yaml for propagation rules and copies/scaffolds
# files into the template repos checked out under repos/.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_DIR="$(dirname "$SCRIPT_DIR")"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
DIM='\033[2m'
NC='\033[0m'

log_info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error()   { echo -e "${RED}[ERROR]${NC} $1"; }
log_dry()     { echo -e "${DIM}[DRY-RUN]${NC} $1"; }

# ─── Parse arguments ──────────────────────────────────────
DRY_RUN=false
TARGET_FILTER=""

for arg in "$@"; do
  case "$arg" in
    --dry-run)  DRY_RUN=true ;;
    --target)   shift; TARGET_FILTER="${1:-}" ;;
    --target=*) TARGET_FILTER="${arg#*=}" ;;
    -h|--help)
      echo "Usage: tools/sync-to-templates.sh [--dry-run] [--target <id>]"
      exit 0
      ;;
    *) ;;
  esac
done

# ─── Validate manifest ───────────────────────────────────
MANIFEST="$WORKSPACE_DIR/template-manifest.yaml"
if [[ ! -f "$MANIFEST" ]]; then
  log_error "template-manifest.yaml not found at workspace root"
  exit 1
fi

# ─── Parse manifest ──────────────────────────────────────
# Read scaffold-dir
SCAFFOLD_DIR=$(grep '^scaffold-dir:' "$MANIFEST" | awk '{print $2}' | tr -d '"' | tr -d "'")
SCAFFOLD_DIR="${SCAFFOLD_DIR%/}"

# Read targets into arrays
declare -a TARGET_IDS=()
declare -a TARGET_PATHS=()

in_targets=false
current_id=""
while IFS= read -r line; do
  # Detect targets section
  if [[ "$line" =~ ^targets: ]]; then
    in_targets=true
    continue
  fi
  # Exit targets section on next top-level key
  if $in_targets && [[ "$line" =~ ^[a-z] ]] && [[ ! "$line" =~ ^[[:space:]] ]]; then
    in_targets=false
    continue
  fi
  if $in_targets; then
    if [[ "$line" =~ ^[[:space:]]*-[[:space:]]*id:[[:space:]]*(.*) ]]; then
      current_id="${BASH_REMATCH[1]}"
      TARGET_IDS+=("$current_id")
    fi
    if [[ "$line" =~ ^[[:space:]]*path:[[:space:]]*(.*) ]]; then
      TARGET_PATHS+=("${BASH_REMATCH[1]}")
    fi
  fi
done < "$MANIFEST"

# Read rules into arrays
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
  if [[ "$line" =~ ^rules: ]]; then
    in_rules=true
    continue
  fi
  if ! $in_rules; then continue; fi
  # Skip comments and blank lines
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
# Convert manifest glob to bash-compatible pattern
matches_glob() {
  local filepath="$1"
  local pattern="$2"

  # Handle ** (recursive) patterns
  if [[ "$pattern" == *"**"* ]]; then
    # Convert to regex: ** = any path, * = any non-/ chars
    local regex="${pattern//\*\*/DOUBLEWILD}"
    regex="${regex//\*/[^/]*}"
    regex="${regex//DOUBLEWILD/.*}"
    regex="^${regex}$"
    [[ "$filepath" =~ $regex ]]
  else
    # Simple glob — use bash pattern matching
    [[ "$filepath" == $pattern ]]
  fi
}

# ─── Find matching rule ──────────────────────────────────
# Returns: action via MATCH_ACTION, or "" if no match (ignored)
MATCH_ACTION=""

find_rule() {
  local filepath="$1"
  local target_id="$2"
  MATCH_ACTION=""

  for i in "${!RULE_PATTERNS[@]}"; do
    if matches_glob "$filepath" "${RULE_PATTERNS[$i]}"; then
      # Check target constraint
      local rule_targets="${RULE_TARGETS[$i]}"
      if [[ "$rule_targets" != "all" ]]; then
        # Parse comma-separated target list
        if [[ ! "$rule_targets" =~ (^|,)[[:space:]]*$target_id[[:space:]]*(,|$) ]]; then
          continue
        fi
      fi
      MATCH_ACTION="${RULE_ACTIONS[$i]}"
      return
    fi
  done
}

# ─── Sync one file ───────────────────────────────────────
COPY_COUNT=0
SCAFFOLD_COUNT=0
SKIP_COUNT=0
ORPHAN_COUNT=0
ERROR_COUNT=0

sync_file() {
  local filepath="$1"
  local target_id="$2"
  local target_path="$3"
  local action="$4"

  local src=""
  local dst="$WORKSPACE_DIR/$target_path/$filepath"

  if [[ "$action" == "copy" ]]; then
    src="$WORKSPACE_DIR/$filepath"
  elif [[ "$action" == "scaffold" ]]; then
    # Resolve: target-specific → common fallback
    if [[ -f "$WORKSPACE_DIR/$SCAFFOLD_DIR/$target_id/$filepath" ]]; then
      src="$WORKSPACE_DIR/$SCAFFOLD_DIR/$target_id/$filepath"
    elif [[ -f "$WORKSPACE_DIR/$SCAFFOLD_DIR/common/$filepath" ]]; then
      src="$WORKSPACE_DIR/$SCAFFOLD_DIR/common/$filepath"
    else
      log_warn "No scaffold source for $filepath (target: $target_id)"
      ERROR_COUNT=$((ERROR_COUNT + 1))
      return
    fi
  else
    return
  fi

  if [[ ! -f "$src" ]]; then
    log_warn "Source missing: $src"
    ERROR_COUNT=$((ERROR_COUNT + 1))
    return
  fi

  if $DRY_RUN; then
    if [[ -f "$dst" ]]; then
      if diff -q "$src" "$dst" > /dev/null 2>&1; then
        SKIP_COUNT=$((SKIP_COUNT + 1))
        return
      fi
      log_dry "UPDATE [$action] $filepath → $target_id"
    else
      log_dry "CREATE [$action] $filepath → $target_id"
    fi
  else
    if [[ -f "$dst" ]] && diff -q "$src" "$dst" > /dev/null 2>&1; then
      SKIP_COUNT=$((SKIP_COUNT + 1))
      return
    fi
    mkdir -p "$(dirname "$dst")"
    cp "$src" "$dst"
    log_success "[$action] $filepath → $target_id"
  fi

  if [[ "$action" == "copy" ]]; then
    COPY_COUNT=$((COPY_COUNT + 1))
  else
    SCAFFOLD_COUNT=$((SCAFFOLD_COUNT + 1))
  fi
}

# ─── Enumerate target repo files (for orphan detection) ─
enumerate_target_files() {
  local target_dir="$1"
  find "$target_dir" \
    -path "$target_dir/.git" -prune -o \
    -type f -print \
    | sed "s|$target_dir/||" | sort -u
}

# ─── Detect and remove orphaned copy-action files ────────
# Walks the template repo and removes any copy-action files
# that no longer exist at workspace root.
detect_orphans() {
  local tid="$1"
  local tpath="$2"
  local target_dir="$WORKSPACE_DIR/$tpath"

  while IFS= read -r filepath; do
    find_rule "$filepath" "$tid"
    if [[ "$MATCH_ACTION" == "copy" ]]; then
      if [[ ! -f "$WORKSPACE_DIR/$filepath" ]]; then
        if $DRY_RUN; then
          log_dry "ORPHAN $filepath ← $tid"
        else
          rm "$target_dir/$filepath"
          log_warn "DELETED orphan: $filepath ← $tid"
        fi
        ORPHAN_COUNT=$((ORPHAN_COUNT + 1))
      fi
    fi
  done < <(enumerate_target_files "$target_dir")
}

# ─── Enumerate workspace files to sync ───────────────────
# Walk workspace files and match against rules.
# We enumerate files that could match any rule pattern.

enumerate_workspace_files() {
  # Find all files in workspace root (excluding deep repos/*, scaffolds/, .tmp/, .git/, archive/)
  # Include top-level files in repos/ and sandbox/ but not nested repo contents
  {
    find "$WORKSPACE_DIR" \
      -path "$WORKSPACE_DIR/repos" -prune -o \
      -path "$WORKSPACE_DIR/scaffolds" -prune -o \
      -path "$WORKSPACE_DIR/.tmp" -prune -o \
      -path "$WORKSPACE_DIR/.git" -prune -o \
      -path "$WORKSPACE_DIR/archive" -prune -o \
      -path "$WORKSPACE_DIR/node_modules" -prune -o \
      -type f -print
    # Add top-level files from repos/ and sandbox/ (e.g., repos/README.md)
    find "$WORKSPACE_DIR/repos" -maxdepth 1 -type f 2>/dev/null || true
    find "$WORKSPACE_DIR/sandbox" -maxdepth 1 -type f 2>/dev/null || true
    # Add .tmp/ READMEs (tracked despite .tmp/ being pruned)
    find "$WORKSPACE_DIR/.tmp" -name "README.md" -type f 2>/dev/null || true
  } | sed "s|$WORKSPACE_DIR/||" | sort -u
}

# ─── Main ────────────────────────────────────────────────
cd "$WORKSPACE_DIR"

if $DRY_RUN; then
  log_info "DRY RUN — no files will be changed"
fi

log_info "Reading template-manifest.yaml..."
log_info "Targets: ${TARGET_IDS[*]}"
log_info "Rules: ${#RULE_PATTERNS[@]}"

for t in "${!TARGET_IDS[@]}"; do
  tid="${TARGET_IDS[$t]}"
  tpath="${TARGET_PATHS[$t]}"

  # Skip if target filter is set and doesn't match
  if [[ -n "$TARGET_FILTER" ]] && [[ "$tid" != "$TARGET_FILTER" ]]; then
    continue
  fi

  if [[ ! -d "$WORKSPACE_DIR/$tpath" ]]; then
    log_error "Target path not found: $tpath"
    ERROR_COUNT=$((ERROR_COUNT + 1))
    continue
  fi

  echo ""
  log_info "Syncing target: $tid ($tpath)"

  # Reset per-target counters
  COPY_COUNT=0
  SCAFFOLD_COUNT=0
  SKIP_COUNT=0
  ORPHAN_COUNT=0

  while IFS= read -r filepath; do
    find_rule "$filepath" "$tid"
    if [[ -n "$MATCH_ACTION" ]] && [[ "$MATCH_ACTION" != "ignore" ]]; then
      sync_file "$filepath" "$tid" "$tpath" "$MATCH_ACTION"
    fi
  done < <(enumerate_workspace_files)

  detect_orphans "$tid" "$tpath"

  echo "  Copied: $COPY_COUNT  Scaffolded: $SCAFFOLD_COUNT  Unchanged: $SKIP_COUNT  Orphans: $ORPHAN_COUNT"
done

echo ""
if [[ $ERROR_COUNT -gt 0 ]]; then
  log_error "Completed with $ERROR_COUNT errors"
  exit 1
else
  log_success "Sync complete"
fi
