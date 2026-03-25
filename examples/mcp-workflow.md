# MCP-Powered Development Workflow

This example demonstrates a full MATLAB development workflow using slash commands with the MATLAB MCP Core Server connected.

## Scenario

Build a function to analyze vibration sensor data, detect anomalies, and generate a report.

## Step 1: Check Environment

```
/matlab-toolboxes
```

**Output (via MCP `detect_matlab_toolboxes`):**
```
## Installed Toolboxes
| Toolbox | Version |
|---------|---------|
| MATLAB | R2025b |
| Signal Processing Toolbox | 25.2 |
| Statistics and Machine Learning Toolbox | 25.2 |
| Parallel Computing Toolbox | 25.2 |

Recommendation: Signal Processing Toolbox detected — use `bandpass` and
`findpeaks` for vibration analysis instead of manual FFT processing.
```

## Step 2: Refine Requirements

```
/matlab-refine "analyze vibration sensor data to detect machine faults"
```

The command uses `detect_matlab_toolboxes` to know which toolboxes are available and tailors the specification accordingly.

## Step 3: Generate and Validate Tests

```
/matlab-test analyzeVibration
```

**With MCP**, the command:
1. Generates the test class
2. Runs it via `run_matlab_test_file` — all tests initially fail (no implementation yet)
3. Reports: "12 tests generated, 12 failed (function not implemented)"

## Step 4: Implement the Function

Write `analyzeVibration.m` based on the refined specification.

## Step 5: Check Code Quality

```
/matlab-check analyzeVibration.m
```

**With MCP**, the command:
1. Runs Code Analyzer via `check_matlab_code`
2. Reports: "2 warnings: line 45 — variable 'temp' might be unused, line 78 — consider preallocating"
3. Provides corrected code for each issue

## Step 6: Run Tests

```
/matlab-run-tests
```

**With MCP**, the command:
1. Discovers test files in the current directory
2. Runs them via `run_matlab_test_file`
3. Reports: "12 passed, 0 failed — 100% pass rate, 2.3 seconds"

## Step 7: Optimize

```
/matlab-optimize
```

**With MCP**, the command:
1. Benchmarks the original code via `evaluate_matlab_code`: 4.2 seconds for 1M samples
2. Applies vectorization and preallocation
3. Benchmarks the optimized code: 0.8 seconds — **5.25x speedup**

## Step 8: Add Error Handling

```
/matlab-errors
```

## Step 9: Document

```
/matlab-docs analyzeVibration
/matlab-readme
```

## Step 10: Final Validation

```
/matlab-run-tests
/matlab-check analyzeVibration.m
```

Confirm all tests still pass and no Code Analyzer warnings remain.

## Without MCP

The same workflow works without MCP — commands generate code and instructions, but you run validation steps manually in MATLAB:

```matlab
% Manual equivalents
checkcode('analyzeVibration.m')          % instead of /matlab-check
results = runtests('TestAnalyzeVibration'); % instead of /matlab-run-tests
disp(results)
```
