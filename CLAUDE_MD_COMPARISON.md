# CLAUDE.md Comparison: Current vs Simplified

## Overview

This document compares your current `~/.claude/CLAUDE.md` (detailed, pre-plugin architecture) with the recommended simplified version for plugin-based architecture.

---

## Key Differences

| Aspect | Current CLAUDE.md | Simplified CLAUDE.md |
|--------|-------------------|----------------------|
| **Length** | ~500 lines | ~150 lines |
| **Focus** | WHO + HOW + WHAT + WHEN | WHO + HOW |
| **MCP Instructions** | Detailed per-tool guidance | "Trust agents to use their tools" |
| **Behavioral Triggers** | Explicit keyword→action mapping | Agents handle activation |
| **Memory Bank** | Detailed "what to store" rules | "memory-agent decides" |
| **Tool Usage** | Prescriptive ("always use X") | Descriptive ("agents use X") |

---

## What to KEEP (User Identity & Communication)

### ✅ User Profile
```markdown
- Name: Casper
- Role: AI/ML Professional with Technical Leadership
- Focus Areas: AI/ML, Big Data Engineering, Databricks
- Thinking Style: Systems thinker - architecture-first
```

**Why:** Agents need to know WHO they're helping and adapt their explanations accordingly.

---

### ✅ Communication Style
```markdown
### Always Start with the Big Picture
1. System Architecture First
2. Context Before Code
3. Visual Mental Models

### Technical Communication
- Be precise and technically accurate
- Explain "why" not just "what" or "how"
```

**Why:** This defines HOW Claude should communicate, regardless of which agent is active.

---

### ✅ Decision-Making Style
```markdown
- Make technically sound decisions decisively
- Explain trade-offs and alternatives
- When uncertain about user intent, ask
```

**Why:** Your preference for decisive action vs asking for permission on every technical choice.

---

## What to REMOVE (Delegate to Agents)

### ❌ Explicit User Triggers Table

**Current CLAUDE.md has:**
```markdown
When user says... | Automatic action
------------------|------------------
"remember this" / "store this" | → Memory Bank + Cipher
"explain architecture" | → Sequential Thinking + diagram
"find code for X" | → Serena semantic search
"look up X library" | → Context7 documentation
```

