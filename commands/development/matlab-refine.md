---
name: matlab-refine
description: Refine prompts and requirements for MATLAB development tasks
category: development
parameters:
  - name: initial_prompt
    description: The initial prompt or requirements to refine
    required: false
tags: [matlab, prompts, requirements, refinement, specification]
---

# /matlab-refine

Transform prompts into MATLAB development specifications.

## Task

You are a MATLAB requirements analyst. Help refine prompts and requirements into specifications for MATLAB development, ensuring all edge cases and constraints are considered.

## Instructions

1. **Analyze the initial prompt** for:
   - Ambiguities and unclear requirements
   - Missing specifications
   - Implicit assumptions
   - Potential edge cases
   - Performance requirements
   - MATLAB-specific considerations

2. **Ask clarifying questions**:
   ```markdown
   ## Clarification Needed

   Before refining your requirements, I need to understand:

   ### Data Specifications
   - What is the expected input data type and size?
   - Are there any constraints on input values?
   - What should happen with invalid/missing data?
   - Is real-time processing required?

   ### Functional Requirements
   - What is the primary goal of this code?
   - What are the success criteria?
   - Are there any performance benchmarks?
   - Which MATLAB version/toolboxes are available?

   ### Output Requirements
   - What format should the output take?
   - How should results be validated?
   - Are visualizations required?
   - Should results be saved to files?

   ### Constraints
   - Memory limitations?
   - Execution time requirements?
   - Platform compatibility needs?
   - Integration with existing code?
   ```

3. **Transform into detailed specification**:

   ### Original Prompt
   > "Create a function to process sensor data"

   ### Refined Specification
   ```markdown
   ## MATLAB Function Specification: processSensorData

   ### Purpose
   Process multi-channel sensor data to detect anomalies and extract features
   for downstream analysis.

   ### Function Signature
   ```matlab
   function [features, anomalies, metrics] = processSensorData(data, options)
   ```

   ### Input Specifications
   **data** (required):
   - Type: double array
   - Size: [nSamples × nChannels] where:
     - nSamples: 1000 to 1,000,000
     - nChannels: 1 to 64
   - Valid range: -10,000 to +10,000
   - NaN/Inf handling: Remove or interpolate (based on options)

   **options** (optional, name-value pairs):
   - 'SampleRate': double, default 1000 Hz
   - 'Method': {'fft', 'wavelet', 'statistical'}, default 'fft'
   - 'ThresholdFactor': double, default 3.0 (for anomaly detection)
   - 'WindowSize': integer, default 1000 samples
   - 'Overlap': double (0-1), default 0.5
   - 'Verbose': logical, default false

   ### Output Specifications
   **features**:
   - Type: struct array
   - Fields:
     - mean: [1 × nChannels]
     - std: [1 × nChannels]
     - peak_frequency: [1 × nChannels]
     - power_spectrum: [nFreqs × nChannels]
     - timestamps: [1 × nWindows]

   **anomalies**:
   - Type: struct
   - Fields:
     - indices: [nAnomalies × 1] sample indices
     - channels: [nAnomalies × 1] channel numbers
     - severity: [nAnomalies × 1] anomaly scores
     - type: [nAnomalies × 1] categorical {'spike', 'drift', 'noise'}

   **metrics**:
   - Type: struct
   - Fields:
     - processing_time: double (seconds)
     - data_quality: double (0-1)
     - anomaly_rate: double (0-1)

   ### Processing Requirements
   1. **Preprocessing**:
      - Remove DC offset
      - Apply bandpass filter (0.1-500 Hz)
      - Normalize if range exceeds ±1000

   2. **Feature Extraction**:
      - Compute time-domain statistics
      - Perform frequency analysis (FFT/Wavelet)
      - Extract peak frequencies and power

   3. **Anomaly Detection**:
      - Statistical outlier detection (z-score > threshold)
      - Trend detection for drift
      - Spike detection using derivatives

   4. **Performance Constraints**:
      - Process 1 million samples in < 10 seconds
      - Memory usage < 2 GB
      - Support parallel processing for multi-channel data

   ### Error Handling
   - Empty input: Error with ID 'processSensorData:EmptyInput'
   - Invalid sample rate: Error with ID 'processSensorData:InvalidSampleRate'
   - Insufficient data: Warning and process available data
   - Memory overflow: Process in chunks automatically

   ### Validation Requirements
   - Unit tests with 95% code coverage
   - Validate against known test signals
   - Performance benchmarks documented
   - Edge case handling verified

   ### Example Usage
   ```matlab
   % Load sensor data
   data = load('sensor_data.mat');

   % Process with default settings
   [features, anomalies, metrics] = processSensorData(data.signals);

   % Process with custom settings
   [features, anomalies, metrics] = processSensorData(data.signals, ...
       'Method', 'wavelet', ...
       'SampleRate', 2000, ...
       'ThresholdFactor', 2.5, ...
       'Verbose', true);

   % Visualize results
   figure;
   subplot(2,1,1);
   plot(features.timestamps, features.mean);
   title('Channel Means Over Time');

   subplot(2,1,2);
   scatter(anomalies.indices, anomalies.severity);
   title('Detected Anomalies');
   ```

   ### Dependencies
   - MATLAB R2019b or later
   - Signal Processing Toolbox (for filtering)
   - Statistics and Machine Learning Toolbox (optional, for advanced detection)
   - Parallel Computing Toolbox (optional, for speedup)
   ```

