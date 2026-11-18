---
name: matlab-errors
description: Add error handling and input validation to MATLAB code
argument-hint: "[file or function]"
---

# /matlab-errors

Add input validation, error handling, and resource cleanup to MATLAB code.

Input: $ARGUMENTS

## Task

You are a MATLAB robustness expert. Validate inputs with `arguments` blocks, give every error an identifier and a message that states what was expected, and release resources on every exit path, without changing results for valid inputs.

## Instructions

1. **Identify the target**:
   - The input names a file, function, or code snippet. Read the source and list each input, its intended type, size, and range, and the ways the function can fail at run time.
   - If the input is empty, use the file or code the user referenced or selected in this conversation. If there is none, ask which file or function to harden.
   - For `.mlx` or `.mlapp` files, ask the user to export the code to a plain `.m` file first; do not edit the binary file.
   - Check the callers. A migration should keep the contract unless the user wants it changed; list every contract change in the output.

2. **Validate inputs with an `arguments` block** for all new code. Do not write new `inputParser`, `validateattributes`, or `varargin` parsing.
   ```matlab
   function out = smoothSignal(data, options)
       arguments
           data (:,:) {mustBeNumeric, mustBeReal, mustBeFinite, mustBeNonempty}
           options.Method (1,1) string {mustBeMember(options.Method, ["fast", "accurate"])} = "fast"
           options.Tolerance (1,1) {mustBeNumeric, mustBeBetween(options.Tolerance, 0, 1, "open")} = 1e-6
           options.MaxIterations (1,1) {mustBeInteger, mustBePositive} = 100
           options.Window (1,1) {mustBeInteger, mustBePositive} = max(1, round(size(data, 1) / 10))
       end
       out = movmean(data, options.Window, 1);
   end
   ```
   Bad inputs and the identifiers they throw:
   ```matlab
   smoothSignal('abc')                       % MATLAB:validators:mustBeNumeric
   smoothSignal([1 2+1i])                    % MATLAB:validators:mustBeReal
   smoothSignal(rand(5), Method="Fast")      % MATLAB:validators:mustBeMember (exact match)
   smoothSignal(rand(5), Tolerance=2)        % MATLAB:validators:mustBeBetweenScalarBounds
   smoothSignal(rand(5), MaxIterations=2.5)  % MATLAB:validators:mustBeInteger
   smoothSignal(rand(5), Windw=3)            % MATLAB:TooManyInputs (unknown name)
   ```
   Callers can pass name-value arguments as `Method="accurate"` or `'Method', 'accurate'`. The `Window` default is computed from the value passed for `data`, so no `[]` sentinel is needed.

3. **Avoid the conversion pitfalls**. Size and class specs convert input before the validators run:
   ```matlab
   function out = asRow(x)
       arguments
           x (1,:) double        % asRow([1; 2; 3]) returns [1 2 3]; asRow('hi') returns [104 105]
       end
       out = x;
   end

   function out = strictRow(x)
       arguments
           x {mustBeNumeric, mustBeRow}   % strictRow([1; 2; 3]) throws MATLAB:validators:mustBeRow
       end                                % strictRow('hi') throws MATLAB:validators:mustBeNumeric
       out = x;
   end
   ```
   - To reject rather than reshape, use `mustBeRow`, `mustBeColumn`, or `mustBeMatrix` (R2024b+), or `mustBeVector`.
   - To reject rather than convert, drop the class spec and use `mustBeNumeric`, `mustBeFloat` (single or double), or `mustBeA(x, "double")`. A `double` spec turns `'A'` into 65 before `mustBeNumeric` sees it; an `int32` spec rounds 2.5 to 3.
   - Do not pair text validators with a `string` class spec: the spec turns `42` into `"42"` first. Write `name {mustBeTextScalar}`.
   - `mustBeNumeric` and `mustBeFinite` accept complex values. Add `mustBeReal` for sizes, counts, indices, and physical quantities unless a sign or integer validator already rejects complex input.
   - `mustBeMember` is exact and case-sensitive. When the original used `validatestring` (case-insensitive prefix matching), keep that call in the body and use `{mustBeTextScalar}` in the block.
   - `mustBeBetween` needs R2025a+. On earlier releases, combine `mustBeGreaterThan` and `mustBeLessThan`.
   - Use `arguments (Repeating)` instead of `varargin` for repeated argument groups. With a repeating block present, an unknown `Name=Value` pair is absorbed as positional data instead of erroring.
   - Keep `~` placeholders as `~` in the block, with no size or class spec.
   - Output validation, `arguments (Output)`, needs R2022b+.

