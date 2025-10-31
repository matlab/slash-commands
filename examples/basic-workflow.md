# Basic MATLAB Development Workflow

This example demonstrates a typical development workflow using MATLAB slash commands.

## Scenario

You need to create a function that analyzes sensor data and detects anomalies.

## Step 1: Refine Requirements

Start by clarifying what you need to build:

```
/matlab-refine "analyze sensor data and detect anomalies"
```

This generates detailed specifications including:
- Input data format and constraints
- Processing requirements
- Output format
- Performance requirements

## Step 2: Generate Initial Tests

Before writing code, create tests to define expected behavior:

```
/matlab-test analyzeSensorData
```

This creates a test file with:
- Basic functionality tests
- Edge case tests
- Performance benchmarks

## Step 3: Implement the Function

Based on the refined requirements, implement your function:

```matlab
function [anomalies, stats] = analyzeSensorData(data, options)
    % Initial implementation based on requirements

    % Process data
    processed = preprocessData(data);

    % Detect anomalies
    anomalies = detectAnomalies(processed, options.threshold);

    % Calculate statistics
    stats = calculateStats(processed);
end
```

## Step 4: Add Error Handling

Make the function robust:

```
/matlab-errors
```

This adds:
- Input validation using arguments blocks
- Try-catch error handling
- Informative error messages

## Step 5: Optimize Performance

Once the function works correctly, optimize it:

```
/matlab-optimize
```

This improves:
- Loop vectorization
- Memory usage
- Algorithm efficiency

## Step 6: Document the Function

Add comprehensive documentation:

```
/matlab-docs analyzeSensorData
```

This generates:
- Function help text
- Parameter descriptions
- Usage examples

## Step 7: Create Project Documentation

Finally, document the entire project:

```
/matlab-readme
```

## Complete Example

Here's what the final function might look like after applying all commands:

```matlab
function [anomalies, stats] = analyzeSensorData(data, options)
%ANALYZESENSORDATA Detect anomalies in multi-channel sensor data
%   [ANOMALIES, STATS] = ANALYZESENSORDATA(DATA) analyzes sensor data
%   and returns detected anomalies and statistical summaries.
%
%   [ANOMALIES, STATS] = ANALYZESENSORDATA(DATA, OPTIONS) specifies
%   additional options for processing.
%
%   Input Arguments:
%   ----------------
%   DATA - numeric matrix [nSamples × nChannels]
%      Sensor measurements where each column is a channel
%
%   OPTIONS - struct (optional)
%      .Threshold - anomaly threshold (default: 3.0)
%      .Method - detection method {'zscore', 'mad'} (default: 'zscore')
%      .WindowSize - sliding window size (default: 100)
%
%   Output Arguments:
%   -----------------
%   ANOMALIES - struct array
%      .indices - sample indices of anomalies
%      .channels - affected channels
%      .severity - anomaly severity scores
%
%   STATS - struct
%      .mean - mean per channel
%      .std - standard deviation per channel
%      .range - min/max per channel
%
%   Example:
%   --------
%   data = randn(1000, 4); % 4-channel sensor data
%   data(500, 2) = 10; % Inject anomaly
%   [anomalies, stats] = analyzeSensorData(data);
%
%   See also: DETECTANOMALIES, PREPROCESSDATA

    arguments
        data (:,:) double {mustBeFinite, mustBeNonempty}
        options.Threshold (1,1) double {mustBePositive} = 3.0
        options.Method (1,1) string {mustBeMember(options.Method, ["zscore", "mad"])} = "zscore"
        options.WindowSize (1,1) double {mustBeInteger, mustBePositive} = 100
    end

    try
        % Preprocess data (vectorized)
        data = data - mean(data, 1); % Remove DC offset
        data = data ./ std(data, 0, 1); % Normalize

        % Detect anomalies using vectorized operations
        switch options.Method
            case "zscore"
                scores = abs(data);
                anomalyMask = scores > options.Threshold;

            case "mad"
                medianData = median(data, 1);
                madData = median(abs(data - medianData), 1);
                scores = abs(data - medianData) ./ (1.4826 * madData);
                anomalyMask = scores > options.Threshold;
        end

        % Extract anomaly information (vectorized)
        [rows, cols] = find(anomalyMask);

        anomalies = struct(...
            'indices', rows, ...
            'channels', cols, ...
            'severity', scores(anomalyMask));

        % Calculate statistics (vectorized)
        stats = struct(...
            'mean', mean(data, 1), ...
            'std', std(data, 0, 1), ...
            'range', [min(data, [], 1); max(data, [], 1)]);

    catch ME
        switch ME.identifier
            case 'MATLAB:nomem'
                error('analyzeSensorData:OutOfMemory', ...
                    'Insufficient memory. Consider processing in chunks.');
            otherwise
                rethrow(ME);
        end
    end
end
```

## Results

By following this workflow, you get:
- ✅ Well-defined requirements
- ✅ Comprehensive test coverage
- ✅ Robust error handling
- ✅ Optimized performance
- ✅ Complete documentation
- ✅ Professional code quality