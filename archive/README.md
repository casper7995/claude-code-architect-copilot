# Archive

This directory contains legacy files from development phases that have been replaced by the official Claude Code plugin structure.

## Contents

### Legacy Mode Files (`.clinerules-*`)
- `.clinerules-architect` - Architecture mode configuration
- `.clinerules-code` - Code mode configuration
- `.clinerules-test` - Test mode configuration
- `.clinerules-debug` - Debug mode configuration
- `.clinerules-ask` - Ask mode configuration

**Reason for archival:** Claude Code plugins use agent descriptions with keywords for activation, not mode-based configuration files.

### Legacy Hook Files (`hooks/*.json`)
- `hooks/memory-hooks.json` - Memory agent hook configuration
- `hooks/databricks-hooks.json` - Databricks agent hook configuration

**Reason for archival:** Hooks execute shell commands at lifecycle events (PreToolUse, PostToolUse), not agent activation. Agent activation is handled by descriptions with keywords in agent frontmatter.

### Development History Files (`.txt`)
- `claude_code_architect_copilot.txt` - Initial conversation log
- `claude_code_architect_copilot_update.txt` - Restructuring conversation log
- `claude_code_architect_copilot_best_practices_update.txt` - Best practices update log

**Reason for archival:** Historical context for development process, not needed for plugin functionality.

### Cipher Database (`data/`)
- `cipher-sessions.db` - Cipher MCP session database from development
- Database files (`.db-shm`, `.db-wal`) - SQLite temporary files

**Reason for archival:** Development database, users will have their own Cipher data when using the plugin.

## Current System

The project now uses the official Claude Code plugin format:
- Agents defined as `.md` files with YAML frontmatter
- Agent activation via `description` field with keywords
- Plugin bundles defined in `.claude-plugin/marketplace.json`
- MCP tools declared in agent frontmatter `tools:` field

See the main [README.md](../README.md) for current documentation.
