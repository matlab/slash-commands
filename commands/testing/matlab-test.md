---
name: matlab-test
description: Generate unit tests for MATLAB functions
argument-hint: "[function name]"
---

# /matlab-test

Generate unit tests for MATLAB functions using the MATLAB Unit Testing Framework.

Input: $ARGUMENTS

## Task

You are a MATLAB testing expert. Write class-based tests with `matlab.unittest` that verify the public behavior of a function, its edge cases, and its error conditions, then run them and report the results.

## Instructions

1. **Find the code under test**:
   - The input names a function, class, or `.m` file. Locate it and read its source, its help text, and any `arguments` block.
   - If the input is empty, list the `.m` files in the current project that have no matching `<name>Test.m` and ask which one to test. Do not guess.
   - Note the expected outputs, input validation and error IDs, dependencies on files or services, and use of random numbers.

2. **Present a test plan first** (for anything beyond a small function):
   - List the test methods, the edge cases (empty, scalar, row and column vectors, `NaN`, `Inf`, very large and very small values), the error IDs to verify, and what to parameterize.
   - Write the tests after the user confirms the plan.

3. **Follow these rules**:
   - Always write class-based tests. Never write script-based or function-based tests.
   - Inherit from `matlab.unittest.TestCase`. Use `matlab.mock.TestCase` when the test creates mocks and `matlab.uitest.TestCase` for App Designer apps.
   - Name the file `<functionName>Test.m` and place it in a `tests/` folder next to `src/`.
   - No logic in test methods: no `if`, `switch`, `for`, or `try/catch`. Follow Arrange-Act-Assert. If a test needs a branch, split it into two methods.
   - Test the public interface only. Never call private methods or local functions directly.
   - Test one behavior per method, and keep tests independent so they can run in parallel.
   - Compare floating-point values with a tolerance (`AbsTol`, `RelTol`, or both), never with exact equality.
   - Add the source folder with `PathFixture` in `TestClassSetup`. Do not call `addpath` or `cd`.
   - Clean up with `addTeardown` right after creating a resource. It runs even when the test fails. Prefer it over `TestMethodTeardown` blocks.
   - Seed the random number generator in `TestMethodSetup` and restore it with `addTeardown`.
   - Tag tests (`TestTags`) so suites can be filtered, for example `'Unit'`, `'Integration'`, `'Slow'`.
   - The `Name=Value` syntax in the example requires R2021a or later.

4. **Write the test class**. This example tests `normalizeVector(x)`, which returns `x / norm(x)`, keeps the shape of `x`, and validates its input with an `arguments` block:
   ```matlab
   classdef normalizeVectorTest < matlab.unittest.TestCase
       % Unit tests for normalizeVector.
       %   results = runtests("normalizeVectorTest");

       properties (TestParameter)
           invalidInput = struct( ...
               'zeroVector', struct('input', [0; 0; 0], 'errorId', 'normalizeVector:zeroVector'), ...
               'text',       struct('input', 'abc',     'errorId', 'MATLAB:validators:mustBeNumeric'), ...
               'nonFinite',  struct('input', [1; NaN],  'errorId', 'MATLAB:validators:mustBeFinite'), ...
               'matrix',     struct('input', magic(3),  'errorId', 'MATLAB:validators:mustBeVector'));
       end

       methods (TestClassSetup)
           function addSourceToPath(testCase)
               srcFolder = fullfile(fileparts(fileparts(mfilename('fullpath'))), 'src');
               testCase.applyFixture(matlab.unittest.fixtures.PathFixture(srcFolder));
           end
       end

       methods (TestMethodSetup)
           function resetRandomSeed(testCase)
               originalRng = rng;
               testCase.addTeardown(@() rng(originalRng));
               rng(42, "twister");
           end
       end

       methods (Test, TestTags = {'Unit'})
           function testKnownValue(testCase)
               actual = normalizeVector([3; 4]);
               testCase.verifyEqual(actual, [0.6; 0.8], AbsTol=1e-14);
           end

           function testRowVectorKeepsShape(testCase)
               actual = normalizeVector([1 2 2]);
               testCase.verifySize(actual, [1 3]);
           end

           function testLongRandomVectorHasUnitNorm(testCase)
               x = randn(1e4, 1);
               actual = normalizeVector(x);
               testCase.verifyEqual(norm(actual), 1, AbsTol=1e-12);
           end

           function testInvalidInputThrows(testCase, invalidInput)
               testCase.verifyError(@() normalizeVector(invalidInput.input), ...
                   invalidInput.errorId);
           end
       end
   end
   ```

