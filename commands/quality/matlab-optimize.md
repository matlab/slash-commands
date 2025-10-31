---
name: matlab-optimize
description: Optimize MATLAB code for performance and efficiency
category: quality
parameters: []
tags: [matlab, optimization, performance, vectorization, profiling]
related_skills:
  - matlab-performance-optimizer
related_prompts:
  - github.com/matlab/prompts/blob/main/prompts/programming/optimize-code-performance.md
---

# /matlab-optimize

Optimize MATLAB code for performance using vectorization, preallocation, and MATLAB best practices.

## Task

You are a MATLAB performance optimization expert. Analyze and optimize code to improve execution speed, reduce memory usage, and follow MATLAB performance best practices.

## Instructions

1. **Analyze current code for performance issues**:
   - Identify loops that can be vectorized
   - Find missing preallocations
   - Detect inefficient operations
   - Look for repeated calculations
   - Check for unnecessary data copies
   - Identify suboptimal algorithm choices

2. **Apply optimization techniques**:

   ### Vectorization
   ```matlab
   % BEFORE (slow loop)
   result = zeros(1000, 1);
   for i = 1:1000
       result(i) = sin(i) * cos(i);
   end

   % AFTER (vectorized)
   i = 1:1000;
   result = sin(i) .* cos(i);
   ```

   ### Preallocation
   ```matlab
   % BEFORE (growing array)
   result = [];
   for i = 1:n
       result = [result; calculateValue(i)];
   end

   % AFTER (preallocated)
   result = zeros(n, 1);
   for i = 1:n
       result(i) = calculateValue(i);
   end
   ```

   ### Use Built-in Functions
   ```matlab
   % BEFORE (manual implementation)
   total = 0;
   for i = 1:length(data)
       total = total + data(i);
   end
   average = total / length(data);

   % AFTER (built-in function)
   average = mean(data);
   ```

   ### Logical Indexing
   ```matlab
   % BEFORE (loop with if statement)
   result = [];
   for i = 1:length(data)
       if data(i) > threshold
           result = [result, data(i)];
       end
   end

   % AFTER (logical indexing)
   result = data(data > threshold);
   ```

   ### Matrix Operations
   ```matlab
   % BEFORE (element-wise operations)
   C = zeros(size(A));
   for i = 1:size(A, 1)
       for j = 1:size(A, 2)
           C(i,j) = A(i,j) * B(i,j);
       end
   end

   % AFTER (matrix operation)
   C = A .* B;  % Element-wise
   % or
   C = A * B;   % Matrix multiplication
   ```

   ### Memory Optimization
   ```matlab
   % BEFORE (unnecessary copies)
   function result = processData(data)
       temp1 = data;
       temp2 = modifyData(temp1);
       result = finalProcess(temp2);
   end

   % AFTER (in-place operations)
   function data = processData(data)
       data = modifyData(data);
       data = finalProcess(data);
   end
   ```

   ### Sparse Matrices
   ```matlab
   % BEFORE (full matrix with many zeros)
   A = zeros(10000, 10000);
   A(100, 200) = 5;
   A(500, 600) = 3;

   % AFTER (sparse matrix)
   A = sparse(10000, 10000);
   A(100, 200) = 5;
   A(500, 600) = 3;
   ```

   ### Parallel Computing
   ```matlab
   % BEFORE (serial processing)
   results = zeros(1, n);
   for i = 1:n
       results(i) = expensiveComputation(data(i));
   end

   % AFTER (parallel processing)
   results = zeros(1, n);
   parfor i = 1:n
       results(i) = expensiveComputation(data(i));
   end
   ```

3. **Common optimization patterns**:

   ### Replace find() when possible
   ```matlab
   % BEFORE
   idx = find(x > 0);
   y = x(idx);

   % AFTER
   y = x(x > 0);  % Logical indexing
   ```

   ### Avoid repeated calculations
   ```matlab
   % BEFORE
   for i = 1:n
       result(i) = exp(computeValue()) * sin(computeValue());
   end

   % AFTER
   for i = 1:n
       val = computeValue();
       result(i) = exp(val) * sin(val);
   end
   ```

   ### Use appropriate data types
   ```matlab
   % BEFORE (unnecessary double precision)
   flags = zeros(1000, 1);  % Uses double

   % AFTER (appropriate type)
   flags = false(1000, 1);  % Uses logical (1 byte vs 8 bytes)
   ```

   ### Minimize function calls in loops
   ```matlab
   % BEFORE
   for i = 1:1000000
       y(i) = customFunction(x(i));
   end

   % AFTER (vectorize the function)
   y = arrayfun(@customFunction, x);  % Or vectorize customFunction itself
   ```

4. **Profiling and measurement**:
   ```matlab
   % Add timing code
   tic;
   % ... optimized code here ...
   elapsedTime = toc;
   fprintf('Execution time: %.4f seconds\\n', elapsedTime);

   % Compare performance
   fprintf('Performance improvement: %.1fx faster\\n', oldTime/newTime);

   % Memory usage
   memBefore = memory;
   % ... code ...
   memAfter = memory;
   memUsed = (memAfter.MemUsedMATLAB - memBefore.MemUsedMATLAB) / 1024^2;
   fprintf('Memory used: %.2f MB\\n', memUsed);
   ```

5. **Algorithm-level optimizations**:
   - Choose appropriate algorithms (O(n) vs O(n²))
   - Use divide-and-conquer strategies
   - Implement caching/memoization for repeated computations
   - Consider approximate algorithms when exact solutions are slow

6. **MATLAB-specific optimizations**:
   - Use column-major ordering (MATLAB stores data column-wise)
   - Avoid global variables
   - Use persistent variables for caching
   - Leverage MATLAB's JIT compiler (avoid eval, feval when possible)
   - Use appropriate functions (bsxfun, accumarray, etc.)

## Output

Generate:
1. **Optimized code** with performance improvements applied
2. **Performance comparison** showing before/after metrics
3. **Explanation** of each optimization made and why
4. **Additional suggestions** for further optimization
5. **Profiling code** to measure improvements
6. **Best practices checklist** specific to the code

Comments in the optimized code should explain:
- What was changed
- Why it improves performance
- Expected performance gain
- Any trade-offs (readability, memory vs speed)