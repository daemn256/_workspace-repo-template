#!/usr/bin/env bash
set -euo pipefail

# sync-upstream.sh — Safely sync the containment directory from upstream
#
# The containment model means `git merge upstream/main` does NOT work —
# upstream's root is bare (only the containment directory), so a merge
# would try to delete all consumer workspace files.
#
# Instead, this script selectively extracts the containment directory
# from upstream, leaving all consumer root files untouched.
#
# Usage:
#   tools/sync-upstream.sh [--apply]
#
# Without --apply, shows a preview of changes (dry run).
# With --apply, stages the updated containment directory.
#
# Decision 25: Selective extraction sync replaces git merge for
# containment-model templates.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_DIR="$(dirname "$SCRIPT_DIR")"

# Detect containment directory (starts with .workspace-)
CONTAINMENT_DIR=""
for dir in "$WORKSPACE_DIR"/.workspace-*; do
  if [[ -d "$dir" ]]; then
    CONTAINMENT_DIR="$(basename "$dir")"
    break
  fi
done

if [[ -z "$CONTAINMENT_DIR" ]]; then
  echo "❌ No containment directory found (expected .workspace-*/ at workspace root)"
  exit 1
fi

# Detect upstream remote name
REMOTE=""
if git remote get-url upstream-workspace &>/dev/null; then
  REMOTE="upstream-workspace"
elif git remote get-url upstream &>/dev/null; then
  REMOTE="upstream"
else
  echo "❌ No upstream remote found (expected 'upstream-workspace' or 'upstream')"
  echo "   Run tools/setup-remotes.sh to configure remotes."
  exit 1
fi

# Parse arguments
APPLY=false
for arg in "$@"; do
  case "$arg" in
    --apply) APPLY=true ;;
    -h|--help)
      echo "Usage: tools/sync-upstream.sh [--apply]"
      echo ""
      echo "Sync the containment directory (${CONTAINMENT_DIR}/) from upstream."
      echo ""
      echo "Options:"
      echo "  --apply   Stage the updated containment directory"
      echo "  --help    Show this help message"
      echo ""
      echo "Without --apply, shows a preview of what would change."
      exit 0
      ;;
    *) echo "Unknown argument: $arg"; exit 1 ;;
  esac
done

cd "$WORKSPACE_DIR"

echo "🔄 Syncing containment directory from upstream..."
echo "   Remote:      ${REMOTE}"
echo "   Containment: ${CONTAINMENT_DIR}/"
echo ""

# ── Fetch ─────────────────────────────────────────────────────
echo "Fetching ${REMOTE}..."
git fetch "$REMOTE"
echo ""

# ── Compare ───────────────────────────────────────────────────
LOCAL_SHA=$(git rev-parse HEAD:"$CONTAINMENT_DIR" 2>/dev/null || echo "none")
REMOTE_SHA=$(git rev-parse "${REMOTE}/main:${CONTAINMENT_DIR}" 2>/dev/null || echo "none")

if [[ "$LOCAL_SHA" == "$REMOTE_SHA" ]]; then
  echo "✅ Containment directory is already up to date."
  echo "   (${CONTAINMENT_DIR}/ matches ${REMOTE}/main)"
  exit 0
fi

echo "Changes available in ${REMOTE}/main:"
echo ""

# Show diff between local containment and upstream containment
git diff HEAD "${REMOTE}/main" -- "$CONTAINMENT_DIR/" --stat
echo ""

if [[ "$APPLY" != true ]]; then
  echo "────────────────────────────────────────"
  echo "This is a dry run. To apply these changes:"
  echo "  tools/sync-upstream.sh --apply"
  echo ""
  echo "After applying, review and commit:"
  echo "  git diff --cached --stat"
  echo "  git commit -m 'chore: sync containment from upstream'"
  echo "────────────────────────────────────────"
  exit 0
fi

# ── Apply ─────────────────────────────────────────────────────
echo "Extracting ${CONTAINMENT_DIR}/ from ${REMOTE}/main..."
git checkout "${REMOTE}/main" -- "$CONTAINMENT_DIR/"
git add "$CONTAINMENT_DIR/"

echo ""
echo "────────────────────────────────────────"
echo "✅ Containment directory updated and staged."
echo ""
echo "Staged changes:"
git diff --cached --stat -- "$CONTAINMENT_DIR/"
echo ""
echo "Review the changes, then commit:"
echo "  git commit -m 'chore: sync containment from upstream'"
echo ""
echo "Your workspace root files are untouched."
echo "To apply upstream changes to your root files, compare manually:"
echo "  diff -r ${CONTAINMENT_DIR}/ ./ --exclude=.git --exclude=${CONTAINMENT_DIR}"
echo "────────────────────────────────────────"
