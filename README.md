# MATLAB Slash Commands

Slash commands for MATLAB development workflows across multiple AI coding agents. Provides documentation generation, testing, optimization, code analysis, and live execution via MCP.

## Multi-Agent Support

| Agent | Format | Commands | Install |
|-------|--------|----------|---------|
| **Claude Code** | Plugin | All 13 | `/plugin install github:matlab/slash-commands` |
| **GitHub Copilot** | `.prompt.md` | 6 key commands | Copy `copilot/prompts/` to `.github/prompts/` |
| **Cursor IDE** | `.mdc` rules | Rules (always-on) | Copy `cursor/rules/` to `.cursor/rules/` |
| **Any MCP agent** | MCP server | Via MATLAB MCP Core Server | See [MCP Guide](docs/mcp-integration.md) |

## MCP Integration

When the [MATLAB MCP Core Server](https://github.com/matlab/matlab-mcp-core-server) is connected, commands gain live capabilities:

| MCP Tool | What It Enables |
|----------|----------------|
| `check_matlab_code` | Real Code Analyzer diagnostics |
| `evaluate_matlab_code` | Execute MATLAB expressions, benchmark code |
| `run_matlab_file` | Run .m files and return output |
| `run_matlab_test_file` | Execute test suites and report results |
| `detect_matlab_toolboxes` | List installed toolboxes |

All commands work without MCP. They generate code and instructions as before. MCP adds validation, execution, and measurement. See [MCP Integration Guide](docs/mcp-integration.md).

## Installation

### Claude Code (Full Support)

```bash
/plugin install github:matlab/slash-commands
```

### GitHub Copilot

```bash
cp -r copilot/prompts/ .github/prompts/
```

### Cursor IDE

```bash
mkdir -p .cursor/rules
cp cursor/rules/matlab-development.mdc .cursor/rules/
```

### Manual / Development

```bash
git clone https://github.com/matlab/slash-commands.git
```

## Available Commands

### Core Commands

| Command | Description | MCP Enhanced |
|---------|-------------|:------------:|
| `/matlab-readme` | Generate project README | Yes |
| `/matlab-docs` | Document MATLAB functions | Yes |
| `/matlab-livescript` | Create formatted Live Scripts | Yes |
| `/matlab-check` | Run Code Analyzer on code | **MCP** |
| `/matlab-run` | Execute MATLAB code or files | **MCP** |

### Testing Commands

| Command | Description | MCP Enhanced |
|---------|-------------|:------------:|
| `/matlab-test` | Generate unit tests | Yes |
| `/matlab-property-test` | Create property-based tests | Yes |
| `/matlab-run-tests` | Run test suite and report results | **MCP** |

### Quality Commands

| Command | Description | MCP Enhanced |
|---------|-------------|:------------:|
| `/matlab-optimize` | Optimize code performance | Yes |
| `/matlab-errors` | Add error handling and validation | Yes |

### Development Commands

| Command | Description | MCP Enhanced |
|---------|-------------|:------------:|
| `/matlab-explain` | Explain code functionality | Yes |
| `/matlab-refine` | Refine requirements into specs | Yes |
| `/matlab-toolboxes` | Detect installed toolboxes | **MCP** |

**MCP Enhanced** = works without MCP but gains live capabilities with it
**MCP** = primarily designed for MCP, with static fallback

## Quick Start

### Generate and Validate Tests (with MCP)
```
/matlab-test myFunction        # Generate tests
/matlab-run-tests              # Run them via MCP, see pass/fail
```

### Optimize with Real Benchmarks (with MCP)
```
/matlab-optimize               # Optimizes and benchmarks before/after
```

### Full Development Pipeline
```
/matlab-refine "process sensor data"    # Clarify requirements
/matlab-test processData                # Generate tests
/matlab-check processData.m            # Run Code Analyzer
/matlab-optimize                        # Optimize performance
/matlab-errors                          # Add error handling
/matlab-docs processData               # Generate documentation
/matlab-readme                          # Generate project README
```

## Documentation

- [Command Reference](docs/command-reference.md): Reference for all 13 commands
- [MCP Integration Guide](docs/mcp-integration.md): Setup and usage with MATLAB MCP Core Server
- [Cross-Agent Support](docs/cross-agent-support.md): Using commands with Copilot, Cursor, etc.
- [Usage Guide](docs/usage-guide.md): Development patterns and best practices
- [Installation Guide](docs/installation.md): Setup instructions for all agents
- [Examples](examples/): Complete workflow examples

## Requirements

- An AI coding agent (Claude Code, GitHub Copilot, Cursor, or any MCP-compatible agent)
- MATLAB development environment (for running generated code)
- Optional: [MATLAB MCP Core Server](https://github.com/matlab/matlab-mcp-core-server) for live execution

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on adding commands, improving existing ones, and maintaining cross-agent formats.

## License

BSD 3-Clause License. See [LICENSE](LICENSE).

Copyright (c) 2025, The MathWorks, Inc.

## Related Projects

- [matlab/matlab-mcp-core-server](https://github.com/matlab/matlab-mcp-core-server): MATLAB MCP server for AI agent integration
- [matlab/prompts](https://github.com/matlab/prompts): MATLAB prompts for AI assistants and copilots
- [matlab/skills](https://github.com/matlab/skills): Agents Skills for MATLAB
