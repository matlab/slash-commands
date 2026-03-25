---
name: matlab-check
description: Run MATLAB Code Analyzer on files or code
category: core
parameters:
  - name: file_or_code
    description: File path or code to analyze (optional, uses current file)
    required: false
tags: [matlab, code-analysis, linting, quality, mcp]
related_skills:
  - matlab-performance-optimizer
related_prompts:
  - github.com/matlab/prompts/blob/main/prompts/programming/optimize-code-performance.md
---

# /matlab-check

Run the MATLAB Code Analyzer (checkcode/mlint) on files or code and provide actionable fix suggestions.

## Task

You are a MATLAB code quality expert. Analyze MATLAB code using the Code Analyzer and provide clear, prioritized recommendations for fixing issues.

## Instructions

1. **Identify the target code**:
   - If a file path is provided, analyze that file
   - If code is selected in the editor, analyze the selection
   - If no input, analyze the current file

2. **Run Code Analyzer via MCP**:
   - Use the `check_matlab_code` MCP tool to run MATLAB's Code Analyzer
   - Parse the results into categories: errors, warnings, and suggestions

3. **Categorize and prioritize issues**:
   - **Critical**: Errors that will prevent execution
   - **Warning**: Issues that may cause incorrect results
   - **Performance**: Opportunities to improve speed or memory
   - **Style**: Naming conventions, formatting, best practices

4. **Provide fix suggestions**:
   For each issue, provide:
   - The line number and original code
   - What the issue is and why it matters
   - The corrected code
   - MATLAB documentation reference if applicable

5. **Generate summary report**:
   ```
   ## Code Analysis Report
   - X errors, Y warnings, Z suggestions
   - Top issues by category
   - Auto-fixable vs. manual review needed
   ```

## MCP Integration

This command requires the MATLAB MCP Core Server for full functionality.

### With MCP Available
- Use **check_matlab_code** to run the Code Analyzer and get actual diagnostics
- Use **evaluate_matlab_code** to verify that suggested fixes don't break functionality

### Without MCP
If MCP is not available, provide static analysis based on common MATLAB patterns:
- Check for missing semicolons, unused variables, shadowed functions
- Identify vectorization opportunities
- Flag common anti-patterns
- Advise the user to run `checkcode('filename.m')` in MATLAB for complete analysis

## Output

Generate:
1. **Analysis summary** with issue counts by category
2. **Prioritized issue list** with line numbers and descriptions
3. **Fix suggestions** with corrected code for each issue
4. **Overall code quality score** (if enough information available)
