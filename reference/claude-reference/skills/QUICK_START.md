# Quick Start Guide: Installing Your Claude Skills

## What You Got

3 production-ready Claude Skills for AI/ML and Databricks work:

1. **databricks-pyspark-delta** - Databricks, PySpark, Delta Lake patterns
2. **python-ml-datascience** - pandas, scikit-learn, PyTorch, ML workflows  
3. **mlflow-deployment** - MLflow tracking, model registry, deployment

## Installation Options

### Option 1: Claude.ai (Web/Desktop/Mobile)

1. **Download the folder** from the outputs
2. **Go to Claude.ai Settings**
   - Click your profile icon
   - Select "Settings"
   - Navigate to "Skills" tab
3. **Upload each skill**
   - Click "Upload Skill" or "Add Skill"
   - Select a skill folder (e.g., `databricks-pyspark-delta`)
   - Repeat for each skill
4. **Enable the skills** you want to use

### Option 2: Claude Code (CLI)

```bash
# Extract the ZIP file
unzip claude-skills-for-ai-ml-databricks.zip

# Copy to Claude Code skills directory
cp -r claude-skills-for-ai-ml-databricks/databricks-pyspark-delta ~/.claude/skills/
cp -r claude-skills-for-ai-ml-databricks/python-ml-datascience ~/.claude/skills/
cp -r claude-skills-for-ai-ml-databricks/mlflow-deployment ~/.claude/skills/

# Skills will be automatically loaded when relevant
```

### Option 3: As a Plugin Marketplace (Claude Code)

```bash
# In your Claude Code terminal, add as a plugin
cd claude-skills-for-ai-ml-databricks
# Then in Claude Code, reference this directory as a plugin source
```

## Testing Your Skills

After installation, test them with these prompts:

### Test Databricks Skill
```
"Show me how to create a Bronze-Silver-Gold pipeline in Databricks"
```

### Test ML Skill  
```
"Help me build a Random Forest classifier with cross-validation"
```

### Test MLflow Skill
```
"How do I track experiments and register a model in MLflow?"
```

Claude should automatically detect and use the relevant skill!

## Customizing for Your Team

Edit the `SKILL.md` files to add:
- Your company's coding standards
- Internal library imports
- Team-specific naming conventions
- Links to internal docs

## Need Help?

- Check the main README.md for detailed documentation
- Review individual SKILL.md files for specific patterns
- Visit [Anthropic Skills Documentation](https://support.claude.com/en/articles/12512180-using-skills-in-claude)

---

**🎉 You're all set! Start using these skills to supercharge your AI/ML workflows with Claude.**
