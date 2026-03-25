# MCP Integration Guide

This guide explains how the MATLAB Slash Commands use the MATLAB MCP Core Server for live code execution, testing, and analysis.

## What is MCP?

The Model Context Protocol (MCP) is a universal standard for connecting AI agents to external tools. The [MATLAB MCP Core Server](https://github.com/matlab/matlab-mcp-core-server) provides 5 tools that any MCP-compatible AI agent can use:

| Tool | Description |
|------|-------------|
| `check_matlab_code` | Run MATLAB Code Analyzer on a .m file (static analysis) |
| `evaluate_matlab_code` | Execute MATLAB code and return command window output |
| `run_matlab_file` | Run a .m script file and return output |
| `run_matlab_test_file` | Execute a MATLAB test file and return comprehensive results |
| `detect_matlab_toolboxes` | List installed MATLAB toolboxes and versions |

The server also exposes MCP resources:

| Resource | URI | Description |
|----------|-----|-------------|
| MATLAB Coding Guidelines | `guidelines://coding` | Coding standards for readability and collaboration |
| Plain Text Live Code Guidelines | `guidelines://plain-text-live-code` | Rules for plain text Live Scripts (R2025a+) |

## Setup

### Prerequisites

- MATLAB R2020b or later installed and on the system PATH
- Download the latest binary for your platform from the [GitHub releases](https://github.com/matlab/matlab-mcp-core-server/releases)

### Configure Your AI Agent

#### Claude Code

```bash
claude mcp add --transport stdio matlab -- /fullpath/to/matlab-mcp-core-server-binary
```

With startup options:
```bash
claude mcp add --transport stdio matlab -- /fullpath/to/matlab-mcp-core-server-binary --initial-working-folder=/home/username/myproject
```

Remove with: `claude mcp remove matlab`

#### Claude Desktop

1. Download the `matlab-mcp-core-server.mcpb` bundle from the [latest release](https://github.com/matlab/matlab-mcp-core-server/releases)
2. Double-click the `.mcpb` file, or install via Settings > Extensions > Advanced Settings > Install Extension
3. Configure arguments via Settings > Extensions > Configure

#### GitHub Copilot (VS Code)

Add to your workspace `mcp.json`:
```json
{
  "servers": {
    "matlab": {
      "type": "stdio",
      "command": "/fullpath/to/matlab-mcp-core-server-binary",
      "args": []
    }
  }
}
```

See [VS Code MCP documentation](https://code.visualstudio.com/docs/copilot/chat/mcp-servers) for more details.

#### Cursor IDE

Add to `.cursor/mcp.json`:
```json
{
  "mcpServers": {
    "matlab": {
      "command": "/fullpath/to/matlab-mcp-core-server-binary",
      "args": []
    }
  }
}
```

### Server Configuration Arguments

| Argument | Description | Default |
|----------|-------------|---------|
| `--matlab-root` | MATLAB installation path (without `/bin`) | First MATLAB on PATH |
| `--initialize-matlab-on-startup=true` | Start MATLAB immediately instead of on first tool call | `false` (lazy start) |
| `--initial-working-folder` | Set MATLAB's startup directory | Platform-dependent user directory |
| `--matlab-display-mode` | `desktop` (default) or `nodesktop` for headless operation | `desktop` |
| `--disable-telemetry=true` | Disable anonymized usage collection | `false` |

### Verify Connection

Run `/matlab-toolboxes` (Claude Code) to verify the MCP server is connected. You should see a list of installed MATLAB toolboxes.

## How Commands Use MCP

### Commands That Benefit Most
| Command | Primary MCP Tool | Enhancement |
|---------|-----------------|-------------|
| `/matlab-check` | `check_matlab_code` | Real Code Analyzer diagnostics |
| `/matlab-run` | `evaluate_matlab_code`, `run_matlab_file` | Live code execution |
| `/matlab-run-tests` | `run_matlab_test_file` | Actual test results |
| `/matlab-toolboxes` | `detect_matlab_toolboxes` | Real toolbox inventory |
| `/matlab-test` | `run_matlab_test_file` | Generate + verify tests pass |
| `/matlab-optimize` | `evaluate_matlab_code` | Benchmark before/after |

### Graceful Degradation
All commands work without MCP. They generate code and instructions as before. MCP adds the ability to validate, execute, and measure in real-time.

## Headless Mode

Set `--matlab-display-mode=nodesktop` to run MATLAB without the desktop GUI. This is useful for agent workflows where you don't need the MATLAB desktop open. Note that GUI-dependent commands (e.g., `plot`) will still open windows even in `nodesktop` mode.

## Troubleshooting

### MCP Server Not Connecting
1. Verify MATLAB is installed and on the PATH
2. Check that the binary path in your MCP configuration is correct
3. Ensure MATLAB is not blocked by firewall or antivirus software
4. Try running the binary directly to check for error messages

### Slow First Response
By default, MATLAB starts on the first tool call (lazy start). The first MCP call may be slow as MATLAB launches. Use `--initialize-matlab-on-startup=true` to start MATLAB when the server launches instead.

### Toolbox Not Detected
Ensure the toolbox is installed and licensed. Run `ver` in MATLAB directly to confirm.
