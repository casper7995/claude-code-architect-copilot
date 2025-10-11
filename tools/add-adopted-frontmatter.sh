#!/bin/bash

cd agents/adopted

# AI Engineer
if ! head -1 ai-engineer.md | grep -q "^---$"; then
cat > ai-engineer.md.tmp << 'EOF'
---
name: ai-engineer
description: Activates for LLM applications, RAG systems, agent frameworks, and production AI deployment. Keywords - llm, rag, ai agent, langchain, vector database, embeddings, prompt engineering, ai deployment.
model: opus
---

EOF
tail -n +1 ai-engineer.md >> ai-engineer.md.tmp
mv ai-engineer.md.tmp ai-engineer.md
echo "Updated ai-engineer.md"
fi

# ML Engineer
if ! head -1 ml-engineer.md | grep -q "^---$"; then
cat > ml-engineer.md.tmp << 'EOF'
---
name: ml-engineer
description: Activates for ML pipelines, model training, feature engineering, and ML infrastructure. Keywords - machine learning, ml pipeline, model training, feature store, ml deployment, mlops.
model: opus
---

EOF
tail -n +1 ml-engineer.md >> ml-engineer.md.tmp
mv ml-engineer.md.tmp ml-engineer.md
echo "Updated ml-engineer.md"
fi

# Code Reviewer
if ! head -1 code-reviewer.md | grep -q "^---$"; then
cat > code-reviewer.md.tmp << 'EOF'
---
name: code-reviewer
description: Activates for code review, security analysis, and production reliability assessment. Keywords - code review, review this, security check, production ready, code quality.
model: opus
---

EOF
tail -n +1 code-reviewer.md >> code-reviewer.md.tmp
mv code-reviewer.md.tmp code-reviewer.md
echo "Updated code-reviewer.md"
fi

# Data Scientist
if ! head -1 data-scientist.md | grep -q "^---$"; then
cat > data-scientist.md.tmp << 'EOF'
---
name: data-scientist
description: Activates for data analysis, SQL queries, statistical analysis, and exploratory data analysis. Keywords - data analysis, sql, bigquery, statistics, eda, visualization, pandas, data exploration.
model: opus
---

EOF
tail -n +1 data-scientist.md >> data-scientist.md.tmp
mv data-scientist.md.tmp data-scientist.md
echo "Updated data-scientist.md"
fi

# Docs Architect
if ! head -1 docs-architect.md | grep -q "^---$"; then
cat > docs-architect.md.tmp << 'EOF'
---
name: docs-architect
description: Activates for comprehensive technical documentation, API specifications, and knowledge base creation. Keywords - documentation, api docs, technical writing, architecture docs, system documentation.
model: opus
---

EOF
tail -n +1 docs-architect.md >> docs-architect.md.tmp
mv docs-architect.md.tmp docs-architect.md
echo "Updated docs-architect.md"
fi

# Deployment Engineer
if ! head -1 deployment-engineer.md | grep -q "^---$"; then
cat > deployment-engineer.md.tmp << 'EOF'
---
name: deployment-engineer
description: Activates for CI/CD pipelines, containerization, cloud deployments, and release management. Keywords - deployment, ci/cd, docker, kubernetes, github actions, cloud deploy, release.
model: sonnet
---

EOF
tail -n +1 deployment-engineer.md >> deployment-engineer.md.tmp
mv deployment-engineer.md.tmp deployment-engineer.md
echo "Updated deployment-engineer.md"
fi

# Security Auditor
if ! head -1 security-auditor.md | grep -q "^---$"; then
cat > security-auditor.md.tmp << 'EOF'
---
name: security-auditor
description: Activates for security audits, vulnerability assessments, and OWASP compliance checks. Keywords - security audit, vulnerability, owasp, penetration test, security scan, compliance.
model: opus
---

EOF
tail -n +1 security-auditor.md >> security-auditor.md.tmp
mv security-auditor.md.tmp security-auditor.md
echo "Updated security-auditor.md"
fi

cd ../..
echo "All adopted agents updated with frontmatter!"
