---
name: matlab-readme
description: Generate project README for MATLAB projects
category: core
parameters: []
tags: [matlab, documentation, readme, project]
related_prompts:
  - github.com/matlab/prompts/blob/main/prompts/live-scripts-documentation/project-summary.md
---

# /matlab-readme

Generate a README.md file for the current MATLAB project by analyzing the codebase structure and content.

## Task

You are a MATLAB documentation expert. Analyze the current directory and generate a README.md file that follows best practices for MATLAB projects.

## Instructions

1. **Analyze the project structure**:
   - Scan the current directory for MATLAB files (.m, .mlx, .mat, .fig, .mlapp)
   - Identify the main entry points and key functions
   - Look for existing documentation, examples, or tests
   - Check for dependencies and required toolboxes

2. **Generate README content** with these sections:
   - **Project Title and Description**: Clear, concise overview
   - **Features**: Key capabilities and functionality
   - **Requirements**: MATLAB version, required toolboxes, dependencies
   - **Installation**: How to set up the project
   - **Usage**: Basic examples with code snippets
   - **Project Structure**: Directory organization and key files
   - **API Documentation**: Brief description of main functions/classes
   - **Examples**: Links to example scripts or Live Scripts
   - **Testing**: How to run tests if available
   - **Contributing**: Guidelines for contributions
   - **License**: License information if LICENSE file exists
   - **Contact/Authors**: Author information and contact details

3. **Follow MATLAB README best practices**:
   - Use MATLAB syntax highlighting in code blocks
   - Include function signatures with input/output descriptions
   - Provide clear examples that can be copy-pasted
   - Reference MATLAB documentation where relevant
   - Include badges if applicable (File Exchange, CI status)

4. **Code snippets format**:
   ```matlab
   % Example code here
   result = functionName(input1, input2);
   ```

5. **Adapt content** based on project type:
   - Toolbox: Focus on function reference and examples
   - Application: Emphasize usage and configuration
   - Research code: Include citation information and paper references
   - Educational: Add learning objectives and exercises

## Output

Generate a complete README.md file that:
- Is well-structured with clear sections
- Contains accurate information extracted from the codebase
- Includes practical examples
- Follows Markdown best practices
- Is ready to be saved in the project root

Remember to:
- Check if README.md already exists and preserve any custom sections
- Extract actual function names and descriptions from the code
- Include actual code examples found in the project
- Note any missing recommended sections for the user to fill in later