#!/usr/bin/env bash
set -euo pipefail

# setup-githooks.sh — Configure git to use the .githooks/ directory
#
# Points git's core.hooksPath to .githooks/ in the workspace root.
# This enables custom pre-commit, pre-push, and other hook scripts
# shipped with the template.
#
# Idempotent — safe to re-run at any time.
# Can be run standalone from anywhere inside the repository.

WORKSPACE_DIR="$(git rev-parse --show-toplevel)"

echo "   Configuring git hooks..."

if [[ -d "$WORKSPACE_DIR/.githooks" ]]; then
  cd "$WORKSPACE_DIR"
  if git config core.hooksPath .githooks; then
    echo "   ✅ Git hooks configured: core.hooksPath = .githooks"
  else
    echo "   ❌ Failed to configure git hooks path"
    exit 1
  fi
else
  echo "   ⏭️  No .githooks/ directory found — skipping"
  echo "      (Expected at: ${WORKSPACE_DIR}/.githooks/)"
fi
