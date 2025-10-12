# Installation Guide

## Recommended: Marketplace Installation

### Step 1: Add Marketplace via TUI

In Claude Code, run `/plugin` and use the TUI:

```
/plugin
→ Select "Add Marketplace"
→ Enter: https://github.com/casper7995/claude-code-architect-copilot
```

### Step 2: Install Plugin

```
/plugin
→ Select "claude-code-architect-copilot"
→ Choose plugins to install:
   • core-essentials
   • data-platform
   • ai-ml-toolkit
   • development-suite
→ Install selected
```

### Step 3: Restart Claude Code

**For CLI:**
```bash
# Close current session (Ctrl+D), then:
claude
```

**For VS Code:**
```
Cmd+Shift+P → "Developer: Reload Window"
```

---

## Alternative: Direct Installation (Manual Method)

> ⚠️ **Warning:** Don't mix marketplace and manual installation! Choose one method to avoid conflicts.

### Step 1: Clone the Repository

```bash
git clone https://github.com/casper7995/claude-code-architect-copilot.git
cd claude-code-architect-copilot
```

### Step 2: Copy Agents to Claude Directory

```bash
# Create agents directory
mkdir -p ~/.claude/agents

# Copy all agents
cp agents/*.md ~/.claude/agents/
cp agents/adopted/*.md ~/.claude/agents/
```

### Step 3: Restart Claude Code

**For CLI:** Close session (Ctrl+D) then run `claude`

**For VS Code:** Cmd+Shift+P → "Developer: Reload Window"

---

## Verification

After installation, agents activate automatically based on conversation context.

**Test with these prompts:**

- "Design a Unity Catalog structure" → Databricks Agent activates
- "Review this code for security" → Code Reviewer activates
- "Remember this pattern" → Memory Agent activates

**Your 12 installed agents:**
- best-practices-agent
- code-reviewer
- data-scientist
- databricks-agent
- deployment-engineer
- docs-architect
- documentation-agent
- genai-agent
- memory-agent
- ml-agent
- security-auditor
- sequential-thinking-agent

### Verify Files Installed

```bash
ls -1 ~/.claude/agents/*.md | wc -l
# Should show: 12
```

---

## Future: CLI Command Installation (Coming Soon)

Once CLI marketplace commands are released, you'll also be able to use:

### Step 1: Add the Marketplace

In Claude Code, run:

```bash
/plugin marketplace add casper7995/claude-code-architect-copilot
```

This adds the marketplace to your available plugin sources.

### Step 2: Browse Available Plugins

```bash
/plugin
```

This opens the plugin menu where you can see all available plugins from added marketplaces.

### Step 3: Install the Plugin

Select and install from the menu, or directly:

```bash
/plugin install core-essentials@claude-code-architect-copilot
```

Then **restart Claude Code** to activate all agents.

---

### Available Plugin Bundles

When marketplace is available, you can install individual bundles:

| Bundle | Agents Included | Use Case |
|--------|----------------|----------|
| **core-essentials** | Memory, Best Practices, Documentation, Sequential Thinking | Core development (recommended for all) |
| **data-platform** | Databricks | Databricks & Unity Catalog expertise |
| **ai-ml-toolkit** | GenAI, ML | RAG, vector search, MLflow |
| **development-suite** | Code Reviewer, Data Scientist, Docs Architect, Deployment Engineer, Security Auditor | Code review, security, deployment |

---

### Plugin Validation Status

Your plugin is **already validated and ready** for marketplace distribution:

```bash
cd claude-code-architect-copilot
claude plugin validate .
# ✔ Validation passed
```

---

## ⚠️ Required MCP Servers (Separate Installation)

**IMPORTANT:** The plugin installs agents only. MCP servers must be installed separately!

Without MCP servers, some agents will have limited functionality:
- ❌ Memory Agent won't store to Memory Bank or Cipher
- ❌ Best Practices Agent won't fetch documentation
- ❌ Databricks agents won't have direct platform integration

### Essential MCP Servers (Strongly Recommended)

| Server | Purpose | Package | Required For |
|--------|---------|---------|--------------|
| **memorybank** | Project memory storage | `@movibe/memory-bank-mcp` | Memory Agent |
| **context7** | Library documentation lookup | `@upstash/context7-mcp` | Best Practices Agent |
| **cipher** | Semantic memory search | `@byterover/cipher` | Memory Agent |

### Recommended MCP Servers (For Specific Use Cases)

| Server | Purpose | Package | Use Case |
|--------|---------|---------|----------|
| **sequential-thinking** | Structured reasoning | `@modelcontextprotocol/server-sequential-thinking` | Sequential Thinking Agent, complex analysis |
| **sqlite** | SQLite database queries | `@modelcontextprotocol/server-sqlite` | Data analysis, local databases |
| **postgres** | PostgreSQL operations | `@modelcontextprotocol/server-postgres` | Production databases, data work |
| **brave-search** | Real-time web search | `@modelcontextprotocol/server-brave-search` | Current info, documentation lookups |
| **filesystem** | File operations | `@modelcontextprotocol/server-filesystem` | File reading/writing (usually auto-included) |
| **github** | GitHub integration | GitHub Copilot MCP | Repos, PRs, issues (usually auto-included) |

### Databricks-Specific MCP Servers (Optional)

