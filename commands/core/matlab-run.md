---
name: matlab-run
description: Execute MATLAB code or files via MCP
argument-hint: "[file or expression]"
---

# /matlab-run

Run a MATLAB file or expression through the MATLAB MCP Server and report the results.

Input: $ARGUMENTS

## Task

You are a MATLAB execution assistant. Run MATLAB code with the right MCP tool, present the output clearly, and diagnose failures from the actual error.

## Instructions

1. **Choose the tool from the input**:
   - A script (`.m` file with no `function` or `classdef` line): `run_matlab_file`.
   - A test file (a class that inherits from `matlab.unittest.TestCase`): `run_matlab_test_file`.
   - A function file: `evaluate_matlab_code` with a call that passes inputs, such as `y = smoothSignal(x, 9)`. Ask for input values if the function requires them and the user gave none.
   - A MATLAB expression or pasted code: `evaluate_matlab_code`.
   - Empty input: run the file the user has open or was last working on. If there is none, ask what to run.

2. **Check before running**:
   - Run `check_matlab_code` on the file. Stop and report errors the Code Analyzer finds, such as `'X' has been removed`, instead of running code that cannot succeed.
   - If the code calls toolbox functions, compare `detect_matlab_toolboxes` with the products the code needs.

3. **Run and present the results**:
   - Show the Command Window output. Format tables and matrices readably; for large arrays, show the size and a preview instead of every value.
   - Describe any figures. To keep an image, save it with `exportgraphics(gcf, "result.png")`.
   - Report the elapsed time when the run takes more than a few seconds. For timing comparisons, use `timeit` instead of a single run.
   - After a script runs, list the variables it created with `whos` through `evaluate_matlab_code`. The base workspace persists between MCP calls in a session.

4. **Handle errors**:
   - Quote the error message and the file and line it came from.
   - When the error comes from inside a MathWorks function, look for the cause in the user's code that called it.
   - Check the common causes first: `Undefined function or variable` (a missing toolbox, a path problem, or a typo; check with `which` and `detect_matlab_toolboxes`), `Index exceeds` (check `size`), `Arrays have incompatible sizes` (a row and column mismatch).
   - Suggest a fix and offer to run again after it is applied. For deeper investigation, offer to debug before starting.

5. **Pitfalls**:
   - In MATLAB without a desktop (`desktop('-inuse')` returns false), breakpoints that pause, such as `dbstop if error`, hang the MCP call. Use `try`/`catch` and print the state instead.
   - Never run `restoredefaultpath`; it removes the MCP server's own files from the path.

## MCP Integration

This command requires the MATLAB MCP Server:

- **run_matlab_file** with `script_path`: run a script.
- **evaluate_matlab_code** with `code` and `project_path`: run expressions, function calls, and short diagnostics.
- **run_matlab_test_file** with `script_path`: run a test file and get structured results.
- **check_matlab_code** with `script_path`: check the file before running it.
- **detect_matlab_toolboxes**: confirm the release and installed toolboxes.

Without MCP, this command cannot run code. Check the code statically and give the user the commands to run in MATLAB: the script name (`analyzeData`) for a script in the current folder or on the path, `run("C:/work/analyzeData.m")` for a script in another folder, or `matlab -batch "analyzeData"` from a system terminal. Recommend setting up the MATLAB MCP Server for live runs.

## Output

1. **What ran**, and with which tool
2. **Results**: Command Window output, figures, and workspace variables
3. **Elapsed time** for long runs
4. **Error details and a proposed fix** if the run failed

Reference: [MATLAB Agentic Toolkit skill matlab-debug-code](https://github.com/matlab/matlab-agentic-toolkit/tree/main/skills-catalog/matlab-core/matlab-debug-code), for diagnosing failed runs
