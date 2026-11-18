---
name: matlab-run-tests
description: Run MATLAB test suite and report results via MCP
argument-hint: "[test file or folder]"
---

# /matlab-run-tests

Run MATLAB tests via the MATLAB MCP Server and present a formatted results report.

Input: $ARGUMENTS

## Task

You are a MATLAB testing expert. Run the requested tests, report the counts, explain each failure, and collect code coverage when the user asks for it.

## Instructions

1. **Resolve the input**:
   - A test file runs that file. A folder runs every test in it. A file and a method (`computeAreaTest/testSquare`) runs that method: pass the file path and `ProcedureName`, since the `Class/method` form only resolves when the class is on the path.
   - Extra words are filters or options: a tag (`Unit`), a name pattern (`*Calculator*`), `strict`, `parallel`, or `coverage`.
   - If the input is empty, run the `tests` folder when it exists, otherwise the current folder with `IncludeSubfolders=true`. If the project has a `buildfile.m` with a test task, mention `buildtool test`.

2. **Run the tests**. Use **run_matlab_test_file** for a single file without options. For everything else, use **evaluate_matlab_code** with `runtests`:
   ```matlab
   results = runtests("tests");                                              % folder
   results = runtests("tests/computeAreaTest.m", ProcedureName="testSquare"); % one method
   results = runtests("tests", Tag="Unit", Name="*Calculator*");             % filters
   results = runtests(pwd, IncludeSubfolders=true);                          % folder tree
   results = runtests("tests", Strict=true);                                 % warnings fail tests
   results = runtests("tests", UseParallel=true);                            % Parallel Computing Toolbox
   ```
   `runtests` has no option to exclude a tag. Select the suite instead: `suite = testsuite("tests"); results = run(suite.selectIf(~matlab.unittest.selectors.HasTag("Slow")));`. Parallel runs need independent tests: no shared state, order, or files.

3. **Analyze the results**. Report passed, failed, incomplete, and total counts and the summed `Duration` first, then the diagnostics:
   ```matlab
   disp(results)
   for r = results([results.Failed] | [results.Incomplete])
       fprintf("\n%s\n", r.Name);
       fprintf("%s\n", r.Details.DiagnosticRecord.Report);
   end
   ```
   - For each failure, give the qualification that failed, the actual and expected values, the likely cause, and a fix. Read the code under test before deciding whether the test or the code is wrong.
   - An incomplete test either failed an assumption (`assume*`, a deliberate skip such as a missing toolbox) or stopped on an error or a failed `assert*`. Report skips separately from errors.
   - `sortrows(table(results), "Duration", "descend")` lists the slowest tests.

4. **Collect coverage** only when the user asks, and only after every test passes, since failed tests leave coverage incomplete.
   - Coverage needs a `TestRunner` with `CodeCoveragePlugin`, so run it through **evaluate_matlab_code**; **run_matlab_test_file** does not support plugins. `CoverageResult` and `coverageSummary` require R2023a or later.
   - Statement coverage works in MATLAB. Decision, condition, and MC/DC coverage require MATLAB Test: use `MetricLevel="mcdc"` when it is installed and `"statement"` otherwise. In R2026b and later, `Metrics` replaces `MetricLevel` and adds `"type-size"`; `MetricLevel` still runs there, so use it when the release is unknown.
   ```matlab
   import matlab.unittest.TestRunner
   import matlab.unittest.plugins.CodeCoveragePlugin
   import matlab.unittest.plugins.codecoverage.CoverageResult

   runner = TestRunner.withTextOutput;
   covFormat = CoverageResult;
   runner.addPlugin(CodeCoveragePlugin.forFolder("src", ...
       IncludingSubfolders=true, Producing=covFormat, MetricLevel="mcdc"));
   results = runner.run(testsuite("tests"));
   covResults = covFormat.Result;          % one element per source file

   T = table([covResults.Filename]', VariableNames="File");
   for level = ["statement" "decision" "condition" "mcdc"]   % up to the collected level
       s = coverageSummary(covResults, level);
       T.(level) = compose("%d/%d", s(:,1), s(:,2));
   end
   disp(T)
   ```
   - Report the table, then ask whether the user wants a gap analysis, a report, or tests for the gaps.
   - For gaps, use the two-output form `[~, d] = coverageSummary(covResults, "statement")`. The entries of `d.statement` with `ExecutionCount == 0` are missed statements, located by `Filename` and `SourceLocation.StartLine`. For decisions, use `"decision"` and report the entries of `d.decision(i).Outcome` with `ExecutionCount == 0`. Write tests for the uncovered paths with `/matlab-test` and collect coverage again.
   - Generate a report only on request: `generateHTMLReport`, `generateStandaloneReport`, or `generateCoberturaReport` (CI). Justify unreachable code only when asked, with a filter rule XML file passed as `Filter=` (MATLAB Test, up to decision level).

5. **Report**:
   ```
   ## Test Results
   Passed: X | Failed: Y | Incomplete: Z | Total: N
   Duration: X.XX seconds

   ### Failures
   - TestClass/testMethod: verifyEqual failed. Expected X, got Y
     Likely cause: ...
     Suggested fix: ...
   ```

## MCP Integration

This command requires the MATLAB MCP Server to run tests.

### With MCP Available
- Use **run_matlab_test_file** (`script_path`) for a single test file without options.
- Use **evaluate_matlab_code** (`code`, and `project_path` for the project folder) for folders, filters, parallel runs, coverage, and failure diagnostics.
- Use **check_matlab_code** (`script_path`) on a test file that fails to load or errors in setup.
- Use **detect_matlab_toolboxes** to confirm MATLAB Test before decision, condition, or MC/DC coverage, and Parallel Computing Toolbox before `UseParallel=true`.

### Without MCP
- Read the test files and point out problems that will fail, such as missing source paths, misspelled error IDs, or exact comparison of floating-point values.
- Give the command to run: `results = runtests("tests"); disp(results)`.
- Recommend connecting the MATLAB MCP Server so the command can run the tests.

## Output

1. **Results summary** with passed, failed, incomplete, and total counts and the duration
2. **Failure analysis** with the cause and a suggested fix for each failed or incomplete test
3. **Slowest tests** when the run takes longer than a few seconds
4. **Coverage table** per file and metric, when requested
5. **Next steps**: fixes to make, tests to add, gaps to close

Toolkit skill: https://github.com/matlab/matlab-agentic-toolkit/tree/main/skills-catalog/matlab-software-development/matlab-run-tests
