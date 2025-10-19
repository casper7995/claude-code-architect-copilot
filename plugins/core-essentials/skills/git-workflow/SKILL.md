---
name: git-workflow
description: Comprehensive Git workflow patterns including branching strategies, commit conventions, PR workflows, conflict resolution, and best practices. Covers Git commands, branch management, and collaboration workflows. Use when working with Git repositories or creating commits.
---

# Git Workflow & Best Practices Guide

## Overview

This skill provides comprehensive patterns for Git workflows, including branching strategies, commit conventions, collaboration workflows, and advanced Git techniques.

---

## Commit Conventions

### Conventional Commits Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, missing semicolons, etc.)
- `refactor`: Code refactoring
- `perf`: Performance improvements
- `test`: Adding or updating tests
- `chore`: Maintenance tasks, dependency updates
- `ci`: CI/CD changes
- `build`: Build system changes

**Examples:**
```bash
# Simple commits
git commit -m "feat: add user authentication"
git commit -m "fix: resolve null pointer in login handler"
git commit -m "docs: update API documentation"

# With scope
git commit -m "feat(auth): implement JWT token refresh"
git commit -m "fix(database): handle connection timeout"

# With body
git commit -m "feat: add email verification

Implement email verification flow for new users.
Sends verification link to registered email address.

Closes #123"
```

---

## Branching Strategies

### Git Flow

**Main branches:**
- `main` (or `master`) - Production-ready code
- `develop` - Integration branch for features

**Supporting branches:**
- `feature/*` - New features
- `release/*` - Release preparation
- `hotfix/*` - Production fixes

```bash
# Start new feature
git checkout develop
git checkout -b feature/user-authentication

# Work on feature
git add .
git commit -m "feat: implement login endpoint"

# Finish feature
git checkout develop
git merge --no-ff feature/user-authentication
git branch -d feature/user-authentication
git push origin develop

# Create release
git checkout develop
git checkout -b release/1.2.0
# Make release-specific changes
git commit -m "chore: bump version to 1.2.0"

# Finish release
git checkout main
git merge --no-ff release/1.2.0
git tag -a v1.2.0 -m "Release version 1.2.0"
git checkout develop
git merge --no-ff release/1.2.0
git branch -d release/1.2.0

# Hotfix
git checkout main
git checkout -b hotfix/critical-bug
git commit -m "fix: resolve security vulnerability"
git checkout main
git merge --no-ff hotfix/critical-bug
git tag -a v1.2.1 -m "Hotfix 1.2.1"
git checkout develop
git merge --no-ff hotfix/critical-bug
git branch -d hotfix/critical-bug
```

### GitHub Flow (Simpler)

**Single main branch with feature branches:**

```bash
# Create feature branch
git checkout main
git pull origin main
git checkout -b feature/new-dashboard

# Make changes
git add .
git commit -m "feat: create dashboard layout"
git push origin feature/new-dashboard

# Create PR on GitHub
# After review and approval, merge via GitHub
# Delete branch after merge

# Update local
git checkout main
git pull origin main
git branch -d feature/new-dashboard
```

### Trunk-Based Development

**Short-lived branches, frequent integration:**

```bash
# Create short-lived branch
git checkout main
git pull origin main
git checkout -b username/quick-fix

# Make small change
git add .
git commit -m "fix: correct typo in error message"

# Push and create PR immediately
git push origin username/quick-fix
# Merge within hours/same day

# Update and cleanup
git checkout main
git pull origin main
git branch -d username/quick-fix
```

---

## Common Git Commands

### Basic Operations

```bash
# Initialize repository
git init

# Clone repository
git clone https://github.com/user/repo.git
git clone https://github.com/user/repo.git my-folder

# Check status
git status
git status -s  # Short format

# Stage changes
git add file.txt
git add .
git add -A  # All changes
git add -p  # Interactive staging

# Commit
git commit -m "message"
git commit -am "message"  # Stage and commit tracked files
git commit --amend  # Modify last commit
git commit --amend --no-edit  # Amend without changing message

# View history
git log
git log --oneline
git log --graph --oneline --all
git log --author="John"
git log --since="2 weeks ago"
git log --grep="fix"
git log -p  # Show diffs
git log --follow file.txt  # History of specific file
```

