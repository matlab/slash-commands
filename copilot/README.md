# MATLAB Commands for GitHub Copilot

These `.prompt.md` files provide MATLAB development commands for GitHub Copilot Chat.

## Installation

Copy the `prompts/` directory into your repository's `.github/prompts/` directory:

```bash
cp -r copilot/prompts/ .github/prompts/
```

## Usage

In VS Code with Copilot Chat, type `/` to see available commands:
- `/matlab-readme`: Generate project README
- `/matlab-docs`: Document MATLAB functions
- `/matlab-test`: Generate unit tests
- `/matlab-optimize`: Optimize code performance
- `/matlab-check`: Run Code Analyzer
- `/matlab-run`: Execute MATLAB code

## Format

Copilot prompt files use YAML frontmatter with `description` and optional `model`/`tools` fields, followed by markdown instructions.

## Note

These are adapted from the Claude Code slash commands. For the full set of 13 commands, use the Claude Code plugin directly.
