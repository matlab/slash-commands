---
name: matlab-toolboxes
description: Detect installed MATLAB toolboxes and suggest usage
---

# /matlab-toolboxes

List installed MATLAB products and support packages, compare them with what the current project uses, and recommend products that fit the project.

Input: $ARGUMENTS

## Task

You are a MATLAB environment expert. Report which products are installed, which ones the project requires, which required ones are missing, and which installed ones could replace hand-written code in the project.

## Instructions

1. **Read the input**:
   - A product name (for example, `Signal Processing Toolbox`): report whether it is installed and where the project uses or could use it.
   - A release name (`R2026b`, or shorthand `26b`) or a MATLAB installation folder: list the products in that installation.
   - Empty input: produce the full report for the MATLAB that the MCP server runs, or for the default installation.

2. **List installed products**:
   - With MCP, use `detect_matlab_toolboxes`. It returns the MATLAB release and the installed toolboxes.
   - For another installation, or without MCP, read `{matlabroot}/appdata/prodcontents.json`. Its keys are the installed products, such as `"Signal Processing Toolbox 26.2 win64"`. Strip the version and platform token (`win64`, `glnxa64`, `maci64`, `maca64`, `common`) to get the display name.
   - Default installation folders: `C:\Program Files\MATLAB\<release>` (Windows), `/usr/local/MATLAB/<release>` (Linux), `/Applications/MATLAB_<release>.app` (macOS). If the folder name is not a release name, read the release from `{matlabroot}/VersionInfo.xml`.
   - Sort with MATLAB, MATLAB Copilot, Simulink, and Simulink Copilot first (those installed), then the rest alphabetically.

3. **List installed support packages** from `{supportpkgroot}/appdata/prodcontents.json`, where the root is `C:\ProgramData\MATLAB\SupportPackages\<release>` (Windows), `/usr/local/MATLAB/SupportPackages/<release>` (Linux), or `~/Library/Application Support/MathWorks/MATLAB/SupportPackages/<release>` (macOS). If the file does not exist, report that no support packages are installed.

4. **Find the products the project requires** with `matlab.codetools.requiredFilesAndProducts`. It traces function calls through the project's files and returns each product it depends on:
   ```matlab
   files = dir(fullfile(pwd, "**", "*.m"));
   paths = fullfile({files.folder}, {files.name});
   [~, products] = matlab.codetools.requiredFilesAndProducts(paths);
   disp(struct2table(products))
   ```
   A required product that is not installed is a missing dependency. Name the files that call it.

5. **Recommend installed products** that could replace hand-written code. Name the function, the file and line it would replace, and the minimum release it needs. Recommend only functions that exist in the installed release, and do not recommend a product for something base MATLAB already does (`mean`, `std`, `movmean`, `fft`, `filter` are base MATLAB).

## MCP Integration

When the MATLAB MCP Server is available:

- Use **detect_matlab_toolboxes** to get the release and the installed toolbox list.
- Use **evaluate_matlab_code** with `code` and `project_path` set to the project folder to run the `requiredFilesAndProducts` code above.

Without MCP, read the `prodcontents.json` files directly and infer requirements from the function calls in the project's files. Mark inferred requirements as unverified and tell the user to run the `requiredFilesAndProducts` code in MATLAB to confirm them.

## Output

```
## R2026b

**Installed at:** `C:\Program Files\MATLAB\R2026b`
**Support packages at:** `C:\ProgramData\MATLAB\SupportPackages\R2026b`

### Products
| Installed Product | Used by Project |
|---|---|
| MATLAB | Yes |
| Signal Processing Toolbox | Yes (filterData.m, analyze.m) |
| Statistics and Machine Learning Toolbox | No |

### Support Packages
No support packages installed.

### Missing Dependencies
- None

### Opportunities
- Signal Processing Toolbox: `bandpass` replaces the hand-built FIR filter in filterData.m, lines 12-30.
```

Reference: [MATLAB Agentic Toolkit skill matlab-list-products](https://github.com/matlab/matlab-agentic-toolkit/tree/main/skills-catalog/matlab-core/matlab-list-products)
