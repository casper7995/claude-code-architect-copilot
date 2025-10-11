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

Add this marketplace to Claude Code:

```bash
/plugin marketplace add https://github.com/casper7995/claude-code-architect-copilot
```

Browse and install plugins:

```bash
/plugin
```

## 🚀 Available Plugins

### 1. Architect Copilot Essentials

**Essential agents for architecture-first development**

```bash
/plugin install architect-copilot-essentials
```

**Includes:**
- **Memory Agent** - Intelligent storage to Memory Bank and Cipher
- **Best Practices Agent** - Documentation lookup via Context7
- **Documentation Agent** - Technical writing and doc generation
- **Sequential Thinking Agent** - Complex problem-solving with structured reasoning

**Use when:**
- Starting new projects
- Making architectural decisions
- Need to maintain context across sessions
- Looking up best practices and current documentation

---

### 2. Databricks Development Suite

**Complete Databricks platform expertise**

```bash
/plugin install databricks-development-suite
```

**Includes:**
- **Databricks Agent** (Opus) - Unity Catalog, Delta Lake, DLT expert
- **Data Scientist** - SQL, BigQuery, exploratory analysis
- **Best Practices Agent** - Databricks documentation access

**Features:**
- Unity Catalog governance and design
- Delta Lake MERGE operations and optimization
- Delta Live Tables (DLT) pipeline patterns
- Spark performance tuning
- MLflow integration
- Bronze/Silver/Gold layer architecture

**Keywords:** databricks, unity catalog, delta lake, dlt, spark, mlflow, merge, optimize, vacuum

---

### 3. GenAI & ML Toolkit

**Machine learning and GenAI development**

```bash
/plugin install genai-ml-toolkit
```

**Includes:**
- **GenAI Agent** (Opus) - RAG systems, vector search, LLM apps
- **ML Agent** (Opus) - ML pipelines, MLflow, feature engineering
- **AI Engineer** - LLM integration, agent frameworks
- **ML Engineer** - Production ML infrastructure
- **Databricks Agent** - ML on Databricks platform

**Features:**
- RAG system implementation
- Vector search with Databricks Vector Search
- LLM application development
- MLflow experiment tracking
- Feature store management
- Model serving and deployment

**Keywords:** rag, llm, vector search, embeddings, mlflow, feature store, model training

---

### 4. Memory Intelligence

**Context-aware development with persistent memory**

```bash
/plugin install memory-intelligence
```

**Includes:**
- **Memory Agent** - Smart storage orchestration
- **Sequential Thinking Agent** - Complex reasoning

**Features:**
- Automatic storage of significant insights
- Semantic memory with Cipher MCP
- Structured context with Memory Bank MCP
- Decision logging and progress tracking
- Cross-session knowledge retention

**Use when:**
- User says "remember this" or "store this"
- After significant architecture discussions
- Making technology choices
- Discovering non-obvious solutions

---

### 5. Architecture Design System

**Comprehensive system design and review**

```bash
/plugin install architecture-design-system
```

**Includes:**
- **Code Reviewer** (Opus) - Security-focused code review
- **Docs Architect** (Opus) - Technical documentation generation
- **Deployment Engineer** - CI/CD and cloud deployment
- **Security Auditor** (Opus) - OWASP compliance and vulnerability assessment
- **Sequential Thinking Agent** - Complex design decisions
- **Documentation Agent** - Technical writing

**Features:**
- Multi-perspective code analysis
- Security and compliance auditing
- Architecture documentation
- Deployment planning
- Technical leadership guidance

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
├── agents/
│   ├── memory-agent.md        # Smart storage orchestration
│   ├── databricks-agent.md    # Databricks platform expert
│   ├── genai-agent.md         # RAG and vector search
│   ├── ml-agent.md            # ML pipelines and MLflow
│   ├── best-practices-agent.md
│   ├── documentation-agent.md
│   ├── sequential-thinking-agent.md
│   └── adopted/               # Community agents
│       ├── ai-engineer.md
│       ├── ml-engineer.md
│       ├── code-reviewer.md
│       ├── data-scientist.md
│       ├── docs-architect.md
│       ├── deployment-engineer.md
│       └── security-auditor.md
├── workflows/                  # (Future) Multi-agent workflows
├── tools/                      # (Future) Focused utilities
├── examples/                   # Usage examples
└── memory-bank/               # Project memory storage
    ├── product-context.md
    ├── active-context.md
    ├── system-patterns.md
    ├── decision-log.md
    └── progress.md
```

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

## 🎯 When to Use Each Plugin

| Task | Plugin | Agents |
|------|--------|--------|
| New project setup | Architect Copilot Essentials | Memory, Best Practices, Documentation |
| Databricks development | Databricks Development Suite | Databricks, Data Scientist |
| ML/AI features | GenAI & ML Toolkit | GenAI, ML, AI Engineer, ML Engineer |
| Context retention | Memory Intelligence | Memory Agent, Cipher |
| Code review & security | Architecture Design System | Code Reviewer, Security Auditor |
| Documentation | Essentials or Architecture Design | Documentation, Docs Architect |

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
