# Distribution Strategy

## Overview

This plugin uses a **simplified single-plugin distribution** strategy for ease of use.

## Why Single Plugin Instead of Marketplace Bundles?

### Original Plan (Marketplace with Multiple Bundles)
- 5 separate plugin bundles (essentials, databricks-suite, genai-toolkit, etc.)
- Users install only what they need
- More complex structure

### Current Approach (Single All-in-One Plugin)
- One plugin with all 12 agents
- Users install everything with one command
- Agents activate contextually based on keywords
- Much simpler for users

### Rationale for Change
1. **Claude Code's marketplace system has limitations** - Bundle installation doesn't work as expected
2. **All agents are lightweight** - No performance impact from having all 12
3. **Better user experience** - Single command, all features available
4. **Contextual activation** - Agents only engage when relevant keywords are detected
5. **Simpler maintenance** - One plugin to update/version

## Distribution Channels

### 1. Primary: Claude Code Plugin System
```bash
/plugin install claude-code-architect-copilot@casper7995/claude-code-architect-copilot
```

### 2. Fallback: Manual Installation
```bash
git clone https://github.com/casper7995/claude-code-architect-copilot.git
cd claude-code-architect-copilot
mkdir -p ~/.claude/agents
cp agents/*.md ~/.claude/agents/
cp agents/adopted/*.md ~/.claude/agents/
```

## File Structure

```
claude-code-architect-copilot/
├── .claude-plugin/
│   ├── plugin.json          # Main plugin configuration
│   └── marketplace.json     # Legacy marketplace definition (may be deprecated)
├── agents/
│   ├── *.md                 # Core agents (8 files)
│   └── adopted/*.md         # Adopted agents (5 files)
├── INSTALL.md               # Detailed installation guide
├── README.md                # Project overview
└── DISTRIBUTION.md          # This file
```

## Key Configuration

### plugin.json
```json
{
  "name": "claude-code-architect-copilot",
  "version": "1.0.0",
  "agents": "./agents/"     // Points to agents directory
}
```

This tells Claude Code where to find the agent files.

## User Journey

1. **Discovery:** User finds plugin on GitHub or Claude Code marketplace
2. **Installation:** User runs `/plugin install` command OR manual copy
3. **Restart:** User restarts Claude Code
4. **Verification:** User runs `/subagent` to see all 12 agents
5. **Usage:** Agents activate automatically based on conversation context

## For Contributors

### Adding New Agents

1. Create agent file in `agents/` directory:
   ```markdown
   ---
   name: my-new-agent
   description: What this agent does and when it activates
   model: sonnet
   tools: mcp__server__tool_name
   ---

   # Agent content...
   ```

2. Agent automatically becomes available (no need to update plugin.json)
3. Update README.md to document the new agent
4. Commit and push changes

### Testing Distribution

Test both installation methods:

**Method 1: Plugin System**
```bash
# In a test environment
/plugin install claude-code-architect-copilot@casper7995/claude-code-architect-copilot
# Restart Claude Code
/subagent  # Verify all agents appear
```

**Method 2: Manual**
```bash
rm -rf ~/.claude/agents  # Clean slate
mkdir -p ~/.claude/agents
cp agents/*.md ~/.claude/agents/
cp agents/adopted/*.md ~/.claude/agents/
# Restart Claude Code
/subagent  # Verify all agents appear
```

## Version Management

### Semantic Versioning
- **Major (X.0.0):** Breaking changes, major restructuring
- **Minor (1.X.0):** New agents, new features, backwards compatible
- **Patch (1.0.X):** Bug fixes, documentation updates

### Release Process
1. Update version in `.claude-plugin/plugin.json`
2. Update CHANGELOG.md (if exists)
3. Commit with message: `chore: bump version to X.Y.Z`
4. Tag release: `git tag vX.Y.Z`
5. Push: `git push && git push --tags`

## Known Issues & Limitations

### Current Limitations
1. **No granular installation** - Users get all 12 agents (can't pick specific ones)
2. **Marketplace bundles deprecated** - The 5-bundle system in `marketplace.json` isn't functional
3. **Manual fallback required** - If `/plugin install` fails, users must manually copy files

### Future Improvements
- [ ] Test `/plugin install` thoroughly with Claude Code team
- [ ] Consider splitting into separate repositories if granular installation is needed
- [ ] Add automated installation script
- [ ] Create GitHub releases with pre-packaged bundles

## Support & Troubleshooting

Users experiencing installation issues should:
1. Check [INSTALL.md](INSTALL.md) for detailed instructions
2. Try manual installation method
3. Verify MCP servers are configured
4. Open GitHub issue with:
   - OS and Claude Code version
   - Installation method attempted
   - Error messages

## Metrics to Track

For understanding adoption and usage:
- GitHub stars/forks
- Installation success rate (via issues)
- Most frequently activated agents
- Common installation problems
- User feedback on agent quality

---

**Last Updated:** 2025-10-12
**Version:** 1.0.0
