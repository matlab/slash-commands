#!/usr/bin/env bash
# Convert Claude Code commands to GitHub Copilot .prompt.md format
# Usage: ./scripts/convert-to-copilot.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
OUTDIR="$REPO_ROOT/copilot/prompts"

echo "Copilot prompt files are manually maintained in $OUTDIR"
echo ""
echo "To add a new Copilot prompt:"
echo "  1. Create the Claude Code command in commands/"
echo "  2. Create a simplified .prompt.md version in copilot/prompts/"
echo "  3. Copilot format uses: ---description--- frontmatter + markdown body"
echo "  4. Keep it concise — Copilot prompts work best under 200 lines"
echo ""
echo "Current Copilot prompts:"
ls -1 "$OUTDIR"/*.prompt.md 2>/dev/null || echo "  (none found)"
