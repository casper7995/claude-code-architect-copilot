# Plugin Installation Guide

## ✅ Step 1: CLAUDE.md Simplified - COMPLETE

Your `~/.claude/CLAUDE.md` has been simplified:
- **Before:** 500+ lines (detailed MCP instructions, behavioral triggers)
- **After:** 114 lines (user identity, communication style)
- **Backup:** `~/.claude/CLAUDE.md.backup` (in case you need to revert)

---

## 🔌 Step 2: Install Plugins Globally

**Run these commands in Claude Code interface:**

### Add Marketplace (One-Time)
```bash
/plugin marketplace add https://github.com/casper7995/claude-code-architect-copilot
```

### Install All 5 Plugin Bundles

#### 1. Architect Copilot Essentials (Core)
```bash
/plugin install architect-copilot-essentials
```
**Includes:** memory-agent, best-practices-agent, documentation-agent, sequential-thinking-agent

#### 2. Databricks Development Suite
```bash
/plugin install databricks-development-suite
```
**Includes:** databricks-agent, data-scientist, best-practices-agent

#### 3. GenAI & ML Toolkit
```bash
/plugin install genai-ml-toolkit
```
**Includes:** genai-agent, ml-agent, databricks-agent

#### 4. Memory Intelligence
```bash
/plugin install memory-intelligence
```
**Includes:** memory-agent, sequential-thinking-agent

#### 5. Architecture Design System
```bash
/plugin install architecture-design-system
```
**Includes:** code-reviewer, docs-architect, deployment-engineer, security-auditor, sequential-thinking-agent, documentation-agent

---

## 🧪 Step 3: Verify Installation

### Check Installed Plugins
```bash
/plugin list
```

### Check Installed Agents
```bash
/agent list
```

You should see all 12 agents:
1. memory-agent
2. databricks-agent
3. genai-agent
4. ml-agent
5. best-practices-agent
6. documentation-agent
7. sequential-thinking-agent
8. code-reviewer
9. deployment-engineer
10. security-auditor
11. docs-architect
12. data-scientist

---

## 🎯 Step 4: Test Agent Activation

### Test 1: databricks-agent
Say: **"Help me design a Unity Catalog schema for my ML feature store"**

**Expected:**
- databricks-agent activates (keywords: "Unity Catalog", "feature store")
- Provides architecture-first explanation (CLAUDE.md preference)
- Uses Context7 for Databricks docs automatically
- May invoke memory-agent to store the decision

---

### Test 2: best-practices-agent + Context7
Say: **"What's the latest pandas API for reading CSV files?"**

**Expected:**
- best-practices-agent activates (keyword: "pandas")
- Uses Context7 MCP to lookup pandas documentation
- Provides current best practices

---

### Test 3: memory-agent
Say: **"Remember this decision: We're using Delta Lake for Bronze layer with MERGE operations for idempotency"**

**Expected:**
- memory-agent activates (keyword: "remember")
- Stores to Memory Bank (decision-log.md or system-patterns.md)
- Confirms storage with summary

---

### Test 4: genai-agent
Say: **"Design a RAG system for my Databricks documentation"**

**Expected:**
- genai-agent activates (keywords: "RAG", "embeddings")
- Provides architecture-first explanation
- May suggest Databricks Vector Search integration
- May invoke sequential-thinking-agent for complex design

---

### Test 5: Verify CLAUDE.md Preferences Maintained
Say: **"Explain how Delta Lake works"**

**Expected:**
- databricks-agent activates
- **Architecture/big picture FIRST** (CLAUDE.md: "Always start with big picture")
- **Why before how** (CLAUDE.md: "Explain why not just what/how")
- Technical, precise language (CLAUDE.md: "Don't oversimplify")

---

## 🔧 Troubleshooting

### Issue: Agents Not Activating

**Check 1: Are plugins installed?**
```bash
/plugin list
```

**Check 2: Are agents loaded?**
```bash
/agent list
```

**Check 3: Try explicit keywords**
- For databricks-agent: Mention "Unity Catalog" or "Delta Lake"
- For genai-agent: Mention "RAG" or "vector search"
- For memory-agent: Say "remember this"

---

### Issue: Agent Behavior Changed After CLAUDE.md Simplification

**Expected Changes (Good):**
- ✅ Agents use their declared MCP tools automatically
- ✅ memory-agent decides when to store (not every action)
- ✅ best-practices-agent uses Context7 proactively
- ✅ Less verbose about "using MCP server X"

**Preserved Behaviors (From CLAUDE.md):**
- ✅ Architecture-first explanations
- ✅ Big picture before implementation
- ✅ "Why" explanations before "how"
- ✅ Technical, precise communication
- ✅ Decisive decision-making

**If something is missing:**
1. Check agent activation (use keywords)
2. Edit agent file if behavior needs adjustment
3. Don't add back to CLAUDE.md (keep separation of concerns)

---

### Issue: Want to Revert CLAUDE.md

```bash
# Restore original
cp ~/.claude/CLAUDE.md.backup ~/.claude/CLAUDE.md

# Restart Claude Code to apply changes
```

---

## 📊 Before/After Comparison

### Instruction Load on Claude

**Before:**
- CLAUDE.md: 500+ lines (global instructions)
- Active agent: 200 lines (agent prompt)
- **Total: 700+ lines** Claude tries to follow

**After:**
- CLAUDE.md: 114 lines (identity + communication)
- Active agent: 200 lines (domain expertise)
- **Total: 314 lines** Claude follows
- **56% reduction in instruction complexity**

### Separation of Concerns

**Before:**
```
CLAUDE.md: WHO + HOW + WHAT + WHEN + WHICH TOOLS
Agents: Domain expertise
→ Overlap and potential conflicts
```

**After:**
```
CLAUDE.md: WHO + HOW (identity + communication)
Agents: WHAT + WHEN + WHICH TOOLS (expertise + activation + tools)
→ Clean separation, no conflicts
```

---

## 🎉 Success Criteria

After installation and testing, you should observe:

✅ **Agents activate automatically** based on context/keywords
✅ **Architecture-first communication** maintained (CLAUDE.md preference)
✅ **MCP tools used proactively** by appropriate agents
✅ **Memory Bank storage** happens intelligently (significant work only)
✅ **Context7 lookups** happen automatically (best-practices-agent)
✅ **Simpler mental model** - trust agents for tool usage

---

## 📝 Next Steps After Installation

1. **Use plugins naturally** - mention Databricks, ML, RAG topics
2. **Observe agent activation** - see which agents respond to what
3. **Trust the agents** - they handle MCP tools, you focus on your work
4. **Adjust agents if needed** - edit agent files, not CLAUDE.md
5. **Enjoy cleaner architecture** - fewer instruction conflicts

---

**Installation complete!** Your Claude Code is now powered by 12 specialized agents with simplified global instructions. 🚀
