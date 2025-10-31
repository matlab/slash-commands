---
name: matlab-test
description: Generate unit tests for MATLAB functions
category: testing
parameters:
  - name: function_name
    description: Name of the function to test (optional, will analyze selected code)
    required: false
tags: [matlab, testing, unit-test, quality]
related_skills:
  - matlab-test-generator
related_prompts:
  - github.com/matlab/prompts/blob/main/prompts/programming/create-unit-tests.md
---

# /matlab-test

Generate unit tests for MATLAB functions using the MATLAB Unit Testing Framework.

## Task

You are a MATLAB testing expert. Create unit tests that verify function behavior, handle edge cases, and ensure code reliability using MATLAB's testing framework.

## Instructions

1. **Analyze the function to test**:
   - Understand input/output specifications
   - Identify edge cases and boundary conditions
   - Determine error conditions
   - Find dependencies that may need mocking
   - Check for different execution paths

2. **Generate test class structure**:
   ```matlab
   classdef FunctionNameTest < matlab.unittest.TestCase
       % FUNCTIONNAMETEST Unit tests for functionName
       %
       %   Run all tests:
       %       results = runtests('FunctionNameTest');
       %
       %   Run specific test:
       %       results = runtests('FunctionNameTest','Name','testBasicFunctionality');

       properties
           % Test data and fixtures
           TestData
           OriginalPath
       end

       properties (TestParameter)
           % Parameterized test inputs
           validInput = {1, [1 2 3], magic(3)};
           invalidInput = {[], NaN, Inf, 'text'};
       end

       methods (TestClassSetup)
           function setupClass(testCase)
               % Add function path and prepare test environment
               testCase.OriginalPath = path;
               addpath('../src');  % Adjust path as needed
           end
       end

       methods (TestClassTeardown)
           function teardownClass(testCase)
               % Restore original environment
               path(testCase.OriginalPath);
           end
       end

       methods (TestMethodSetup)
           function setupTest(testCase)
               % Setup for each test
               testCase.TestData = generateTestData();
               rng(0);  % Ensure reproducibility
           end
       end

       methods (TestMethodTeardown)
           function teardownTest(testCase)
               % Cleanup after each test
               close all;  % Close any figures
           end
       end

       methods (Test)
           function testBasicFunctionality(testCase)
               % Test normal operation with typical inputs
               input = testCase.TestData.typical;
               expected = knownGoodOutput();
               actual = functionName(input);

               testCase.verifyEqual(actual, expected, ...
                   'Function did not return expected output');
           end

           function testEdgeCases(testCase)
               % Test boundary conditions

               % Empty input
               testCase.verifyError(@() functionName([]), ...
                   'functionName:EmptyInput');

               % Single element
               actual = functionName(1);
               testCase.verifySize(actual, [1 1]);

               % Large input
               largeInput = rand(1000, 1000);
               testCase.verifyWarningFree(@() functionName(largeInput));
           end

           function testErrorConditions(testCase)
               % Verify error handling

               % Wrong input type
               testCase.verifyError(@() functionName('invalid'), ...
                   'MATLAB:invalidInput');

               % Invalid dimensions
               testCase.verifyError(@() functionName(ones(2,3,4)), ...
                   'functionName:InvalidDimensions');
           end

           function testPerformance(testCase)
               % Performance benchmarks
               input = testCase.TestData.performance;

               f = @() functionName(input);
               testCase.verifyThat(f, ...
                   matlab.unittest.constraints.IssuesNoWarnings);

               % Measure execution time
               tic;
               functionName(input);
               elapsedTime = toc;

               testCase.verifyLessThan(elapsedTime, 1.0, ...
                   'Function took too long to execute');
           end

           function testNumericalAccuracy(testCase)
               % Test numerical precision
               input = testCase.TestData.numerical;
               expected = analyticalSolution(input);
               actual = functionName(input);

               testCase.verifyEqual(actual, expected, ...
                   'RelTol', 1e-10, 'AbsTol', 1e-12);
           end

           function testParameterized(testCase, validInput)
               % Parameterized test for multiple inputs
               testCase.verifyWarningFree(@() functionName(validInput));
           end
       end

       methods (Test, ParameterCombination = 'sequential')
           function testInvalidInputs(testCase, invalidInput)
               % Test various invalid inputs
               testCase.verifyError(@() functionName(invalidInput), ...
                   'functionName:InvalidInput');
           end
       end
   end
   ```

3. **Test Categories**:
   - **Functionality Tests**: Verify correct outputs for valid inputs
   - **Edge Case Tests**: Empty, single element, large data
   - **Error Tests**: Invalid inputs, wrong types, dimension mismatches
   - **Performance Tests**: Execution time, memory usage
   - **Numerical Tests**: Accuracy, stability, precision
   - **Regression Tests**: Previously found bugs stay fixed
   - **Integration Tests**: Interaction with other functions

4. **Assertion Methods**:
   ```matlab
   % Equality assertions
   testCase.verifyEqual(actual, expected)
   testCase.verifyNotEqual(actual, unexpected)

   % Boolean assertions
   testCase.verifyTrue(condition)
   testCase.verifyFalse(condition)

   % Size assertions
   testCase.verifySize(actual, expectedSize)
   testCase.verifyLength(actual, expectedLength)

   % Type assertions
   testCase.verifyClass(actual, expectedClass)
   testCase.verifyInstanceOf(actual, className)

   % Error and warning assertions
   testCase.verifyError(funcHandle, errorID)
   testCase.verifyWarning(funcHandle, warningID)
   testCase.verifyWarningFree(funcHandle)

   % Constraint-based assertions
   testCase.verifyThat(actual, constraint)
   testCase.verifyLessThan(actual, ceiling)
   testCase.verifyGreaterThan(actual, floor)
   ```

5. **Best Practices**:
   - Use descriptive test names that explain what is being tested
   - One assertion per test when possible
   - Test both success and failure paths
   - Include setup and teardown for test isolation
   - Use parameterized tests for similar test cases
   - Mock external dependencies when appropriate
   - Document why each test exists
   - Include performance benchmarks for critical functions
   - Test with realistic data sizes and types

6. **Coverage Goals**:
   - Statement coverage: Every line executed
   - Branch coverage: All if/else paths tested
   - Condition coverage: All boolean conditions evaluated
   - Edge coverage: Boundary values tested
   - Error coverage: All error conditions triggered

## Output

Generate:
1. Complete test class file ready to save as `FunctionNameTest.m`
2. Instructions for running the tests
3. Suggestions for additional test cases if gaps are found
4. Mock objects or test data generators if needed