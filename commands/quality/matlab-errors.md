---
name: matlab-errors
description: Add error handling and input validation to MATLAB code
category: quality
parameters: []
tags: [matlab, error-handling, validation, robustness, defensive-programming]
related_prompts:
  - github.com/matlab/prompts/blob/main/prompts/programming/robust-error-handling.md
---

# /matlab-errors

Add error handling, input validation, and defensive programming practices to MATLAB code.

## Task

You are a MATLAB robustness expert. Enhance code with error handling, input validation, and programming techniques to make it reliable.

## Instructions

1. **Add input validation using arguments block** (MATLAB R2019b+):
   ```matlab
   function output = robustFunction(data, options)
       arguments
           data (:,:) double {mustBeNonmissing, mustBeFinite}
           options.Method (1,1) string {mustBeMember(options.Method, ["fast", "accurate"])} = "fast"
           options.Tolerance (1,1) double {mustBePositive, mustBeLessThan(options.Tolerance, 1)} = 1e-6
           options.MaxIterations (1,1) int32 {mustBePositive} = 100
           options.Verbose (1,1) logical = false
       end

       % Function implementation
   end
   ```

2. **Legacy input validation** (pre-R2019b):
   ```matlab
   function output = robustFunction(data, varargin)
       % Parse inputs
       p = inputParser;
       addRequired(p, 'data', @(x) isnumeric(x) && ismatrix(x));
       addParameter(p, 'Method', 'fast', @(x) any(validatestring(x, {'fast', 'accurate'})));
       addParameter(p, 'Tolerance', 1e-6, @(x) isscalar(x) && x > 0 && x < 1);
       parse(p, data, varargin{:});

       % Validate data content
       if isempty(data)
           error('robustFunction:EmptyInput', 'Input data cannot be empty');
       end

       if any(isnan(data(:)))
           error('robustFunction:NaNInput', 'Input contains NaN values');
       end

       if any(isinf(data(:)))
           error('robustFunction:InfInput', 'Input contains infinite values');
       end
   end
   ```

3. **Error handling patterns**:

   ### Try-Catch Blocks
   ```matlab
   function result = safeOperation(input)
       try
           % Attempt operation
           result = riskyOperation(input);

       catch ME
           % Log error details
           warning('Operation failed: %s', ME.message);

           % Handle specific errors
           switch ME.identifier
               case 'MATLAB:divideByZero'
                   warning('Division by zero detected, returning Inf');
                   result = Inf;

               case 'MATLAB:nomem'
                   error('robustFunction:OutOfMemory', ...
                         'Insufficient memory. Try reducing data size.');

               otherwise
                   % Attempt recovery or provide fallback
                   try
                       result = fallbackMethod(input);
                       warning('Using fallback method due to: %s', ME.message);
                   catch
                       % If fallback also fails, throw informative error
                       error('robustFunction:OperationFailed', ...
                             'Operation failed: %s\\nNo fallback available.', ...
                             ME.message);
                   end
           end
       end
   end
   ```

   ### Cleanup Operations
   ```matlab
   function processFile(filename)
       % Ensure cleanup even if errors occur
       fileID = -1;
       cleanupObj = onCleanup(@() cleanup(fileID));

       try
           fileID = fopen(filename, 'r');
           if fileID == -1
               error('processFile:FileOpenFailed', ...
                     'Cannot open file: %s', filename);
           end

           % Process file
           data = fread(fileID);
           % ... processing ...

       catch ME
           % Error handling
           rethrow(ME);
       end

       function cleanup(fid)
           if fid ~= -1
               fclose(fid);
           end
       end
   end
   ```

4. **Validation functions**:
   ```matlab
   function validateInputDimensions(input, expectedDims)
       % Validate input dimensions
       actualDims = size(input);

       if length(actualDims) ~= length(expectedDims)
           error('validateInput:DimensionMismatch', ...
                 'Expected %d dimensions, got %d', ...
                 length(expectedDims), length(actualDims));
       end

       for i = 1:length(expectedDims)
           if expectedDims(i) > 0 && actualDims(i) ~= expectedDims(i)
               error('validateInput:SizeMismatch', ...
                     'Dimension %d: expected %d, got %d', ...
                     i, expectedDims(i), actualDims(i));
           end
       end
   end

   function validateNumericRange(value, minVal, maxVal, varName)
       % Validate numeric value is within range
       if ~isnumeric(value) || ~isscalar(value)
           error('validateInput:NotScalarNumeric', ...
                 '%s must be a scalar numeric value', varName);
       end

       if value < minVal || value > maxVal
           error('validateInput:OutOfRange', ...
                 '%s must be between %g and %g (got %g)', ...
                 varName, minVal, maxVal, value);
       end
   end
   ```

