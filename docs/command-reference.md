# Command Reference

Reference for all MATLAB Slash Commands, including parameters, options, and examples.

## Core Documentation Commands

### `/matlab-readme`

Generate project documentation by analyzing the codebase.

**Parameters:** None

**Analyzes:**
- Project structure and files
- Main functions and entry points
- Dependencies and requirements
- Existing documentation

**Generates:**
- Project overview
- Installation instructions
- Usage examples
- API documentation
- Testing instructions

**Example:**
```
/matlab-readme
```

**Output:** Complete README.md file ready for your repository

---

### `/matlab-docs`

Create MATLAB function documentation following MathWorks standards.

**Parameters:**
- `function_name` (optional) - Name of function to document

**Features:**
- H1 line and help text
- Input/output specifications
- Usage examples
- Error conditions
- See also references

**Example:**
```
/matlab-docs calculateMetrics
```

**Output:** Complete help text block for the function

---

### `/matlab-livescript`

Generate MATLAB Live Scripts for tutorials and documentation.

**Parameters:**
- `topic` (optional) - Topic or title for the Live Script

**Creates:**
- Formatted sections with %% markers
- Text explanations with % comments
- Executable code blocks
- Visualization examples
- Exercises and solutions

**Example:**
```
/matlab-livescript "Signal Processing Tutorial"
```

**Output:** Plain text .m file formatted for Live Editor

## Testing Commands

### `/matlab-test`

Generate unit tests using MATLAB Unit Testing Framework.

**Parameters:**
- `function_name` (optional) - Function to test

**Generates:**
- Complete test class
- Setup/teardown methods
- Parameterized tests
- Edge case validation
- Performance benchmarks

**Example:**
```
/matlab-test processData
```

**Output:** TestClassName.m file with complete test suite

**Test Categories:**
- Functionality tests
- Edge cases
- Error conditions
- Performance tests
- Regression tests

---

### `/matlab-property-test`

Create property-based tests for mathematical invariants.

**Parameters:**
- `function_name` (optional) - Function to test

**Tests:**
- Mathematical properties
- Invariants
- Algebraic relationships
- Domain constraints

**Example:**
```
/matlab-property-test matrixOperation
```

**Properties Tested:**
- Commutativity
- Associativity
- Distributivity
- Identity elements
- Inverse operations
- Idempotence

## Quality Commands

### `/matlab-optimize`

Optimize MATLAB code for performance and efficiency.

**Parameters:** None (operates on selected code)

**Optimizations:**
- Loop vectorization
- Array preallocation
- Built-in function usage
- Memory optimization
- Parallel computing suggestions

**Example:**
```matlab
% Select code to optimize, then:
/matlab-optimize
```

**Improvements:**
- Execution speed
- Memory usage
- Code readability
- Numerical stability

---

### `/matlab-errors`

Add error handling and input validation.

**Parameters:** None (operates on selected code)

**Adds:**
- Input validation (arguments block)
- Try-catch patterns
- Custom error messages
- Warning management
- Resource cleanup

**Example:**
```matlab
% Select function to enhance, then:
/matlab-errors
```

**Features:**
- Type checking
- Range validation
- Dimension verification
- Error recovery
- Progress reporting

## Development Commands

### `/matlab-explain`

Explain MATLAB code functionality and algorithms.

**Parameters:** None (operates on selected code)

**Provides:**
- Algorithm explanation
- Line-by-line breakdown
- MATLAB idiom clarification
- Performance analysis
- Mathematical background

**Example:**
```matlab
% Select complex code, then:
/matlab-explain
```

**Explains:**
- What the code does
- How it works
- Why design choices were made
- Potential improvements

---

### `/matlab-refine`

Transform vague requirements into detailed specifications.

**Parameters:**
- `initial_prompt` (optional) - Initial requirement description

**Generates:**
- Detailed specifications
- Clarifying questions
- Implementation checklist
- Design decisions
- Test scenarios

**Example:**
```
/matlab-refine "process sensor data and detect anomalies"
```

**Output:**
- Complete function specification
- Input/output definitions
- Performance requirements
- Error handling strategy

## MCP-Powered Commands

These commands are designed primarily for use with the MATLAB MCP Core Server. They provide static fallback when MCP is not available.

---

### `/matlab-check`

Run MATLAB Code Analyzer on files or code.

**Parameters:**
- `file_or_code` (optional) - File path or code to analyze

**MCP Tools Used:** `check_matlab_code`, `evaluate_matlab_code`

**Features:**
- Real Code Analyzer diagnostics (with MCP)
- Issue categorization: errors, warnings, performance, style
- Fix suggestions with corrected code
- Static pattern analysis (without MCP)

**Example:**
```
/matlab-check myFunction.m
```

---

### `/matlab-run`

Execute MATLAB code or files via MCP.

**Parameters:**
- `file_or_expression` (optional) - File path or MATLAB expression

