---
name: matlab-property-test
description: Create property-based tests for mathematical invariants and properties
category: testing
parameters:
  - name: function_name
    description: Name of the function to test (optional)
    required: false
tags: [matlab, testing, property-based, invariants, verification]
related_prompts:
  - github.com/matlab/prompts/blob/main/prompts/programming/property-based-testing.md
---

# /matlab-property-test

Generate property-based tests that verify mathematical properties and invariants rather than specific outputs.

## Task

You are a MATLAB property-based testing expert. Create tests that verify mathematical properties, invariants, and relationships that should hold for all valid inputs.

## Instructions

1. **Identify properties to test**:
   - Mathematical invariants (e.g., commutativity, associativity)
   - Domain properties (e.g., output range, monotonicity)
   - Algebraic properties (e.g., identity, inverse)
   - Structural properties (e.g., shape preservation)
   - Optimization properties (e.g., optimality conditions)

2. **Generate property-based test class**:
   ```matlab
   classdef FunctionNamePropertyTest < matlab.unittest.TestCase
       % FUNCTIONNAMEPROPERTYTEST Property-based tests for functionName
       %
       %   These tests verify mathematical properties and invariants
       %   that should hold for all valid inputs.
       %
       %   Run all property tests:
       %       results = runtests('FunctionNamePropertyTest');

       properties
           NumRandomTests = 100  % Number of random inputs to test
           Tolerance = 1e-10     % Numerical tolerance
       end

       methods (TestClassSetup)
           function setupClass(testCase)
               % Setup test environment
               addpath('../src');
               rng(42);  % Reproducible randomness
           end
       end

       methods (Test)
           %% Identity Properties
           function testIdentityElement(testCase)
               % Verify: f(x, identity) = x
               for i = 1:testCase.NumRandomTests
                   x = generateRandomInput();
                   identity = getIdentityElement();
                   result = functionName(x, identity);

                   testCase.verifyEqual(result, x, ...
                       'RelTol', testCase.Tolerance, ...
                       'Identity element property violated');
               end
           end

           function testInverseProperty(testCase)
               % Verify: f(f_inverse(x)) = x
               for i = 1:testCase.NumRandomTests
                   x = generateRandomInput();
                   y = functionName(x);
                   x_recovered = inverseFunctionName(y);

                   testCase.verifyEqual(x_recovered, x, ...
                       'RelTol', testCase.Tolerance, ...
                       'Inverse property not satisfied');
               end
           end

           %% Algebraic Properties
           function testCommutativity(testCase)
               % Verify: f(a, b) = f(b, a)
               for i = 1:testCase.NumRandomTests
                   a = generateRandomInput();
                   b = generateRandomInput();

                   result1 = functionName(a, b);
                   result2 = functionName(b, a);

                   testCase.verifyEqual(result1, result2, ...
                       'RelTol', testCase.Tolerance, ...
                       'Commutativity property violated');
               end
           end

           function testAssociativity(testCase)
               % Verify: f(f(a, b), c) = f(a, f(b, c))
               for i = 1:testCase.NumRandomTests
                   a = generateRandomScalar();
                   b = generateRandomScalar();
                   c = generateRandomScalar();

                   result1 = functionName(functionName(a, b), c);
                   result2 = functionName(a, functionName(b, c));

                   testCase.verifyEqual(result1, result2, ...
                       'RelTol', testCase.Tolerance, ...
                       'Associativity property violated');
               end
           end

           function testDistributivity(testCase)
               % Verify: f(a, g(b, c)) = g(f(a, b), f(a, c))
               for i = 1:testCase.NumRandomTests
                   a = generateRandomInput();
                   b = generateRandomInput();
                   c = generateRandomInput();

                   result1 = functionName(a, otherFunction(b, c));
                   result2 = otherFunction(functionName(a, b), ...
                                          functionName(a, c));

                   testCase.verifyEqual(result1, result2, ...
                       'RelTol', testCase.Tolerance, ...
                       'Distributivity property violated');
               end
           end

           %% Domain Properties
           function testOutputRange(testCase)
               % Verify output is within expected range
               for i = 1:testCase.NumRandomTests
                   input = generateRandomInput();
                   output = functionName(input);

                   % Check range constraints
                   testCase.verifyGreaterThanOrEqual(output, 0, ...
                       'Output below minimum bound');
                   testCase.verifyLessThanOrEqual(output, 1, ...
                       'Output above maximum bound');
               end
           end

           function testMonotonicity(testCase)
               % Verify: if a <= b then f(a) <= f(b)
               for i = 1:testCase.NumRandomTests
                   a = generateRandomScalar();
                   b = a + abs(randn());  % Ensure b > a

                   result_a = functionName(a);
                   result_b = functionName(b);

                   testCase.verifyLessThanOrEqual(result_a, result_b, ...
                       'Monotonicity property violated');
               end
           end

           function testIdempotence(testCase)
               % Verify: f(f(x)) = f(x)
               for i = 1:testCase.NumRandomTests
                   x = generateRandomInput();
                   once = functionName(x);
                   twice = functionName(once);

                   testCase.verifyEqual(once, twice, ...
                       'RelTol', testCase.Tolerance, ...
                       'Idempotence property violated');
               end
           end

           %% Structural Properties
           function testShapePreservation(testCase)
               % Verify function preserves input shape
               shapes = {[1 1], [10 1], [1 10], [5 5], [3 4 5]};

               for shape = shapes
                   input = rand(shape{1});
                   output = functionName(input);

                   testCase.verifySize(output, size(input), ...
                       'Shape preservation violated');
               end
           end

           function testLinearityProperty(testCase)
               % Verify: f(ax + by) = af(x) + bf(y)
               for i = 1:testCase.NumRandomTests
                   x = generateRandomInput();
                   y = generateRandomInput();
                   a = randn();
                   b = randn();

                   lhs = functionName(a*x + b*y);
                   rhs = a*functionName(x) + b*functionName(y);

                   testCase.verifyEqual(lhs, rhs, ...
                       'RelTol', testCase.Tolerance, ...
                       'Linearity property violated');
               end
           end

           %% Optimization Properties
           function testOptimalityCondition(testCase)
               % Verify solution satisfies optimality conditions
               for i = 1:testCase.NumRandomTests
                   problem = generateRandomProblem();
                   solution = functionName(problem);

                   % Check first-order conditions
                   gradient = computeGradient(problem, solution);
                   testCase.verifyLessThan(norm(gradient), testCase.Tolerance, ...
                       'Optimality condition not satisfied');

                   % Check second-order conditions if applicable
                   hessian = computeHessian(problem, solution);
                   eigenvalues = eig(hessian);
                   testCase.verifyGreaterThanOrEqual(min(eigenvalues), 0, ...
                       'Second-order condition violated');
               end
           end

           %% Metamorphic Properties
           function testScaleInvariance(testCase)
               % Verify: f(k*x) = k*f(x) or similar relationship
               for i = 1:testCase.NumRandomTests
                   x = generateRandomInput();
                   k = 10^(randn()*2);  % Random scale factor

                   scaled_input = k * x;
                   result_scaled = functionName(scaled_input);
                   result_original = functionName(x);

                   % Adjust expected relationship
                   expected = k * result_original;  % Or k^2, sqrt(k), etc.

                   testCase.verifyEqual(result_scaled, expected, ...
                       'RelTol', testCase.Tolerance, ...
                       'Scale invariance violated');
               end
           end

           function testTranslationInvariance(testCase)
               % Verify: f(x + c) = f(x) + g(c) for some g
               for i = 1:testCase.NumRandomTests
                   x = generateRandomInput();
                   c = randn();

                   result_translated = functionName(x + c);
                   result_original = functionName(x);

                   % Check if difference is consistent
                   difference = result_translated - result_original;
                   expected_difference = computeExpectedShift(c);

                   testCase.verifyEqual(difference, expected_difference, ...
                       'RelTol', testCase.Tolerance, ...
                       'Translation invariance violated');
               end
           end

           %% Consistency Properties
           function testRoundTripProperty(testCase)
               % Verify: decode(encode(x)) = x
               for i = 1:testCase.NumRandomTests
                   original = generateRandomInput();
                   encoded = encode(original);
                   decoded = decode(encoded);

                   testCase.verifyEqual(decoded, original, ...
                       'RelTol', testCase.Tolerance, ...
                       'Round-trip property violated');
               end
           end

           function testReferenceImplementation(testCase)
               % Compare against known reference implementation
               for i = 1:testCase.NumRandomTests
                   input = generateRandomInput();

                   result = functionName(input);
                   reference = referenceImplementation(input);

                   testCase.verifyEqual(result, reference, ...
                       'RelTol', testCase.Tolerance, ...
                       'Results differ from reference implementation');
               end
           end
       end

       methods (Access = private)
           function input = generateRandomInput(testCase)
               % Generate valid random input for the function
               n = randi([1, 100]);
               input = randn(n, n);
           end

           function scalar = generateRandomScalar(testCase)
               scalar = randn();
           end

           function problem = generateRandomProblem(testCase)
               % Generate random optimization problem
               problem.A = randn(10, 10);
               problem.b = randn(10, 1);
           end
       end
   end
   ```

3. **Property Categories**:
   - **Algebraic**: Commutativity, associativity, distributivity
   - **Functional**: Idempotence, inverse, identity
   - **Analytical**: Continuity, differentiability, monotonicity
   - **Numerical**: Stability, conditioning, precision
   - **Structural**: Shape, type, sparsity preservation
   - **Invariance**: Scale, translation, rotation invariance
   - **Optimization**: Optimality, convergence, bounds

4. **Property Test Patterns**:
   - **Invariant**: Something that never changes
   - **Round-trip**: Encode then decode equals original
   - **Comparison**: Different algorithms give same result
   - **Oracle**: Compare with known good implementation
   - **Metamorphic**: Known input transformations

5. **Best Practices**:
   - Test with many random inputs (100-1000)
   - Use appropriate numerical tolerances
   - Document the mathematical property being tested
   - Include counter-examples when property fails
   - Test edge cases within properties
   - Make tests deterministic with seeded randomness

## Output

Generate:
1. Complete property-based test class
2. Helper functions for generating test inputs
3. Documentation of properties being tested
4. Suggestions for additional properties to verify