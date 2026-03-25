#!/usr/bin/env bash
# Guide for maintaining Cursor rules from Claude Code commands
# Usage: ./scripts/convert-to-cursor.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
OUTDIR="$REPO_ROOT/cursor/rules"

echo "Cursor rules are manually maintained in $OUTDIR"
echo ""
echo "The .mdc rules file consolidates MATLAB best practices from"
echo "all commands into a single always-on context file."
echo ""
echo "To update after changing commands:"
echo "  1. Review changes in commands/"
echo "  2. Update cursor/rules/matlab-development.mdc if best practices changed"
echo ""
echo "Current Cursor rules:"
ls -1 "$OUTDIR"/*.mdc 2>/dev/null || echo "  (none found)"
