# Installation Guide

Install MATLAB Slash Commands for Claude Code, GitHub Copilot, or Cursor using one of the methods below.

## Prerequisites

- Claude Code installed and signed in
- MATLAB (optional, for running the generated code)
- Git (for installing from a local clone)

## Installation Methods

### Method 1: Claude Code Plugin Manager (Recommended)

Add this repository as a plugin marketplace, then install the plugin from it:

```bash
/plugin marketplace add matlab/slash-commands
/plugin install matlab-slash-commands@matlab-slash-commands
```

From a terminal, the same steps are `claude plugin marketplace add matlab/slash-commands` and `claude plugin install matlab-slash-commands@matlab-slash-commands`.

### Method 2: From a Local Clone

Clone the repository and add the clone as a marketplace:

```bash
git clone https://github.com/matlab/slash-commands.git
```

```bash
/plugin marketplace add ./slash-commands
/plugin install matlab-slash-commands@matlab-slash-commands
```

### Method 3: Development

To edit commands and try them without installing, start Claude Code with the clone as a plugin folder:

```bash
claude --plugin-dir ./slash-commands
```

Changes to the command files take effect the next time Claude Code starts.

### Verify the Installation

1. Type `/matlab-` to see the available commands
2. Run a command, for example `/matlab-explain` on an open MATLAB file

### Method 4: GitHub Copilot

Copy the prompt files to your repository:

```bash
# From the cloned repo
cp -r copilot/prompts/ /path/to/your/repo/.github/prompts/
```

Commands appear as slash commands in Copilot Chat (VS Code, JetBrains). 6 key commands available.

### Method 5: Cursor IDE

Copy the rules file to your project:

```bash
mkdir -p /path/to/your/project/.cursor/rules
cp cursor/rules/matlab-development.mdc /path/to/your/project/.cursor/rules/
```

The rules apply when `.m`, `.mlx`, or `.mlapp` files are in context.

### MCP Server Setup (Optional, All Agents)

The MATLAB MCP Server enables live code execution across any agent:

1. Install from [github.com/matlab/matlab-mcp-server](https://github.com/matlab/matlab-mcp-server)
2. Configure your agent (see [MCP Integration Guide](mcp-integration.md))
3. Verify with `/matlab-toolboxes` (Claude Code) or check toolbox listing

## Configuration

### Command Customization

Individual commands can be customized by editing their markdown files in the `commands/` directory.
To use your edited copy, install from your clone (Method 2) or load it with `--plugin-dir` (Method 3).

## Updating

```bash
/plugin marketplace update matlab-slash-commands
/plugin update matlab-slash-commands
```

From a local clone, run `git pull` in the clone first.

## Troubleshooting

### Commands Not Appearing

1. Run `/plugin` and check that `matlab-slash-commands` is installed and enabled
2. Check the plugin files from a terminal in the clone:
```bash
claude plugin validate .
```
3. Restart Claude Code

### Command Execution Errors

1. Check command file exists in correct location
2. Verify markdown frontmatter is properly formatted
3. Ensure no syntax errors in command content

### MCP Server Not Connecting

1. Verify MATLAB is installed and on the PATH
2. Check the MCP server logs for errors
3. Ensure the MATLAB MCP Server is running
4. See [MCP Integration Guide](mcp-integration.md) for detailed troubleshooting

## Verification Tests

After installation, test these commands:

```
# Test documentation generation
/matlab-readme

# Test function documentation
/matlab-docs myFunction

# Test code explanation
/matlab-explain

# Test optimization
/matlab-optimize
```

## Uninstallation

```bash
/plugin uninstall matlab-slash-commands
```

To remove the marketplace as well, run `/plugin marketplace remove matlab-slash-commands`.

## Getting Help

- [GitHub Issues](https://github.com/matlab/slash-commands/issues)
- [MATLAB Central](https://www.mathworks.com/matlabcentral/)
- [Claude Code Documentation](https://code.claude.com/docs)

## Next Steps

After installation:
1. Read the [Usage Guide](usage-guide.md)
2. Review [Command Reference](command-reference.md)
3. Try example workflows in the main README
4. Customize commands for your development process