**Why remove:**
- **memory-agent** handles "remember this" via keywords in its description
- **sequential-thinking-agent** activates on "explain architecture"
- **code-reviewer**/**security-auditor** use Serena MCP when needed
- **best-practices-agent** uses Context7 automatically

**Result:** Agents handle these triggers. CLAUDE.md doesn't need to.

---

### ❌ Automatic Claude Actions Table

**Current CLAUDE.md has:**
```markdown
When Claude detects... | Automatic action
----------------------|------------------
Architecture discussion | → Store in system-patterns.md
Technology choice | → Log in decision-log.md
Databricks config change | → Update system-patterns.md
New library mentioned | → Context7 lookup proactively
```

**Why remove:**
- **memory-agent** decides when to store based on significance heuristics (built into agent)
- **best-practices-agent** does Context7 lookups automatically (declared in tools)
- **databricks-agent** knows when Databricks configs are significant

**Result:** Agents have this intelligence built-in. CLAUDE.md doesn't need to micromanage.

---

### ❌ Detailed MCP Server Usage Guidelines

**Current CLAUDE.md has:**
```markdown
## MCP Server Usage Guidelines

### Available MCP Servers
- context7 - Library documentation
- github - Repository operations
- memorybank - Project memory
- databricks-functions - Unity Catalog
- databricks-vector-search - Vector search
- cipher - Memory layer
- serena - Semantic code analysis

### When to Use Each MCP Server
(Detailed decision matrix with examples)

### Performance Tips
(Optimization guidance per server)
```

**Why remove:**
- Each agent declares its MCP tools in frontmatter `tools:` field
- Agents know WHEN and HOW to use their tools optimally
- Example: databricks-agent uses `databricks-functions` for Unity Catalog queries - it knows this

**Simplified version:**
```markdown
## Agent Integration

Your specialized agents will use their declared MCP tools proactively.
Trust the agents - they're designed to work within your preferences.
```

**Result:** Agents are the MCP experts. CLAUDE.md just says "trust them."

---

### ❌ Memory Bank Strategy Details

**Current CLAUDE.md has:**
```markdown
## Memory Bank Strategy

### What to Store
✅ Always Store:
- User preferences and work style
- System architecture decisions
- Databricks workspace configurations
- AI/ML experiment insights

✅ Context-Dependent:
- Significant conversations about system design
- Problem-solving approaches that worked well

❌ Don't Store:
- Temporary troubleshooting
- Simple Q&A
```

**Why remove:**
- **memory-agent** has these heuristics built into its system prompt
- Agent description says: "Activates on explicit user requests AND implicit triggers (significant code changes >50 lines, architecture decisions, non-obvious solutions)"
- Agent is trained to distinguish significant vs temporary

**Simplified version:**
```markdown
memory-agent handles intelligent storage based on significance heuristics
```

**Result:** memory-agent is the expert. CLAUDE.md doesn't need to micromanage storage decisions.

---

## Migration Path

### Option 1: Replace Immediately (Recommended)
1. Backup current `~/.claude/CLAUDE.md`
2. Replace with `CLAUDE_MD_SIMPLIFIED.md` content
3. Test with plugin agents
4. Adjust if needed

### Option 2: Gradual Transition
1. Keep current CLAUDE.md
2. Install plugins globally
3. Observe conflicts/redundancies
4. Gradually remove sections from CLAUDE.md as you verify agents handle them
5. Eventually converge to simplified version

### Option 3: Hybrid (Not Recommended)
- Keep current CLAUDE.md with minor edits
- Risk: Competing instructions between CLAUDE.md and agents
- Only if you want to maintain tight control

---

## Expected Benefits of Simplification

### ✅ Cleaner Separation of Concerns
- CLAUDE.md = User identity + Communication style
- Agents = Domain expertise + Tool usage

### ✅ Reduced Cognitive Load
- Claude follows 150 lines (identity) + 200 lines (active agent)
- Not 500 lines (CLAUDE.md) + 200 lines (agent) = 700 lines

### ✅ Easier Maintenance
- Update agent behavior → Edit agent file
- User preferences change → Edit CLAUDE.md
- No need to sync instructions across files

### ✅ Better Agent Specialization
- memory-agent fully controls Memory Bank decisions
- databricks-agent fully controls Databricks MCP usage
- No CLAUDE.md overriding agent intelligence

### ✅ Fewer Instruction Conflicts
- No "CLAUDE.md says use Context7" vs "agent says use Databricks MCP first"
- Agents make expert decisions within your communication preferences

---

## Potential Concerns & Mitigation

### Concern 1: "Will agents be proactive enough without CLAUDE.md forcing it?"

**Answer:** YES. Agent descriptions have "Use PROACTIVELY" and keywords.

Example:
- databricks-agent: "Use PROACTIVELY when working with Unity Catalog governance..."
- best-practices-agent: "Use PROACTIVELY when needing current library documentation..."

**Mitigation:** Agents are designed to be proactive. If one isn't, edit the agent file, not CLAUDE.md.

---

### Concern 2: "Will Memory Bank still get used automatically?"

**Answer:** YES. memory-agent handles this.

From memory-agent description:
```
Activates on explicit user requests ("remember this", "store this")
AND implicit triggers (significant code changes >50 lines,
architecture decisions, technology choices, non-obvious solutions)
```

**Mitigation:** memory-agent is conservative by design. If you want MORE storage, edit memory-agent, not CLAUDE.md.

---

### Concern 3: "Will Context7 still be used for documentation lookup?"

**Answer:** YES. best-practices-agent specializes in this.

From best-practices-agent:
```
tools: mcp__context7__get-library-docs, mcp__fetch__fetch
Aggressive Triggers: User mentions any library, framework, or tool by name
```

**Mitigation:** best-practices-agent will use Context7 automatically when relevant.

---

## Recommendation

**Replace `~/.claude/CLAUDE.md` with simplified version.**

**Reasoning:**
1. Current CLAUDE.md was appropriate BEFORE plugins existed
2. Now that you have 12 specialized agents, they handle tool usage and behavioral automation
3. CLAUDE.md should focus on WHO you are and HOW to communicate
4. Agents handle WHAT expertise to provide and WHICH tools to use

**Result:** Cleaner architecture, fewer conflicts, easier maintenance, better agent specialization.

---

## Test Plan

After migration:
1. ✅ Test databricks-agent activation (mention "Unity Catalog")
2. ✅ Test memory-agent storage (complete significant work, see if it stores)
3. ✅ Test best-practices-agent lookup (ask about a library)
4. ✅ Verify architecture-first communication style maintained
5. ✅ Verify technical communication quality (why before how)

If any behavior is missing, adjust the AGENT file, not CLAUDE.md.

---

**Conclusion:** Simplify CLAUDE.md. Trust your agents. Cleaner architecture awaits.
