#!/usr/bin/env bash
set -euo pipefail

# copy-template.sh — Copy template files from containment to workspace root
#
# Copies all template content from the containment directory to the workspace
# root, giving the consumer a complete workspace structure.
#
# Excluded from copy (containment-only files):
#   - initialize-workspace.sh  (Decision 20: stays in containment)
#   - .template.yaml           (template identity metadata)
#   - tools/copy-template.sh   (only meaningful inside containment)
#
# Called by initialize-workspace.sh. Not typically run standalone.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONTAINMENT_DIR="$(dirname "$SCRIPT_DIR")"
CONTAINMENT_NAME="$(basename "$CONTAINMENT_DIR")"
WORKSPACE_DIR="$(dirname "$CONTAINMENT_DIR")"

# Verify we're running from inside a containment directory
if [[ ! "$CONTAINMENT_NAME" =~ ^\. ]]; then
  echo "❌ Error: copy-template.sh must be run from inside a containment directory"
  echo "   Expected parent directory to start with '.', got: ${CONTAINMENT_NAME}"
  exit 1
fi

echo "   Copying template files to workspace root..."
echo "   Source: ${CONTAINMENT_DIR}/"
echo "   Target: ${WORKSPACE_DIR}/"

# Files that stay in containment only — not copied to workspace root
EXCLUDE_ARGS=(
  --exclude "initialize-workspace.sh"
  --exclude ".template.yaml"
  --exclude "tools/copy-template.sh"
)

rsync -a \
  "${EXCLUDE_ARGS[@]}" \
  "$CONTAINMENT_DIR/" \
  "$WORKSPACE_DIR/"

echo "   ✅ Template files copied to workspace root"
echo ""
echo "   Excluded (containment-only):"
echo "     - initialize-workspace.sh"
echo "     - .template.yaml"
echo "     - tools/copy-template.sh"
