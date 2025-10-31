# MATLAB Slash Commands for Claude Code

A collection of slash commands for MATLAB development workflows in Claude Code. These commands provide access to MATLAB development capabilities including documentation generation, testing, optimization, and code analysis.

## Features

- **Commands** covering documentation, testing, quality, and development workflows
- **Integrated with MATLAB Best Practices** from matlab/prompts and matlab/skills repositories
- **Templates** for tests, documentation, and code optimization
- **Optimizations** leveraging vectorization and built-in functions
- **Error Handling** patterns and input validation

## Installation

### Via Claude Code Marketplace (Recommended)

Once published to the Claude Code marketplace, you can install directly:

```bash
# Install from marketplace
/plugin install matlab-slash-commands
```

### Via GitHub Repository

```bash
# Install directly from GitHub
/plugin install github:matlab/slash-commands
```

### Manual Installation

1. Clone this repository:
```bash
git clone https://github.com/matlab/slash-commands.git
```

2. Navigate to the repository:
```bash
cd slash-commands
```

3. The plugin is ready to use with the provided `.claude-plugin/` directory

4. For system-wide installation, copy the plugin files:
```bash
# Windows
xcopy /E /I .claude-plugin %APPDATA%\Claude\plugins\matlab-slash-commands

# macOS/Linux
cp -r .claude-plugin ~/.claude/plugins/matlab-slash-commands
```

5. Restart Claude Code or reload plugins using `/plugin reload`

## Quick Start

### Generate Project Documentation
```
/matlab-readme
```
Analyzes your MATLAB project and generates a README.md with project structure, requirements, and usage examples.

### Create Unit Tests
```
/matlab-test myFunction
```
Generates a test class with unit tests, edge cases, and performance benchmarks for your MATLAB function.

### Optimize Performance
```
/matlab-optimize
```
Analyzes selected code and applies MATLAB-specific optimizations including vectorization, preallocation, and efficient built-in usage.

## Available Commands

### Core Documentation Commands

| Command | Description | Example |
|---------|-------------|---------|
| `/matlab-readme` | Generate project README | `/matlab-readme` |
| `/matlab-docs` | Document MATLAB function with help text | `/matlab-docs functionName` |
| `/matlab-livescript` | Create formatted Live Script | `/matlab-livescript "Signal Processing Demo"` |

### Testing & Quality Commands

| Command | Description | Example |
|---------|-------------|---------|
| `/matlab-test` | Generate unit tests for functions | `/matlab-test calculateMetrics` |
| `/matlab-property-test` | Create property-based tests | `/matlab-property-test matrixOperation` |
| `/matlab-optimize` | Optimize code performance | `/matlab-optimize` |
| `/matlab-errors` | Add error handling and validation | `/matlab-errors` |

### Development Commands

| Command | Description | Example |
|---------|-------------|---------|
| `/matlab-explain` | Explain code functionality and algorithms | `/matlab-explain` |
| `/matlab-refine` | Refine prompts into detailed specifications | `/matlab-refine "process sensor data"` |

## Command Details

### `/matlab-readme` - Project Documentation Generator
Scans your project directory and creates a README with:
- Project overview and features
- Installation instructions
- Usage examples with code
- API documentation
- Testing instructions
- License information

### `/matlab-docs` - Function Documentation
Generates MATLAB help text following MathWorks standards:
- H1 line and detailed description
- Input/output specifications
- Usage examples
- Error conditions
- See also references

### `/matlab-test` - Unit Test Generator
Creates test classes using MATLAB Unit Testing Framework:
- Setup and teardown methods
- Parameterized tests
- Performance benchmarks
- Edge case validation
- Mock object suggestions

### `/matlab-optimize` - Performance Optimizer
Applies MATLAB-specific optimizations:
- Vectorization of loops
- Preallocation strategies
- Built-in function usage
- Memory optimization
- Parallel computing suggestions

### `/matlab-errors` - Error Handling
Adds error handling:
- Input validation with arguments blocks
- Try-catch patterns
- Custom error messages
- Warning management
- Resource cleanup

## Example Workflows

### Complete Function Development
```matlab
% 1. Start with requirements refinement
/matlab-refine "Create function to analyze time series data"

% 2. Implement the function based on refined specs
function results = analyzeTimeSeries(data, options)
    % Implementation here
end

% 3. Add documentation
/matlab-docs analyzeTimeSeries

% 4. Optimize for performance
/matlab-optimize

% 5. Add error handling
/matlab-errors

% 6. Generate unit tests
/matlab-test analyzeTimeSeries

% 7. Create project documentation
/matlab-readme
```

### Test-Driven Development
```matlab
% 1. Define requirements
/matlab-refine "Statistical analysis function"

% 2. Generate tests first
/matlab-test statisticalAnalysis
/matlab-property-test statisticalAnalysis

% 3. Implement to pass tests
% ... write code ...

% 4. Optimize and document
/matlab-optimize
/matlab-docs statisticalAnalysis
```

## Integration with MATLAB Workflows

These commands integrate seamlessly with:
- **MATLAB Editor**: Copy generated code directly
- **Live Editor**: Create formatted Live Scripts
- **Testing Framework**: Compatible with `runtests` command
- **Code Analyzer**: Follows mlint guidelines
- **Doc Generation**: Works with `publish` and `help`

## Best Practices

1. **Start with `/matlab-refine`** to clarify requirements
2. **Use `/matlab-test`** early for test-driven development
3. **Apply `/matlab-optimize`** after functionality is complete
4. **Always add `/matlab-errors`** for production code
5. **Document with `/matlab-docs`** for team collaboration

## Requirements

- Claude Code CLI
- MATLAB development environment (for running generated code)
- Optional: MATLAB toolboxes for specific functionality

## Contributing

We welcome contributions! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on:
- Adding new commands
- Improving existing commands
- Reporting issues
- Suggesting enhancements

### Creating New Commands

1. Use the template in `templates/command-template.md`
2. Follow the established command structure
3. Add comprehensive examples
4. Update plugin.json
5. Submit a pull request

## License

BSD 3-Clause License - see [LICENSE](LICENSE) file.

Copyright (c) 2025, The MathWorks, Inc.

## Related Projects

- [matlab/prompts](https://github.com/matlab/prompts) - Collection of MATLAB prompts for AI assistants
- [matlab/skills](https://github.com/matlab/skills) - Claude Code skills for MATLAB

## Support

- **Issues**: [GitHub Issues](https://github.com/matlab/slash-commands/issues)
- **Discussions**: [MATLAB Central](https://www.mathworks.com/matlabcentral/)
- **Documentation**: [Command Reference](docs/command-reference.md)

