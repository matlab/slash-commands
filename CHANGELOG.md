# Changelog

All notable changes to the MATLAB Slash Commands plugin will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0] - 2026-03-24

### Added
- **MCP Integration**: All commands now detect and use the MATLAB MCP Core Server when available
  - Live code execution via `evaluate_matlab_code` and `run_matlab_file`
  - Code Analyzer integration via `check_matlab_code`
  - Test execution via `run_matlab_test_file`
  - Toolbox detection via `detect_matlab_toolboxes`
- **4 new MCP-powered commands**:
  - `/matlab-check`: Run Code Analyzer on files or code
  - `/matlab-run`: Execute MATLAB code or files via MCP
  - `/matlab-run-tests`: Run test suite and report results
  - `/matlab-toolboxes`: Detect installed toolboxes and suggest usage
- **Cross-agent support**:
  - GitHub Copilot `.prompt.md` files for 6 key commands
  - Cursor IDE `.mdc` rules file for MATLAB development
- **New documentation**:
  - MCP Integration Guide (`docs/mcp-integration.md`)
  - Cross-Agent Support Guide (`docs/cross-agent-support.md`)
  - MCP workflow example (`examples/mcp-workflow.md`)

### Changed
- All 9 existing commands updated with MCP-aware instruction sections
- Plugin manifests updated with MCP server reference and new commands
- Command template updated with MCP integration section
- README rewritten for multi-agent audience
- Installation guide expanded for Copilot and Cursor
- Command reference expanded for 4 new commands

### Project Stats
- Total commands: 13 (was 9)
- Supported agents: Claude Code, GitHub Copilot, Cursor, any MCP agent
- MCP tools used: check_code, evaluate_code, run_file, run_tests, detect_toolboxes

## [0.1.0] - 2025-10-30

### Added
- Initial plugin structure
- Basic command implementations
- Testing framework integration
- Documentation templates

#### Core Commands
- **`/matlab-readme`** - Generate project README with structure analysis, feature detection, and usage examples
- **`/matlab-docs`** - Create MATLAB function documentation following MathWorks standards with H1 lines, detailed descriptions, and examples
- **`/matlab-livescript`** - Generate MATLAB Live Scripts with proper formatting, sections, and executable code blocks

#### Testing Commands
- **`/matlab-test`** - Generate complete unit test classes using MATLAB Unit Testing Framework
  - Includes setup/teardown methods
  - Parameterized test support
  - Performance benchmarking
  - Edge case validation
  - Mock object integration suggestions
- **`/matlab-property-test`** - Create property-based tests for mathematical invariants
  - Automatic property generation
  - QuickCheck-style testing
  - Mathematical correctness validation

#### Code Quality Commands
- **`/matlab-optimize`** - Apply MATLAB-specific performance optimizations
  - Loop vectorization
  - Memory preallocation
  - Built-in function utilization
  - Parallel computing suggestions
  - JIT compilation optimization
- **`/matlab-errors`** - Add error handling and validation
  - Input validation using arguments blocks
  - Try-catch patterns
  - Custom error classes
  - Warning management
  - Resource cleanup with onCleanup

#### Development Commands
- **`/matlab-explain`** - Provide detailed explanations of MATLAB code
  - Algorithm analysis
  - Complexity assessment
  - Performance characteristics
  - Best practice suggestions
- **`/matlab-refine`** - Transform vague requirements into detailed specifications
  - Structured requirement analysis
  - Edge case identification
  - Interface design
  - Implementation planning

### Features
- **Plugin Architecture** - Modular command structure with `.claude-plugin/plugin.json` configuration
- **Template System** - Reusable command template for creating new slash commands
- **Documentation** - README with examples and development patterns
- **Integration** - Works with the MATLAB development environment
- **Best Practices** - Commands follow MATLAB coding standards and conventions

### Project Structure
- Organized command categories (core, testing, quality, development)
- Standardized command naming with `matlab-` prefix
- Consistent command interface and output format
- Example-driven command documentation

### Documentation
- Detailed README with installation instructions
- Command reference with examples
- Workflow demonstrations
- Contributing guidelines
- License information (BSD-3-Clause)
- `marketplace.json` configuration for Claude Code marketplace publication
- Marketplace installation instructions in README
- Publishing guidelines and version management documentation

---

## Version History Summary

| Version | Date | Highlights |
|---------|------|------------|
| 0.2.0 | 2026-03-24 | MCP integration, 4 new commands, cross-agent support |
| 0.1.0 | 2025-10-30 | Initial release |

## Feedback and Contributions

To contribute:
- Report issues at [GitHub Issues](https://github.com/matlab/slash-commands/issues)
- Submit feature requests through issues
- Contribute new commands via pull requests

For more information, see [CONTRIBUTING.md](CONTRIBUTING.md).