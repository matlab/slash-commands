# MCP Integration Guide

This guide describes how to connect the [MATLAB MCP Server](https://github.com/matlab/matlab-mcp-server) to your agent and how the slash commands use it.

## The MATLAB MCP Server

The MATLAB MCP Server connects AI agents to MATLAB through the Model Context Protocol (MCP).
It works with any agent that supports MCP and provides five tools:

| Tool | What it does |
|------|--------------|
| `check_matlab_code` | Runs the Code Analyzer on a `.m` file without running the file |
| `evaluate_matlab_code` | Runs MATLAB code and returns the Command Window output |
| `run_matlab_file` | Runs a `.m` or `.p` script and returns the output |
| `run_matlab_test_file` | Runs a test file and returns the test results |
| `detect_matlab_toolboxes` | Lists the installed MATLAB release and toolboxes, with versions |

The server also provides two MCP resources:

| Resource | URI | Contents |
|----------|-----|----------|
| `matlab_coding_guidelines` | `guidelines://coding` | MATLAB coding standards for naming, formatting, comments, performance, and error handling |
| `plain_text_live_code_guidelines` | `guidelines://plain-text-live-code` | Rules for plain-text Live Scripts, which run in MATLAB R2025a or later |

## Setup

### Prerequisites

- MATLAB R2021a or later, on the system PATH
- The server binary for your platform from the [latest release](https://github.com/matlab/matlab-mcp-server/releases/latest)

The [Agentic Toolkit Installer](https://github.com/matlab/agentic-toolkit-installer) sets up the server.
To set it up manually, follow the steps below.
On macOS, the server README gives the download commands for Apple silicon and Intel.
Before you run the binary on macOS, make it executable with `chmod +x`.

### Claude Code

```bash
claude mcp add --transport stdio matlab -- /fullpath/to/matlab-mcp-server-binary
```

To pass server arguments, add them after the `--` separator:

```bash
claude mcp add --transport stdio matlab -- /fullpath/to/matlab-mcp-server-binary --initial-working-folder=/home/username/myproject
```

To remove the server, run `claude mcp remove matlab`.

### Claude Desktop

1. Install the Filesystem extension so that Claude can read and write your files.
   In **Settings > Extensions > Browse extensions**, search for Filesystem, install it, select the folders it can access, and enable it.
2. Download `matlab-mcp-server.mcpb` from the [latest release](https://github.com/matlab/matlab-mcp-server/releases/latest).
3. Double-click the file and click **Install**, or install it from **Settings > Extensions > Advanced Settings > Install Extension**.
4. To set server arguments, open **Settings > Extensions > Configure**.

### GitHub Copilot in VS Code

Create `.vscode/mcp.json` in your workspace:

```json
{
  "servers": {
    "matlab": {
      "type": "stdio",
      "command": "/fullpath/to/matlab-mcp-server-binary",
      "args": []
    }
  }
}
```

On Windows, escape the backslashes in paths, for example `C:\\tools\\matlab-mcp-server-windows-x64.exe`.
For details, see [Add and manage MCP servers in VS Code](https://code.visualstudio.com/docs/copilot/customization/mcp-servers).

### Cursor

Add the server to `.cursor/mcp.json` in your project:

```json
{
  "mcpServers": {
    "matlab": {
      "command": "/fullpath/to/matlab-mcp-server-binary",
      "args": []
    }
  }
}
```

### Server Arguments

| Argument | What it does | Default |
|----------|--------------|---------|
| `--matlab-root` | MATLAB installation folder to start, without `/bin` | First MATLAB on the system PATH |
| `--initialize-matlab-on-startup=true` | Starts MATLAB when the server starts | MATLAB starts on the first tool call |
| `--initial-working-folder` | Folder where MATLAB starts | The agent's first MCP root; otherwise, your home folder on Linux or your Documents folder on Windows and macOS |
| `--matlab-display-mode` | `desktop` shows the MATLAB desktop, `nodesktop` hides it | `desktop` |
| `--matlab-session-mode` | `new` starts a new MATLAB session, `existing` connects to a running session, `auto` tries to connect and otherwise starts a new session | `auto` |
| `--extension-file` | JSON file that defines custom MCP tools; repeat the argument for multiple files | None |
| `--log-folder` | Folder for server log files | The system temporary folder |
| `--log-level` | `debug`, `info`, `warn`, or `error` | `info` |
| `--disable-telemetry=true` | Turns off anonymized usage data collection | Collection on |

You can also set each argument as an environment variable.
To form the variable name, add the prefix `MW_MCP_SERVER_`, convert the argument name to uppercase, and replace hyphens with underscores, for example `MW_MCP_SERVER_MATLAB_ROOT`.
Command-line arguments take precedence over environment variables.

To connect to a MATLAB session that is already open (R2023a or later), run the server once with `--setup-matlab`, and then run `shareMATLABSession()` in that session.
For the full steps, see the [server README](https://github.com/matlab/matlab-mcp-server#arguments).

### Check the Connection

In Claude Code, run `/matlab-toolboxes`.
When the server is connected, the command lists the products installed in the MATLAB session that the server uses.

## How the Commands Use the Server

When the server is connected, every command checks its output in MATLAB.

| Command | Tools it uses | What the server adds |
|---------|---------------|----------------------|
| `/matlab-check` | `check_matlab_code`, `evaluate_matlab_code`, `guidelines://coding` | Code Analyzer results for the file |
| `/matlab-run` | `evaluate_matlab_code`, `run_matlab_file`, `run_matlab_test_file`, `check_matlab_code`, `detect_matlab_toolboxes` | Runs the code and selects the tool based on the input |
| `/matlab-run-tests` | `run_matlab_test_file`, `evaluate_matlab_code`, `check_matlab_code`, `detect_matlab_toolboxes` | Test results and coverage |
| `/matlab-test` | `run_matlab_test_file`, `evaluate_matlab_code`, `check_matlab_code`, `detect_matlab_toolboxes` | Runs the new tests |
| `/matlab-property-test` | `run_matlab_test_file`, `evaluate_matlab_code`, `check_matlab_code` | Runs the new tests |
| `/matlab-optimize` | `evaluate_matlab_code`, `run_matlab_file`, `run_matlab_test_file`, `check_matlab_code`, `detect_matlab_toolboxes` | Profiles the code, times it before and after, and checks the results match |
| `/matlab-errors` | `evaluate_matlab_code`, `run_matlab_test_file`, `check_matlab_code`, `detect_matlab_toolboxes` | Runs invalid inputs to confirm each error |
| `/matlab-docs` | `evaluate_matlab_code`, `check_matlab_code` | Runs `help` and the example |
| `/matlab-readme` | `evaluate_matlab_code`, `run_matlab_file`, `check_matlab_code`, `detect_matlab_toolboxes` | Confirms the required products and runs the examples |
| `/matlab-livescript` | `evaluate_matlab_code`, `run_matlab_file`, `check_matlab_code`, `detect_matlab_toolboxes`, `guidelines://plain-text-live-code` | Checks the release and toolboxes, and runs the script |
| `/matlab-explain` | `evaluate_matlab_code`, `check_matlab_code`, `detect_matlab_toolboxes` | Runs sections to confirm behavior |
| `/matlab-refine` | `evaluate_matlab_code`, `detect_matlab_toolboxes` | Confirms the release and installed toolboxes |
| `/matlab-toolboxes` | `detect_matlab_toolboxes`, `evaluate_matlab_code` | Lists the products installed in the running MATLAB session |

### Without the Server

`/matlab-run` and `/matlab-run-tests` check the code and provide the MATLAB commands to run.
The other commands write their output and state what to run in MATLAB to confirm it.

## Running Without the Desktop

With `--matlab-display-mode=nodesktop`, MATLAB runs without its desktop.
Commands that need a graphical interface, such as `edit`, `open`, `open_system`, `uifigure`, and `appdesigner`, still open windows.

## Troubleshooting

### The Server Does Not Connect

1. Check that MATLAB R2021a or later is installed and on the system PATH, or set `--matlab-root`.
2. Check the binary path in your agent's MCP configuration.
3. Run the binary with `--version` to confirm it starts.
4. Run the server with `--log-level=debug` and read the log in the log folder.

### The First Call Is Slow

By default, MATLAB starts on the first tool call.
To start MATLAB when the server starts, use `--initialize-matlab-on-startup=true`.

### A Toolbox Is Missing

Check that the toolbox is installed and licensed.
Run `ver` in the MATLAB installation that the server uses, which `--matlab-root` sets.