**MCP Tools Used:** `run_matlab_file`, `evaluate_matlab_code`, `check_matlab_code`, `detect_matlab_toolboxes`

**Features:**
- Live code execution with formatted results
- Pre-execution validation
- Error handling with fix suggestions
- Execution timing

**Example:**
```
/matlab-run "x = magic(5); disp(x)"
```

---

### `/matlab-run-tests`

Run MATLAB test suite and report results.

**Parameters:**
- `test_target` (optional) - Test file, folder, or test name

**MCP Tools Used:** `run_matlab_test_file`, `evaluate_matlab_code`, `check_matlab_code`

**Features:**
- Automated test discovery and execution
- Pass/fail/incomplete reporting
- Failure analysis with root cause suggestions
- Performance reporting

**Example:**
```
/matlab-run-tests tests/
```

---

### `/matlab-toolboxes`

Detect installed MATLAB toolboxes and provide recommendations.

**Parameters:** None

**MCP Tools Used:** `detect_matlab_toolboxes`, `evaluate_matlab_code`, `check_matlab_code`

**Features:**
- Installed toolbox inventory
- Project dependency analysis
- Usage recommendations for unused toolboxes
- Missing dependency warnings

**Example:**
```
/matlab-toolboxes
```

## Command Options and Flags

While commands don't have explicit flags, they adapt based on context:

### Context Detection

Commands automatically detect:
- Selected code vs. file context
- Function vs. script context
- Available MATLAB version
- Existing code patterns

### Output Customization

Commands generate output considering:
- Code style in the project
- Existing naming conventions
- Documentation patterns
- Test framework usage

## Output Formats

### Code Output

Generated code follows MATLAB conventions:
```matlab
function output = functionName(input, options)
    arguments
        input (:,:) double
        options.Method string = "default"
    end

    % Implementation
end
```

### Documentation Output

Documentation uses standard MATLAB format:
```matlab
%FUNCTIONNAME Brief description
%   Detailed explanation...
%
%   See also: RELATED_FUNCTION
```

### Test Output

Tests follow MATLAB Unit Testing Framework:
```matlab
classdef TestClass < matlab.unittest.TestCase
    methods (Test)
        function testMethod(testCase)
            % Test implementation
        end
    end
end
```

## Error Messages

Commands provide clear error messages:

| Error | Meaning | Solution |
|-------|---------|----------|
| "No code selected" | Command needs code selection | Select code in editor |
| "Function not found" | Named function doesn't exist | Check function name |
| "Invalid MATLAB syntax" | Code has syntax errors | Fix syntax first |
| "Missing dependencies" | Required toolbox not found | Note requirements |

## Performance Considerations

### Command Execution

- Most commands execute instantly
- Large codebases may take a few seconds
- Commands are stateless (can be rerun)

### Generated Code Performance

Commands optimize for:
- Execution speed
- Memory efficiency
- Numerical stability
- Readability balance

## Version Compatibility

### MATLAB Versions

- **Minimum:** R2019b (for arguments blocks)
- **Recommended:** R2021a or later
- **Legacy support:** Available with modifications

### Feature Availability

| Feature | Required Version |
|---------|-----------------|
| arguments block | R2019b+ |
| string arrays | R2016b+ |
| Live Scripts | R2016a+ |
| Unit Testing | R2013a+ |

## Integration with Other Tools

### MATLAB Tools

Commands work with:
- MATLAB Editor
- Live Editor
- Code Analyzer (mlint)
- Profiler
- Test Runner

### Version Control

Generated code is:
- Git-friendly (consistent formatting)
- Diff-friendly (logical organization)
- Merge-friendly (minimal conflicts)

### MATLAB MCP Core Server

Commands can use the MCP Core Server for:
- Live code execution and validation
- Real Code Analyzer diagnostics
- Automated test execution
- Toolbox detection

See [MCP Integration Guide](mcp-integration.md) for setup.

## Customization

### Modifying Commands

1. Edit command file in `commands/` directory
2. Update frontmatter if needed
3. Reload plugins in Claude Code

### Creating Variations

Copy and modify existing commands:
```bash
cp commands/testing/matlab-test.md commands/testing/matlab-integration-test.md
# Edit the new file
# Update plugin.json
```

## FAQ

**Multiple files.** Commands work on single files or selections. For multiple files, run the command once per file.

**MATLAB not installed.** Commands generate code without requiring MATLAB. You need MATLAB only to run the generated code.

**Modifying existing files.** Commands generate new code. You manually integrate it with existing files.

**Updating command output style.** Edit the command markdown file to customize output format.

## Getting Help

- Command not working: Check [Troubleshooting](usage-guide.md#troubleshooting)
- Report issues: [GitHub Issues](https://github.com/matlab/slash-commands/issues)
- Request features: [Discussions](https://github.com/matlab/slash-commands/discussions)