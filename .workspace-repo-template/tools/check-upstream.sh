#!/usr/bin/env bash
set -euo pipefail

# check-upstream.sh — Non-destructive "am I up to date?" check
#
# Fetches the upstream-workspace remote and reports whether the containment
# directory has available updates, without modifying the working tree.
#
# Usage:
#   tools/check-upstream.sh           # Check for upstream updates
#   tools/check-upstream.sh --verbose  # Include commit log and file diff
#
# Exit codes:
#   0 — Up to date (or updates reported successfully)
#   1 — Error (no containment dir, no remote, etc.)
#
# Issue #58: Add check-upstream.sh for downstream consumers

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_DIR="$(dirname "$SCRIPT_DIR")"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

# ── Detect containment directory ───────────────────────────────
CONTAINMENT_DIR=""
for dir in "$WORKSPACE_DIR"/.workspace-*; do
  if [[ -d "$dir" ]]; then
    CONTAINMENT_DIR="$(basename "$dir")"
    break
  fi
done

if [[ -z "$CONTAINMENT_DIR" ]]; then
  echo -e "${RED}❌ No containment directory found (expected .workspace-*/ at workspace root)${NC}"
  exit 1
fi

# ── Detect upstream remote ─────────────────────────────────────
REMOTE=""
if git remote get-url upstream-workspace &>/dev/null; then
  REMOTE="upstream-workspace"
elif git remote get-url upstream &>/dev/null; then
  REMOTE="upstream"
else
  echo -e "${RED}❌ No upstream remote found (expected 'upstream-workspace' or 'upstream')${NC}"
  echo "   Run tools/setup-remotes.sh to configure remotes."
  exit 1
fi

# ── Parse arguments ────────────────────────────────────────────
VERBOSE=false
for arg in "$@"; do
  case "$arg" in
    --verbose|-v) VERBOSE=true ;;
    -h|--help)
      echo "Usage: tools/check-upstream.sh [--verbose]"
      echo ""
      echo "Check if the containment directory (${CONTAINMENT_DIR}/) has upstream updates."
      echo ""
      echo "Options:"
      echo "  --verbose, -v   Show commit log and file-level changes"
      echo "  --help, -h      Show this help message"
      echo ""
      echo "This is a non-destructive read-only check."
      echo "To apply updates, use: tools/sync-upstream.sh --apply"
      exit 0
      ;;
    *) echo -e "${RED}Unknown argument: $arg${NC}"; exit 1 ;;
  esac
done

cd "$WORKSPACE_DIR"

# ── Fetch ──────────────────────────────────────────────────────
echo -e "${BLUE}Fetching ${REMOTE}...${NC}"
git fetch "$REMOTE" --quiet 2>/dev/null || git fetch "$REMOTE"
echo ""

# ── Compare tree SHAs ──────────────────────────────────────────
LOCAL_SHA=$(git rev-parse HEAD:"$CONTAINMENT_DIR" 2>/dev/null || echo "none")
REMOTE_SHA=$(git rev-parse "${REMOTE}/main:${CONTAINMENT_DIR}" 2>/dev/null || echo "none")

if [[ "$LOCAL_SHA" == "$REMOTE_SHA" ]]; then
  echo -e "${GREEN}✅ Up to date${NC}"
  echo -e "   ${CONTAINMENT_DIR}/ matches ${REMOTE}/main"
  exit 0
fi

# ── Count commits ──────────────────────────────────────────────
# Commits in upstream that touch the containment directory and aren't in local
COMMIT_COUNT=$(git rev-list --count HEAD.."${REMOTE}/main" -- "$CONTAINMENT_DIR/" 2>/dev/null || echo "?")

echo -e "${YELLOW}⚡ ${COMMIT_COUNT} update(s) available${NC}"
echo -e "   Remote: ${REMOTE}/main"
echo -e "   Containment: ${CONTAINMENT_DIR}/"
echo ""

# ── File summary ───────────────────────────────────────────────
echo -e "${BOLD}Changed files:${NC}"
git diff --stat HEAD "${REMOTE}/main" -- "$CONTAINMENT_DIR/"
echo ""

# ── Verbose: commit log ───────────────────────────────────────
if [[ "$VERBOSE" == true ]]; then
  echo -e "${BOLD}Commits:${NC}"
  git --no-pager log --oneline HEAD.."${REMOTE}/main" -- "$CONTAINMENT_DIR/"
  echo ""

  echo -e "${BOLD}Full diff:${NC}"
  git diff HEAD "${REMOTE}/main" -- "$CONTAINMENT_DIR/"
  echo ""
fi

# ── Next steps ─────────────────────────────────────────────────
echo "To preview changes:"
echo "  tools/sync-upstream.sh"
echo ""
echo "To apply updates:"
echo "  tools/sync-upstream.sh --apply"
