# Installation Guide

## Current Installation (v2.0.14)

> **Note:** The `/plugin marketplace` commands are coming in Claude Code v2.1.0+. For now, use direct installation.

### Step-by-Step Installation

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

**For CLI:**
```bash
# Close current session (Ctrl+D)
# Start new session
claude
```

**For VS Code:**
```
Cmd+Shift+P → "Developer: Reload Window"
```

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

## Future Installation (v2.1.0+)

Once plugin marketplace support is released, you'll be able to install with:

```bash
/plugin marketplace add casper7995/claude-code-architect-copilot
/plugin install architect-copilot-essentials
```

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

| Server | Purpose | Required For |
|--------|---------|--------------|
| **memorybank** | Project memory storage | Memory Agent |
| **context7** | Library documentation lookup | Best Practices Agent |
| **cipher** | Semantic memory search | Memory Agent |

### Optional MCP Servers (For Specific Use Cases)

| Server | Purpose | Required For |
|--------|---------|--------------|
| **databricks-functions** | Unity Catalog operations | Databricks Agent |
| **databricks-vector-search** | Vector similarity search | GenAI Agent |
| **serena** | Code intelligence & analysis | Code Reviewer |

### How to Install MCP Servers

Add to your `claude_desktop_config.json` (location varies by OS):
- **Mac:** `~/Library/Application Support/Claude/claude_desktop_config.json`
- **Linux:** `~/.config/Claude/claude_desktop_config.json`
- **Windows:** `%APPDATA%\Claude\claude_desktop_config.json`

**Configuration example:**

```json
{
  "mcpServers": {
    "memorybank": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory-bank"]
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@context7/mcp-server"]
    },
    "cipher": {
      "command": "npx",
      "args": ["-y", "@byterover/cipher", "--mode", "mcp"]
    }
  }
}
```

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

### Agents Don't Show Up

1. **Verify installation location:**
   ```bash
   ls -la ~/.claude/agents/
   ```
   Should show 12 .md files

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

1. **Check configuration file location:**
   - Mac: `~/Library/Application Support/Claude/claude_desktop_config.json`
   - Linux: `~/.config/Claude/claude_desktop_config.json`

2. **Verify MCP server installation:**
   ```bash
   npx -y @context7/mcp-server --version
   ```

3. **Restart after adding MCP servers**

---

## Support

If you encounter issues:
1. Check [GitHub Issues](https://github.com/casper7995/claude-code-architect-copilot/issues)
2. Review [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code)
3. Open a new issue with:
   - Your OS and Claude Code version
   - Steps you followed
   - Error messages (if any)