5. **Warning management**:
   ```matlab
   function result = functionWithWarnings(input)
       % Save warning state
       originalWarning = warning;
       cleanupWarning = onCleanup(@() warning(originalWarning));

       % Modify warning behavior
       warning('on', 'all');  % Or specific IDs

       % Check for issues that should warn
       if size(input, 1) > 10000
           warning('functionWithWarnings:LargeInput', ...
                   'Input has %d rows. Processing may be slow.', ...
                   size(input, 1));
       end

       % Detect and warn about potential issues
       if rank(input) < min(size(input))
           warning('functionWithWarnings:RankDeficient', ...
                   'Input matrix is rank deficient. Results may be inaccurate.');
       end

       % Process with warnings
       lastwarn('');  % Clear last warning
       result = processData(input);

       [warnMsg, warnId] = lastwarn;
       if ~isempty(warnMsg)
           warning('functionWithWarnings:ProcessingWarning', ...
                   'Processing generated warning: %s', warnMsg);
       end
   end
   ```

6. **Assertion patterns**:
   ```matlab
   function output = functionWithAssertions(input)
       % Preconditions
       assert(~isempty(input), ...
              'functionWithAssertions:EmptyInput', ...
              'Input cannot be empty');

       assert(isreal(input), ...
              'functionWithAssertions:ComplexInput', ...
              'Input must be real-valued');

       % Invariants during processing
       intermediate = step1(input);
       assert(all(intermediate >= 0), ...
              'functionWithAssertions:NegativeIntermediate', ...
              'Intermediate values should be non-negative');

       % Postconditions
       output = step2(intermediate);
       assert(size(output, 1) == size(input, 1), ...
              'functionWithAssertions:OutputSizeMismatch', ...
              'Output size does not match input');
   end
   ```

7. **Custom error classes**:
   ```matlab
   classdef CustomError < MException
       properties
           AdditionalInfo
           RecoveryHint
       end

       methods
           function obj = CustomError(id, message, info, hint)
               obj = obj@MException(id, message);
               obj.AdditionalInfo = info;
               obj.RecoveryHint = hint;
           end

           function displayError(obj)
               fprintf('Error: %s\\n', obj.message);
               fprintf('Additional Info: %s\\n', obj.AdditionalInfo);
               fprintf('Recovery Hint: %s\\n', obj.RecoveryHint);
           end
       end
   end
   ```

8. **Progress and status reporting**:
   ```matlab
   function result = longRunningFunction(data, options)
       arguments
           data
           options.Verbose (1,1) logical = false
           options.ProgressBar (1,1) logical = true
       end

       n = size(data, 1);
       result = zeros(n, 1);

       % Create progress bar if requested
       if options.ProgressBar
           h = waitbar(0, 'Processing...');
           cleanupBar = onCleanup(@() delete(h));
       end

       for i = 1:n
           try
               result(i) = processRow(data(i, :));

               % Update progress
               if options.ProgressBar && mod(i, 10) == 0
                   waitbar(i/n, h, sprintf('Processing %d of %d', i, n));
               end

               if options.Verbose && mod(i, 100) == 0
                   fprintf('Processed %d/%d rows\\n', i, n);
               end

           catch ME
               if options.Verbose
                   warning('Failed to process row %d: %s', i, ME.message);
               end
               result(i) = NaN;  % Mark as failed
           end
       end
   end
   ```

## Output

Generate:
1. **Enhanced code** with error handling
2. **Input validation** using arguments blocks or inputParser
3. **Error recovery strategies** for common failure modes
4. **Informative error messages** with context and recovery hints
5. **Cleanup code** to ensure resources are properly released
6. **Warning management** for non-critical issues
7. **Progress reporting** for long-running operations
8. **Documentation** of error conditions and handling strategies