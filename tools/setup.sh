#!/usr/bin/env bash
set -euo pipefail

# setup.sh — Configure a satellite workspace after cloning from the template
#
# This script:
# 1. Seeds real files from .template variants (first init only)
# 2. Configures git to use the .githooks/ directory
# 3. Adds the template as 'upstream' remote (if not already present)
# 4. Adds the parent template as 'upstream-repo' remote
# 5. Blocks push to both upstreams
#
# Run this once after creating your workspace from the template.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_DIR="$(dirname "$SCRIPT_DIR")"
TEMPLATE_URL="https://github.com/daemn256/_workspace-root-template.git"
PARENT_TEMPLATE_URL="https://github.com/daemn256/_repo-template.git"

cd "$WORKSPACE_DIR"

echo "🔧 Setting up workspace..."
echo ""

# 1. Seed real files from .template variants
echo "1️⃣  Seeding files from .template variants..."
seeded=0
skipped=0
while IFS= read -r -d '' template_file; do
  # Derive real filename: README.template.md → README.md, LICENSE.template → LICENSE
  real_file="${template_file/.template/}"
  if [[ "$real_file" == "$template_file" ]]; then
    continue  # Pattern didn't match, skip
  fi
  if [[ -f "$real_file" ]]; then
    echo "   ⏭️  Skipped $(basename "$real_file") (already exists)"
    ((skipped++))
  else
    cp "$template_file" "$real_file"
    echo "   ✅ Created $(basename "$real_file") from $(basename "$template_file")"
    ((seeded++))
  fi
done < <(find "$WORKSPACE_DIR" -maxdepth 3 -not -path '*/.git/*' \( -name '*.template.*' -o -name '*.template' -o -name '.*.template' \) -print0)
echo "   Seeded: $seeded | Skipped: $skipped"

# 2. Configure githooks
echo ""
echo "2️⃣  Configuring git hooks..."
if git config core.hooksPath .githooks; then
  echo "   ✅ Hooks configured: $(git config core.hooksPath)"
else
  echo "   ❌ Failed to configure hooks"
  exit 1
fi

# 3. Add upstream remote if not present
echo ""
echo "3️⃣  Checking upstream remote..."
if git remote get-url upstream &>/dev/null; then
  echo "   ✅ Upstream already configured: $(git remote get-url upstream)"
else
  echo "   Adding upstream remote..."
  git remote add upstream "$TEMPLATE_URL"
  echo "   ✅ Upstream added: $TEMPLATE_URL"
fi

# 4. Add upstream-repo remote (parent template) if not present
echo ""
echo "4️⃣  Checking upstream-repo remote..."
if git remote get-url upstream-repo &>/dev/null; then
  echo "   ✅ Upstream-repo already configured: $(git remote get-url upstream-repo)"
else
  echo "   Adding upstream-repo remote..."
  git remote add upstream-repo "$PARENT_TEMPLATE_URL"
  echo "   ✅ Upstream-repo added: $PARENT_TEMPLATE_URL"
fi

# 5. Block push to both upstreams
echo ""
echo "5️⃣  Blocking push to upstreams..."
git remote set-url --push upstream no_push
git remote set-url --push upstream-repo no_push
echo "   ✅ Push to upstream and upstream-repo blocked (fetch-only)"

# Summary
echo ""
echo "────────────────────────────────────────"
echo "✅ Workspace setup complete!"
echo ""
echo "Remotes configured:"
git remote -v
echo ""
echo "Next steps:"
echo "  1. Customize .github/AGENTS.md with your workspace context (seeded from .template)"
echo "  2. Review .github/copilot-instructions.md and update Template Identity section"
echo "  3. Customize README.md with your workspace description"
echo "  4. Clone or create projects in repos/"
echo ""
echo "To sync template updates later:"
echo "  git fetch upstream        # Direct template updates"
echo "  git fetch upstream-repo   # Parent template updates"
echo "  git merge upstream/main"
echo "────────────────────────────────────────"
