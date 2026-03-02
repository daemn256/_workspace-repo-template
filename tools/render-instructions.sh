#!/usr/bin/env bash
set -euo pipefail

# render-instructions.sh — DEPRECATED
#
# This script was part of the token-based rendering system which has been
# replaced by the config-reference model. Agentic files now reference
# workspace.config.yaml and docs/workspace/ directly instead of embedding
# consumer-specific content via {{{placeholder}}} tokens.
#
# What to do instead:
#   - Edit workspace.config.yaml for project identity and commands
#   - Edit docs/workspace/project-overlay.md for project-specific context
#   - Run tools/sync-to-templates.sh to sync changes to template repos
#   - Run tools/validate-templates.sh to verify template consistency
#
# This stub exists for backward compatibility. It will be removed in a
# future release.

echo "⚠️  render-instructions.sh is deprecated."
echo ""
echo "The token-based rendering system has been replaced by config-reference."
echo "Agentic files now reference workspace.config.yaml directly."
echo ""
echo "See: docs/architecture/operating-model.md"
echo "Run: tools/sync-to-templates.sh (to sync workspace → templates)"
echo "Run: tools/validate-templates.sh (to validate template repos)"
exit 0
