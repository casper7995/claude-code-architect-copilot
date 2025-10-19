# Claude Skills for AI/ML and Databricks

A collection of production-ready Claude Skills designed specifically for AI/ML engineering and Databricks development workflows.

## 📦 Skills Included

### 1. **databricks-pyspark-delta**
Expert guidance for Databricks development including:
- PySpark DataFrame operations and SQL queries
- Delta Lake MERGE operations and time travel
- Medallion architecture (Bronze/Silver/Gold layers)
- Performance optimization (Z-ordering, partitioning, caching)
- Unity Catalog best practices

**Use when:** Working with Databricks notebooks, Spark DataFrames, Delta tables, or building data pipelines

### 2. **python-ml-datascience**
Comprehensive guide for Python-based ML and data science:
- pandas/numpy data manipulation patterns
- scikit-learn model development workflows
- PyTorch/TensorFlow deep learning basics
- Feature engineering techniques
- Model evaluation metrics and visualization
- Jupyter notebook best practices

**Use when:** Building ML models, analyzing data, or working with data science libraries

### 3. **mlflow-deployment**
Complete MLflow and ML operations guide:
- Experiment tracking and logging
- Model registry and versioning
- Deployment patterns (batch scoring, REST APIs)
- A/B testing frameworks
- Model monitoring and performance tracking
- Databricks-specific MLflow features

**Use when:** Tracking ML experiments, managing model lifecycle, or deploying models to production

## 🚀 Installation

### For Claude.ai Users

1. Download this repository
2. Go to Settings → Skills in Claude.ai
3. Click "Upload Skill"
4. Select each skill folder (databricks-pyspark-delta, python-ml-datascience, mlflow-deployment)
5. Enable the skills you want to use

### For Claude Code Users

```bash
# Clone or copy the skills to your Claude Code skills directory
cp -r databricks-pyspark-delta ~/.claude/skills/
cp -r python-ml-datascience ~/.claude/skills/
cp -r mlflow-deployment ~/.claude/skills/
```

Or register as a plugin marketplace:

```bash
# In Claude Code terminal
/plugin add /path/to/claude-skills-for-ai-ml-databricks
```

### For API Users

```python
from anthropic import Anthropic

client = Anthropic(api_key="your-api-key")

# Load skills from directory
response = client.messages.create(
    model="claude-sonnet-4-5-20250929",
    max_tokens=4096,
    container={
        "skills": [
            {"type": "user", "path": "/path/to/databricks-pyspark-delta"},
            {"type": "user", "path": "/path/to/python-ml-datascience"},
            {"type": "user", "path": "/path/to/mlflow-deployment"}
        ]
    },
    messages=[{
        "role": "user",
        "content": "Help me build a medallion architecture pipeline"
    }]
)
```

## 📚 Usage Examples

### Example 1: Building a Data Pipeline

```
User: "I need to create a Bronze-Silver-Gold pipeline for ingesting JSON 
files from S3 and creating daily user metrics"

Claude will:
- Load databricks-pyspark-delta skill
- Provide complete code for Bronze layer ingestion
- Show Silver layer cleaning and deduplication
- Create Gold layer aggregations
- Include optimization patterns (partitioning, Z-ordering)
```

### Example 2: ML Model Development

```
User: "Help me build a classification model with feature engineering 
and hyperparameter tuning"

Claude will:
- Load python-ml-datascience skill
- Show data preprocessing patterns
- Demonstrate feature engineering techniques
- Provide GridSearchCV/RandomizedSearchCV examples
- Include cross-validation and evaluation metrics
```

### Example 3: Model Deployment

```
User: "How do I deploy my model to production with MLflow on Databricks?"

Claude will:
- Load mlflow-deployment skill
- Show experiment tracking setup
- Demonstrate model registration workflow
- Provide batch scoring and API serving patterns
- Include monitoring and A/B testing examples
```

## 🎯 Key Features

✅ **Production-Ready Patterns** - Battle-tested code patterns used in real-world projects

✅ **Best Practices** - Follows Databricks and ML engineering best practices

✅ **Complete Examples** - Full code snippets, not just snippets

✅ **Error Handling** - Includes error handling and debugging patterns

✅ **Performance Optimized** - Includes optimization techniques and anti-patterns to avoid

✅ **Well-Documented** - Clear explanations and use cases for each pattern

## 🔧 Customization

You can customize these skills for your organization by:

1. **Adding company-specific patterns**:
   - Edit SKILL.md files to add your team's conventions
   - Add internal library imports
   - Include your data naming conventions

2. **Adding internal tool integrations**:
   - Add sections for your internal ML platforms
   - Include company-specific deployment workflows
   - Add links to internal documentation

3. **Creating new skills**:
   - Use the template structure from existing skills
   - Follow the YAML frontmatter format
   - Test with Claude before deploying to team

## 📖 Skill Structure

Each skill follows this structure:

```
skill-name/
├── SKILL.md          # Main skill file with YAML frontmatter
└── reference/        # (Optional) Additional reference files
```

SKILL.md format:
```markdown
---
name: skill-name
description: When and how to use this skill
---

# Skill Title

## Overview
Brief explanation

## Sections
Organized patterns and examples

## Key Takeaways
Summary of best practices
```

## 🤝 Contributing

Improvements and additions are welcome! To contribute:

1. Fork this repository
2. Create your skill or improvement
3. Test with Claude
4. Submit a pull request with:
   - Description of the skill/improvement
   - Example usage
   - Test results

## 📝 License

These skills are provided as-is for educational and commercial use. Feel free to adapt them to your organization's needs.

## 🆘 Support

For issues or questions:
- Check the [Anthropic Skills Documentation](https://support.claude.com/en/articles/12512180-using-skills-in-claude)
- Review the [anthropics/skills GitHub repository](https://github.com/anthropics/skills)
- Open an issue in this repository

## 🔄 Version History

- **v1.0.0** (2025-10-17): Initial release
  - Databricks PySpark & Delta Lake skill
  - Python ML & Data Science skill
  - MLflow & Deployment skill

## 🎓 Learning Resources

- [Databricks Documentation](https://docs.databricks.com/)
- [MLflow Documentation](https://mlflow.org/docs/latest/index.html)
- [Scikit-learn Documentation](https://scikit-learn.org/)
- [Anthropic Claude Documentation](https://docs.anthropic.com/)
- [Claude Skills Guide](https://support.claude.com/en/articles/12512198-creating-custom-skills)

---

**Made with ❤️ for Data Scientists and ML Engineers**

*These skills are designed to accelerate your Databricks and ML workflows with Claude Code and Claude.ai*
