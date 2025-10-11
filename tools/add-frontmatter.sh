#!/bin/bash

# Add frontmatter to agent files that don't have it

# Best Practices Agent
if ! head -1 agents/best-practices-agent.md | grep -q "^---$"; then
cat > agents/best-practices-agent.md.tmp << 'EOF'
---
name: best-practices-agent
description: Activates for documentation lookup, best practices research, and current library information. Keywords - how to, best practice, documentation, context7, latest version, API reference, library docs. Provides up-to-date technical documentation using Context7 and Fetch MCPs.
model: sonnet
tools: mcp__context7__get-library-docs, mcp__fetch__fetch, mcp__sequentialthinking__sequentialthinking
---

EOF
tail -n +1 agents/best-practices-agent.md >> agents/best-practices-agent.md.tmp
mv agents/best-practices-agent.md.tmp agents/best-practices-agent.md
echo "Updated best-practices-agent.md"
fi

# Sequential Thinking Agent
if ! head -1 agents/sequential-thinking-agent.md | grep -q "^---$"; then
cat > agents/sequential-thinking-agent.md.tmp << 'EOF'
---
name: sequential-thinking-agent
description: Activates for complex problem-solving, multi-step analysis, architectural decisions, and design trade-offs. Keywords - analyze, think through, evaluate options, compare approaches, complex decision, architecture choice. Uses Sequential Thinking MCP for structured reasoning.
model: opus
tools: mcp__sequentialthinking__sequentialthinking
---

EOF
tail -n +1 agents/sequential-thinking-agent.md >> agents/sequential-thinking-agent.md.tmp
mv agents/sequential-thinking-agent.md.tmp agents/sequential-thinking-agent.md
echo "Updated sequential-thinking-agent.md"
fi

# GenAI Agent
if ! head -1 agents/genai-agent.md | grep -q "^---$"; then
cat > agents/genai-agent.md.tmp << 'EOF'
---
name: genai-agent
description: Activates for LLM applications, RAG systems, vector search, embeddings, and GenAI workflows. Keywords - rag, retrieval augmented generation, vector search, embeddings, llm, langchain, semantic search, similarity. Leverages Databricks Vector Search and Context7 for documentation.
model: opus
tools: mcp__databricks-vector-search, mcp__context7__get-library-docs, mcp__fetch__fetch
---

EOF
tail -n +1 agents/genai-agent.md >> agents/genai-agent.md.tmp
mv agents/genai-agent.md.tmp agents/genai-agent.md
echo "Updated genai-agent.md"
fi

# ML Agent
if ! head -1 agents/ml-agent.md | grep -q "^---$"; then
cat > agents/ml-agent.md.tmp << 'EOF'
---
name: ml-agent
description: Activates for machine learning pipelines, model training, MLflow integration, feature engineering, and ML deployment. Keywords - machine learning, ml pipeline, model training, mlflow, feature store, model serving, hyperparameter tuning, cross-validation. Works with Databricks MLflow and Unity Catalog.
model: opus
tools: mcp__databricks-functions, mcp__context7__get-library-docs, mcp__fetch__fetch
---

EOF
tail -n +1 agents/ml-agent.md >> agents/ml-agent.md.tmp
mv agents/ml-agent.md.tmp agents/ml-agent.md
echo "Updated ml-agent.md"
fi

# Documentation Agent
if ! head -1 agents/documentation-agent.md | grep -q "^---$"; then
cat > agents/documentation-agent.md.tmp << 'EOF'
---
name: documentation-agent
description: Activates for technical writing, documentation generation, API docs, README files, tutorials, and knowledge base creation. Keywords - documentation, readme, tutorial, api docs, technical writing, user guide, how-to guide, docstring, comments. Generates comprehensive technical documentation.
model: sonnet
tools: mcp__context7__get-library-docs, mcp__memorybank__write_memory_bank_file
---

EOF
tail -n +1 agents/documentation-agent.md >> agents/documentation-agent.md.tmp
mv agents/documentation-agent.md.tmp agents/documentation-agent.md
echo "Updated documentation-agent.md"
fi

echo "Frontmatter added to all agent files!"
