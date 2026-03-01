#!/usr/bin/env bash
set -euo pipefail

# render-instructions.sh — Render instruction files from containment templates + workspace config
#
# Usage:
#   tools/render-instructions.sh              # Render all instruction files
#   tools/render-instructions.sh --dry-run    # Show what would change without writing
#
# This script reads workspace.config.yaml and docs/workspace/project-overlay.md,
# then renders containment templates into root instruction files by replacing
# consumer-fill {{{placeholder}}} tokens with real values.
#
# Consumer-fill tokens (replaced by this tool):
#   {{{project_name}}}      ← workspace.name
#   {{{project_purpose}}}   ← workspace.description
#   {{{project_overlay}}}   ← contents of project.overlay-file
#   {{{project_root}}}      ← project.root
#   {{{build_command}}}     ← commands.build
#   {{{test_command}}}      ← commands.test
#   {{{run_command}}}       ← commands.run
#   {{{lint_command}}}      ← commands.lint
#   {{{base_branch}}}       ← project.base-branch
#   {{{branch_pattern}}}    ← project.branch-pattern
#
# AI-runtime-fill tokens ({{{pr-number}}}, {{{scope}}}, etc.) are LEFT UNTOUCHED.
# They exist inside skill/prompt templates and are filled by the AI at runtime.
#
# Decision: Config-Driven Instruction Rendering (Issue #73)
# See: docs/observations/2026-02-22-workspace-contract-evaluation.md

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_DIR="$(dirname "$SCRIPT_DIR")"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# ─── Parse arguments ──────────────────────────────────────────────
DRY_RUN=false
for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=true ;;
    -h|--help)
      echo "Usage: tools/render-instructions.sh [--dry-run]"
      echo ""
      echo "Render instruction files from containment templates + workspace config."
      echo ""
      echo "Options:"
      echo "  --dry-run   Show what would change without writing files"
      echo "  --help      Show this help message"
      exit 0
      ;;
    *) echo "Unknown argument: $arg"; exit 1 ;;
  esac
done

# ─── Portable YAML helpers ────────────────────────────────────────
# Read a top-level key: value
read_yaml_key() {
  local file="$1" key="$2"
  grep "^${key}:" "$file" 2>/dev/null | head -1 \
    | sed "s/^${key}:[[:space:]]*//" | tr -d '"' | tr -d "'"
}

# Read a value nested under a parent key (one level deep)
read_yaml_nested() {
  local file="$1" parent="$2" key="$3"
  sed -n "/^${parent}:/,/^[^ ]/p" "$file" 2>/dev/null \
    | grep "^  ${key}:" | head -1 \
    | sed "s/^  ${key}:[[:space:]]*//" | tr -d '"' | tr -d "'"
}

# ─── Detect containment directory ─────────────────────────────────
CONTAINMENT_DIR=""
for dir in "$WORKSPACE_DIR"/.workspace-*-template; do
  if [[ -d "$dir" ]]; then
    CONTAINMENT_DIR="$dir"
    break
  fi
done

if [[ -z "$CONTAINMENT_DIR" ]]; then
  log_error "No containment directory found (expected .workspace-*-template/)"
  exit 1
fi

CONTAINMENT_NAME=$(basename "$CONTAINMENT_DIR")
log_info "Containment: $CONTAINMENT_NAME/"

# ─── Read workspace config ────────────────────────────────────────
CONFIG_FILE="$WORKSPACE_DIR/workspace.config.yaml"
if [[ ! -f "$CONFIG_FILE" ]]; then
  log_error "workspace.config.yaml not found at workspace root"
  exit 1
fi

log_info "Reading workspace.config.yaml..."

