# Claude Code Plugins Configuration

## Installed Plugins

You recently installed 8 Claude Code plugins. Here's what each one does and how to use them:

### 1. commit-commands
**Purpose:** Enhanced git commit workflows

**Features:**
- Guided commit message creation
- Commit message templates
- Conventional commits support

**Usage:**
```bash
# In Claude Code, use enhanced commit commands
# The plugin provides structured commit workflows
```

---

### 2. security-guidance
**Purpose:** Security best practices and vulnerability detection

**Features:**
- Security vulnerability scanning
- Best practice recommendations
- Secure coding patterns

**Usage:**
- Automatically provides security guidance when writing code
- Flags potential security issues
- Suggests secure alternatives

---

### 3. agent-sdk-dev
**Purpose:** Claude Agent SDK development tools

**Features:**
- Agent development helpers
- SDK documentation access
- Testing tools for custom agents

**Usage:**
- Helps when building custom Claude agents
- Provides SDK code snippets and examples

---

### 4. playwright
**Purpose:** Browser automation and testing with Playwright

**Features:**
- Browser automation
- E2E testing support
- Screenshot and PDF generation

**Usage:**
```bash
# Enables Playwright-based browser automation
# Test web applications
# Generate screenshots and PDFs
```

---

### 5. explanatory-output-style
**Purpose:** Enhanced explanatory responses

**Features:**
- More detailed explanations
- Step-by-step breakdowns
- Educational responses

**Usage:**
- Automatically provides more thorough explanations
- Great for learning and understanding complex topics

---

### 6. serena
**Purpose:** Advanced conversational capabilities

**Features:**
- Enhanced dialogue management
- Context awareness
- Improved multi-turn conversations

---

### 7. typescript-lsp
**Purpose:** TypeScript Language Server integration

**Features:**
- TypeScript code intelligence
- Type checking
- Autocomplete and refactoring
- Go-to-definition and references

**Usage:**
- Automatically provides TypeScript analysis
- Enhanced code understanding for TS/JS projects

---

### 8. pyright-lsp
**Purpose:** Python Language Server (Pyright) integration

**Features:**
- Python type checking
- Code intelligence
- Import resolution
- Refactoring support

**Usage:**
- Automatically analyzes Python code
- Provides type hints and error detection

---

## Configuration

Most plugins work automatically after installation. For custom configuration:

### TypeScript LSP

If you have a `tsconfig.json`:
```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "commonjs",
    "strict": true,
    "esModuleInterop": true
  }
}
```

### Pyright LSP

If you have a `pyrightconfig.json`:
```json
{
  "typeCheckingMode": "basic",
  "reportMissingTypeStubs": false,
  "pythonVersion": "3.11"
}
```

---

## Usage Patterns

### For Development Work

**TypeScript/JavaScript Projects:**
```bash
# LSP automatically activates when working with .ts/.js files
# Provides:
# - Type checking
# - Autocomplete
# - Error detection
# - Refactoring suggestions
```

**Python Projects:**
```bash
# Pyright LSP activates for .py files
# Provides:
# - Type hints
# - Import analysis
# - Error detection
```

**Security-Sensitive Code:**
```bash
# security-guidance plugin automatically:
# - Scans for vulnerabilities
# - Suggests secure patterns
# - Warns about dangerous functions
```

---

## Plugin Management

### Checking Installed Plugins

```bash
# In Claude Code
/plugins  # Lists all installed plugins
```

### Installing Additional Plugins

```bash
# Search for plugins
/plugin search [keyword]

# Install a plugin
/plugin install [plugin-name]
```

### Updating Plugins

```bash
# Update all plugins
/plugin update
```

---

## Recommended Workflow

### For TypeScript Projects:
1. ✅ typescript-lsp provides code intelligence
2. ✅ security-guidance checks for vulnerabilities
3. ✅ commit-commands helps with structured commits
4. ✅ playwright for browser testing (if web app)

### For Python Projects:
1. ✅ pyright-lsp provides type checking
2. ✅ security-guidance scans for issues
3. ✅ commit-commands for git workflow

### For Agent Development:
1. ✅ agent-sdk-dev provides SDK helpers
2. ✅ explanatory-output-style for detailed guidance
3. ✅ serena for conversational testing

---

## Complementary Tools

These plugins work well with your existing setup:

**Your Dotfiles:**
- ✅ 1Password integration (security-guidance compatible)
- ✅ Pre-commit hooks (works with commit-commands)
- ✅ XDG compliance (LSPs find configs automatically)

**Your Workflow:**
- ✅ Chezmoi (version control with commit-commands)
- ✅ File organization (LSPs work with organized structure)
- ✅ Multi-OS support (LSPs work on all platforms)

---

## Troubleshooting

### LSP Not Working

**TypeScript LSP:**
```bash
# Check if tsconfig.json exists
ls -la tsconfig.json

# Check Node.js version
node --version  # Should be 16+

# Restart Claude Code
# LSP should re-initialize
```

**Pyright LSP:**
```bash
# Check Python version
python --version  # Should be 3.7+

# Check if in virtual environment
which python

# Create pyrightconfig.json if needed
```

### Security Guidance False Positives

If security-guidance flags safe code:
- Add `# allow-secret` comment for known safe examples
- Check if actual secret (move to 1Password if so!)
- Report false positive to plugin maintainers

---

## Advanced Usage

### Using with Custom Agents

If developing custom agents:

```typescript
// agent-sdk-dev provides helpers for:
import { Agent } from '@anthropic-ai/agent-sdk';

// SDK documentation and examples available in-conversation
```

### Browser Automation with Playwright

```typescript
// playwright plugin enables:
import { chromium } from 'playwright';

// Browser automation, testing, screenshots
const browser = await chromium.launch();
const page = await browser.newPage();
```

---

## Next Steps

1. **Test TypeScript LSP** - Open a .ts file and see code intelligence
2. **Test Python LSP** - Open a .py file and check type hints
3. **Try security scanning** - Write some code with potential issues
4. **Explore commit-commands** - Make a commit and see enhanced workflow
5. **Build an agent** - Use agent-sdk-dev to create custom agents

---

## Resources

- **Claude Code Docs:** https://docs.anthropic.com/claude-code
- **Plugin Marketplace:** In Claude Code CLI
- **TypeScript:** https://www.typescriptlang.org/
- **Pyright:** https://github.com/microsoft/pyright
- **Playwright:** https://playwright.dev/

---

**Status:** All 8 plugins installed ✅
**Requires:** Claude Code restart to fully activate
**Compatible:** Works with your dotfiles setup