### Branching

```bash
# List branches
git branch
git branch -a  # All branches (local + remote)
git branch -r  # Remote branches

# Create branch
git branch feature-x
git checkout -b feature-x  # Create and switch
git switch -c feature-x  # Modern alternative

# Switch branches
git checkout feature-x
git switch feature-x  # Modern alternative

# Rename branch
git branch -m old-name new-name
git branch -m new-name  # Rename current branch

# Delete branch
git branch -d feature-x  # Safe delete
git branch -D feature-x  # Force delete
git push origin --delete feature-x  # Delete remote branch

# Track remote branch
git checkout -b feature-x origin/feature-x
git branch --set-upstream-to=origin/feature-x
```

### Remote Operations

```bash
# View remotes
git remote -v

# Add remote
git remote add origin https://github.com/user/repo.git

# Fetch updates
git fetch origin
git fetch --all

# Pull changes
git pull origin main
git pull --rebase origin main

# Push changes
git push origin main
git push -u origin feature-x  # Set upstream
git push --force-with-lease  # Safer force push
git push --tags  # Push tags

# Update remote URL
git remote set-url origin https://github.com/user/new-repo.git
```

### Undoing Changes

```bash
# Unstage files
git reset HEAD file.txt
git restore --staged file.txt  # Modern alternative

# Discard working directory changes
git checkout -- file.txt
git restore file.txt  # Modern alternative

# Undo last commit (keep changes)
git reset --soft HEAD~1

# Undo last commit (discard changes)
git reset --hard HEAD~1

# Undo commits (keep history)
git revert HEAD
git revert <commit-hash>

# Reset to specific commit
git reset --hard <commit-hash>

# Clean untracked files
git clean -n  # Dry run
git clean -f  # Remove files
git clean -fd  # Remove files and directories
```

---

## Advanced Workflows

### Interactive Rebase

```bash
# Rebase last 3 commits
git rebase -i HEAD~3

# In editor, choose actions:
# pick = use commit
# reword = use commit, edit message
# edit = use commit, stop for amending
# squash = combine with previous commit
# fixup = like squash, discard commit message
# drop = remove commit

# Example: squash commits
pick a1b2c3d feat: add login
squash e4f5g6h fix: login typo
squash i7j8k9l refactor: clean login code

# Continue rebase
git rebase --continue

# Abort rebase
git rebase --abort
```

### Cherry-Pick

```bash
# Apply specific commit from another branch
git cherry-pick <commit-hash>

# Cherry-pick without committing
git cherry-pick -n <commit-hash>

# Cherry-pick range
git cherry-pick <start-hash>^..<end-hash>
```

### Stash Changes

```bash
# Stash changes
git stash
git stash push -m "work in progress"

# Stash including untracked files
git stash -u

# List stashes
git stash list

# Apply stash
git stash apply
git stash apply stash@{2}

# Apply and remove stash
git stash pop

# Show stash contents
git stash show
git stash show -p stash@{1}

# Create branch from stash
git stash branch new-branch stash@{1}

# Delete stash
git stash drop stash@{1}
git stash clear  # Delete all stashes
```

### Conflict Resolution

```bash
# When merge conflict occurs
git status  # See conflicted files

# Edit conflicted files, look for:
<<<<<<< HEAD
Current branch content
=======
Incoming branch content
>>>>>>> feature-branch

# After resolving conflicts
git add resolved-file.txt
git commit  # Complete merge

# Abort merge
git merge --abort

# Use specific version
git checkout --ours file.txt  # Keep current branch version
git checkout --theirs file.txt  # Use incoming branch version

# Tools for resolving conflicts
git mergetool
git diff --conflicts
```

---

## Best Practices

### 1. Commit Frequently, Push Often

```bash
# Bad: large infrequent commits
git commit -m "various changes"  # After 2 days

# Good: small focused commits
git commit -m "feat: add user model"
git commit -m "feat: add user repository"
git commit -m "feat: add user service"
git commit -m "test: add user service tests"
```

### 2. Write Clear Commit Messages

```bash
# Bad
git commit -m "fix stuff"
git commit -m "update"
git commit -m "changes"

# Good
git commit -m "fix: resolve null pointer in user authentication

The authentication middleware was not properly checking for null
user objects before accessing properties. Added null check and
appropriate error handling.

Closes #456"
```

