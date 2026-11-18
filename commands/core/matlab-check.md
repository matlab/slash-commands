---
name: matlab-check
description: Run MATLAB Code Analyzer on files or code
argument-hint: "[file or code]"
---

# /matlab-check

Run the MATLAB Code Analyzer on files or code, then review what it misses and report prioritized fixes.

Input: $ARGUMENTS

## Task

You are a MATLAB code reviewer. Combine Code Analyzer diagnostics with a manual review against MathWorks coding conventions, and report findings by severity without changing the code's behavior.

## Instructions

1. **Identify the target code**:
   - A file path: check that file.
   - A folder path: check every `.m` file in it.
   - Pasted MATLAB code: save it to a temporary `.m` file first, because the Code Analyzer works on files.
   - Empty input: check the file the user has open or was last working on. If there is none, ask which file to check.

2. **Run the Code Analyzer** with the `check_matlab_code` MCP tool on each file. Treat its output as the starting point, not the whole review.

3. **Sort lifecycle diagnostics first**. These wordings mean an outdated API:
   - `'X' has been removed`: the code errors today. Report as an error.
   - `'X' will be removed in a future release`: report as a warning.
   - `'X' is not recommended`: report as a suggestion, with the replacement.

   Common replacements: `csvread`/`dlmread` to `readmatrix`, `xlsread` to `readtable`, `datenum`/`datestr`/`now` to `datetime`, `strmatch` to `startsWith` or `matches`, `uicontrol` to `uibutton` and related components, `guide` to `appdesigner` (GUIDE was removed in R2025a).

4. **Scan the source for what the Code Analyzer misses**. Report these as errors:
   - `eval`, `evalc`, `evalin`, `assignin`. Suggest dynamic field names `s.(name)`, function handles, or cell arrays.
   - Arrays that grow inside loops without preallocation.
   - Variables that shadow built-in functions, such as `sum = 0`.
   - Hardcoded paths with backslashes. Suggest `fullfile`.

   Report these as warnings or suggestions:
   - Nesting deeper than 3 levels (warning), and functions longer than about 50 lines.
   - Public functions without an `arguments` block (warning) or without an H1 help line.
   - Unrestricted `str2num(text)` on external input. Suggest `str2num(text, Evaluation="restricted")` (R2022a+).
   - Magic numbers with no named constant or comment.
   - `containers.Map`: suggest `dictionary` (R2022b+). `bsxfun`: suggest implicit expansion. `clear all`: suggest `clearvars`.
   - `subplot` is supported and not deprecated. Mention `tiledlayout`/`nexttile` as the preferred choice for new code only, not as a required fix.

5. **Check naming and signatures**:
   - Functions and variables in lowerCamelCase; functions named with a verb (`computeArea`).
   - Classes in PascalCase. The file name matches the primary function or class.
   - At most 6 positional inputs and 4 outputs. Name-value options through `options.Name` in an `arguments` block rather than `varargin`.
   - Every function terminated with `end`.

6. **Report by severity**: errors (must fix) > warnings (should fix) > suggestions. For each finding give the line number, the issue and why it matters, and the corrected code. Do not propose changes that alter behavior; this is an assessment.

## MCP Integration

When the MATLAB MCP Server is available:

- Use **check_matlab_code** with `script_path` set to each target file to get the Code Analyzer diagnostics.
- Read the server's `matlab_coding_guidelines` resource when the client supports MCP resources, and use it as the baseline for naming and structure checks.
- Use **evaluate_matlab_code** with `code` and `project_path` for a folder-wide check (R2022b+) or to list required products:
  ```matlab
  issues = codeIssues("src");
  disp(issues.Issues)
  [~, products] = matlab.codetools.requiredFilesAndProducts(fullfile("src", "computeArea.m"));
  disp({products.Name}')
  ```

Without MCP, review the code statically against the checklist above and tell the user to run `checkcode("computeArea.m")` in MATLAB, or `codeIssues("src")` for a folder (R2022b+).

## Output

```
## Code Review: computeArea.m
- Code Analyzer: 1 error, 2 warnings, 3 suggestions

### Errors
- Line 12: `eval` builds a variable name. Use a struct field instead: `s.(name) = value;`
### Warnings
- Line 32: nesting reaches 4 levels. Move the inner block into a local function.
### Suggestions
- Line 18: `datenum` is not recommended. Use `datetime`.
```

Reference: [MATLAB Agentic Toolkit skill matlab-review-code](https://github.com/matlab/matlab-agentic-toolkit/tree/main/skills-catalog/matlab-core/matlab-review-code), with lifecycle replacements from [matlab-modernize-code](https://github.com/matlab/matlab-agentic-toolkit/tree/main/skills-catalog/matlab-software-development/matlab-modernize-code)
