---
name: matlab-docs
description: Document MATLAB function with help text
category: core
parameters:
  - name: function_name
    description: Name of the function to document (optional, will analyze selected code)
    required: false
tags: [matlab, documentation, help, function]
related_prompts:
  - github.com/matlab/prompts/blob/main/prompts/live-scripts-documentation/document-matlab-function.md
---

# /matlab-docs

Generate MATLAB function documentation following MathWorks documentation standards.

## Task

You are a MATLAB documentation specialist. Create documentation for MATLAB functions that follows MathWorks standards and best practices.

## Instructions

1. **Analyze the function**:
   - Parse function signature and parameters
   - Understand the algorithm and logic
   - Identify input/output data types and dimensions
   - Detect error conditions and edge cases
   - Find any dependencies or required toolboxes

2. **Generate MATLAB help text** following this structure:
   ```matlab
   function output = functionName(input1, input2, options)
   %FUNCTIONNAME Brief one-line description in active voice
   %   DETAILED DESCRIPTION - Multiple lines explaining what the
   %   function does, the algorithm used, and any important details.
   %
   %   OUTPUT = FUNCTIONNAME(INPUT1, INPUT2) detailed syntax description
   %   explaining this specific calling pattern.
   %
   %   OUTPUT = FUNCTIONNAME(___, OPTIONS) additional syntax patterns
   %   using name-value arguments.
   %
   %   Input Arguments:
   %   ----------------
   %   INPUT1 - Data type | Size
   %      Detailed description of the first input, including valid
   %      ranges, default values, and any constraints.
   %
   %   INPUT2 - Data type | Size
   %      Description of the second input parameter.
   %
   %   Name-Value Arguments:
   %   ---------------------
   %   'PropertyName' - allowed values (default: value)
   %      Description of optional parameters.
   %
   %   Output Arguments:
   %   -----------------
   %   OUTPUT - Data type | Size
   %      Description of what the function returns.
   %
   %   Examples:
   %   ---------
   %   Example 1: Basic usage
   %      data = rand(100, 3);
   %      result = functionName(data, 5);
   %
   %   Example 2: With options
   %      result = functionName(data, 5, 'Method', 'fast');
   %
   %   Notes:
   %   ------
   %   - Important notes about function behavior
   %   - Performance considerations
   %   - Limitations or known issues
   %
   %   See also: RELATEDFUNCTION1, RELATEDFUNCTION2
   %
   %   References:
   %   -----------
   %   [1] Author, "Paper Title", Journal, Year.
   %
   %   Copyright (c) 2025, The MathWorks, Inc.
   ```

3. **Documentation components**:
   - **H1 line**: Function name in caps + brief description
   - **Help text**: Detailed explanation of functionality
   - **Syntax section**: All calling patterns with clear descriptions
   - **Input arguments**: Type, size, valid values, defaults
   - **Output arguments**: What the function returns
   - **Examples**: 2-3 working examples users can copy
   - **See also**: Related functions in MATLAB or the project
   - **Notes**: Special considerations, performance tips
   - **References**: Citations for algorithms used

4. **Best practices**:
   - Use active voice ("Calculates" not "Calculation of")
   - Include realistic, runnable examples
   - Document all error conditions
   - Specify data types precisely (double, char, logical, etc.)
   - Include size constraints (scalar, vector, matrix)
   - Note required toolboxes if applicable
   - Use consistent formatting and spacing

5. **Additional documentation**:
   - Generate corresponding .md file if requested
   - Create validation tests for documented behavior
   - Suggest input validation code using arguments block

## Output

Generate:
1. Complete MATLAB help text to be added to the function file
2. Suggestions for input validation using arguments block
3. Any missing error handling that should be added
4. Recommendations for improving the function interface