4. **Migrate existing validation** when the function already uses `inputParser` or `validateattributes`:

   | Existing check | `arguments` block |
   |---|---|
   | `addRequired(p, 'x', fn)` / `addOptional(p, 'x', d, fn)` | `x` / `x = d` |
   | `addParameter(p, 'Name', d, fn)`, `p.Results.Name` | `options.Name = d`, `options.Name` |
   | `@isnumeric`, `{'numeric'}` | `{mustBeNumeric}`, no class spec |
   | `{'single','double'}` / exactly `{'double'}` | `{mustBeFloat}` / `{mustBeA(x, "double")}` |
   | `@ischar` / `@islogical` | `{mustBeA(x, 'char')}` / `{mustBeA(x, 'logical')}` |
   | `@(x) x > 0`, `{'positive'}`; `@(x) ~isempty(x)`, `{'nonempty'}` | `{mustBePositive}`; `{mustBeNonempty}` |
   | `{'scalar'}` / `{'vector'}` / `{'>=',0,'<=',1}` | `(1,1)` / `{mustBeVector}` / `{mustBeBetween(x, 0, 1, "closed")}` |

   ```matlab
   % Before
   function y = scaleData(x, varargin)
       p = inputParser;
       addRequired(p, 'x', @isnumeric);
       addParameter(p, 'Gain', 1, @(g) isnumeric(g) && isscalar(g) && g > 0);
       parse(p, x, varargin{:});
       y = p.Results.Gain * x;
   end

   % After: same calls work, scaleData(x, 'Gain', 2) and scaleData(x, Gain=2)
   function y = scaleData(x, options)
       arguments
           x {mustBeNumeric}
           options.Gain (1,1) {mustBeNumeric, mustBePositive} = 1
       end
       y = options.Gain * x;
   end
   ```
   Translate every anonymous-function validator; do not drop one. Keep `inputParser` where an `arguments` block cannot express the interface: valid options that depend on another argument's value, rules computed at run time, `KeepUnmatched` pass-through, or nested functions.

5. **Handle run-time errors in the body**:
   - Throw with an identifier and a message that names the value received and what was expected: `error('loadModel:badVersion', 'Expected version 2 or 3, got %d.', v)`.
   - Leave `if`/`error` guard clauses for run-time invariants in the body; they are not input validation. Use `assert(cond, id, msg)` for internal invariants.
   - Wrap only the call that can fail. Catch errors you can act on, and rethrow the rest with `rethrow(ME)`. To add context, throw a new error with the original as its cause:
   ```matlab
   function cfg = readConfig(filename)
       arguments
           filename {mustBeFile}          % missing file: MATLAB:validators:mustBeFile
       end
       txt = fileread(filename);
       try
           cfg = jsondecode(txt);
       catch ME
           err = MException('readConfig:invalidJSON', 'File "%s" is not valid JSON.', filename);
           throw(addCause(err, ME));      % malformed JSON: readConfig:invalidJSON
       end
   end
   ```
   - Do not catch an error and return a silent default; the caller cannot tell the result is wrong.

6. **Release resources on every exit path** with `onCleanup`, created after the resource exists so it captures the real handle:
   ```matlab
   function bytes = readBytes(filename)
       arguments
           filename {mustBeFile}
       end
       [fid, msg] = fopen(filename, 'r');
       if fid == -1
           error('readBytes:cannotOpen', 'Cannot open "%s": %s', filename, msg);
       end
       closeFile = onCleanup(@() fclose(fid));   % runs on normal return and on error
       bytes = fread(fid, Inf, '*uint8');
   end
   ```
   Restore warning state the same way: `s = warning('off', id); restoreWarnings = onCleanup(@() warning(s));`. Issue warnings with an identifier, `warning('myFunc:largeInput', ...)`, so callers can turn off that one warning.

## MCP Integration

When the MATLAB MCP Server is available:

- Use **check_matlab_code** (`script_path`) before editing to find existing issues, and after editing to confirm the `arguments` blocks parse cleanly.
- Use **evaluate_matlab_code** (`code`, `project_path`) to call each function with valid input and confirm the output is unchanged, then with one bad input per rule, catching the error and printing `ME.identifier`. Use `try`/`catch` for this, not pausing breakpoints such as `dbstop if error`, which hang a MATLAB session without a desktop. Never run `restoredefaultpath`; it removes the server's own code from the path.
- Use **run_matlab_test_file** (`script_path`) to run the existing tests, and tests that check each error path with `verifyError(testCase, @() f(badInput), 'MATLAB:validators:mustBePositive')`.
- Use **detect_matlab_toolboxes** when an "Undefined function" error may come from a missing toolbox.

If MCP is not available, generate the code as normal and give the user the bad-input calls from step 2 to run, with the identifier each should throw, and advise running `checkcode` on the result.

## Output

Generate:
1. **Updated code** with `arguments` blocks and run-time error handling
2. **Error table**: each validator or `error` call, the condition that triggers it, and its identifier
3. **Contract changes**: inputs that were accepted before and are now rejected or converted, and the reverse
4. **Error-path checks**: one bad-input call per rule, as `verifyError` tests or a script
5. **Cleanup**: each resource and the `onCleanup` that releases it

Toolkit skills: https://github.com/matlab/matlab-agentic-toolkit/tree/main/skills-catalog/matlab-programming/matlab-validate-function-arguments and https://github.com/matlab/matlab-agentic-toolkit/tree/main/skills-catalog/matlab-core/matlab-debug-code
