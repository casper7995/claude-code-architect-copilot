# Archive

This directory contains legacy files from the initial project design that are no longer used in the official Claude Code plugin system.

## Legacy Files

### .clinerules-* Files
These were part of an early "mode system" concept (architect, code, test, debug, ask modes).

**Why archived:**
- Claude Code plugins use agents, not modes
- Agent activation is handled by descriptions in frontmatter
- Mode switching is implicit based on agent activation

### hooks/ Directory
JSON-based hook definitions for triggering agents.

**Why archived:**
- Claude Code handles agent activation through agent descriptions
- Keywords, file patterns, and context cues go in agent frontmatter
- No separate JSON hook files needed

## Current System

The project now uses the official Claude Code plugin format:
- Agents defined as `.md` files with YAML frontmatter
- Agent activation via `description` field
- Plugin bundles defined in `.claude-plugin/marketplace.json`

See the main [README.md](../README.md) for current documentation.
