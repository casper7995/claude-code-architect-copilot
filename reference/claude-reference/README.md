# Claude Reference Structure

This directory contains a reference structure of the global `~/.claude` directory setup.

## What's Included

- `agents/` - Installed agent files
- `commands/` - Installed command files  
- `skills/` - Installed skill files
- `CLAUDE.md` - Main Claude configuration
- `settings.example.json` - Example settings (sanitized)

## What's Excluded (Sensitive)

- `settings.json` and `settings.local.json` - May contain API keys
- `debug/` - Debug logs and temporary files
- `file-history/` - Personal file history
- `projects/` - Personal project data
- `session-env/` - Session environment data
- `shell-snapshots/` - Shell state snapshots
- `todos/` - Personal todo data
- `statsig/` - Analytics data
- `history.jsonl` - Conversation history
- `.claude_backup_*` - Backup directories

## Usage

This reference structure helps users understand how to set up their own `~/.claude` directory when installing the claude-code-architect-copilot plugin.

## Sync

Run `./sync-claude-reference.sh` to update this reference with your current setup.
