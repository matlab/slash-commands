# MCP Integration Guide

This guide covers how to connect the [MATLAB MCP Server](https://github.com/matlab/matlab-mcp-server) to your agent and how the slash commands use it.

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

The [Agentic Toolkit Installer](https://github.com/matlab/agentic-toolkit-installer) sets up the server for you.
The steps below set it up by hand.
On macOS, the server README gives the download commands for Apple silicon and Intel, and the binary needs `chmod +x` before it runs.

### Claude Code

```bash
claude mcp add --transport stdio matlab -- /fullpath/to/matlab-mcp-server-binary
```

Server arguments go after the `--` separator:

```bash
claude mcp add --transport stdio matlab -- /fullpath/to/matlab-mcp-server-binary --initial-working-folder=/home/username/myproject
```

To remove the server, run `claude mcp remove matlab`.

### Claude Desktop

1. Install the Filesystem extension so Claude can read and write your files: **Settings > Extensions > Browse extensions**, search for Filesystem, install it, choose the folders it can access, and enable it.
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

On Windows, escape the backslashes in paths, as in `C:\\tools\\matlab-mcp-server-windows-x64.exe`.
See [Add and manage MCP servers in VS Code](https://code.visualstudio.com/docs/copilot/customization/mcp-servers) for details.

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
| `--initial-working-folder` | Folder where MATLAB starts | The agent's first MCP root, else your home folder on Linux or Documents folder on Windows and macOS |
| `--matlab-display-mode` | `desktop` shows the MATLAB desktop, `nodesktop` hides it | `desktop` |
| `--matlab-session-mode` | `new` starts a MATLAB, `existing` connects to a running one, `auto` tries to connect and otherwise starts one | `auto` |
| `--extension-file` | JSON file that defines custom MCP tools; repeat it for several files | None |
| `--log-folder` | Folder for server log files | The system temporary folder |
| `--log-level` | `debug`, `info`, `warn`, or `error` | `info` |
| `--disable-telemetry=true` | Turns off anonymized usage data collection | Collection on |

Each argument can also be set as an environment variable: add the prefix `MW_MCP_SERVER_`, use uppercase, and replace hyphens with underscores, as in `MW_MCP_SERVER_MATLAB_ROOT`.
Command-line arguments take precedence.

To connect to a MATLAB you already have open (R2023a or later), run the server once with `--setup-matlab`, then run `shareMATLABSession()` in that MATLAB.
The [server README](https://github.com/matlab/matlab-mcp-server#arguments) has the full steps.

### Check the Connection

In Claude Code, run `/matlab-toolboxes`.
With the server connected, it lists the products installed in the MATLAB the server started.

## How the Commands Use the Server

Every command checks its output in MATLAB when the server is connected.

| Command | Tools it uses | What the server adds |
|---------|---------------|----------------------|
| `/matlab-check` | `check_matlab_code`, `evaluate_matlab_code`, `guidelines://coding` | Code Analyzer results for the file |
| `/matlab-run` | `evaluate_matlab_code`, `run_matlab_file`, `run_matlab_test_file`, `check_matlab_code`, `detect_matlab_toolboxes` | Runs the code; picks the tool from the input |
| `/matlab-run-tests` | `run_matlab_test_file`, `evaluate_matlab_code`, `check_matlab_code`, `detect_matlab_toolboxes` | Test results and coverage |
| `/matlab-test` | `run_matlab_test_file`, `evaluate_matlab_code`, `check_matlab_code`, `detect_matlab_toolboxes` | Runs the new tests |
| `/matlab-property-test` | `run_matlab_test_file`, `evaluate_matlab_code`, `check_matlab_code` | Runs the new tests |
| `/matlab-optimize` | `evaluate_matlab_code`, `run_matlab_file`, `run_matlab_test_file`, `check_matlab_code`, `detect_matlab_toolboxes` | Profiles the code, times it before and after, and checks the results match |
| `/matlab-errors` | `evaluate_matlab_code`, `run_matlab_test_file`, `check_matlab_code`, `detect_matlab_toolboxes` | Runs bad inputs to confirm each error |
| `/matlab-docs` | `evaluate_matlab_code`, `check_matlab_code` | Runs `help` and the example |
| `/matlab-readme` | `evaluate_matlab_code`, `run_matlab_file`, `check_matlab_code`, `detect_matlab_toolboxes` | Confirms the required products and runs the examples |
| `/matlab-livescript` | `evaluate_matlab_code`, `run_matlab_file`, `check_matlab_code`, `detect_matlab_toolboxes`, `guidelines://plain-text-live-code` | Checks the release and toolboxes, and runs the script |
| `/matlab-explain` | `evaluate_matlab_code`, `check_matlab_code`, `detect_matlab_toolboxes` | Runs sections to confirm behavior |
| `/matlab-refine` | `evaluate_matlab_code`, `detect_matlab_toolboxes` | Confirms the release and installed toolboxes |
| `/matlab-toolboxes` | `detect_matlab_toolboxes`, `evaluate_matlab_code` | Lists the products of the running MATLAB |

### Without the Server

`/matlab-run` and `/matlab-run-tests` check the code and give you the MATLAB commands to run.
The other commands write their output and tell you what to run in MATLAB to confirm it.

## Running Without the Desktop

With `--matlab-display-mode=nodesktop`, MATLAB runs without its desktop.
Commands that need a graphical interface, such as `edit`, `open`, `open_system`, `uifigure`, and `appdesigner`, still open windows.

## Troubleshooting

### The Server Does Not Connect

1. Check that MATLAB R2021a or later is installed and on the system PATH, or set `--matlab-root`.
2. Check the binary path in your agent's MCP configuration.
3. Run the binary with `--version` to confirm it starts.
4. Run with `--log-level=debug` and read the log in the log folder.

### The First Call Is Slow

MATLAB starts on the first tool call.
To start it with the server instead, use `--initialize-matlab-on-startup=true`.

### A Toolbox Is Missing

Check that the toolbox is installed and licensed: run `ver` in the same MATLAB the server uses, which `--matlab-root` sets.
