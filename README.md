# Claude Code Architect Copilot

> 🧠 **Architecture-first AI development copilot with intelligent memory, Databricks expertise, and 12 specialized agents that activate proactively based on context**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Plugin-purple)](https://claude.com/claude-code)
[![Sonnet 4.5](https://img.shields.io/badge/Model-Sonnet%204.5-orange)](https://www.anthropic.com/news/claude-3-5-sonnet)

## 🎯 Overview

**Claude Code plugin marketplace featuring 12 specialized agents powered by Sonnet 4.5.**

This plugin collection enhances Claude Code with domain-expert agents that automatically activate based on keywords and file patterns, providing seamless assistance across:

- 🧠 **Memory Bank integration** - Cross-session context with intelligent storage (Memory Bank + Cipher)
- ⚡ **Databricks/Unity Catalog expertise** - Delta Lake, DLT, Spark optimization, MLflow
- 🤖 **GenAI/ML workflows** - RAG systems, vector search, model training & deployment
- 🔒 **Security-focused code review** - SAST/DAST, OWASP, compliance auditing
- 📚 **Architecture-first development** - System design, technical documentation, deployment automation

All agents use **Sonnet 4.5** for fast, cost-effective, and high-quality assistance with automatic MCP tool integration.

## 📦 Installation

### Method 1: Plugin Marketplace (Recommended)

In Claude Code, use the `/plugin` TUI to add and install:

1. **Add the marketplace:**
   ```
   /plugin
   → Select "Add Marketplace"
   → Enter: casper7995/claude-code-architect-copilot
   ```

2. **Install plugins (choose what you need):**
   ```
   /plugin
   → Select "claude-code-architect-copilot"
   → Choose your plugins:
      • core-essentials (Memory, Best Practices, Documentation, Sequential Thinking)
      • data-platform (Databricks & Unity Catalog)
      • ai-ml-toolkit (GenAI & ML workflows)
      • development-suite (Code Review, Security, Deployment)
   → Install selected
   ```

3. **Restart:**
   - **CLI:** Close and reopen terminal
   - **VS Code:** Reload window (Cmd+Shift+P → "Developer: Reload Window")

> **Note:** Marketplace feature is available through the `/plugin` TUI. CLI commands (`/plugin marketplace add`) are coming in a future release.

### Method 2: Direct Installation (Alternative)

If you prefer manual installation:

```bash
git clone https://github.com/casper7995/claude-code-architect-copilot.git
cd claude-code-architect-copilot
mkdir -p ~/.claude/agents
cp agents/*.md ~/.claude/agents/
cp agents/adopted/*.md ~/.claude/agents/
```

⚠️ **Important:** Don't mix marketplace and manual installation. Choose one method to avoid conflicts where uninstalling doesn't work properly.

### Verification

**CLI:** Agents activate automatically based on keywords in your conversation  
**VS Code:** Same - agents work in the sidebar chat interface

Test by asking:
- "Design a Unity Catalog structure" → Databricks Agent activates
- "Review this code for security" → Code Reviewer activates
- "Remember this pattern" → Memory Agent activates

**[→ See detailed installation guide](INSTALL.md)**

### 🎨 Works in Both CLI & VS Code

This plugin works seamlessly in:

**Terminal (CLI)**
```bash
claude
# Agents activate automatically
```

**VS Code Extension**
1. Install [Claude Code extension](https://marketplace.visualstudio.com/items?itemName=anthropic.claude-code)
2. Requires VS Code 1.98.0+
3. Agents load from same `~/.claude/agents/` directory
4. Access via sidebar panel

### ⚠️ MCP Servers Required

The plugin installs **agents only**. For full functionality, you also need:
- **memorybank** - Memory Agent storage
- **context7** - Best Practices documentation lookup
- **cipher** - Semantic memory (optional)

[See MCP installation guide in INSTALL.md](INSTALL.md#required-mcp-servers-separate-installation)

## 🚀 What's Included

Four focused plugin bundles with **12 specialized agents** total:

### 📦 **Plugin Bundles**

| Plugin | Agents | Use When |
|--------|--------|----------|
| **core-essentials** | 4 agents | Essential for any project |
| **data-platform** | 1 agent | Working with Databricks |
| **ai-ml-toolkit** | 2 agents | Building AI/ML features |
| **development-suite** | 5 agents | Code review & deployment |

**Install only what you need!** Mix and match based on your project.

---

### 📦 **core-essentials** (Essential - Install First)

| Agent | Purpose | Keywords |
|-------|---------|----------|
| **Memory Agent** | Smart storage to Memory Bank & Cipher | "remember this", "store decision" |
| **Best Practices Agent** | Up-to-date docs via Context7 | "best practice", "how to" |
| **Documentation Agent** | Technical writing & generation | "document this", "write docs" |
| **Sequential Thinking Agent** | Complex problem-solving | "think through", "analyze" |

### ⚡ **data-platform** (For Databricks Users)

| Agent | Purpose | Keywords |
|-------|---------|----------|
| **Databricks Agent** | Unity Catalog, Delta Lake, DLT, Spark, MLflow | "databricks", "unity catalog", "delta lake" |

### 🤖 **ai-ml-toolkit** (For AI/ML Development)

| Agent | Purpose | Keywords |
|-------|---------|----------|
| **GenAI Agent** | RAG systems, vector search, LLM apps | "rag", "vector search", "genai" |
| **ML Agent** | ML pipelines, feature engineering, deployment | "machine learning", "mlflow", "feature" |

### 🔧 **development-suite** (For Code Quality & Deployment)

| Agent | Purpose | Keywords |
|-------|---------|----------|
| **Code Reviewer** | Security-focused code analysis | "review this code", "security check" |
| **Data Scientist** | SQL, exploratory analysis, statistics | "analyze data", "sql query" |
| **Docs Architect** | Long-form technical documentation | "architecture doc", "system design doc" |
| **Deployment Engineer** | CI/CD, Kubernetes, cloud deployment | "deploy", "kubernetes", "ci/cd" |
| **Security Auditor** | OWASP, SOC2, HIPAA compliance | "security audit", "compliance", "owasp" |

### 🎯 Key Features

**Memory & Context:**
- Cross-session knowledge retention
- Automatic decision logging
- Progress tracking
- Semantic memory with embeddings

**Databricks Expertise:**
- Unity Catalog governance
- Delta Lake MERGE operations
- Delta Live Tables (DLT) patterns
- Spark optimization
- MLflow integration
- Bronze/Silver/Gold architecture

**GenAI & ML:**
- RAG implementation
- Vector search integration
- Feature store management
- Model serving & deployment
- Experiment tracking

**Security & Quality:**
- SAST/DAST analysis
- Vulnerability detection
- Compliance auditing
- Multi-perspective code review

---

## 🔧 How It Works

### Marketplace vs Manual Installation

**Marketplace (Recommended):**
- ✅ Toggle plugins on/off via `/plugin`
- ✅ Easy updates when new versions release
- ✅ Install/uninstall actually works
- ✅ No file management needed

**Manual Installation:**
- ⚠️ Agents always active (can't toggle)
- ⚠️ Manual updates required
- ⚠️ Must delete files to uninstall
- ⚠️ Conflicts with marketplace if mixed

**Don't mix both methods!** Pick one approach.

---

## 🏗️ Architecture

### Agent System

Agents are specialized AI personas that automatically activate based on:
- **Keywords**: Technical terms in your conversation
- **File Patterns**: File extensions and imports
- **Context**: Architectural discussions, technology choices

### Memory Integration

**Memory Bank** (Structured):
- `product-context.md` - Project goals, tech stack
- `active-context.md` - Current work, ongoing tasks
- `system-patterns.md` - Technical patterns, architectures
- `decision-log.md` - Major decisions with rationale
- `progress.md` - Timeline of accomplishments

**Cipher** (Semantic):
- Architecture patterns
- Performance optimizations
- Domain-specific learnings
- Problem-solving approaches

### MCP Server Integration

Agents leverage multiple MCP servers:
- **Memory Bank MCP** - Structured project context
- **Cipher MCP** - Semantic memory with embeddings
- **Context7 MCP** - Current library documentation
- **Databricks Functions MCP** - Unity Catalog operations
- **Databricks Vector Search MCP** - Semantic similarity
- **Sequential Thinking MCP** - Structured reasoning
- **Fetch MCP** - Web content retrieval

## 📖 Usage Examples

### Architecture Planning
```
"Design a Unity Catalog structure for our AI stock platform"
```
→ Databricks Agent → Sequential Thinking Agent → Memory Agent (stores decision)

### RAG System Implementation
```
"Implement a RAG system with Databricks Vector Search"
```
→ GenAI Agent → Databricks Agent → Documentation Agent

### Memory Management
```
"Remember this: yfinance API changed - data now under 'content' key"
```
→ Memory Agent stores to Cipher and system-patterns.md

### Code Review with Security
```
"Review this authentication implementation for security issues"
```
→ Code Reviewer → Security Auditor → Best Practices Agent

## 🤝 Agent Collaboration

Agents work together automatically:

**Full-Stack Feature Development:**
1. Sequential Thinking Agent plans architecture
2. Best Practices Agent looks up framework docs
3. Databricks/GenAI/ML agents implement backend
4. Code Reviewer validates implementation
5. Security Auditor checks vulnerabilities
6. Memory Agent stores insights
7. Documentation Agent generates docs

## 🎨 Model Distribution

- **Opus (Complex Analysis)**: Databricks Agent, GenAI Agent, ML Agent, AI Engineer, ML Engineer, Code Reviewer, Security Auditor, Data Scientist, Docs Architect
- **Sonnet (Standard Development)**: Memory Agent, Best Practices Agent, Documentation Agent, Deployment Engineer
- **Haiku**: (Reserved for future lightweight agents)

## 📂 Repository Structure

```
claude-code-architect-copilot/
├── .claude-plugin/
│   └── marketplace.json       # Plugin catalog
├── plugin.json                # Plugin manifest
├── agents/
│   ├── memory-agent.md        # Smart storage orchestration
│   ├── databricks-agent.md    # Databricks platform expert
│   ├── genai-agent.md         # RAG and vector search
│   ├── ml-agent.md            # ML pipelines and MLflow
│   ├── best-practices-agent.md
│   ├── documentation-agent.md
│   ├── sequential-thinking-agent.md
│   └── adopted/               # Community agents
│       ├── code-reviewer.md
│       ├── data-scientist.md
│       ├── docs-architect.md
│       ├── deployment-engineer.md
│       └── security-auditor.md
├── archive/                   # Archived documentation
├── memory-bank/               # Example structure (user-specific, not distributed)
│   ├── product-context.md
│   ├── active-context.md
│   ├── system-patterns.md
│   ├── decision-log.md
│   └── progress.md
├── README.md
└── LICENSE
```

> **Note:** The `memory-bank/` directory shown here is an example structure for reference. Each user will have their own Memory Bank managed by the Memory Bank MCP server in their local environment.

## 🔧 Configuration

### Required MCP Servers

To use all features, configure these MCP servers in your Claude Code settings:

**Essential:**
- `memorybank` - Project memory storage
- `context7` - Library documentation

**Databricks:**
- `databricks-functions` - Unity Catalog operations
- `databricks-vector-search` - Vector similarity search

**Optional:**
- `cipher` - Semantic memory (uses Anthropic API)
- `sequential-thinking` - Advanced reasoning
- `fetch` - Web content retrieval

## 🎯 Plugin Selection Guide

| Your Use Case | Install These Plugins | Why |
|---------------|----------------------|-----|
| **Any project** | `core-essentials` | Essential for memory, best practices, docs |
| **Databricks dev** | `core-essentials` + `data-platform` | Unity Catalog & Delta Lake expertise |
| **AI/ML projects** | `core-essentials` + `ai-ml-toolkit` | RAG, vector search, MLflow |
| **Full-stack development** | `core-essentials` + `development-suite` | Code review, security, deployment |
| **Data platform + AI** | All except `development-suite` | Complete data & AI workflow |
| **Everything** | All 4 plugins | Full 12-agent suite |

**💡 Tip:** Start with `core-essentials` only, add others as needed!

---

## 💡 Smart Storage (Memory Agent)

**Automatically stores:**
- Significant code changes (>50 lines)
- Architecture decisions
- Technology choices with rationale
- Non-obvious problem solutions
- API gotchas and patterns

**Does NOT store:**
- Temporary troubleshooting
- Simple Q&A
- Already documented info
- Routine operations

**User triggers:**
- "remember this"
- "store this"
- "save decision"
- "log this"
- "important decision"

## 🤝 Contributing

This repository is organized for contribution:

1. Add new agents in `agents/` directory
2. Use proper frontmatter format (see existing agents)
3. Update `marketplace.json` to include in plugins
4. Submit PR with clear description

## 📜 License

MIT License - see [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Adopted agents based on [wshobson/agents](https://github.com/wshobson/agents)
- Built for [Claude Code](https://docs.anthropic.com/en/docs/claude-code)
- Inspired by architecture-first development principles

## 🔗 Resources

- [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code)
- [Claude Code Plugins](https://www.anthropic.com/news/claude-code-plugins)
- [MCP Server Documentation](https://modelcontextprotocol.io/)
- [Memory Bank MCP](https://github.com/cyanheads/mcp-memory-bank)
- [Context7 MCP](https://github.com/Context7-AI/mcp-context7)

---

**Questions or feedback?** Open an issue on [GitHub](https://github.com/casper7995/claude-code-architect-copilot/issues)
