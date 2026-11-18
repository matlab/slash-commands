---
name: matlab-livescript
description: Create MATLAB Live Script with proper formatting and structure
argument-hint: "[topic]"
---

# /matlab-livescript

Create a plain-text MATLAB Live Script (`.m`) for a tutorial, analysis, report, or documentation.

Input: $ARGUMENTS

## Task

You are a MATLAB Live Script author. Write a plain-text Live Script that combines formatted text, equations, code, and inline figures, and that opens in the MATLAB Live Editor as a rich document.

## Instructions

1. **Read the input**:
   - A topic or description: write a new Live Script on that subject.
   - A path to an existing plain-text Live Script: edit it and keep its format. Read only the content above the `%[appendix]` marker; the appendix holds embedded outputs and metadata.
   - A path to a binary `.mlx` file: convert it to a plain-text `.m` file by running this in MATLAB (the recipe is not part of the output file):
     ```matlab
     editor = matlab.desktop.editor.openDocument(mlxPath, Visible=0);
     editor.saveAs(newMPath);   % use the .m extension
     editor.closeNoPrompt;
     ```
     The recipe needs the MATLAB Editor. In a `-batch` session it fails with "Unable to open or load the Editor"; in that case, give the user the recipe to run at the MATLAB Command Window.
   - Empty: ask the user for the topic and the audience. If the conversation already makes the subject clear (code or data under discussion), propose that topic and confirm it before writing.

2. **Check the release**: Plain-text Live Scripts require MATLAB R2025a or later. Confirm the release with `detect_matlab_toolboxes` or `isMATLABReleaseOlderThan("R2025a")`. On an older release, do not write this format. Tell the user it needs R2025a or later, and offer a regular script with `%%` sections and ordinary comments instead.

3. **Write the file** in this structure:
   ```matlab
   %[text] # Damped Oscillator
   %[text] This script simulates a damped mass-spring system and plots its response.
   %[text:tableOfContents]{"heading":"Contents"}
   %%
   %[text] ## Model
   %[text] The displacement of an underdamped oscillator is:
   %[text]{"align":"center"} $ x(t) = e^{-\\zeta \\omega\_n t} \\cos(\\omega\_d t) $
   %[text] where $ \\omega\_d = \\omega\_n \\sqrt{1-\\zeta^2} $ is the damped frequency.
   zeta = 0.1;
   omegaN = 2*pi;
   omegaD = omegaN*sqrt(1 - zeta^2)
   %%
   %[text] ## Response
   t = linspace(0, 5, 500);
   x = exp(-zeta*omegaN*t).*cos(omegaD*t);
   plot(t, x)
   title("Damped Response")
   xlabel("Time (s)")
   ylabel("Displacement")
   grid on
   %%
   %[text] ## Summary
   %[text] - The envelope decays at rate $ \\zeta \\omega\_n $.
   %[text] - Smaller $ \\zeta $ gives more oscillation cycles before decay. \

   %[appendix]{"version":"1.0"}
   %---
   %[metadata:view]
   %   data: {"layout":"inline"}
   %---
   ```

4. **Format rules**:
   - Text lines start with `%[text]`, not bare `%`. One paragraph is one `%[text]` line; do not hard-wrap.
   - No empty `%[text]` lines and no blank lines, except one blank line directly before `%[appendix]`.
   - Sections: `%%` alone on its own line, then `%[text] ## Title` on the next line. Use `%[text] # Title` once for the document title.
   - Markdown in text: `**bold**`, `*italic*`, `` `code` ``, `<u>underline</u>`, `[text](url)` for links, `- item` for bullets, `1. item` for numbered lists. The last item of every list ends with ` \`.
   - Equations use the single-`$` inline form only, never `$$ ... $$`. For a display equation, use `%[text]{"align":"center"} $ ... $`. In the saved file, LaTeX commands take double backslashes (`\\pi`, `\\frac`, `\\sin`) and markdown characters inside equations take one (`\_`, `\*`).
   - Escape `*`, `_`, `[`, `]`, `` ` ``, and `\` when they are literal text, not markdown. Also escape `.` after a digit and `#` at the start of a line.
   - Tables go between two `%[text:table]` lines, one `%[text] | a | b |` row per line, with a `| --- | --- |` separator row.
   - Internal links: `%[text] %[text:anchor:my_id] ...` marks a target and `[text](internal:my_id)` links to it. IDs use letters, digits, and underscores only.
   - End every file with the appendix block shown above, exactly.

5. **Code rules**:
   - No `figure` command; let plotting functions create the figure. One plot per section, unless a `tiledlayout` comparison is the point of the section.
   - No `clear`, `clc`, or `close all`.
   - No `mfilename`; it does not return the script name in a Live Script. Hardcode file names or use `pwd`.
   - Avoid `fprintf`. Show a value by dropping the semicolon or with `disp`; output appears inline below the code that produced it.
   - Show outputs that help the reader understand the result, not outputs that only confirm the code ran.
   - Local functions go at the end of the file, before the appendix.

6. **Write with a tool that takes literal text** (a file-write tool or `fwrite`). Shell heredocs collapse `\\` to `\` and corrupt the equations.

7. **Plan the content**: title and purpose, setup, one section per step of the analysis or lesson, and a summary. Put explanatory text before the code it describes.

## MCP Integration

When the MATLAB MCP Server is available:

- Read the resource `guidelines://plain-text-live-code` when the client supports MCP resources; it holds the same format rules from MathWorks.
- Use **detect_matlab_toolboxes** to confirm the release is R2025a or later and that toolboxes the script calls are installed.
- Use **check_matlab_code** with `script_path` set to the saved file to catch Code Analyzer issues. A missing-semicolon message on a line that displays a value on purpose is expected.
- Use **run_matlab_file** with `script_path`, or **evaluate_matlab_code** with `code` and `project_path`, to confirm the script runs without errors. Note the run time.
- Use **evaluate_matlab_code** to check rendering: `export("<abs>.m", "<abs>.html")` produces an HTML approximation of the Live Editor view. Read it to confirm that equations are typeset and that no `%[text]` markers appear as literal text, then delete the HTML file. If `export` reports "File must be a live script or function", MATLAB did not recognize the format; fix the file.
- Use **evaluate_matlab_code** for `.mlx` conversion with the recipe in step 1.

Without MATLAB, the written file is still a valid Live Script. Tell the user to open it in the Live Editor (R2025a or later) and run it to embed outputs. If MATLAB saves the file, read it again before further edits.

## Output

- One `.m` file in the plain-text Live Script format, ending with the required appendix
- A title, sections that each pair text with code, equations where they explain the method, and labeled plots
- Code that runs top to bottom in a fresh MATLAB session on R2025a or later
- A short note to the user stating the release requirement and what was verified (run, Code Analyzer, rendering)

Reference: [MATLAB Agentic Toolkit skill matlab-create-live-script](https://github.com/matlab/matlab-agentic-toolkit/tree/main/skills-catalog/matlab-core/matlab-create-live-script)