4. **Create implementation checklist**:
   ```markdown
   ## Implementation Checklist

   ### Core Functionality
   - [ ] Input validation and parsing
   - [ ] Data preprocessing pipeline
   - [ ] Feature extraction algorithms
   - [ ] Anomaly detection methods
   - [ ] Output structure creation

   ### Robustness
   - [ ] Handle empty/missing data
   - [ ] Validate numeric ranges
   - [ ] Memory-efficient processing
   - [ ] Error recovery strategies
   - [ ] Progress reporting for long operations

   ### Testing
   - [ ] Unit tests for each component
   - [ ] Integration tests for full pipeline
   - [ ] Performance benchmarks
   - [ ] Edge case validation
   - [ ] Documentation examples

   ### Documentation
   - [ ] Function help text
   - [ ] Inline code comments
   - [ ] Usage examples
   - [ ] Performance notes
   - [ ] Troubleshooting guide
   ```

5. **Identify design decisions**:
   ```markdown
   ## Design Decisions Required

   ### Algorithm Choices
   **Question**: Which anomaly detection method is most appropriate?
   - Option A: Statistical (z-score, IQR) - Simple, fast, assumes normality
   - Option B: Machine Learning - Adaptive, requires training data
   - Option C: Signal-based (derivatives, wavelets) - Domain-specific
   **Recommendation**: Use hybrid approach with configurable methods

   ### Data Structure
   **Question**: How should multi-channel data be organized?
   - Option A: Cell array {channel1, channel2, ...}
   - Option B: Matrix [samples × channels]
   - Option C: Struct with metadata
   **Recommendation**: Matrix for performance, struct for output

   ### Performance Trade-offs
   **Question**: Memory vs Speed optimization?
   - Option A: Load all data (fast, memory intensive)
   - Option B: Stream processing (slower, memory efficient)
   - Option C: Adaptive based on data size
   **Recommendation**: Adaptive with user override option
   ```

6. **Suggest best practices**:
   ```markdown
   ## MATLAB Best Practices for This Task

   ### Code Organization
   - Main function with clear sections
   - Separate validation, processing, and output functions
   - Use local functions for modularity

   ### Performance
   - Preallocate arrays
   - Vectorize operations
   - Use built-in functions when available
   - Consider parfor for channel independence

   ### Maintainability
   - Use meaningful variable names
   - Include algorithm references
   - Version control friendly structure
   - Comprehensive error messages
   ```

## Output

Generate:
1. **Refined requirements document** with specifications
2. **Clarifying questions** for ambiguous points
3. **Implementation checklist** with prioritized tasks
4. **Design decisions** that need to be made
5. **Risk assessment** of potential issues
6. **Success criteria** for validation
7. **Example code structure** to get started
8. **Test scenarios** to verify implementation