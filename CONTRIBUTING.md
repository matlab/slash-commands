# Contributing to MATLAB Slash Commands

Thank you for your interest in contributing to MATLAB Slash Commands! This document provides guidelines and instructions for contributing to the project.

## Code of Conduct

We follow the MathWorks Community Guidelines. Please be respectful, inclusive, and professional in all interactions.

## How to Contribute

### Reporting Issues

1. **Check existing issues** first to avoid duplicates
2. **Use issue templates** when available
3. **Provide detailed information**:
   - Claude Code version
   - MATLAB version
   - Steps to reproduce
   - Expected vs actual behavior
   - Error messages if any

### Suggesting Enhancements

1. **Open a discussion** first for major changes
2. **Describe the use case** and why it's valuable
3. **Consider compatibility** with existing commands
4. **Provide examples** of how it would work

### Contributing Code

#### Getting Started

1. Fork the repository
2. Clone your fork:
```bash
git clone https://github.com/YOUR_USERNAME/slash-commands.git
cd slash-commands
```

3. Create a feature branch:
```bash
git checkout -b feature/your-feature-name
```

#### Adding a New Command

1. **Use the command template**:
```bash
cp templates/command-template.md commands/category/matlab-yourcommand.md
```

2. **Follow the command structure**:
```markdown
---
name: matlab-commandname
description: Brief description (50 chars max)
category: [core|testing|quality|development]
parameters:
  - name: param1
    description: Parameter description
    required: false
tags: [matlab, relevant, tags]
related_prompts:
  - github.com/matlab/prompts/path/to/prompt
---

# /matlab-commandname

[Command content following template structure]
```

3. **Update plugin configuration**:
Edit `.claude-plugin/plugin.json` to register your command:
```json
{
  "name": "matlab-yourcommand",
  "description": "Your command description",
  "file": "commands/category/matlab-yourcommand.md"
}
```

4. **Write comprehensive documentation**:
- Clear purpose and use cases
- Detailed instructions
- Multiple examples
- Edge cases and error handling
- Expected output format

5. **Test your command**:
- Verify it works in Claude Code
- Test with various inputs
- Ensure error messages are helpful
- Check performance with large inputs

#### Improving Existing Commands

1. **Maintain backward compatibility**
2. **Document breaking changes clearly**
3. **Add tests for new functionality**
4. **Update examples if behavior changes**

### Command Guidelines

#### Command Naming

- Use format: `matlab-verb` or `matlab-noun`
- Keep names concise and descriptive
- Use lowercase with hyphens
- Examples: `matlab-test`, `matlab-optimize`

#### Command Content

1. **Task Section**:
   - Define the role clearly
   - State the objective
   - Set expectations

2. **Instructions Section**:
   - Step-by-step process
   - Code examples with comments
   - Multiple approaches when applicable
   - Best practices and anti-patterns

3. **Output Section**:
   - Specify exact output format
   - Include examples of generated code
   - Define success criteria

#### MATLAB Best Practices

- Follow [MATLAB Style Guidelines](https://www.mathworks.com/matlabcentral/fileexchange/46056-matlab-style-guidelines-2-0)
- Use vectorization over loops when possible
- Include proper error handling
- Add input validation
- Provide meaningful variable names
- Comment complex algorithms

### Testing

#### Manual Testing Checklist

- [ ] Command loads without errors
- [ ] Generates expected output for basic input
- [ ] Handles edge cases appropriately
- [ ] Error messages are informative
- [ ] Performance is acceptable
- [ ] Documentation examples work

#### Test Scenarios

Create test scenarios in `examples/` showing:
- Basic usage
- Advanced features
- Error conditions
- Performance considerations

### Documentation

#### Required Documentation

1. **Command file**: Complete markdown with examples
2. **README update**: Add to command list if new
3. **Example workflow**: Show integration with other commands
4. **Changelog entry**: Document your changes

#### Documentation Style

- Use clear, concise language
- Provide code examples for everything
- Include both simple and advanced usage
- Explain the "why" not just the "how"
- Keep examples realistic and practical

### Pull Request Process

1. **Before submitting**:
   - Test all changes thoroughly
   - Update documentation
   - Check for merge conflicts
   - Run through the testing checklist

2. **PR Description**:
   ```markdown
   ## Summary
   Brief description of changes

   ## Type of Change
   - [ ] Bug fix
   - [ ] New command
   - [ ] Command enhancement
   - [ ] Documentation update

   ## Changes Made
   - Detail 1
   - Detail 2

   ## Testing
   - How you tested
   - Test scenarios covered

   ## Checklist
   - [ ] Documentation updated
   - [ ] Examples provided
   - [ ] Plugin.json updated (if applicable)
   - [ ] Backward compatible
   ```

3. **Review process**:
   - PRs require at least one review
   - Address feedback constructively
   - Keep PRs focused and atomic
   - Update based on review comments

### Version Guidelines

We follow Semantic Versioning (SemVer):
- **Major** (X.0.0): Breaking changes
- **Minor** (0.X.0): New features, backward compatible
- **Patch** (0.0.X): Bug fixes

### Development Environment

#### Recommended Setup

- Claude Code (latest version)
- MATLAB R2019b or later
- Git for version control
- Text editor with Markdown support

#### Useful Tools

- MATLAB Code Analyzer (mlint)
- MATLAB Profiler for performance
- Git hooks for pre-commit checks

## Getting Help

- **Questions**: Open a discussion
- **Bugs**: Create an issue
- **Ideas**: Start a discussion
- **MATLAB Help**: [MATLAB Answers](https://www.mathworks.com/matlabcentral/answers/)

## Recognition

Contributors will be:
- Listed in CONTRIBUTORS.md
- Mentioned in release notes
- Given credit in relevant documentation

## Release Process

1. Update version in plugin.json
2. Update CHANGELOG.md
3. Create release tag
4. Publish release notes

## License

By contributing, you agree that your contributions will be licensed under the BSD 3-Clause License.

## Resources

- [MATLAB Documentation](https://www.mathworks.com/help/matlab/)
- [Claude Code Docs](https://docs.claude.com/claude-code)
- [MATLAB Style Guide](https://www.mathworks.com/matlabcentral/fileexchange/46056-matlab-style-guidelines-2-0)
- [Git Best Practices](https://git-scm.com/book/en/v2)

Thank you for contributing to make MATLAB development better with Claude Code!