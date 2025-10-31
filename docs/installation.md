# Installation Guide

This guide covers different methods to install MATLAB Slash Commands for Claude Code.

## Prerequisites

- Claude Code CLI installed and configured
- MATLAB development environment (optional, for testing generated code)
- Git (for manual installation)

## Installation Methods

### Method 1: Claude Code Plugin Manager (Recommended)

*Note: This method will be available once the plugin is published to the Claude Code registry.*

```bash
# Install directly from Claude Code
/plugin install matlab-slash-commands

# Or install from GitHub
/plugin install github:matlab/slash-commands
```

### Method 2: Manual Installation

#### Step 1: Clone the Repository

```bash
# Clone the repository
git clone https://github.com/matlab/slash-commands.git

# Navigate to the directory
cd slash-commands
```

#### Step 2: Copy Plugin Files

**Windows:**
```cmd
# Copy plugin files to Claude Code directory
xcopy /E /I .claude-plugin "%APPDATA%\claude\plugins\matlab-slash-commands"
xcopy /E /I commands "%APPDATA%\claude\plugins\matlab-slash-commands\commands"
```

**macOS/Linux:**
```bash
# Create plugins directory if it doesn't exist
mkdir -p ~/.claude/plugins/matlab-slash-commands

# Copy plugin files
cp -r .claude-plugin/* ~/.claude/plugins/matlab-slash-commands/
cp -r commands ~/.claude/plugins/matlab-slash-commands/
```

#### Step 3: Verify Installation

1. Restart Claude Code or reload plugins
2. Type `/matlab-` to see available commands
3. Test a simple command: `/matlab-explain`

### Method 3: Development Installation

For contributing or customizing commands:

```bash
# Fork the repository first, then:
git clone https://github.com/YOUR_USERNAME/slash-commands.git
cd slash-commands

# Create a symbolic link (Windows - run as Administrator)
mklink /D "%APPDATA%\claude\plugins\matlab-slash-commands" "%CD%"

# Create a symbolic link (macOS/Linux)
ln -s $(pwd) ~/.claude/plugins/matlab-slash-commands
```

## Configuration

### Plugin Settings

Edit `.claude-plugin/plugin.json` to customize:

```json
{
  "name": "matlab-slash-commands",
  "version": "1.0.0",
  "settings": {
    "defaultMatlabVersion": "R2023b",
    "enableVerboseMode": false,
    "preferredOptimizationLevel": "balanced"
  }
}
```

### Command Customization

Individual commands can be customized by editing their markdown files in the `commands/` directory.

## Updating

### Automatic Updates

```bash
/plugin update matlab-slash-commands
```

### Manual Updates

```bash
cd slash-commands
git pull origin main

# If using symbolic links, changes are immediate
# Otherwise, repeat the copy process from installation
```

## Troubleshooting

### Commands Not Appearing

1. Check Claude Code plugin directory:
   - Windows: `%APPDATA%\claude\plugins\`
   - macOS/Linux: `~/.claude/plugins/`

2. Verify plugin.json is valid JSON:
```bash
# Validate JSON syntax
python -m json.tool .claude-plugin/plugin.json
```

3. Reload plugins in Claude Code:
```
/plugin reload
```

### Command Execution Errors

1. Check command file exists in correct location
2. Verify markdown frontmatter is properly formatted
3. Ensure no syntax errors in command content

### Version Conflicts

If you have multiple versions installed:

1. Remove all versions:
```bash
# Windows
rmdir /S "%APPDATA%\claude\plugins\matlab-slash-commands"

# macOS/Linux
rm -rf ~/.claude/plugins/matlab-slash-commands
```

2. Reinstall fresh version

## Platform-Specific Notes

### Windows

- Run Command Prompt as Administrator for symbolic links
- Use PowerShell for better Unix-like command support
- Path separators use backslash (`\`)

### macOS

- May need to grant terminal permissions for file access
- Use Homebrew to install git if needed: `brew install git`

### Linux

- Ensure proper file permissions: `chmod -R 755 ~/.claude/plugins/matlab-slash-commands`
- Some distributions may use different config directories

## Verification Tests

After installation, test these commands:

```matlab
# Test documentation generation
/matlab-readme

# Test function documentation
/matlab-docs myFunction

# Test code explanation
/matlab-explain

# Test optimization
/matlab-optimize
```

## Uninstallation

### Via Plugin Manager

```bash
/plugin uninstall matlab-slash-commands
```

### Manual Removal

**Windows:**
```cmd
rmdir /S /Q "%APPDATA%\claude\plugins\matlab-slash-commands"
```

**macOS/Linux:**
```bash
rm -rf ~/.claude/plugins/matlab-slash-commands
```

## Getting Help

- [GitHub Issues](https://github.com/matlab/slash-commands/issues)
- [MATLAB Central](https://www.mathworks.com/matlabcentral/)
- [Claude Code Documentation](https://docs.claude.com/claude-code)

## Next Steps

After installation:
1. Read the [Usage Guide](usage-guide.md)
2. Review [Command Reference](command-reference.md)
3. Try example workflows in the main README
4. Customize commands for your workflow