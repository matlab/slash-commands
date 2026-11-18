---
name: matlab-docs
description: Document MATLAB function with help text
argument-hint: "[function name]"
---

# /matlab-docs

Write or improve MATLAB help text for a function, class, or script, following MathWorks help conventions.

Input: $ARGUMENTS

## Task

You are a MATLAB documentation specialist. Write help text that `help` and `doc` display correctly and that follows the conventions MathWorks uses for its own functions.

## Instructions

1. **Resolve the input to a file**:
   - A path to an `.m` file: use it.
   - A function or class name: find the file with `which("name")`.
   - Empty input: use the file the user has open or was last working on. If there is none, ask which function to document.
   - Read the file and identify whether it is a function, a class, or a script.

2. **Read the signature**. If the function has an `arguments` block, it defines the syntaxes:
   - No default and no dot prefix: required positional input.
   - `= default`, no dot prefix: optional positional input.
   - `options.Name`: name-value argument, written as `Name=VALUE` in the help.

3. **Write the help text in this order**: H1 line, syntax paragraphs, example (optional), See also line, note (optional).
   ```matlab
   function y = smoothSignal(x,windowLength,options)
       %smoothSignal - Smooth a signal with a moving window
       %   Y = smoothSignal(X) smooths the vector X with a 5-sample moving
       %   mean.
       %
       %   Y = smoothSignal(X,windowLength) also specifies the window length
       %   in samples.
       %
       %   Y = smoothSignal(...,Method=METHOD) also specifies the smoothing
       %   method. METHOD must be:
       %       "mean"   - (default) Moving mean.
       %       "median" - Moving median.
       %
       %   Example: Smooth a noisy sine wave
       %       t = linspace(0,1,200);
       %       x = sin(2*pi*5*t) + 0.2*randn(size(t));
       %       y = smoothSignal(x,9,Method="median");
       %       plot(t,x,t,y)
       %
       %   See also movmean, movmedian, smoothdata

       arguments
           x {mustBeNumeric, mustBeVector}
           windowLength (1,1) {mustBeInteger, mustBePositive} = 5
           options.Method (1,1) string {mustBeMember(options.Method,["mean","median"])} = "mean"
       end
       if options.Method == "mean"
           y = movmean(x,windowLength);
       else
           y = movmedian(x,windowLength);
       end
   end
   ```

4. **Follow these rules**:
   - Help starts on the line after `function` or `classdef` (line 1 for scripts) and matches the indentation of the body code.
   - **H1 line**: `%name - Brief description`, no space after `%`, no period, no namespace or class prefix.
   - **Help casing**: names that are all lowercase (or capitalized then lowercase) are written in uppercase (`x` becomes `X`, `sort` becomes `SORT`). Names with any other uppercase letter, digit, or underscore keep their exact casing (`smoothSignal`, `windowLength`).
   - **Syntax paragraphs**: one per syntax, indented `%   `, starting with the syntax followed by a lowercase verb (`Y = smoothSignal(X) smooths...`). No blank `%` line between the H1 and the first syntax. The first syntax shows required inputs and the primary output only; each optional input and each additional output gets its own paragraph. Use `...` and `[...]` to abbreviate arguments already described.
   - **Options**: list allowed values as double-quoted strings indented `%       `, dashes aligned, default first and marked `(default)`.
   - **Example**: only when it shows non-obvious usage. Heading `%   Example: label`, code indented `%       `, at most 10 lines, no control flow, runs when pasted into the Command Window. Label examples; do not number them.
   - **See also**: `%   See also` followed by 2 to 7 names in their real case, separated by commas, no period. Qualify names in other namespaces (`pkg.fun`).
   - **Note**: for product requirements, such as `%   Note: bandRatio requires the Signal Processing Toolbox`. Full product names, no period.
   - No comment line longer than 75 characters counted from the `%`. Syntax lines are exempt; wrap the description after them instead.
   - Only `%` line comments: no `%{ %}` blocks, no tabs, no trailing spaces, no web links, no `matlab:` links.
   - Do not use `Inputs:`/`Outputs:` lists or section underlines. Types and sizes go in the syntax paragraph text.
   - If the file has a copyright line, keep it after the help, separated by one blank line with no `%`. Do not add, remove, or edit it.

5. **For classes**: the class help describes construction (no separate constructor help), then lists `CLASSNAME functions:` (the word "functions", not "methods") and `CLASSNAME properties:` with every public member and aligned dashes. Give every public property at least a postfix comment. Public methods get an H1 line and syntax paragraphs; private and protected methods, constructors, and property get/set methods get an H1 line only.

6. **Present the draft** to the user before editing the file. After approval, insert or replace the help block.

## MCP Integration

When the MATLAB MCP Server is available:

- Use **evaluate_matlab_code** with `code` and `project_path` to resolve a function name (`which("smoothSignal")`).
- After editing, use **evaluate_matlab_code** to run `help smoothSignal` and confirm the full help text prints, then run the example lines to confirm they work.
- Use **check_matlab_code** with `script_path` set to the file to confirm the edit introduced no Code Analyzer issues.

Without MCP, write the help text as usual and tell the user to run `help name` and the example in MATLAB.

## Output

1. The complete help block, ready to insert into the file
2. A one-line note on anything the help could not state precisely (for example, an input with no validation, so its type is unclear)

Reference: [MATLAB Agentic Toolkit skill matlab-write-help](https://github.com/matlab/matlab-agentic-toolkit/tree/main/skills-catalog/matlab-software-development/matlab-write-help)