| Server | Purpose | Package | Required For |
|--------|---------|---------|--------------|
| **databricks-functions** | Unity Catalog operations | `@databricks/mcp-server-functions` | Databricks Agent |
| **databricks-vector-search** | Vector similarity search | `@databricks/mcp-server-vector-search` | GenAI Agent |

### How to Install MCP Servers

**For Claude Code CLI + VS Code Extension (Recommended):**

Use the built-in `claude mcp` commands:

```bash
# Add essential MCP servers
claude mcp add memorybank npx -y @movibe/memory-bank-mcp --mode code
claude mcp add context7 npx -y @upstash/context7-mcp
claude mcp add cipher npx -y @byterover/cipher --mode mcp

# Add recommended servers (choose based on your needs)
claude mcp add sequential-thinking npx -y @modelcontextprotocol/server-sequential-thinking
claude mcp add sqlite npx -y @modelcontextprotocol/server-sqlite --db-path /path/to/your/database.db
claude mcp add postgres npx -y @modelcontextprotocol/server-postgres postgresql://user:password@localhost/dbname
claude mcp add brave-search npx -y @modelcontextprotocol/server-brave-search

# Add Databricks-specific servers (if you use Databricks)
claude mcp add databricks-functions npx -y @databricks/mcp-server-functions

# Verify installation
claude mcp list
```

**For Claude Desktop App (Alternative):**

If using Claude Desktop instead of CLI, add to `claude_desktop_config.json`:
- **Mac:** `~/Library/Application Support/Claude/claude_desktop_config.json`
- **Linux:** `~/.config/Claude/claude_desktop_config.json`  
- **Windows:** `%APPDATA%\Claude\claude_desktop_config.json`

```json
{
  "mcpServers": {
    "memorybank": {
      "command": "npx",
      "args": ["-y", "@movibe/memory-bank-mcp", "--mode", "code"]
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"]
    },
    "cipher": {
      "command": "npx",
      "args": ["-y", "@byterover/cipher", "--mode", "mcp"]
    }
  }
}
```

> **Note:** Claude Code CLI and VS Code extension share the same MCP configuration. Once added via CLI, servers work in both places.

---

## Testing Your Installation

### Test Memory Agent
```
"Remember this: yfinance API returns data under 'content' key"
```

### Test Best Practices Agent
```
"What's the latest pandas DataFrame.apply documentation?"
```

### Test Databricks Agent
```
"Explain Delta Lake MERGE operation best practices"
```

### Test Sequential Thinking Agent
```
"Help me design a Unity Catalog structure for our platform"
```

---

## Troubleshooting

### Install/Uninstall Not Working (IMPORTANT!)

**Problem:** Installing or uninstalling via marketplace doesn't actually change which agents are active.

**Cause:** You have agents in **both** locations:
- Manual: `~/.claude/agents/*.md`
- Marketplace: `~/.claude/plugins/marketplaces/*/agents/`

Claude Code loads from both, so marketplace uninstall doesn't remove manually installed agents!

**Solution:**
```bash
# Check for manual installs
ls ~/.claude/agents/

# If you see .md files, CHOOSE ONE METHOD:

# Option A: Use marketplace (recommended)
mkdir -p ~/backup-agents
cp ~/.claude/agents/*.md ~/backup-agents/  # Backup first
rm ~/.claude/agents/*.md                    # Remove manual installs

# Option B: Use manual only
# Uninstall marketplace via /plugin
# Then keep using manual installs
```

After cleanup, marketplace install/uninstall will work correctly!

### Agents Don't Show Up

1. **Verify installation location:**
   
   **For marketplace:**
   ```bash
   ls -la ~/.claude/plugins/marketplaces/claude-code-architect-copilot/agents/
   ```
   
   **For manual:**
   ```bash
   ls -la ~/.claude/agents/
   ```
   
   Should show 12 .md files total

2. **Check agent format:**
   ```bash
   head -5 ~/.claude/agents/memory-agent.md
   ```
   Should show YAML frontmatter with `name:`, `description:`, etc.

3. **Restart Claude Code completely:**
   - Quit VS Code entirely
   - Reopen VS Code
   - Wait 10-15 seconds for agents to load

### MCP Servers Not Working

**For Claude Code CLI:**

1. **Check installed MCP servers:**
   ```bash
   claude mcp list
   ```
   Should show all servers with ✓ Connected status

2. **Test specific MCP server:**
   ```bash
   npx -y @upstash/context7-mcp
   ```
   Should run without errors

3. **Remove and re-add problematic server:**
   ```bash
   claude mcp remove memorybank
   claude mcp add memorybank npx -y @movibe/memory-bank-mcp --mode code
   ```

4. **Check MCP server logs:**
   ```bash
   claude --debug mcp
   ```

**For Claude Desktop:**

1. **Check configuration file:**
   - Mac: `~/Library/Application Support/Claude/claude_desktop_config.json`
   - Linux: `~/.config/Claude/claude_desktop_config.json`

2. **Verify JSON syntax:** Use a JSON validator

3. **Restart Claude Desktop after changes**

---

## Support

If you encounter issues:
1. Check [GitHub Issues](https://github.com/casper7995/claude-code-architect-copilot/issues)
2. Review [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code)
3. Open a new issue with:
   - Your OS and Claude Code version
   - Steps you followed
   - Error messages (if any)
