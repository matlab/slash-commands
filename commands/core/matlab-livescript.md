---
name: matlab-livescript
description: Create MATLAB Live Script with proper formatting and structure
category: core
parameters:
  - name: topic
    description: Topic or purpose of the Live Script (optional)
    required: false
tags: [matlab, livescript, documentation, tutorial]
related_skills:
  - matlab-live-script
---

# /matlab-livescript

Create MATLAB Live Scripts for documentation, tutorials, or analysis.

## Task

You are a MATLAB Live Script expert. Create Live Scripts that combine code, formatted text, equations, and visualizations for technical communication.

## Instructions

1. **Live Script Structure**:
   Create a plain text representation of a Live Script (.m format) that follows this structure:
   ```matlab
   %% Title of the Live Script
   % Brief description of what this Live Script demonstrates
   %
   % Author: Name
   % Date: YYYY-MM-DD
   % Copyright (c) 2025, The MathWorks, Inc.

   %% Introduction
   % Provide context and objectives. Explain what the reader will learn
   % or accomplish by working through this Live Script.
   %
   % Key concepts covered:
   %
   % * Concept 1
   % * Concept 2
   % * Concept 3

   %% Section 1: Setup and Initialization
   % Describe what this section does

   clear; clc; close all;  % Clean workspace

   % Add any required paths or configurations
   % Set random seed for reproducibility
   rng(42);

   %% Section 2: Data Preparation or Problem Setup
   % Explain the data or problem being addressed

   % Code with inline comments
   data = generateSampleData();  % Helper function defined at end

   %% Section 3: Main Analysis or Demonstration
   % Core content with explanations

   % Include visualizations where appropriate
   figure;
   plot(data);
   title('Descriptive Title');
   xlabel('X Label'); ylabel('Y Label');
   grid on;

   %% Section 4: Results and Interpretation
   % Discuss the results and their implications

   % Show key metrics or outputs
   fprintf('Key Result: %.2f\\n', result);

   %% Exercises (for educational content)
   %
   % *Exercise 1:* Modify the code to...
   %
   % *Exercise 2:* Extend the analysis by...

   %% Summary and Conclusions
   % Summarize key takeaways
   %
   % * Key finding 1
   % * Key finding 2
   % * Next steps or further reading

   %% References
   %
   % # Smith, J. (2024). "MATLAB Programming Best Practices"
   % # MATLAB Documentation: <https://mathworks.com/help>

   %% Helper Functions
   % Include any supporting functions at the end

   function data = generateSampleData()
       % GENERATESAMPLEDATA Create sample data for demonstration
       data = randn(100, 1);
   end
   ```

2. **Content Guidelines**:
   - **Text sections**: Use % for formatted text, %% for section headers
   - **Lists**: Use * for bulleted lists, # for numbered lists
   - **Emphasis**: Use *bold* and _italic_ for emphasis
   - **Links**: Use <URL> format for hyperlinks
   - **Equations**: Describe equations in LaTeX format comments
   - **Code**: Include well-commented, runnable MATLAB code

3. **Best Practices**:
   - Start with clear objectives and prerequisites
   - Use progressive disclosure (simple to complex)
   - Include visualizations to illustrate concepts
   - Provide context before code blocks
   - Add exercises for interactive learning
   - Include expected outputs as comments
   - Use consistent formatting throughout

4. **Types of Live Scripts**:
   - **Tutorial**: Step-by-step learning with exercises
   - **Analysis**: Data analysis workflow with visualizations
   - **Documentation**: Algorithm explanation with examples
   - **Report**: Results presentation with interpretations
   - **Demo**: Feature demonstration with use cases

5. **Visual Elements**:
   - Create informative plots with labels and legends
   - Use subplots for comparing multiple visualizations
   - Include tables for structured data presentation
   - Add annotations to highlight important features

6. **Code Quality**:
   - Use meaningful variable names
   - Include error handling where appropriate
   - Follow MATLAB style guidelines
   - Optimize for readability over brevity
   - Include parameter validation

## Output

Generate a Live Script in plain text (.m format) that:
- Has a clear narrative flow
- Combines explanatory text with executable code
- Includes appropriate visualizations
- Is self-contained and runnable
- Follows MATLAB Live Script conventions
- Can be opened in MATLAB Live Editor

Note: The output should be valid MATLAB code with proper comment formatting for Live Script sections.