# Installation Guide

This guide describes how to install MATLAB Slash Commands in Claude Code, GitHub Copilot, and Cursor.

## Prerequisites

- Claude Code, GitHub Copilot, or Cursor
- MATLAB, to run the code that the commands write
- Git, to install from a clone or to copy the Copilot and Cursor files

## Claude Code

### Install from the Marketplace

Add this repository as a plugin marketplace, and then install the plugin from it:

```bash
/plugin marketplace add matlab/slash-commands
/plugin install matlab-slash-commands@matlab-slash-commands
```

To install from a terminal instead, run `claude plugin marketplace add matlab/slash-commands` and then `claude plugin install matlab-slash-commands@matlab-slash-commands`.

### Install from a Clone

Clone the repository:

```bash
git clone https://github.com/matlab/slash-commands.git
```

Then add the clone as a marketplace and install the plugin:

```bash
/plugin marketplace add ./slash-commands
/plugin install matlab-slash-commands@matlab-slash-commands
```

### Load a Clone for Development

To edit commands and test them without installing the plugin, start Claude Code with the clone as a plugin folder:

```bash
claude --plugin-dir ./slash-commands
```

Changes to the command files take effect the next time Claude Code starts.

### Check the Installation

1. Type `/matlab-` to list the commands.
2. Run a command, for example `/matlab-explain` with a MATLAB file in the project.

### Update

```bash
/plugin marketplace update matlab-slash-commands
/plugin update matlab-slash-commands
```

If you installed from a clone, run `git pull` in the clone first.

### Uninstall

```bash
/plugin uninstall matlab-slash-commands
```

To remove the marketplace as well, run `/plugin marketplace remove matlab-slash-commands`.

## GitHub Copilot

GitHub Copilot supports 6 of the 13 commands: check, docs, optimize, readme, run, and test.
From a clone of this repository, copy the prompt files into your project:

```bash
mkdir -p /path/to/project/.github/prompts
cp copilot/prompts/*.prompt.md /path/to/project/.github/prompts/
```

The commands appear as slash commands in Copilot Chat, for example `/matlab-check`.

## Cursor

From a clone of this repository, copy the rule into your project:

```bash
mkdir -p /path/to/project/.cursor/rules
cp cursor/rules/matlab-development.mdc /path/to/project/.cursor/rules/
```

The rule applies when `.m`, `.mlx`, or `.mlapp` files are in context.

## MATLAB MCP Server (Optional)

With the [MATLAB MCP Server](https://github.com/matlab/matlab-mcp-server) connected, the commands run the code they write and check the results in MATLAB.

1. Install the server from [github.com/matlab/matlab-mcp-server](https://github.com/matlab/matlab-mcp-server).
2. Add it to your agent, as described in the [MCP Integration Guide](mcp-integration.md).
3. In Claude Code, run `/matlab-toolboxes` to confirm the connection.

## Customize the Commands

Each command is a Markdown file in the `commands/` folder.
To use your edited commands, install the plugin from your clone or load the clone with `--plugin-dir`.

## Troubleshooting

### The Commands Do Not Appear

1. Run `/plugin` and check that `matlab-slash-commands` is installed and enabled.
2. In a terminal in the clone, run `claude plugin validate .` to check the plugin files.
3. Restart Claude Code.

### A Command You Edited Fails

1. Check that the frontmatter at the top of the file starts and ends with `---` and has `name` and `description` fields.
2. Run `claude plugin validate .` in the clone and read its warnings.
   The validator reports a missing frontmatter block as a warning, not an error.
3. Restart Claude Code.

### The MCP Server Does Not Connect

See [Troubleshooting](mcp-integration.md#troubleshooting) in the MCP Integration Guide.

## Get Help

- [GitHub Issues](https://github.com/matlab/slash-commands/issues)
- [MATLAB Central](https://www.mathworks.com/matlabcentral/)
- [Claude Code documentation](https://code.claude.com/docs)

## Next Steps

- [Usage Guide](usage-guide.md)
- [Command Reference](command-reference.md)
- [Examples](../examples/)