# Consumer-fill values from config
PROJECT_NAME=$(read_yaml_nested "$CONFIG_FILE" "workspace" "name")
PROJECT_PURPOSE=$(read_yaml_nested "$CONFIG_FILE" "workspace" "description")
BUILD_COMMAND=$(read_yaml_nested "$CONFIG_FILE" "commands" "build")
TEST_COMMAND=$(read_yaml_nested "$CONFIG_FILE" "commands" "test")
RUN_COMMAND=$(read_yaml_nested "$CONFIG_FILE" "commands" "run")
LINT_COMMAND=$(read_yaml_nested "$CONFIG_FILE" "commands" "lint")
PROJECT_ROOT=$(read_yaml_nested "$CONFIG_FILE" "project" "root")
BASE_BRANCH=$(read_yaml_nested "$CONFIG_FILE" "project" "base-branch")
BRANCH_PATTERN=$(read_yaml_nested "$CONFIG_FILE" "project" "branch-pattern")
OVERLAY_FILE_REL=$(read_yaml_nested "$CONFIG_FILE" "project" "overlay-file")

# Read overlay content from file
OVERLAY_FILE="$WORKSPACE_DIR/$OVERLAY_FILE_REL"
PROJECT_OVERLAY=""
if [[ -n "$OVERLAY_FILE_REL" && -f "$OVERLAY_FILE" ]]; then
  PROJECT_OVERLAY=$(cat "$OVERLAY_FILE")
  log_info "Loaded overlay from $OVERLAY_FILE_REL ($(wc -l < "$OVERLAY_FILE" | tr -d ' ') lines)"
elif [[ -n "$OVERLAY_FILE_REL" ]]; then
  log_warn "Overlay file not found: $OVERLAY_FILE_REL (will leave {{{project_overlay}}} unfilled)"
fi

# Report config values
echo ""
log_info "Config values:"
echo "  project_name:     ${PROJECT_NAME:-<empty>}"
echo "  project_purpose:  ${PROJECT_PURPOSE:0:60}${PROJECT_PURPOSE:+...}"
echo "  build_command:    ${BUILD_COMMAND:-<empty>}"
echo "  test_command:     ${TEST_COMMAND:-<empty>}"
echo "  run_command:      ${RUN_COMMAND:-<empty>}"
echo "  lint_command:     ${LINT_COMMAND:-<empty>}"
echo "  project_root:     ${PROJECT_ROOT:-<empty>}"
echo "  base_branch:      ${BASE_BRANCH:-<empty>}"
echo "  branch_pattern:   ${BRANCH_PATTERN:-<empty>}"
echo "  overlay:          ${OVERLAY_FILE_REL:-<none>} ($(echo "$PROJECT_OVERLAY" | wc -l | tr -d ' ') lines)"
echo ""

# ─── Find files to render ─────────────────────────────────────────
# Only process files in containment that contain consumer-fill tokens.
# Consumer-fill tokens use underscores: {{{project_name}}}, {{{build_command}}}
# AI-runtime-fill tokens use hyphens: {{{pr-number}}}, {{{issue-number}}}

CONSUMER_TOKEN_PATTERN='{{{project_name}}}|{{{project_purpose}}}|{{{project_overlay}}}|{{{project_root}}}|{{{build_command}}}|{{{test_command}}}|{{{run_command}}}|{{{lint_command}}}|{{{base_branch}}}|{{{branch_pattern}}}'

# Find all files in containment with consumer-fill tokens
RENDER_FILES=()
while IFS= read -r file; do
  [[ -z "$file" ]] && continue
  RENDER_FILES+=("$file")
done < <(grep -rl -E "$CONSUMER_TOKEN_PATTERN" "$CONTAINMENT_DIR" --include='*.md' 2>/dev/null || true)

