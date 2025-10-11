#!/bin/bash

cd agents/adopted

# Data Scientist
cat > data-scientist.md.tmp << 'EOF'
---
name: data-scientist
description: Expert in data analysis, SQL queries, and statistical analysis. Use PROACTIVELY for exploratory data analysis (EDA), writing complex SQL queries, performing statistical tests, creating visualizations, or working with BigQuery/Pandas. Specializes in uncovering insights from data. Keywords - data analysis, sql, bigquery, statistics, eda, visualization, pandas, data exploration, statistical analysis.
model: opus
---

EOF
tail -n +6 data-scientist.md >> data-scientist.md.tmp
mv data-scientist.md.tmp data-scientist.md

# ML Engineer
cat > ml-engineer.md.tmp << 'EOF'
---
name: ml-engineer
description: Expert in ML infrastructure, pipelines, and deployment. Use PROACTIVELY when building ML pipelines, setting up ML infrastructure, implementing feature stores, deploying models to production, or establishing MLOps practices. Focuses on production-ready ML systems. Keywords - machine learning, ml pipeline, model training, feature store, ml deployment, mlops, model serving, ml infrastructure.
model: opus
---

EOF
tail -n +6 ml-engineer.md >> ml-engineer.md.tmp
mv ml-engineer.md.tmp ml-engineer.md

# Docs Architect
cat > docs-architect.md.tmp << 'EOF'
---
name: docs-architect
description: Expert in comprehensive technical documentation and knowledge management. Use PROACTIVELY when creating architecture documentation, API specifications (OpenAPI/Swagger), system design docs, or building knowledge bases. Excels at high-level documentation strategy. Keywords - documentation, api docs, technical writing, architecture docs, system documentation, openapi, swagger, knowledge base.
model: opus
---

EOF
tail -n +6 docs-architect.md >> docs-architect.md.tmp
mv docs-architect.md.tmp docs-architect.md

# Deployment Engineer
cat > deployment-engineer.md.tmp << 'EOF'
---
name: deployment-engineer
description: Expert in CI/CD pipelines, containerization, and cloud deployment strategies. Use PROACTIVELY when setting up CI/CD pipelines (GitHub Actions, GitLab CI), containerizing applications with Docker, deploying to Kubernetes, or implementing release management strategies. Focuses on reliable, automated deployments. Keywords - deployment, ci/cd, docker, kubernetes, github actions, cloud deploy, release, containerization, k8s.
model: sonnet
---

EOF
tail -n +6 deployment-engineer.md >> deployment-engineer.md.tmp
mv deployment-engineer.md.tmp deployment-engineer.md

# Security Auditor
cat > security-auditor.md.tmp << 'EOF'
---
name: security-auditor
description: Expert in security audits, vulnerability assessments, and compliance. Use PROACTIVELY for comprehensive security audits, OWASP Top 10 vulnerability checks, penetration testing, compliance validation (SOC2, HIPAA, GDPR), or security hardening. Identifies security vulnerabilities before they become issues. Keywords - security audit, vulnerability, owasp, penetration test, security scan, compliance, security hardening, soc2, hipaa, gdpr.
model: opus
---

EOF
tail -n +6 security-auditor.md >> security-auditor.md.tmp
mv security-auditor.md.tmp security-auditor.md

cd ../..
echo "✅ All adopted agents updated with proactive descriptions!"
