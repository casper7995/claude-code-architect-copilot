# Testing Guide

## Overview

This guide helps you test the plugin distribution end-to-end to ensure users can successfully install and use all agents.

---

## Prerequisites

Before testing, you need:
- Claude Code installed
- Git installed
- Access to terminal/command line

---

## Test 1: Clean Environment Test (Most Important)

This simulates a **new user** installing your plugin from scratch.

### Step 1: Clean Your Current Installation

```bash
# Backup your current agents (optional)
cp -r ~/.claude/agents ~/.claude/agents.backup

# Remove current installation
rm -rf ~/.claude/agents
```

### Step 2: Test Manual Installation (Primary Test)

```bash
# Clone from GitHub
cd ~/Downloads  # or any temp directory
rm -rf claude-code-architect-copilot  # remove if exists
git clone https://github.com/casper7995/claude-code-architect-copilot.git
cd claude-code-architect-copilot

# Install agents
mkdir -p ~/.claude/agents
cp agents/*.md ~/.claude/agents/
cp agents/adopted/*.md ~/.claude/agents/

# Verify files copied
ls -la ~/.claude/agents/*.md | wc -l
# Should output: 12
```

### Step 3: Restart Claude Code

- **VS Code:** Quit VS Code completely, then reopen
- **Desktop App:** Quit Claude, then reopen
- **Wait 10-15 seconds** for agents to load

### Step 4: Verify Agent Discovery

In Claude Code, run:
```
/subagent
```

**Expected result:**
```
Available subagents:
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
```

✅ **PASS:** All 12 agents show up
❌ **FAIL:** Missing agents or command doesn't work

---

## Test 2: Plugin Install Command Test

Test the `/plugin install` command (may not work due to Claude Code limitations).

### Step 1: Remove Marketplace

```bash
rm -rf ~/.claude/plugins/marketplaces/claude-code-architect-copilot
```

### Step 2: Try Plugin Install

In Claude Code:
```bash
/plugin install claude-code-architect-copilot@casper7995/claude-code-architect-copilot
```

**Expected outcomes:**

**If it works:**
- Plugin downloads to `~/.claude/plugins/`
- Agents appear in `/subagent` after restart

**If it fails:**
- Error message about unknown plugin or marketplace
- This is expected - direct to manual installation in docs

---

## Test 3: Agent Activation Test

Test that agents actually activate based on keywords.

### Memory Agent Test

Ask Claude:
```
"Remember this: yfinance API changed in v0.2.0 - data is now under 'content' key instead of root"
```

**Expected behavior:**
- Memory Agent should activate (you may see a subtle indication)
- Should attempt to store to Memory Bank or Cipher
- If MCP servers not configured, may say "MCP server not available"

### Best Practices Agent Test

Ask Claude:
```
"What's the latest pandas DataFrame.apply documentation? Show me examples."
```

**Expected behavior:**
- Best Practices Agent should activate
- Should attempt to use Context7 MCP
- If Context7 not configured, may fall back to built-in knowledge

### Databricks Agent Test

Ask Claude:
```
"Explain the best approach for Delta Lake MERGE operations in Unity Catalog"
```

**Expected behavior:**
- Databricks Agent should activate
- Provides Databricks-specific guidance
- May reference Unity Catalog patterns

### Sequential Thinking Agent Test

Ask Claude:
```
"Help me design a Unity Catalog structure for a multi-tenant stock analysis platform with Bronze/Silver/Gold layers"
```

**Expected behavior:**
- Sequential Thinking Agent should activate
- Uses structured reasoning
- May invoke `mcp__sequentialthinking__sequentialthinking` tool

---

## Test 4: MCP Server Integration Test

Test that agents work properly WITH MCP servers configured.

### Prerequisites

MCP servers must be configured in `claude_desktop_config.json`:

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

Restart Claude Code after adding MCP servers.

### Test Memory Bank Integration

```
"Store this decision: We're using Delta Lake for all raw data storage because it provides ACID transactions and time travel"
```

**Expected:**
- Memory Agent activates
- Uses `mcp__memorybank__log_decision` tool
- Stores to Memory Bank successfully

**Verify:**
```bash
cat ~/memory-bank/decision-log.md
# Should contain your decision
```

### Test Context7 Integration

```
"Look up the latest yfinance Ticker.news API documentation"
```

**Expected:**
- Best Practices Agent activates
- Uses `mcp__context7__resolve-library-id` and `mcp__context7__get-library-docs`
- Returns current yfinance documentation

---

## Test 5: Documentation Test

Verify that documentation is clear and accurate.

### Test README.md

