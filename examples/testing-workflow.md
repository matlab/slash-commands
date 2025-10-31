# Testing Workflow Example

This example demonstrates comprehensive testing strategies using MATLAB slash commands.

## Scenario

You have a complex numerical algorithm that needs thorough testing including unit tests, property-based tests, and performance validation.

## The Function to Test

```matlab
function [eigenvalues, eigenvectors] = robustEigen(A, options)
    % Compute eigenvalues and eigenvectors with numerical stability
    % ... implementation ...
end
```

## Step 1: Generate Unit Tests

Create traditional unit tests for specific cases:

```
/matlab-test robustEigen
```

This generates tests for:
- Known matrices with analytical solutions
- Edge cases (empty, scalar, singular matrices)
- Large matrices
- Complex matrices

### Generated Unit Test Example

```matlab
classdef RobustEigenTest < matlab.unittest.TestCase
    properties
        TestMatrices
        Tolerance = 1e-10
    end

    methods (TestClassSetup)
        function setupTestData(testCase)
            % Create test matrices with known eigenvalues
            testCase.TestMatrices.identity = eye(3);
            testCase.TestMatrices.diagonal = diag([1, 2, 3]);
            testCase.TestMatrices.symmetric = [4 1 1; 1 4 1; 1 1 4];
            testCase.TestMatrices.singular = [1 2; 2 4];
        end
    end

    methods (Test)
        function testIdentityMatrix(testCase)
            % Identity matrix should have all eigenvalues = 1
            A = testCase.TestMatrices.identity;
            [eigenvalues, eigenvectors] = robustEigen(A);

            testCase.verifyEqual(eigenvalues, ones(size(A, 1), 1), ...
                'RelTol', testCase.Tolerance);
            testCase.verifyEqual(eigenvectors * eigenvectors', eye(size(A)), ...
                'AbsTol', testCase.Tolerance);
        end

        function testDiagonalMatrix(testCase)
            % Diagonal matrix eigenvalues should match diagonal elements
            A = testCase.TestMatrices.diagonal;
            expected = diag(A);
            [eigenvalues, ~] = robustEigen(A);

            testCase.verifyEqual(sort(eigenvalues), sort(expected), ...
                'RelTol', testCase.Tolerance);
        end

        function testSymmetricMatrix(testCase)
            % Symmetric matrices should have real eigenvalues
            A = testCase.TestMatrices.symmetric;
            [eigenvalues, eigenvectors] = robustEigen(A);

            testCase.verifyTrue(all(isreal(eigenvalues)), ...
                'Symmetric matrix should have real eigenvalues');

            % Verify orthogonality of eigenvectors
            testCase.verifyEqual(eigenvectors' * eigenvectors, eye(size(A)), ...
                'AbsTol', testCase.Tolerance, ...
                'Eigenvectors should be orthonormal');
        end

        function testSingularMatrix(testCase)
            % Singular matrix should have at least one zero eigenvalue
            A = testCase.TestMatrices.singular;
            [eigenvalues, ~] = robustEigen(A);

            testCase.verifyTrue(any(abs(eigenvalues) < testCase.Tolerance), ...
                'Singular matrix should have zero eigenvalue');
        end

        function testLargeMatrix(testCase)
            % Performance test for large matrices
            n = 1000;
            A = randn(n) + 1i * randn(n);
            A = (A + A') / 2; % Make Hermitian

            tic;
            [eigenvalues, eigenvectors] = robustEigen(A);
            elapsedTime = toc;

            testCase.verifyLessThan(elapsedTime, 5, ...
                'Large matrix computation should complete within 5 seconds');

            % Verify decomposition
            reconstruction = eigenvectors * diag(eigenvalues) * eigenvectors';
            testCase.verifyEqual(reconstruction, A, ...
                'RelTol', sqrt(eps) * n, ...
                'Eigendecomposition should reconstruct matrix');
        end
    end
end
```

## Step 2: Generate Property-Based Tests

Create tests that verify mathematical properties:

```
/matlab-property-test robustEigen
```

### Generated Property Test Example

