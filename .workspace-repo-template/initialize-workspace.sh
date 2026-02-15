#!/usr/bin/env bash
set -euo pipefail

# initialize-workspace.sh — Initialize a new workspace from the template
#
# Single entry point for workspace initialization. Copies template files to
# the workspace root and configures git settings (remotes, hooks).
#
# Usage:
#   .workspace-repo-template/initialize-workspace.sh [--force]
#
# The --force flag allows re-initialization over an existing workspace.
# Without --force, the script aborts if the workspace appears already initialized.
#
# This script stays inside the containment directory and is NOT copied to
# the workspace root (Decision 20). It calls modular sub-scripts in tools/.

CONTAINMENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONTAINMENT_NAME="$(basename "$CONTAINMENT_DIR")"
WORKSPACE_DIR="$(dirname "$CONTAINMENT_DIR")"

# Parse arguments
FORCE=false
for arg in "$@"; do
  case "$arg" in
    --force) FORCE=true ;;
    -h|--help)
      echo "Usage: ${CONTAINMENT_NAME}/initialize-workspace.sh [--force]"
      echo ""
      echo "Initialize a workspace from the template containment directory."
      echo ""
      echo "Options:"
      echo "  --force   Allow re-initialization over an existing workspace"
      echo "  --help    Show this help message"
      exit 0
      ;;
    *) echo "Unknown argument: $arg"; exit 1 ;;
  esac
done

echo "🚀 Initializing workspace from ${CONTAINMENT_NAME}..."
echo "   Containment: ${CONTAINMENT_DIR}"
echo "   Workspace:   ${WORKSPACE_DIR}"
echo ""

# ── Safety check ──────────────────────────────────────────────
# Abort if workspace looks initialized, unless --force is set.
if [[ -f "$WORKSPACE_DIR/README.md" ]] && [[ "$FORCE" != true ]]; then
  echo "⚠️  Workspace appears already initialized (README.md exists at root)."
  echo ""
  echo "   To re-initialize, run with --force:"
  echo "     ${CONTAINMENT_NAME}/initialize-workspace.sh --force"
  echo ""
  echo "   This will overwrite existing workspace files with template defaults."
  exit 1
fi

# ── Step 1: Copy template files ──────────────────────────────
echo "━━━ Step 1/3: Copy template files ━━━"
"$CONTAINMENT_DIR/tools/copy-template.sh"
echo ""

# ── Step 2: Configure git remotes ─────────────────────────────
echo "━━━ Step 2/3: Configure git remotes ━━━"
"$CONTAINMENT_DIR/tools/setup-remotes.sh"
echo ""

# ── Step 3: Configure git hooks ───────────────────────────────
echo "━━━ Step 3/3: Configure git hooks ━━━"
"$CONTAINMENT_DIR/tools/setup-githooks.sh"
echo ""

# ── Summary ───────────────────────────────────────────────────
echo "────────────────────────────────────────"
echo "✅ Workspace initialized successfully!"
echo ""
echo "Next steps:"
echo "  1. Edit README.md — fill in your workspace details"
echo "  2. Edit workspace.config.yaml — set your project configuration"
echo "  3. Edit LICENSE — set your copyright holder and year"
echo "  4. Commit your initialized workspace:"
echo "     git add -A && git commit -m 'chore: initialize workspace from template'"
echo ""
echo "The containment directory (${CONTAINMENT_NAME}/) preserves the"
echo "upstream template reference. Do not modify files inside it directly."
echo "────────────────────────────────────────"