if [[ ${#RENDER_FILES[@]} -eq 0 ]]; then
  log_warn "No files with consumer-fill tokens found in $CONTAINMENT_NAME/"
  exit 0
fi

log_info "Found ${#RENDER_FILES[@]} files with consumer-fill tokens"

# ─── Render each file ─────────────────────────────────────────────
RENDERED_COUNT=0
SKIPPED_COUNT=0
UNFILLED_REPORTS=()
HEADER_COMMENT="<!-- GENERATED by tools/render-instructions.sh — edit workspace.config.yaml to change consumer values -->"

for src_file in "${RENDER_FILES[@]}"; do
  # Compute the relative path within containment → root target
  rel_path="${src_file#"$CONTAINMENT_DIR"/}"
  target_file="$WORKSPACE_DIR/$rel_path"
  target_dir=$(dirname "$target_file")

  # Read source content
  content=$(cat "$src_file")

  # Replace consumer-fill tokens with config values
  # Use a temporary file approach for multi-line overlay replacement
  tmp_file=$(mktemp)

  # Write content to temp file first
  echo "$content" > "$tmp_file"

  # Simple token replacements (single-line values) using sed
  # Escape special sed characters in values
  escape_sed() {
    printf '%s' "$1" | sed -e 's/[&/\]/\\&/g'
  }

  [[ -n "$PROJECT_NAME" ]] && \
    sed -i '' "s|{{{project_name}}}|$(escape_sed "$PROJECT_NAME")|g" "$tmp_file" 2>/dev/null || \
    sed -i "s|{{{project_name}}}|$(escape_sed "$PROJECT_NAME")|g" "$tmp_file" 2>/dev/null || true

  [[ -n "$PROJECT_PURPOSE" ]] && \
    sed -i '' "s|{{{project_purpose}}}|$(escape_sed "$PROJECT_PURPOSE")|g" "$tmp_file" 2>/dev/null || \
    sed -i "s|{{{project_purpose}}}|$(escape_sed "$PROJECT_PURPOSE")|g" "$tmp_file" 2>/dev/null || true

  [[ -n "$BUILD_COMMAND" ]] && \
    sed -i '' "s|{{{build_command}}}|$(escape_sed "$BUILD_COMMAND")|g" "$tmp_file" 2>/dev/null || \
    sed -i "s|{{{build_command}}}|$(escape_sed "$BUILD_COMMAND")|g" "$tmp_file" 2>/dev/null || true

  [[ -n "$TEST_COMMAND" ]] && \
    sed -i '' "s|{{{test_command}}}|$(escape_sed "$TEST_COMMAND")|g" "$tmp_file" 2>/dev/null || \
    sed -i "s|{{{test_command}}}|$(escape_sed "$TEST_COMMAND")|g" "$tmp_file" 2>/dev/null || true

  [[ -n "$RUN_COMMAND" ]] && \
    sed -i '' "s|{{{run_command}}}|$(escape_sed "$RUN_COMMAND")|g" "$tmp_file" 2>/dev/null || \
    sed -i "s|{{{run_command}}}|$(escape_sed "$RUN_COMMAND")|g" "$tmp_file" 2>/dev/null || true

  [[ -n "$LINT_COMMAND" ]] && \
    sed -i '' "s|{{{lint_command}}}|$(escape_sed "$LINT_COMMAND")|g" "$tmp_file" 2>/dev/null || \
    sed -i "s|{{{lint_command}}}|$(escape_sed "$LINT_COMMAND")|g" "$tmp_file" 2>/dev/null || true

  [[ -n "$PROJECT_ROOT" ]] && \
    sed -i '' "s|{{{project_root}}}|$(escape_sed "$PROJECT_ROOT")|g" "$tmp_file" 2>/dev/null || \
    sed -i "s|{{{project_root}}}|$(escape_sed "$PROJECT_ROOT")|g" "$tmp_file" 2>/dev/null || true

  [[ -n "$BASE_BRANCH" ]] && \
    sed -i '' "s|{{{base_branch}}}|$(escape_sed "$BASE_BRANCH")|g" "$tmp_file" 2>/dev/null || \
    sed -i "s|{{{base_branch}}}|$(escape_sed "$BASE_BRANCH")|g" "$tmp_file" 2>/dev/null || true

  [[ -n "$BRANCH_PATTERN" ]] && \
    sed -i '' "s|{{{branch_pattern}}}|$(escape_sed "$BRANCH_PATTERN")|g" "$tmp_file" 2>/dev/null || \
    sed -i "s|{{{branch_pattern}}}|$(escape_sed "$BRANCH_PATTERN")|g" "$tmp_file" 2>/dev/null || true

  # Multi-line overlay replacement
  # Replace {{{project_overlay}}} with the overlay file content
  if [[ -n "$PROJECT_OVERLAY" ]] && grep -q '{{{project_overlay}}}' "$tmp_file" 2>/dev/null; then
    # Use awk for multi-line replacement (portable)
    overlay_tmp=$(mktemp)
    echo "$PROJECT_OVERLAY" > "$overlay_tmp"
    awk -v overlay_file="$overlay_tmp" '
      /{{{project_overlay}}}/ {
        while ((getline line < overlay_file) > 0) print line
        close(overlay_file)
        next
      }
      { print }
    ' "$tmp_file" > "${tmp_file}.new"
    mv "${tmp_file}.new" "$tmp_file"
    rm -f "$overlay_tmp"
  fi

  # Add generated header (after first line if it starts with #, otherwise at top)
  first_line=$(head -1 "$tmp_file")
  if [[ "$first_line" == "#"* ]]; then
    # Insert after the title line
    header_tmp=$(mktemp)
    head -1 "$tmp_file" > "$header_tmp"
    echo "" >> "$header_tmp"
    echo "$HEADER_COMMENT" >> "$header_tmp"
    tail -n +2 "$tmp_file" >> "$header_tmp"
    mv "$header_tmp" "$tmp_file"
  else
    header_tmp=$(mktemp)
    echo "$HEADER_COMMENT" > "$header_tmp"
    echo "" >> "$header_tmp"
    cat "$tmp_file" >> "$header_tmp"
    mv "$header_tmp" "$tmp_file"
  fi

  # Check for unfilled consumer tokens in the rendered output (while we still have tmp_file)
  file_remaining=$(grep -cE "$CONSUMER_TOKEN_PATTERN" "$tmp_file" 2>/dev/null || true)
  if [[ "$file_remaining" -gt 0 ]]; then
    UNFILLED_REPORTS+=("$rel_path|$file_remaining|$(grep -oE "$CONSUMER_TOKEN_PATTERN" "$tmp_file" 2>/dev/null | sort -u | tr '\n' ',' | sed 's/,$//')")
  fi

  if [[ "$DRY_RUN" == true ]]; then
    # Show diff between current file and rendered output
    if [[ -f "$target_file" ]]; then
      diff_output=$(diff "$target_file" "$tmp_file" 2>/dev/null || true)
      if [[ -n "$diff_output" ]]; then
        echo "  Would update: $rel_path"
        ((RENDERED_COUNT++))
      else
        ((SKIPPED_COUNT++))
      fi
    else
      echo "  Would create: $rel_path"
      ((RENDERED_COUNT++))
    fi
    rm -f "$tmp_file"
  else
    # Write rendered file to target
    mkdir -p "$target_dir"
    mv "$tmp_file" "$target_file"
    log_success "Rendered: $rel_path"
    ((RENDERED_COUNT++))
  fi
done

# ─── Summary ──────────────────────────────────────────────────────
echo ""
echo "═══════════════════════════════════════════════════════════════"
if [[ "$DRY_RUN" == true ]]; then
  echo "DRY RUN COMPLETE"
else
  echo "RENDER COMPLETE"
fi
echo "═══════════════════════════════════════════════════════════════"
echo ""
echo "  Source:    $CONTAINMENT_NAME/"
echo "  Config:    workspace.config.yaml"
echo "  Rendered:  $RENDERED_COUNT files"
[[ $SKIPPED_COUNT -gt 0 ]] && echo "  Unchanged: $SKIPPED_COUNT files"
echo ""

# Report unfilled consumer tokens (collected during rendering)
REMAINING=0
for report in "${UNFILLED_REPORTS[@]+"${UNFILLED_REPORTS[@]}"}"; do
  IFS='|' read -r rel_path count tokens <<< "$report"
  log_warn "$rel_path has $count unfilled consumer token(s)"
  echo "$tokens" | tr ',' '\n' | sed 's/^/    /'
  REMAINING=$((REMAINING + count))
done

if [[ $REMAINING -gt 0 ]]; then
  echo ""
  log_warn "$REMAINING consumer token(s) remain unfilled"
  log_warn "Add missing values to workspace.config.yaml and re-run"
elif [[ "$DRY_RUN" != true ]]; then
  log_success "All consumer tokens filled successfully"
fi

echo ""
