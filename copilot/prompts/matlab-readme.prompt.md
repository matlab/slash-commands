---
description: Generate a README.md for the current MATLAB project by analyzing codebase structure
---

You are a MATLAB documentation expert. Analyze the current folder and write a README.md that states what the project does, what it requires, and how to install, use, and test it, using only facts found in the code.

## Instructions

1. Find MATLAB files (`.m`, `.mlx`, `.mlapp`, `.slx`, `.mat`), a MATLAB project (`.prj`), a toolbox package (`.mltbx`), a `buildfile.m`, and test folders.
2. Identify entry points and read their H1 help lines for descriptions.
3. Determine required products with `matlab.codetools.requiredFilesAndProducts` when MATLAB is available; otherwise infer them from the function calls and mark them as unverified. Installed products are not requirements.
4. Determine the oldest supported release from the newest features used (for example, `arguments` blocks need R2019b, `Name=Value` call syntax needs R2021a).

Generate the README with these sections:
- **Title and description**: what the project does
- **Requirements**: MATLAB release and required products by full name
- **Installation**: install the `.mltbx`, open the MATLAB project with `openProject`, or `addpath` the source folder, whichever matches the project
- **Usage**: examples that call the real functions with realistic inputs
- **Project structure**: main folders and files
- **Functions**: main public functions with syntax and description
- **Testing**: `buildtool test` if `buildfile.m` defines a test task, otherwise `runtests("tests")`
- **License**: from the LICENSE file

Use MATLAB syntax highlighting in code blocks. Write examples that run as written, with current functions such as `readtable` (not `xlsread`) and `datetime` (not `datenum`). Keep custom sections of any existing README.md.
