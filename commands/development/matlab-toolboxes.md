---
name: matlab-toolboxes
description: Detect installed MATLAB toolboxes and suggest usage
category: development
parameters: []
tags: [matlab, toolboxes, dependencies, mcp, environment]
---

# /matlab-toolboxes

Detect installed MATLAB toolboxes and provide recommendations for leveraging them in the current project.

## Task

You are a MATLAB environment expert. Detect which toolboxes are available and advise on how they can benefit the current project.

## Instructions

1. **Detect installed toolboxes**:
   - Use `detect_matlab_toolboxes` MCP tool to get the list of installed toolboxes
   - Include toolbox names, version numbers, and license status

2. **Analyze the current project**:
   - Scan MATLAB files in the current directory
   - Identify which toolboxes are currently used (via function calls)
   - Identify which toolboxes could benefit the project but aren't being used

3. **Generate recommendations**:
   - For each unused but relevant toolbox:
     - What functions from it could help
     - Specific code patterns that would benefit
     - Example usage in the project's context
   - For missing toolboxes (used but not installed):
     - Flag as a dependency risk
     - Suggest alternatives using base MATLAB

4. **Generate dependency report**:
   ```
   ## Toolbox Report

   ### Installed (X total)
   | Toolbox | Version | Used in Project |
   |---------|---------|----------------|
   | Signal Processing | 9.3 | Yes (3 files) |
   | Statistics and ML | 12.6 | No |

   ### Opportunities
   - Statistics Toolbox: Could replace manual mean/std calculations in processData.m
   - Parallel Computing: Could speed up the parfor-eligible loop in analyze.m

   ### Missing Dependencies
   - None detected / List any used-but-not-installed
   ```

## MCP Integration

This command benefits significantly from the MATLAB MCP Core Server.

### With MCP Available
- Use **detect_matlab_toolboxes** to get the actual installed toolbox list
- Use **evaluate_matlab_code** to run `ver` and get detailed version information
- Use **check_matlab_code** on project files to detect toolbox-dependent function calls

### Without MCP
If MCP is not available:
- Scan project files for known toolbox-specific function names
- Provide a list of likely toolbox dependencies based on static analysis
- Advise running `ver` in MATLAB to get the actual toolbox list

## Output

Generate:
1. **Installed toolbox table** with names, versions, and project usage
2. **Opportunity recommendations** for unused toolboxes
3. **Dependency warnings** for missing toolboxes
4. **Compatibility notes** for minimum MATLAB version requirements
