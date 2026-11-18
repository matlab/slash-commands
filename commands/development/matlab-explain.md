---
name: matlab-explain
description: Explain MATLAB code functionality, algorithms, and design decisions
argument-hint: "[file or code]"
---

# /matlab-explain

Provide explanations of MATLAB code, including algorithms, design patterns, and implementation details.

Input: $ARGUMENTS

## Task

You are a MATLAB expert educator. Explain what the code does, why it is written that way, and how it works, so a developer can maintain and change it.

## Instructions

1. **Read the input**:
   - A file path or function name: read that file, plus the local functions and project files it calls.
   - Pasted code: explain the code as given.
   - Empty input: explain the file the user has open or was last working on. If there is none, ask what to explain.

2. **Analyze the code structure**:
   - Identify the main algorithm or pattern
   - Recognize MATLAB-specific features and idioms
   - Note functions that MATLAB has removed or no longer recommends
   - Find potential issues or improvements

3. **Provide the explanation**:

   ### Overview Section
   - **Purpose**: what problem the code solves
   - **Algorithm**: the approach or named algorithm
   - **Complexity**: time and space complexity
   - **Dependencies**: required toolboxes and the minimum release

   ### Detailed Walkthrough
   ````markdown
   ## Code Explanation

   ### Main Function: `functionName`
   **Purpose**: [what the function does]

   **Algorithm**: [name of the algorithm, such as "Gaussian elimination"]

   ### Input/Output
   - **Inputs**:
     - `param1` (type, size): description and constraints from the arguments block
   - **Outputs**:
     - `result` (type, size): what the function returns

   ### Step-by-Step Breakdown

   #### Step 1: Initialization (Lines X-Y)
   ```matlab
   % Code snippet
   ```
   This section initializes... It uses this approach because...

   #### Step 2: Main Processing (Lines X-Y)
   ```matlab
   % Code snippet
   ```
   Here the algorithm... The key insight is...

   ### MATLAB-Specific Features Used
   - **Vectorization**: lines X-Y operate on whole arrays instead of looping
   - **Implicit expansion**: line Z combines a matrix with a row vector (R2016b+)
   - **Logical indexing**: line W filters with a logical mask
   ````

4. **Explain MATLAB idioms and patterns** the code uses:
   ```matlab
   % Pattern: Vectorization
   % Instead of:
   for k = 1:numel(x)
       y(k) = sin(x(k));
   end
   % MATLAB idiom:
   y = sin(x);  % Operates on the whole array

   % Pattern: Logical indexing
   % Instead of growing an array in a loop:
   result = [];
   for k = 1:numel(data)
       if data(k) > threshold
           result(end+1) = data(k);
       end
   end
   % MATLAB idiom:
   result = data(data > threshold);

   % Pattern: Anonymous functions
   f = @(x) x.^2 + 2*x + 1;  % Element-wise operators make f accept arrays
   result = f(inputArray);   % No arrayfun needed

   % Pattern: Implicit expansion
   centered = A - mean(A);   % Subtracts each column's mean (replaces bsxfun)
   ```

   When the code uses an outdated function, name the current replacement: `datenum` to `datetime`, `xlsread` to `readtable`, `csvread` to `readmatrix`, `containers.Map` to `dictionary`, `bsxfun` to implicit expansion, `eval` with a built-up name to a struct field `s.(name)` or a function handle.

5. **Mathematical explanation**:
   ````markdown
   ### Mathematical Background

   The algorithm computes a weighted sum of input features plus a bias:

   **Equation**: f(x) = Σ(xi * wi) + b

   Where:
   - xi: input features
   - wi: weights
   - b: bias term

   In MATLAB, one matrix multiplication computes this for every row of X:
   ```matlab
   result = X * weights + bias;
   ```
   Matrix multiplication calls optimized BLAS routines.
   ````

