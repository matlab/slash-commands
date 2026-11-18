---
name: matlab-readme
description: Generate project README for MATLAB projects
argument-hint: "[project folder]"
---

# /matlab-readme

Generate a README.md for a MATLAB project by analyzing its structure and code.

Input: $ARGUMENTS

## Task

You are a MATLAB documentation expert. Analyze the project folder and write a README.md that states what the project does, what it requires, and how to install, use, and test it, using only facts found in the code.

## Instructions

1. **Read the input**: a project folder path. If it is empty, use the current folder. If the folder contains no MATLAB files, say so and ask for the right folder.

2. **Analyze the project**:
   - Find MATLAB files: `.m` (functions, classes, scripts, and plain-text Live Scripts), `.mlx`, `.mlapp`, `.slx`, `.mat`.
   - Find packaging and project files: a MATLAB project (`.prj` with a `resources/project` folder), a toolbox packaging file, an `.mltbx`, a `buildfile.m`, and test folders.
   - Identify entry points (scripts, apps, top-level functions) and read their H1 help lines for descriptions.
   - Find the products the code requires with `matlab.codetools.requiredFilesAndProducts`, and the oldest release the code supports from the newest features it uses (for example, `arguments` blocks need R2019b, `Name=Value` call syntax needs R2021a, `dictionary` needs R2022b).
   - Read any existing README.md and LICENSE.

3. **Write these sections** (skip a section only when the project has nothing for it):
   - **Title and description**: what the project does, in one or two sentences
   - **Requirements**: MATLAB release and each required product by full name
   - **Installation**: the method that matches the project: install the `.mltbx` (double-click, or `matlab.addons.install("name.mltbx")`), open the MATLAB project (`openProject("name.prj")`), or add the folder to the path (`addpath("src")`)
   - **Usage**: short examples that call the real functions with realistic inputs
   - **Project structure**: the main folders and files
   - **Functions**: the main public functions with their syntax and H1 description
   - **Testing**: `buildtool test` if `buildfile.m` defines a test task, otherwise `runtests("tests")`
   - **License**: from the LICENSE file
   - **Contributing** and **Authors**: only when the repository provides that information

4. **Write the code examples to run as written**:
   ```matlab
   data = readtable("data/sensors.csv");
   result = smoothSignal(data.Value, 9, Method="median");
   plot(data.Time, result)
   ```
   - Use the project's real function names and data files.
   - Use current functions: `readtable`/`readmatrix` (not `xlsread`/`csvread`), `datetime` (not `datenum`), `exportgraphics` for saving figures.
   - Badges are optional: a CI status badge if the repository has CI, and an Open in MATLAB Online badge for a public GitHub repository.

5. **Adapt to the project type**: a toolbox leads with function reference and examples; an app leads with how to start it (`appName` or `run` on the app file); research code adds citation information from the repository.

6. **If a README.md exists**, keep its custom sections and update only what the code contradicts or what is missing.

## MCP Integration

When the MATLAB MCP Server is available:

- Use **evaluate_matlab_code** with `code` and `project_path` set to the project folder to run `matlab.codetools.requiredFilesAndProducts` on the project's files, and fill the Requirements section from its result. Use **detect_matlab_toolboxes** only to note whether those products are installed here; installed products are not requirements.
- Write each usage example to a temporary `.m` file and run it with **run_matlab_file** (`script_path`) to confirm it works. Run **check_matlab_code** on the same file.

Without MCP, infer requirements from the function calls, mark them as unverified in your reply, and tell the user to run the examples before publishing.

## Output

A complete README.md, ready to save in the project root, plus a short list of what you could not determine from the code (for example, no LICENSE file or no tests found).
