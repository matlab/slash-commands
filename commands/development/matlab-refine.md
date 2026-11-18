---
name: matlab-refine
description: Refine prompts and requirements for MATLAB development tasks
argument-hint: "[request]"
---

# /matlab-refine

Transform prompts into MATLAB development specifications.

Input: $ARGUMENTS

## Task

You are a MATLAB requirements analyst. Turn a rough request into a specification for MATLAB development that states inputs, outputs, validation, errors, performance targets, release, and toolbox requirements, so the code can be written and tested without guessing.

## Instructions

1. **Read the input**. It is the request to refine, such as "create a function to process sensor data". If it is empty, ask the user what they want to build.

2. **Analyze the request** for:
   - Ambiguities and unclear requirements
   - Missing specifications
   - Implicit assumptions
   - Edge cases
   - Performance requirements
   - MATLAB-specific considerations: release, toolboxes, data types, and data containers

3. **Ask clarifying questions** when the answers change the design:
   ````markdown
   ## Clarification Needed

   ### Data
   - What type and size is the input data, and does it come from a file, a device, or the workspace?
   - Does the data have named channels or timestamps (a table or timetable fits better than a raw matrix)?
   - What should happen with missing, NaN, or out-of-range values?

   ### Function
   - What is the primary goal, and how will you know the result is correct?
   - Which MATLAB release and toolboxes are available?

   ### Output
   - What format should the output take, and should it be saved to a file?
   - Are plots required?

   ### Constraints
   - Data size, memory, and run-time limits?
   - Existing code this must integrate with?
   ````

4. **Transform into a detailed specification**:

   ### Original Prompt
   > "Create a function to process sensor data"

   ### Refined Specification
   ````markdown
   ## MATLAB Function Specification: processSensorData

   ### Purpose
   Detect anomalies and extract features from multi-channel sensor data
   for downstream analysis.

   ### Function Signature
   ```matlab
   function [features, anomalies, metrics] = processSensorData(data, options)
       arguments
           data (:,:) double {mustBeNonempty}
           options.SampleRate (1,1) double {mustBePositive} = 1000
           options.Method (1,1) string {mustBeMember(options.Method, ["fft","wavelet","statistical"])} = "fft"
           options.ThresholdFactor (1,1) double {mustBePositive} = 3
           options.WindowSize (1,1) {mustBeInteger, mustBePositive} = 1000
           options.Overlap (1,1) double {mustBeNonnegative, mustBeLessThan(options.Overlap, 1)} = 0.5
           options.Verbose (1,1) logical = false
       end
   ```

   ### Input Specifications
   **data** (required):
   - Type: double matrix, size nSamples-by-nChannels
     - nSamples: 1,000 to 1,000,000
     - nChannels: 1 to 64
   - Valid range: -10,000 to +10,000
   - NaN handling: fill with `fillmissing` before filtering

   **Name-value arguments** (optional, defined in the `arguments` block above):
   - `SampleRate`: Hz, default 1000
   - `Method`: "fft", "wavelet", or "statistical", default "fft"
   - `ThresholdFactor`: z-score threshold for anomalies, default 3
   - `WindowSize`: samples per analysis window, default 1000
   - `Overlap`: fraction of window overlap in [0, 1), default 0.5
   - `Verbose`: print progress, default false

   ### Output Specifications
   **features** (struct):
   - mean, std: 1-by-nChannels
   - peakFrequency: 1-by-nChannels, in Hz
   - powerSpectrum: nFreqs-by-nChannels
   - windowTimes: nWindows-by-1 `duration`

   **anomalies** (table, one row per anomaly):
   - SampleIndex: double
   - Channel: double
   - Severity: double (anomaly score)
   - Type: categorical, one of "spike", "drift", "noise"

   **metrics** (struct):
   - processingTime: seconds
   - dataQuality: fraction of valid samples, 0 to 1
   - anomalyRate: anomalies per sample, 0 to 1

   ### Processing Requirements
   1. **Preprocessing**:
      - Remove the DC offset from each channel
      - Bandpass filter from 0.1 Hz to 0.4 times SampleRate (below the Nyquist frequency) with a 4th-order IIR filter from `designfilt`, applied with `filtfilt`. `bandpass` with default settings gives unusable output for a 0.1 Hz edge on records this short.
      - Normalize channels whose range exceeds 1,000

   2. **Feature extraction**:
      - Time-domain statistics per channel
      - Frequency analysis by the selected Method
      - Peak frequency and power per channel

   3. **Anomaly detection**:
      - Statistical outliers: z-score above ThresholdFactor
      - Drift: trend of the unfiltered data over each window (the 0.1 Hz filter removes slower drift)
      - Spikes: first difference above threshold

   4. **Performance targets** (measured with `timeit`):
      - 1,000,000 samples by 64 channels in under 10 seconds
      - Peak memory under 2 GB
      - Operate on whole matrices: `filtfilt`, `mean`, and `fft` work column by column, so no loop over channels is needed

   ### Error Handling
   - Empty input: rejected by `mustBeNonempty` in the arguments block
   - Fewer samples than WindowSize: error `processSensorData:InsufficientData`
   - Data larger than available memory: process in chunks of whole windows

   ### Validation Requirements
   - Class-based unit tests (`matlab.unittest`) covering each output field
   - Known test signals: a pure sine (known peak frequency) and injected spikes (known anomaly indices)
   - 95% statement coverage
   - Edge cases: one channel, all-NaN channel, minimum sample count

   ### Example Usage
   ```matlab
   s = load("sensor_data.mat");
   [features, anomalies, metrics] = processSensorData(s.signals);

   [features, anomalies] = processSensorData(s.signals, ...
       Method="wavelet", SampleRate=2000, ThresholdFactor=2.5);

   tiledlayout(2,1)
   nexttile
   plot(features.mean)
   title("Channel Means")
   nexttile
   scatter(anomalies.SampleIndex, anomalies.Severity)
   title("Detected Anomalies")
   ```

   ### Dependencies
   - MATLAB R2021a or later (`Name=Value` call syntax)
   - Signal Processing Toolbox: `designfilt`, `filtfilt`
   - Wavelet Toolbox: only for Method="wavelet"
   ````

