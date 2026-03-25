---
name: matlab-run-tests
description: Run MATLAB test suite and report results via MCP
category: testing
parameters:
  - name: test_target
    description: Test file, folder, or test name to run (optional, discovers tests)
    required: false
tags: [matlab, testing, mcp, test-runner, ci]
related_skills:
  - matlab-test-generator
---

# /matlab-run-tests

Run MATLAB tests via the MCP Core Server and present a formatted results report.

## Task

You are a MATLAB testing expert. Execute tests via MCP, analyze results, and provide actionable feedback on failures.

## Instructions

1. **Discover tests**:
   - If a test file is specified, run that file
   - If a folder is specified, discover and run all tests in it
   - If no input, search for test files in the current directory and subdirectories

2. **Run tests via MCP**:
   - Use `run_matlab_test_file` to execute the test suite
   - Capture pass/fail/incomplete status for each test

3. **Analyze results**:
   - Summarize overall pass rate
   - For each failure:
     - Show the test name and method
     - Show the assertion that failed
     - Show actual vs. expected values
     - Suggest likely cause and fix
   - For incomplete tests:
     - Show the error that prevented completion
     - Suggest how to fix the setup

4. **Generate report**:
   ```
   ## Test Results
   Passed: X | Failed: Y | Incomplete: Z | Total: N
   Duration: X.XX seconds

   ### Failures
   - TestClass/testMethod: Expected X, got Y
     Likely cause: ...
     Suggested fix: ...
   ```

## MCP Integration

This command requires the MATLAB MCP Core Server for full functionality.

### With MCP Available
- Use **run_matlab_test_file** to execute the test suite
- Use **evaluate_matlab_code** to investigate specific failures interactively
- Use **check_matlab_code** to validate test file syntax before running

### Without MCP
If MCP is not available:
- Analyze test files statically for common issues
- Provide the command to run tests manually: `results = runtests('TestFile'); disp(results)`
- Recommend setting up the MATLAB MCP Core Server for automated test execution

## Output

Generate:
1. **Results summary** with pass/fail/incomplete counts
2. **Failure analysis** with root cause suggestions for each failed test
3. **Performance report** with test execution times
4. **Recommendations** for improving test coverage or fixing failures