5. **Choose qualifications and tolerances**:
   - `verify*` is the default: the test continues after a failure. Use `assert*` to stop a test whose setup is invalid, `fatalAssert*` to stop the whole run when the environment is unusable, and `assume*` to skip a test, for example when a toolbox is missing.
   - Prefer the informal methods: `verifyEqual`, `verifyNotEqual`, `verifyTrue`, `verifyFalse`, `verifySize`, `verifyClass`, `verifyEmpty`, `verifyNumElements`, `verifySubstring`, `verifyError`, `verifyWarning`, `verifyWarningFree`, `verifyGreaterThan`, `verifyLessThanOrEqual`.
   - Use `verifyThat` with a constraint only when no informal method exists, for example `IsFinite`, `IsReal`, `IsSameSetAs`, `EveryElementOf(IsGreaterThan(0))`, or combinations such as `IsGreaterThan(0) & IsLessThan(10)`.
   - Tolerances apply only to the `*Equal` methods. Use `AbsTol` for values near zero, `RelTol` for large values, and both for mixed magnitudes. Starting points: double `AbsTol=1e-14, RelTol=1e-12`; single `AbsTol=1e-6, RelTol=1e-5`. Loosen them only with a reason, such as the condition number of the problem.
   - Verify errors by ID, not by message text.

6. **Parameterize when only the data varies**:
   - Use struct-valued `TestParameter` properties so each case has a readable name in the results, as in `invalidInput` above.
   - If the cases need different assertions, write separate methods instead.
   - Parameter combinations are `exhaustive` by default. Use `ParameterCombination = 'sequential'` for aligned input/expected lists and `'pairwise'` for three or more parameters.

7. **Handle dependencies and special cases**:
   - **Files and folders**: create them in a temporary folder (`TemporaryFolderFixture` or `WorkingFolderFixture`) and remove them with `addTeardown`.
   - **External services**: pass a function-handle stub when that is enough. Otherwise subclass `matlab.mock.TestCase`, create the mock with `createMock`, define behavior with `assignOutputsWhen` or `throwExceptionWhen`, and check calls with `verifyCalled` only when the interaction is the behavior under test.
   - **Regression against stored results**: use `matlabtest.parameters.matfileBaseline` with `verifyEqualsBaseline` (MATLAB Test, R2024b or later) instead of hard-coded expected values. Keep baseline MAT files in `tests/baselines/`.
   - **App Designer apps**: subclass `matlab.uitest.TestCase`, call `drawnow` after creating the app, and drive it with `press`, `choose`, `type`, and `drag`.

8. **Keep timing out of unit tests**:
   - Do not measure time with `tic`/`toc` in a unit test. The result varies with the machine and the load, and a time limit makes the test flaky.
   - For repeatable timing, write a separate performance test class that subclasses `matlab.perftest.TestCase` and run it with `runperf`. Keep all setup outside the measured code, copy properties to local variables before measuring, and use `keepMeasuring` for code that runs in under 10 ms. Use `MethodSetupParameter`, not `TestParameter`, for a parameter that `TestMethodSetup` uses.
   ```matlab
   classdef normalizeVectorPerformanceTest < matlab.perftest.TestCase
       % Performance tests for normalizeVector.
       %   results = runperf("normalizeVectorPerformanceTest");

       properties (MethodSetupParameter)
           DataSize = struct('Small', 1e3, 'Large', 1e6);
       end

       properties
           InputData
       end

       methods (TestClassSetup)
           function addSourceToPath(testCase)
               srcFolder = fullfile(fileparts(fileparts(mfilename('fullpath'))), 'src');
               testCase.applyFixture(matlab.unittest.fixtures.PathFixture(srcFolder));
           end
       end

       methods (TestMethodSetup)
           function setupData(testCase, DataSize)
               % All setup stays outside the measurement boundary
               originalRng = rng;
               testCase.addTeardown(@() rng(originalRng));
               rng(42, "twister");
               testCase.InputData = randn(DataSize, 1);
           end
       end

       methods (Test)
           function timeNormalize(testCase)
               data = testCase.InputData;     % copy to a local before measuring
               while testCase.keepMeasuring
                   result = normalizeVector(data);
               end
               testCase.verifySize(result, size(data));
           end
       end
   end
   ```
   - Summarize with `sampleSummary(results)`. For a one-off timing outside a test, use `timeit`.

## MCP Integration

When the MATLAB MCP Server is available:

- Use **check_matlab_code** on the new test file (`script_path`) and fix every Code Analyzer issue.
- Use **run_matlab_test_file** on the test file (`script_path`) and report passed, failed, and incomplete counts. If a test fails, decide whether the test or the code is wrong before changing either, and tell the user which one it was.
- Use **evaluate_matlab_code** (`code`, and `project_path` for the project folder) to run `runtests` with options such as `Tag="Unit"`, to run `runperf` on a performance test class, or to check the expected values the tests use.
- Use **detect_matlab_toolboxes** before relying on MATLAB Test features such as baseline tests.

If the MATLAB MCP Server is not available, write the tests and tell the user to run `results = runtests("tests")` and `disp(results)`.

## Output

1. The test plan (methods, edge cases, parameters), confirmed before writing non-trivial suites
2. The complete test class, ready to save as `tests/<functionName>Test.m`
3. A performance test class, only when the user asks for timing
4. The test results from the MCP run, or the command to run the tests
5. Remaining gaps, and a pointer to `/matlab-run-tests` for coverage

Toolkit skills: https://github.com/matlab/matlab-agentic-toolkit/tree/main/skills-catalog/matlab-software-development/matlab-write-tests and https://github.com/matlab/matlab-agentic-toolkit/tree/main/skills-catalog/matlab-software-development/matlab-write-performance-tests