Open [README.md](README.md) and verify:
- [ ] Installation instructions are clear
- [ ] Both primary and fallback methods are documented
- [ ] MCP server requirements are mentioned
- [ ] Link to INSTALL.md works

### Test INSTALL.md

Open [INSTALL.md](INSTALL.md) and follow it step-by-step:
- [ ] Quick install instructions make sense
- [ ] Manual installation steps are accurate
- [ ] MCP server configuration is clear
- [ ] Troubleshooting section is helpful

### Test DISTRIBUTION.md

Open [DISTRIBUTION.md](DISTRIBUTION.md) and verify:
- [ ] Distribution strategy is explained
- [ ] Rationale for single plugin is clear
- [ ] Contributor guidelines are present

---

## Test 6: Cross-Platform Test

Test on different operating systems if possible.

### macOS
```bash
# Config location
~/Library/Application Support/Claude/claude_desktop_config.json

# Agents location
~/.claude/agents/
```

### Linux
```bash
# Config location
~/.config/Claude/claude_desktop_config.json

# Agents location
~/.claude/agents/
```

### Windows
```powershell
# Config location
%APPDATA%\Claude\claude_desktop_config.json

# Agents location
%USERPROFILE%\.claude\agents\
```

---

## Common Issues & Solutions

### Issue: `/subagent` shows nothing

**Diagnosis:**
```bash
ls -la ~/.claude/agents/*.md
```

**Solutions:**
1. Agents not in correct directory → Re-run copy commands
2. Agent files have wrong format → Check frontmatter with `head -10`
3. Claude Code not restarted → Completely quit and reopen

### Issue: Agents activate but tools fail

**Diagnosis:** MCP servers not configured

**Solution:**
```bash
# Check if MCP servers are configured
cat ~/Library/Application\ Support/Claude/claude_desktop_config.json | grep -A5 mcpServers
```

Add MCP server configuration and restart.

### Issue: Memory Agent doesn't store anything

**Diagnosis:** Memory Bank MCP not running

**Solution:**
1. Verify MCP config includes memorybank
2. Test MCP manually: `npx -y @modelcontextprotocol/server-memory-bank --version`
3. Restart Claude Code

### Issue: Best Practices Agent can't fetch docs

**Diagnosis:** Context7 MCP not running

**Solution:**
1. Verify MCP config includes context7
2. Test manually: `npx -y @context7/mcp-server --version`
3. Restart Claude Code

---

## Success Criteria

All tests pass if:

✅ **Installation:**
- [ ] Manual installation completes successfully
- [ ] All 12 agents appear in `/subagent`
- [ ] No error messages during installation

✅ **Agent Activation:**
- [ ] Memory Agent activates on "remember this"
- [ ] Best Practices Agent activates on documentation requests
- [ ] Databricks Agent activates on Databricks keywords
- [ ] Sequential Thinking Agent activates on complex design questions

✅ **MCP Integration:**
- [ ] Memory Bank stores decisions
- [ ] Context7 fetches documentation
- [ ] Cipher handles semantic search (if configured)

✅ **Documentation:**
- [ ] README is clear and accurate
- [ ] INSTALL.md is step-by-step correct
- [ ] Links work properly

---

## Reporting Issues

If tests fail:

1. **Document the failure:**
   - Which test failed?
   - What was the expected vs actual result?
   - Error messages (if any)

2. **Gather environment info:**
   - OS and version
   - Claude Code version
   - Agent file locations
   - MCP server configuration

3. **Create GitHub issue:**
   - Include test results
   - Include environment info
   - Include steps to reproduce

---

## Test Checklist

Use this checklist when testing:

### Basic Installation
- [ ] Test 1: Clean environment manual installation
- [ ] Test 2: Plugin command installation (optional)
- [ ] Verify all 12 agents show in `/subagent`

### Agent Functionality
- [ ] Test 3: Memory Agent activation
- [ ] Test 3: Best Practices Agent activation
- [ ] Test 3: Databricks Agent activation
- [ ] Test 3: Sequential Thinking Agent activation

### MCP Integration
- [ ] Test 4: Memory Bank integration
- [ ] Test 4: Context7 integration
- [ ] Test 4: Cipher integration (optional)

### Documentation
- [ ] Test 5: README accuracy
- [ ] Test 5: INSTALL.md accuracy
- [ ] Test 5: Links work

### Cross-Platform (if applicable)
- [ ] Test 6: macOS
- [ ] Test 6: Linux
- [ ] Test 6: Windows

---

**Testing completed by:** _________________
**Date:** _________________
**All tests passed:** [ ] Yes [ ] No
**Issues found:** _________________
