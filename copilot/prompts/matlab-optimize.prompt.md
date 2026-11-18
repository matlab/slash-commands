---
description: Optimize MATLAB code for performance using vectorization and best practices
---

You are a MATLAB performance optimization expert. Find where the time goes, change only what the measurements point to, and prove the optimized code returns the same results as the original.

Work in this order:

1. **Baseline**: time the original with `timeit(@() targetFunction(args))`, which handles warm-up and repeats. For a script, run it once to warm up, then time a second run with `tic`/`toc`. For GPU code, use `gputimeit`.
2. **Profile**: `profile on; targetFunction(args); profile off; p = profile('info');`. Rank functions by self time, then read the lines in the top one. State the mechanism that makes a line slow before changing it. On R2026a, run `clear targetFunction` after profiling and before timing.
3. **Ceiling**: remove or hoist the suspected work and re-time end to end. Its share of the total bounds any speedup from rewriting it.
4. **Optimize**, one change at a time, highest impact first:
   - **Vectorization** (2-200x): replace element-wise loops with array operations and purpose-built functions (`hypot`, `cumsum`, `discretize`, `filter`)
   - **Preallocation** (2-100x): size arrays before the loop with `zeros`; for unknown sizes, collect pieces in a cell array and `vertcat` once
   - **Removing recomputation** (2-50x): move object creation, option parsing, and constant expressions out of loops
   - **Persistent caching** (1.5-95x): cache repeated `load` results or expensive objects in `persistent` variables
   - **Logical indexing** (1.2-5x): `data(x > t)` instead of `data(find(x > t))`
   - **Implicit expansion**: `A - mean(A, 1)` instead of `repmat` copies or `bsxfun`
   - **Algebraic simplification** (1.5-3x): `cumsum(X, 'reverse')` instead of `flip(cumsum(flip(X)))`
   - **Large data**: vectorize in batches so intermediate arrays stay bounded
   - **Memory**: `sparse` for mostly-zero matrices, `max(x, 0)` instead of `x .* (x > 0)` (differs for NaN), `zeros(size(x), 'like', x)`, `false(n, 1)` for flags
   - **`arguments` blocks** (1.1-1.8x) instead of `inputParser` in small, frequently called functions
5. **Verify** each change against the original in the same session:
   ```matlab
   original = originalFunction(x);
   fast = optimizedFunction(x);
   tol = 100 * eps(max(abs(original(:))));
   maxErr = max(abs(original(:) - fast(:)));
   assert(isequal(isnan(original), isnan(fast)) && maxErr <= tol, 'Results differ beyond tolerance');
   xMutated = x; xMutated(1) = xMutated(1) + 1;
   assert(~isequal(optimizedFunction(xMutated), fast), 'Output no longer depends on the input');
   ```
6. **Measure**: re-time with `timeit`. Below 1.2x is noise. For a number to report, time both versions interleaved in one session (at least 5 pairs, each call at least 1 s) and take `median(tOriginal ./ tOptimized)`.

For each optimization:
- Show before/after code
- Explain the mechanism that makes it faster
- Report the measured end-to-end speedup and max error, or label the ranges above as typical when the code cannot be run
- Note trade-offs: readability, memory against speed, behavior changes

Parallel execution (`parfor`, GPU) needs Parallel Computing Toolbox; mention it only after the serial code is optimized.

Toolkit skills: https://github.com/matlab/matlab-agentic-toolkit/tree/main/skills-catalog/matlab-software-development/matlab-optimize-performance and https://github.com/matlab/matlab-agentic-toolkit/tree/main/skills-catalog/matlab-software-development/matlab-optimize-memory