5. **Create an implementation checklist**:
   ```markdown
   ## Implementation Checklist

   ### Core Functionality
   - [ ] arguments block with validators
   - [ ] Preprocessing
   - [ ] Feature extraction
   - [ ] Anomaly detection
   - [ ] Output struct and table

   ### Robustness
   - [ ] Missing and invalid data
   - [ ] Chunked processing for large inputs
   - [ ] Error identifiers for each failure

   ### Testing
   - [ ] Unit tests for each component
   - [ ] Known-signal tests for the full pipeline
   - [ ] Performance baseline with timeit

   ### Documentation
   - [ ] Help text with H1 line and syntax paragraphs
   - [ ] Usage example
   ```

6. **Identify design decisions**:
   ```markdown
   ## Design Decisions Required

   ### Anomaly Detection Method
   - Option A: Statistical (z-score, IQR): simple and fast, assumes a stationary signal
   - Option B: Machine learning: adapts to the data, needs labeled training data
   - Option C: Signal-based (derivatives, wavelets): matches known fault shapes
   **Recommendation**: statistical by default, others selectable through Method

   ### Data Container
   - Option A: Matrix (samples by channels): fastest for numeric processing
   - Option B: timetable: carries timestamps and channel names
   **Recommendation**: accept a matrix; return anomalies as a table

   ### Memory and Speed
   - Option A: Load all data: fastest, limited by memory
   - Option B: Process in chunks: bounded memory, more code
   **Recommendation**: whole-matrix processing, chunking above a size threshold
   ```

7. **Recommend MATLAB practices for the task**:
   ```markdown
   ## MATLAB Practices for This Task

   ### Code Organization
   - One public function per file, with local functions for each stage
   - arguments block for all input validation
   - Error identifiers in the form `processSensorData:ErrorName`

   ### Performance
   - Preallocate arrays that are filled in loops
   - Operate on whole arrays; most built-in functions work column by column
   - Measure with `timeit` and profile before optimizing; parallelize only stages the profile shows are slow

   ### Maintainability
   - lowerCamelCase names that describe the quantity (`sampleRate`, not `sr`)
   - Named constants instead of magic numbers
   - Algorithm references in the help text
   ```

## MCP Integration

When the MATLAB MCP Server is available:

- Use **detect_matlab_toolboxes** to confirm the release and which toolboxes are installed, and write them into the specification's Dependencies section.
- Use **evaluate_matlab_code** with `code` and `project_path` to prototype key decisions, such as checking that a candidate function exists in the installed release.

Without MCP, write the specification and mark the release and toolbox requirements as unverified.

## Output

Generate:
1. **Refined requirements** as a specification
2. **Clarifying questions** for open points
3. **Implementation checklist**
4. **Design decisions** with a recommendation for each
5. **Risks** that could invalidate the design
6. **Success criteria** for validation
7. **Function signature and arguments block** to start from
8. **Test scenarios** with known expected results
