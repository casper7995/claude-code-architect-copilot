Please analyze and fix the GitHub issue: $ARGUMENTS

Follow these steps:

1. Use `gh issue view` to get the issue details
2. Understand the problem described in the issue
3. Search the codebase for relevant files using grep or codebase_search
4. Implement the necessary changes to fix the issue
5. Write and run tests to verify the fix
6. Ensure code passes linting and type checking
7. Create a descriptive commit message following the format: "fix: [issue description] (#issue_number)"
8. Push changes and create a PR with `gh pr create`

Remember to:
- Use the GitHub CLI (`gh`) for all GitHub-related tasks
- Reference the issue number in commits and PR
- Add tests for the fix
- Update documentation if needed

