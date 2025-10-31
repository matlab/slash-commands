---
name: matlab-commandname
description: Brief description of what this command does (50 chars max)
category: [core|testing|quality|development]
parameters:
  - name: param1
    description: Description of the first parameter
    required: false
  - name: param2
    description: Description of the second parameter
    required: true
tags: [matlab, tag1, tag2, tag3]
related_prompts:
  - github.com/matlab/prompts/path/to/related-prompt.md
related_skills:
  - skill-name-from-matlab-skills
---

# /matlab-commandname

One-line description of what this command does.

## Task

You are a MATLAB [role/expert]. [Main objective of this command and what the user expects to achieve].

## Instructions

1. **First major step**:
   - Sub-step with details
   - Another sub-step
   - Important considerations

2. **Second major step**:
   ```matlab
   % Example code showing the pattern
   function result = exampleFunction(input)
       % Process input
       result = processData(input);
   end
   ```

3. **Third major step**:
   - Explain what happens
   - Show alternatives if applicable
   - Note any MATLAB version requirements

### Section for Complex Topics

#### Subsection 1
Detailed explanation of a specific aspect.

```matlab
% Code example
data = [1, 2, 3];
result = sum(data);
```

#### Subsection 2
Another important concept with examples.

### Common Patterns

Pattern 1:
```matlab
% Before
for i = 1:length(array)
    result(i) = array(i) * 2;
end

% After (better)
result = array * 2;
```

Pattern 2:
```matlab
% Example of another pattern
```

## Parameters

Detailed explanation of parameters if needed beyond the frontmatter:

- **param1**: Extended description, valid values, defaults
- **param2**: When to use, impact on output

## Examples

### Example 1: Basic Usage
```matlab
% Simple example
input = randn(100, 1);
output = functionName(input);
```

Expected output:
```
Description of what the output looks like
```

### Example 2: Advanced Usage
```matlab
% More complex example with options
options.Method = 'advanced';
options.Verbose = true;
output = functionName(input, options);
```

### Example 3: Edge Cases
```matlab
% Handling special cases
emptyInput = [];
output = functionName(emptyInput);  % Should handle gracefully
```

## Best Practices

1. **Practice 1**: Explanation of why this is important
2. **Practice 2**: Another best practice with rationale
3. **Practice 3**: Common pitfalls to avoid

## MATLAB Version Compatibility

- **Minimum version**: R2019b (for arguments block)
- **Recommended**: R2021a or later
- **Alternative for older versions**: Describe workarounds

## Output

Describe exactly what this command generates:

1. **Primary output**: What the main generated code/text looks like
2. **Format**: Structure and organization of output
3. **Customization**: How users can modify the output
4. **Integration**: How to integrate with existing code

Example of generated output:
```matlab
% This is what the command will generate
function generatedCode()
    % Generated implementation
end
```

## Notes and Warnings

⚠️ **Important Warning**: Things to be careful about

📝 **Note**: Additional information that's helpful

💡 **Tip**: Pro tips for advanced usage

## Related Commands

- `/matlab-related1` - How this command relates
- `/matlab-related2` - Another related command
- `/matlab-related3` - Complementary functionality

## References

- [MATLAB Documentation Topic](https://mathworks.com/help/matlab/...)
- [Related Paper or Article](URL)
- [Best Practices Guide](URL)

## Troubleshooting

Common issues and solutions:

**Issue 1**: Description of problem
- **Solution**: How to fix it

**Issue 2**: Another common problem
- **Solution**: Resolution steps

## Performance Considerations

- Time complexity: O(n)
- Space complexity: O(1)
- Typical execution time: < 1 second
- Memory usage: Minimal

## Customization

How to modify this command for specific needs:

1. Edit the command file at `commands/category/matlab-commandname.md`
2. Adjust these sections:
   - [Section name] for [purpose]
   - [Section name] for [purpose]
3. Reload plugins in Claude Code

---

*This command is part of the MATLAB Slash Commands collection. For more information, see the [main documentation](../README.md).*