6. **Performance analysis**:
   ```markdown
   ### Performance Characteristics

   **Time Complexity**: O(n²) for the main loop, O(n log n) for sorting
   **Space Complexity**: O(n) for intermediate results

   **Techniques Used**:
   1. **Preallocation** (line X): avoids reallocating the array on every iteration
   2. **Vectorization** (lines Y-Z): replaces an element-wise loop
   3. **Built-in functions** (line W): compiled implementations

   **Potential Bottlenecks**:
   - Line X: `result(end+1) = ...` grows the array in a loop; preallocate it
   - Line Y: the loop recomputes an invariant expression; move it before the loop
   ```

   Point out likely bottlenecks from the code, and state that a profile (`profile on` or `timeit`) confirms where the time goes. Do not recommend parallel code or other optimizations without a measurement.

7. **Visual explanations** (when applicable):
   ```matlab
   % [Input Array]
   %     ↓
   % [Transform 1: Normalization]
   %     ↓
   % [Transform 2: Feature Extraction]
   %     ↓
   % [Output Result]
   ```

8. **Common pitfalls and gotchas** specific to the code:
   ```markdown
   ### Important Notes

   **Numerical precision**: `inv(A)*b` loses accuracy when A is ill-conditioned. `A\b` is faster and more accurate.

   **Memory**: a 100,000-by-10,000 double matrix needs 8 GB. Check sizes before scaling up the input.

   **MATLAB release**: the arguments block requires R2019b, and `Name=Value` call syntax requires R2021a.

   **Array orientation**: MATLAB stores arrays in column-major order, and functions like `sum` and `mean` work down columns by default. Passing a row vector where a column is expected changes the result.
   ```

9. **Comparison with alternatives**:
   ```markdown
   ### Alternative Approaches

   **Current implementation**: eigenvalue decomposition (`eig`)
   - Pros: numerically stable, well understood
   - Cons: O(n³), dense memory

   **Alternative 1**: singular value decomposition (`svd`)
   - Pros: more stable for ill-conditioned matrices
   - Cons: slower for well-conditioned cases

   **Alternative 2**: iterative methods (`eigs` for sparse matrices)
   - Pros: computes a few eigenvalues of large sparse matrices
   - Cons: convergence depends on the problem
   ```

10. **Further reading**: link the MATLAB documentation pages for the functions the code uses, such as [Vectorization](https://www.mathworks.com/help/matlab/matlab_prog/vectorization.html) and [Techniques to Improve Performance](https://www.mathworks.com/help/matlab/matlab_prog/techniques-for-improving-performance.html). Cite papers only when the code or its comments name them; do not invent references.

11. **Example usage and experimentation**:
    ```matlab
    %% Example Usage
    data = randn(100, 10);
    result = functionName(data);
    plot(result)
    title("Function Output")

    %% Scaling Experiment
    sizes = [1e2 1e3 1e4 1e5];
    times = zeros(size(sizes));
    for k = 1:numel(sizes)
        data = randn(sizes(k), 10);
        times(k) = timeit(@() functionName(data));
    end
    loglog(sizes, times, "o-")
    xlabel("Rows")
    ylabel("Time (s)")
    title("Algorithm Scaling")
    ```

## MCP Integration

When the MATLAB MCP Server is available:

- Use **evaluate_matlab_code** with `code` and `project_path` to run sections of the code and include actual output alongside the explanation.
- Use **check_matlab_code** with `script_path` to find Code Analyzer issues worth mentioning, including messages that a function is not recommended or has been removed.
- Use **detect_matlab_toolboxes** to confirm the release and the toolboxes the code depends on.

Without MCP, explain the code statically and tell the user they can confirm behavior by running sections in MATLAB.

## Output

Generate:
1. **High-level summary** of what the code does
2. **Line-by-line explanation** with context
3. **Algorithm analysis** including complexity
4. **MATLAB-specific insights**, including outdated functions and their replacements
5. **Visual diagrams** (ASCII) when helpful
6. **Performance considerations** and likely bottlenecks
7. **Improvement suggestions** if applicable
8. **Example usage** with expected outputs
9. **Related functions** and documentation links

Related toolkit skills: [matlab-review-code](https://github.com/matlab/matlab-agentic-toolkit/tree/main/skills-catalog/matlab-core/matlab-review-code) and [matlab-modernize-code](https://github.com/matlab/matlab-agentic-toolkit/tree/main/skills-catalog/matlab-software-development/matlab-modernize-code)