### 3. Use Branches for Features

```bash
# Bad: work directly on main
git checkout main
# make changes
git commit -m "new feature"

# Good: use feature branches
git checkout -b feature/user-profiles
# make changes
git commit -m "feat: implement user profiles"
git push origin feature/user-profiles
# Create PR for review
```

### 4. Keep Commits Atomic

```bash
# Bad: mixing unrelated changes
git add user.py product.py settings.py
git commit -m "updates"

# Good: separate logical changes
git add user.py
git commit -m "feat: add user validation"

git add product.py
git commit -m "feat: add product search"

git add settings.py
git commit -m "chore: update database config"
```

### 5. Review Before Pushing

```bash
# Review staged changes
git diff --staged

# Review commits
git log --oneline -5

# Review current branch vs main
git log main..HEAD
git diff main..HEAD
```

---

## Pull Request Workflow

### Creating Quality PRs

```bash
# 1. Update from main
git checkout main
git pull origin main

# 2. Create feature branch
git checkout -b feature/user-notifications

# 3. Make changes and commit
git add .
git commit -m "feat: implement email notifications"

# 4. Keep branch updated
git checkout main
git pull origin main
git checkout feature/user-notifications
git rebase main  # Or merge main

# 5. Push and create PR
git push origin feature/user-notifications
# Create PR on GitHub with:
# - Clear title
# - Detailed description
# - Screenshots if applicable
# - Link to related issues

# 6. Address review comments
git add .
git commit -m "refactor: address PR feedback"
git push origin feature/user-notifications

# 7. After merge, cleanup
git checkout main
git pull origin main
git branch -d feature/user-notifications
```

### PR Description Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Changes Made
- Added email notification service
- Integrated with SendGrid API
- Added notification preferences to user model

## Testing
- [ ] Unit tests added/updated
- [ ] Integration tests added/updated
- [ ] Manual testing completed

## Screenshots (if applicable)
[Add screenshots here]

## Related Issues
Closes #123
Relates to #456

## Checklist
- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex logic
- [ ] Documentation updated
- [ ] No new warnings generated
```

---

## Git Aliases

**Add to `~/.gitconfig`:**

```ini
[alias]
    # Shortcuts
    co = checkout
    br = branch
    ci = commit
    st = status

    # Useful aliases
    unstage = reset HEAD --
    last = log -1 HEAD
    visual = log --graph --oneline --all --decorate

    # Advanced
    amend = commit --amend --no-edit
    undo = reset --soft HEAD~1
    cleanup = "!git branch --merged | grep -v '\\*' | xargs -n 1 git branch -d"

    # Pretty logs
    lg = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
    hist = log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short
```

---

## Troubleshooting

### Common Issues

```bash
# Forgot to branch before making changes
git stash
git checkout -b new-branch
git stash pop

# Committed to wrong branch
git reset --soft HEAD~1
git stash
git checkout correct-branch
git stash pop
git add .
git commit -m "message"

# Need to update commit author
git commit --amend --author="Name <email@example.com>"

# Remove sensitive file from history
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch path/to/file" \
  --prune-empty --tag-name-filter cat -- --all

# Or use git-filter-repo (recommended)
git filter-repo --path path/to/file --invert-paths

# Recover deleted branch
git reflog
git checkout -b recovered-branch <commit-hash>

# Fix diverged branches
git pull --rebase origin main
# Or
git pull origin main --allow-unrelated-histories
```

---

## Quick Reference

```bash
# Start work
git checkout main && git pull && git checkout -b feature/name

# Save work
git add . && git commit -m "message" && git push

# Update branch
git checkout main && git pull && git checkout - && git rebase main

# Cleanup
git checkout main && git pull && git branch -d feature/name

# Emergency undo
git reflog  # Find commit
git reset --hard <commit-hash>
```

---

## Resources

- **Pro Git Book**: https://git-scm.com/book/
- **Git Documentation**: https://git-scm.com/docs
- **Conventional Commits**: https://www.conventionalcommits.org/
- **GitHub Flow**: https://guides.github.com/introduction/flow/
