#!/usr/bin/env bash
set -euo pipefail

# setup.sh — Configure a satellite workspace after cloning from the template
#
# This script:
# 1. Configures git to use the .githooks/ directory
# 2. Adds the template as 'upstream' remote (if not already present)
# 3. Blocks push to upstream to prevent accidental template contamination
#
# Run this once after creating your workspace from the template.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_DIR="$(dirname "$SCRIPT_DIR")"
TEMPLATE_URL="https://github.com/daemn256/dev-workspace-template.git"

cd "$WORKSPACE_DIR"

echo "🔧 Setting up workspace..."
echo ""

# 1. Configure githooks
echo "1️⃣  Configuring git hooks..."
if git config core.hooksPath .githooks; then
  echo "   ✅ Hooks configured: $(git config core.hooksPath)"
else
  echo "   ❌ Failed to configure hooks"
  exit 1
fi

# 2. Add upstream remote if not present
echo ""
echo "2️⃣  Checking upstream remote..."
if git remote get-url upstream &>/dev/null; then
  echo "   ✅ Upstream already configured: $(git remote get-url upstream)"
else
  echo "   Adding upstream remote..."
  git remote add upstream "$TEMPLATE_URL"
  echo "   ✅ Upstream added: $TEMPLATE_URL"
fi

# 3. Block push to upstream
echo ""
echo "3️⃣  Blocking push to upstream..."
git remote set-url --push upstream no_push
echo "   ✅ Push to upstream blocked (fetch-only)"

# Summary
echo ""
echo "────────────────────────────────────────"
echo "✅ Workspace setup complete!"
echo ""
echo "Remotes configured:"
git remote -v
echo ""
echo "Next steps:"
echo "  1. Customize .github/workspace.md with your context"
echo "  2. Replace README.md with your workspace description"
echo "  3. Add projects to repos/"
echo ""
echo "To sync template updates later:"
echo "  git fetch upstream"
echo "  git merge upstream/main"
echo "────────────────────────────────────────"
