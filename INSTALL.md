# Installation Guide

## Quick Install (Recommended)

Install all 12 agents with a single command:

```bash
/plugin install claude-code-architect-copilot@casper7995/claude-code-architect-copilot
```

Then **restart Claude Code** to activate all agents.

---

## Manual Installation (Alternative)

If the plugin install doesn't work, you can manually install agents:

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

Close and reopen VS Code (or restart the Claude Code extension).

---

## Verification

After installation, verify agents are available:

```bash
/subagent
```

You should see all 12 agents:
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
