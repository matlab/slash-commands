# Cross-Agent Support

MATLAB Slash Commands are available in multiple formats for different AI coding agents.

## Supported Agents

| Agent | Format | Directory | Commands |
|-------|--------|-----------|----------|
| Claude Code | Plugin (markdown + YAML) | `commands/` | All 13 |
| GitHub Copilot | `.prompt.md` files | `copilot/prompts/` | 6 key commands |
| Cursor IDE | `.mdc` rules file | `cursor/rules/` | Rules (not commands) |
| Any MCP agent | MCP server | External | Via MATLAB MCP Core Server |

## Claude Code (Full Support)

Install via plugin system:
```bash
/plugin install github:matlab/slash-commands
```

All 13 commands available as `/matlab-*` slash commands.

## GitHub Copilot

Copy prompt files to your repo:
```bash
cp -r copilot/prompts/ .github/prompts/
```

Available as slash commands in Copilot Chat (VS Code, JetBrains).

### Available Commands
- `/matlab-readme`, `/matlab-docs`, `/matlab-test`
- `/matlab-optimize`, `/matlab-check`, `/matlab-run`

## Cursor IDE

Copy rules to your project:
```bash
mkdir -p .cursor/rules
cp cursor/rules/matlab-development.mdc .cursor/rules/
```

Provides always-on MATLAB context for `.m`, `.mlx`, and `.mlapp` files.

## Other Agents

### Windsurf
Copy the Cursor rules file to `.windsurfrules` at your project root.

### Cline / Roo Code
Copy the Cursor rules file to `.clinerules` at your project root.

### Amazon Q Developer
Create a custom agent JSON referencing the MATLAB MCP Core Server.

## MCP Support for All Agents

The **MATLAB MCP Core Server** provides live MATLAB capabilities (code execution, testing, analysis) to any MCP-compatible agent. This is the recommended way to add MATLAB integration across all agents.

Setup: See [MCP Integration Guide](mcp-integration.md).
