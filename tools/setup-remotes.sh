#!/usr/bin/env bash
set -euo pipefail

# setup-remotes.sh — Configure upstream template remotes
#
# Adds two fetch-only remotes for tracking template updates:
#   upstream-workspace  — the workspace template this repo was created from
#   upstream-repo       — the parent repository template
#
# Push is blocked on both remotes to prevent accidental writes to upstream.
# Legacy 'upstream' remotes are automatically migrated to 'upstream-workspace'.
#
# Idempotent — safe to re-run at any time.
# Can be run standalone from anywhere inside the repository.

WORKSPACE_DIR="$(git rev-parse --show-toplevel)"
TEMPLATE_URL="https://github.com/daemn256/_workspace-repo-template.git"
PARENT_TEMPLATE_URL="https://github.com/daemn256/_repo-template.git"

cd "$WORKSPACE_DIR"

# ── upstream-workspace remote ─────────────────────────────────
echo "   Checking upstream-workspace remote..."
if git remote get-url upstream-workspace &>/dev/null; then
  echo "   ✅ Already configured: $(git remote get-url upstream-workspace)"
elif git remote get-url upstream &>/dev/null; then
  echo "   ⚠️  Found legacy 'upstream' remote — renaming to 'upstream-workspace'"
  git remote rename upstream upstream-workspace
  echo "   ✅ Renamed: upstream → upstream-workspace"
else
  git remote add upstream-workspace "$TEMPLATE_URL"
  echo "   ✅ Added upstream-workspace: $TEMPLATE_URL"
fi

# ── upstream-repo remote ──────────────────────────────────────
echo "   Checking upstream-repo remote..."
if git remote get-url upstream-repo &>/dev/null; then
  echo "   ✅ Already configured: $(git remote get-url upstream-repo)"
else
  git remote add upstream-repo "$PARENT_TEMPLATE_URL"
  echo "   ✅ Added upstream-repo: $PARENT_TEMPLATE_URL"
fi

# ── Block push to both upstreams ──────────────────────────────
echo "   Blocking push to upstream remotes..."
git remote set-url --push upstream-workspace no_push 2>/dev/null || true
git remote set-url --push upstream-repo no_push 2>/dev/null || true
echo "   ✅ Push blocked on upstream-workspace and upstream-repo (fetch-only)"