```matlab
classdef RobustEigenPropertyTest < matlab.unittest.TestCase
    properties
        NumRandomTests = 100
        Tolerance = 1e-10
    end

    methods (Test)
        function testCharacteristicPolynomial(testCase)
            % det(A - λI) = 0 for all eigenvalues
            for i = 1:testCase.NumRandomTests
                n = randi([2, 10]);
                A = randn(n);
                [eigenvalues, ~] = robustEigen(A);

                for j = 1:length(eigenvalues)
                    lambda = eigenvalues(j);
                    detValue = det(A - lambda * eye(n));

                    testCase.verifyLessThan(abs(detValue), ...
                        testCase.Tolerance * norm(A, 'fro'), ...
                        'Eigenvalue should satisfy characteristic equation');
                end
            end
        end

        function testEigenvectorProperty(testCase)
            % Av = λv for each eigenvalue-eigenvector pair
            for i = 1:testCase.NumRandomTests
                n = randi([2, 10]);
                A = randn(n);
                [eigenvalues, eigenvectors] = robustEigen(A);

                for j = 1:n
                    v = eigenvectors(:, j);
                    lambda = eigenvalues(j);
                    Av = A * v;
                    lambdav = lambda * v;

                    testCase.verifyEqual(Av, lambdav, ...
                        'RelTol', testCase.Tolerance, ...
                        'Eigenvector equation not satisfied');
                end
            end
        end

        function testTraceEqualsSum(testCase)
            % trace(A) = sum(eigenvalues)
            for i = 1:testCase.NumRandomTests
                n = randi([2, 20]);
                A = randn(n);
                [eigenvalues, ~] = robustEigen(A);

                testCase.verifyEqual(sum(eigenvalues), trace(A), ...
                    'RelTol', testCase.Tolerance, ...
                    'Trace should equal sum of eigenvalues');
            end
        end

        function testDeterminantEqualsProduct(testCase)
            % det(A) = prod(eigenvalues)
            for i = 1:testCase.NumRandomTests
                n = randi([2, 10]);
                A = randn(n);
                [eigenvalues, ~] = robustEigen(A);

                testCase.verifyEqual(prod(eigenvalues), det(A), ...
                    'RelTol', testCase.Tolerance * n, ...
                    'Determinant should equal product of eigenvalues');
            end
        end

        function testSimilarityTransform(testCase)
            % Similar matrices have same eigenvalues
            for i = 1:testCase.NumRandomTests
                n = randi([2, 10]);
                A = randn(n);
                P = randn(n);

                while cond(P) > 1e10
                    P = randn(n); % Ensure P is well-conditioned
                end

                B = P * A / P; % Similarity transform

                [eigenvaluesA, ~] = robustEigen(A);
                [eigenvaluesB, ~] = robustEigen(B);

                testCase.verifyEqual(sort(eigenvaluesA), sort(eigenvaluesB), ...
                    'RelTol', testCase.Tolerance * cond(P), ...
                    'Similar matrices should have same eigenvalues');
            end
        end

        function testHermitianRealEigenvalues(testCase)
            % Hermitian matrices have real eigenvalues
            for i = 1:testCase.NumRandomTests
                n = randi([2, 20]);
                A = randn(n) + 1i * randn(n);
                A = (A + A') / 2; % Make Hermitian

                [eigenvalues, ~] = robustEigen(A);

                testCase.verifyTrue(all(abs(imag(eigenvalues)) < testCase.Tolerance), ...
                    'Hermitian matrix should have real eigenvalues');
            end
        end
    end
end
```

## Step 3: Create Performance Tests

Add specific performance and stress tests:

```matlab
classdef RobustEigenPerformanceTest < matlab.unittest.TestCase
    methods (Test)
        function testScalingBehavior(testCase)
            % Test O(n³) scaling behavior
            sizes = [10, 20, 40, 80, 160];
            times = zeros(size(sizes));

            for i = 1:length(sizes)
                n = sizes(i);
                A = randn(n);

                tic;
                robustEigen(A);
                times(i) = toc;
            end

            % Verify roughly cubic scaling
            coeffs = polyfit(log(sizes), log(times), 1);
            scalingExponent = coeffs(1);

            testCase.verifyGreaterThan(scalingExponent, 2.5, ...
                'Algorithm should scale at least O(n^2.5)');
            testCase.verifyLessThan(scalingExponent, 3.5, ...
                'Algorithm should scale no worse than O(n^3.5)');
        end

        function testMemoryUsage(testCase)
            % Verify memory efficiency
            n = 500;
            A = randn(n);

            memBefore = memory;
            [eigenvalues, eigenvectors] = robustEigen(A);
            memAfter = memory;

            memUsed = (memAfter.MemUsedMATLAB - memBefore.MemUsedMATLAB) / 1024^2;

            % Should use roughly 2*n² for eigenvectors + overhead
            expectedMem = 2 * n^2 * 8 / 1024^2; % 8 bytes per double

            testCase.verifyLessThan(memUsed, expectedMem * 2, ...
                'Memory usage should be efficient');
        end
    end
end
```

## Step 4: Run All Tests

Execute the complete test suite:

```matlab
% Run all tests
results = runtests('RobustEigen*Test.m');

% Display results
disp(results);

% Generate test report
generateHTMLReport(results, 'test-report');
```

## Step 5: Coverage Analysis

Check test coverage:

```matlab
% Run with coverage analysis
import matlab.unittest.TestRunner
import matlab.unittest.plugins.CodeCoveragePlugin

suite = testsuite('RobustEigen*Test.m');
runner = TestRunner.withTextOutput;
runner.addPlugin(CodeCoveragePlugin.forFile('robustEigen.m'));

results = runner.run(suite);
```

## Best Practices Applied

1. **Unit Tests**: Specific input/output validation
2. **Property Tests**: Mathematical invariants
3. **Performance Tests**: Scaling and efficiency
4. **Coverage**: Ensure all code paths tested
5. **Reproducibility**: Seeded random tests

## Summary

This testing workflow ensures:
- ✅ Correctness for known cases
- ✅ Mathematical properties preserved
- ✅ Performance requirements met
- ✅ Edge cases handled
- ✅ Numerical stability verified
- ✅ Memory efficiency confirmed

The combination of unit tests and property-based tests provides confidence that the implementation is both correct and robust.