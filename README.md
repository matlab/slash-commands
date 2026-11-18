# MATLAB Slash Commands

MATLAB Slash Commands is a set of slash commands for MATLAB development in AI coding agents.
The commands write help text, tests, Live Scripts, and READMEs.
They review, speed up, and explain code.
Each command follows the matching skill in the [MATLAB Agentic Toolkit](https://github.com/matlab/matlab-agentic-toolkit).
With the [MATLAB MCP Server](https://github.com/matlab/matlab-mcp-server) connected, the commands also run the code they write and check the results in MATLAB.

## Supported Agents

| Agent | Format | Commands |
|-------|--------|----------|
| Claude Code | Plugin | All 13 |
| GitHub Copilot | `.prompt.md` files | 6: check, docs, optimize, readme, run, test |
| Cursor | `.mdc` rule | One rule that applies to `.m`, `.mlx`, and `.mlapp` files |

## Installation

### Claude Code

```bash
/plugin marketplace add matlab/slash-commands
/plugin install matlab-slash-commands@matlab-slash-commands
```

To try changes to the commands without installing, clone the repository and start Claude Code with `claude --plugin-dir ./slash-commands`.

### GitHub Copilot

From a clone of this repository, copy the prompt files into your project:

```bash
mkdir -p /path/to/project/.github/prompts
cp copilot/prompts/*.prompt.md /path/to/project/.github/prompts/
```

### Cursor

From a clone of this repository, copy the rule into your project:

```bash
mkdir -p /path/to/project/.cursor/rules
cp cursor/rules/matlab-development.mdc /path/to/project/.cursor/rules/
```

See the [Installation Guide](docs/installation.md) for updating, uninstalling, and troubleshooting.

## Commands

| Command | What it does | With the MATLAB MCP Server, it also |
|---------|--------------|-------------------------------------|
| `/matlab-readme` | Writes a README for a MATLAB project | Confirms the required products and runs the examples |
| `/matlab-docs` | Writes help text for a function | Runs `help` and the example |
| `/matlab-livescript` | Writes a plain-text Live Script | Checks the release and toolboxes, and runs the script |
| `/matlab-check` | Reviews code for errors, style, and outdated functions | Runs the Code Analyzer |
| `/matlab-run` | Runs a MATLAB file or expression | Requires the server to run code |
| `/matlab-test` | Writes class-based unit tests | Runs the new tests |
| `/matlab-property-test` | Writes tests for properties that must hold for any input | Runs the new tests |
| `/matlab-run-tests` | Runs a test suite and reports results and coverage | Requires the server to run tests |
| `/matlab-optimize` | Speeds up code and checks that the results do not change | Profiles the code and times it before and after |
| `/matlab-errors` | Adds `arguments` blocks and error identifiers | Runs bad inputs to confirm each error |
| `/matlab-explain` | Explains what code does and how | Runs sections to confirm behavior |
| `/matlab-refine` | Turns a request into a MATLAB specification | Confirms the release and installed toolboxes |
| `/matlab-toolboxes` | Lists installed MathWorks products | Lists the products of the running MATLAB |

Without the server, `/matlab-run` and `/matlab-run-tests` check the code and give you the MATLAB commands to run.
The other commands write their output and tell you what to run in MATLAB to confirm it.
The [MCP Integration Guide](docs/mcp-integration.md) covers server setup and the server tools the commands use.

## Example

Take a request from specification to a tested, documented function.
You write `processData` from the specification after the first command.

```
/matlab-refine process sensor data
/matlab-test processData
/matlab-check processData.m
/matlab-optimize processData.m
/matlab-errors processData.m
/matlab-docs processData
/matlab-readme
```

## Documentation

- [Command Reference](docs/command-reference.md): all 13 commands
- [MCP Integration Guide](docs/mcp-integration.md): setup and use with the MATLAB MCP Server
- [Cross-Agent Support](docs/cross-agent-support.md): Copilot and Cursor formats
- [Usage Guide](docs/usage-guide.md): development patterns
- [Installation Guide](docs/installation.md): setup for each agent
- [Examples](examples/): complete workflows

## Requirements

- Claude Code, GitHub Copilot, or Cursor
- MATLAB, to run the code the commands write
- Optional: the [MATLAB MCP Server](https://github.com/matlab/matlab-mcp-server), which requires MATLAB R2021a or later
- Live Scripts from `/matlab-livescript` require MATLAB R2025a or later

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for how to add commands, change existing ones, and keep the Copilot and Cursor versions in step.

## License

BSD 3-Clause License. See [LICENSE](LICENSE).

Copyright (c) 2025, The MathWorks, Inc.

## Related Projects

- [matlab/matlab-agentic-toolkit](https://github.com/matlab/matlab-agentic-toolkit): MATLAB skills and tools for AI agents
- [matlab/matlab-mcp-server](https://github.com/matlab/matlab-mcp-server): the MATLAB MCP Server
- [matlab/prompts](https://github.com/matlab/prompts): MATLAB prompts for AI coding assistants
- [matlab/agent-skills-playground](https://github.com/matlab/agent-skills-playground): prototype Agent Skills for MATLAB and Simulink, formerly `matlab/skills`
