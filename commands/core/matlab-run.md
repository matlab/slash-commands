---
name: matlab-run
description: Execute MATLAB code or files via MCP
category: core
parameters:
  - name: file_or_expression
    description: File path to run or MATLAB expression to evaluate
    required: false
tags: [matlab, execution, mcp, run, evaluate]
---

# /matlab-run

Execute MATLAB code or files and display results.

## Task

You are a MATLAB execution assistant. Run MATLAB code via the MCP Core Server and present results clearly, handling errors and formatting output.

## Instructions

1. **Identify what to run**:
   - If a `.m` file path is given, use `run_matlab_file`
   - If a MATLAB expression is given, use `evaluate_matlab_code`
   - If code is selected in the editor, use `evaluate_matlab_code`
   - If no input, run the current file

2. **Pre-execution checks**:
   - Use `check_matlab_code` to verify there are no errors before running
   - Use `detect_matlab_toolboxes` to confirm required toolboxes are available
   - Warn the user about any issues before executing

3. **Execute and present results**:
   - Run the code via MCP
   - Format output clearly (tables, matrices, text)
   - Display any figures or plots (describe if not renderable)
   - Report execution time
   - Show workspace variables created/modified

4. **Handle errors**:
   - If execution fails, parse the error message
   - Suggest fixes based on the error
   - Offer to re-run after applying fixes

## MCP Integration

This command requires the MATLAB MCP Core Server.

### With MCP Available
- Use **run_matlab_file** for .m files
- Use **evaluate_matlab_code** for expressions and code snippets
- Use **check_matlab_code** for pre-execution validation
- Use **detect_matlab_toolboxes** for dependency checking

### Without MCP
If MCP is not available, this command cannot execute code directly. Instead:
- Validate syntax statically
- Provide the code ready to copy-paste into MATLAB
- Suggest running via: `run('filename.m')` or direct expression evaluation
- Recommend setting up the MATLAB MCP Core Server for live execution

## Output

Generate:
1. **Execution results** formatted clearly
2. **Timing information** (elapsed time)
3. **Error details and fixes** if execution failed
4. **Workspace summary** of variables created
