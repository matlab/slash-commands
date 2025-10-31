# Usage Guide

Learn how to effectively use MATLAB Slash Commands in your development workflow.

## Getting Started

### Basic Command Usage

All commands start with `/matlab-` followed by the command name:

```
/matlab-test
/matlab-optimize
/matlab-readme
```

### Command Parameters

Some commands accept parameters:

```
/matlab-docs functionName
/matlab-test calculateMetrics
/matlab-livescript "Signal Processing"
```

### Working with Selected Code

Many commands operate on selected code in your editor:

1. Select the code you want to process
2. Run the command (e.g., `/matlab-optimize`)
3. The command analyzes and processes the selected code

## Workflow Examples

### 1. Starting a New Project

```matlab
% Step 1: Define requirements
/matlab-refine "Create image processing pipeline for medical images"

% Step 2: Generate project structure and README
/matlab-readme

% Step 3: Create main function with documentation
/matlab-docs processMedialImages
```

### 2. Test-Driven Development (TDD)

```matlab
% Step 1: Define function requirements
/matlab-refine "Statistical analysis function for time series"

% Step 2: Generate tests before implementation
/matlab-test analyzeTimeSeries
/matlab-property-test analyzeTimeSeries

% Step 3: Implement function to pass tests
function results = analyzeTimeSeries(data, options)
    % Implementation here
end

% Step 4: Run tests to verify
```

### 3. Optimizing Existing Code

```matlab
% Step 1: Select the code to optimize
% (Select your function in the editor)

% Step 2: Apply optimizations
/matlab-optimize

% Step 3: Add error handling
/matlab-errors

% Step 4: Verify with tests
/matlab-test
```

### 4. Documentation Pipeline

```matlab
% Step 1: Document individual functions
/matlab-docs myFunction1
/matlab-docs myFunction2

% Step 2: Create Live Script tutorials
/matlab-livescript "Getting Started Tutorial"

% Step 3: Generate project README
/matlab-readme
```

## Command Categories

### Documentation Commands

Perfect for creating professional documentation:

- **`/matlab-readme`**: Complete project documentation
- **`/matlab-docs`**: Function-level documentation
- **`/matlab-livescript`**: Interactive tutorials

**Best Practice**: Document as you code, not after.

### Testing Commands

Ensure code reliability:

- **`/matlab-test`**: Unit tests with coverage
- **`/matlab-property-test`**: Mathematical property verification

**Best Practice**: Write tests before or immediately after implementation.

### Quality Commands

Improve code quality and performance:

- **`/matlab-optimize`**: Performance enhancements
- **`/matlab-errors`**: Robust error handling

**Best Practice**: Optimize after functionality is complete and tested.

### Development Commands

Understand and refine code:

- **`/matlab-explain`**: Understand complex algorithms
- **`/matlab-refine`**: Clarify vague requirements

**Best Practice**: Use early in development to clarify goals.

## Advanced Usage

### Chaining Commands

Commands can be used in sequence for comprehensive development:

```matlab
% Complete development pipeline
/matlab-refine "initial idea"
    ↓
/matlab-test functionName
    ↓
(implement function)
    ↓
/matlab-optimize
    ↓
/matlab-errors
    ↓
/matlab-docs functionName
    ↓
/matlab-readme
```

### Customizing Output

Commands generate customizable output. After generation:

1. Review the generated code
2. Modify as needed for your specific requirements
3. Integrate with your existing codebase

### Integration with MATLAB Tools

Generated code works with MATLAB's built-in tools:

```matlab
% Run generated tests
results = runtests('FunctionNameTest.m');

% Check code quality
checkcode('optimizedFunction.m');

% Generate documentation
publish('functionName.m', 'html');
```

## Tips and Tricks

### 1. Effective Refinement

When using `/matlab-refine`:
- Start with high-level description
- Include constraints and requirements
- Specify performance needs
- Mention available toolboxes

### 2. Comprehensive Testing

For thorough testing:
```matlab
% Generate both types of tests
/matlab-test myFunction
/matlab-property-test myFunction
```

### 3. Optimization Strategy

Before optimizing:
1. Profile your code first
2. Identify bottlenecks
3. Apply `/matlab-optimize` to hot spots
4. Measure improvements

### 4. Documentation Maintenance

Keep documentation current:
- Update docs when function signature changes
- Regenerate README for new features
- Create Live Scripts for complex workflows

## Common Patterns

### Pattern 1: Feature Development

```matlab
/matlab-refine → implement → /matlab-test → /matlab-docs
```

### Pattern 2: Code Review

```matlab
/matlab-explain → /matlab-optimize → /matlab-errors
```

### Pattern 3: Legacy Code

```matlab
/matlab-explain → /matlab-test → refactor → /matlab-docs
```

### Pattern 4: Research Code

```matlab
/matlab-property-test → /matlab-livescript → /matlab-readme
```

## Troubleshooting

### Command Not Working

1. Check command syntax
2. Verify code selection (if required)
3. Check for required parameters
4. Review error messages

### Generated Code Issues

1. Review MATLAB version compatibility
2. Check required toolboxes
3. Verify input assumptions
4. Adjust parameters and regenerate

### Performance Concerns

1. For large codebases, process in sections
2. Use specific function names rather than wildcards
3. Consider breaking complex functions into smaller units

## Best Practices Summary

1. **Start with requirements**: Use `/matlab-refine` first
2. **Test early and often**: Generate tests before/during development
3. **Optimize when stable**: Don't optimize prematurely
4. **Document continuously**: Keep docs in sync with code
5. **Iterate as needed**: Commands can be run multiple times

## Quick Reference Card

| Task | Command | When to Use |
|------|---------|-------------|
| Clarify requirements | `/matlab-refine` | Project start |
| Generate tests | `/matlab-test` | Before/after implementation |
| Optimize speed | `/matlab-optimize` | After functionality complete |
| Add robustness | `/matlab-errors` | Before production |
| Document function | `/matlab-docs` | After implementation |
| Create tutorial | `/matlab-livescript` | For teaching/sharing |
| Document project | `/matlab-readme` | Project milestones |
| Understand code | `/matlab-explain` | Working with unknown code |

## Next Steps

- Review [Command Reference](command-reference.md) for detailed command options
- Check [Examples](../examples/) for complete workflows
- See [Contributing](../CONTRIBUTING.md) to add custom commands