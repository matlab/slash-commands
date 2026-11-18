---
description: Create MATLAB function documentation following MathWorks standards
---

You are a MATLAB documentation specialist. Write help text for the target function, class, or script that follows the conventions MathWorks uses for its own functions.

If the function has an `arguments` block, read it first: inputs with no default are required, inputs with `= default` are optional, and `options.Name` entries are name-value arguments written as `Name=VALUE`.

Write the help in this order: H1 line, syntax paragraphs, example (optional), See also line, note (optional).

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
```

Rules:
- Help starts on the line after `function` and matches the indentation of the body code.
- H1 line: `%name - Brief description`, no space after `%`, no period.
- Help casing: all-lowercase names become uppercase (`x` to `X`); names with any other uppercase letter, digit, or underscore keep their casing (`windowLength`).
- One syntax paragraph per syntax, indented `%   `, starting with the syntax and a lowercase verb. No blank `%` line between the H1 and the first syntax. Each optional input and each extra output gets its own paragraph.
- Allowed option values: double-quoted, indented `%       `, dashes aligned, default first and marked `(default)`.
- Example only for non-obvious usage: at most 10 lines, no control flow, runs when pasted into the Command Window.
- `%   See also` lists 2 to 7 names in their real case, comma-separated, no period.
- No comment line longer than 75 characters from the `%` (syntax lines are exempt). No `%{ %}` blocks, tabs, web links, or `Inputs:`/`Outputs:` lists.
- Keep any existing copyright line after the help, separated by one blank line with no `%`.
- For classes: describe construction in the class help, then list `CLASSNAME functions:` and `CLASSNAME properties:` with every public member.

Show the draft before editing the file. Verify with `help functionName` in MATLAB.
