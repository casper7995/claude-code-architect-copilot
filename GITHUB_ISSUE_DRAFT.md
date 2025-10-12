# [BUG] `/plugin marketplace` commands not available in v2.0.14

## What's Wrong?

The `/plugin marketplace` commands documented in the [Oct 9 plugin announcement](https://www.anthropic.com/news/claude-code-plugins) and [official docs](https://docs.claude.com/en/docs/claude-code/plugins-reference) don't work in Claude Code v2.0.14.

```bash
$ claude --version
2.0.14

$ claude
> /plugin marketplace add anthropics/claude-code
error: unknown command 'marketplace'

> /plugin marketplace list
error: unknown command 'marketplace'
```

## What Should Happen?

According to the documentation, these commands should work:

```bash
/plugin marketplace add user-or-org/repo-name  # Register a marketplace
/plugin marketplace list                       # List available marketplaces
/plugin                                        # Browse and install plugins
```

## Testing

Tested with multiple repos (all failed identically):
- ❌ `anthropics/claude-code` (Anthropic's official repo)
- ❌ `wshobson/agents` (Community marketplace)  
- ❌ `casper7995/claude-code-architect-copilot` (my repo, validated against [Anthropic's format](https://github.com/anthropics/claude-code/blob/main/.claude-plugin/marketplace.json))

## Evidence

Backend infrastructure exists:
```bash
$ cat ~/.claude/plugins/known_marketplaces.json
{
  "claude-code-architect-copilot": {
    "source": { "source": "github", "repo": "casper7995/claude-code-architect-copilot" },
    "installLocation": "/Users/caspe/.claude/plugins/marketplaces/...",
    "lastUpdated": "2025-10-12T01:04:19.557Z"
  }
}
```

This suggests CLI commands aren't exposed in v2.0.14.

## Questions

1. Is this a bug or is marketplace only in beta/nightly?
2. Which version will include marketplace commands?
3. Should docs specify minimum version requirements?

## Workaround

Direct installation works:
```bash
git clone https://github.com/user/plugin-repo
cp plugin-repo/agents/*.md ~/.claude/agents/
```

## Environment

- **Version**: 2.0.14 (stable)
- **Platform**: macOS
- **Installation**: npm global

---

**Request:** Please clarify expected behavior and timeline for marketplace availability in stable releases.

