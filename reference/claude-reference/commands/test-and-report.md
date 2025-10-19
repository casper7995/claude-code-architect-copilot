Run comprehensive tests and generate a report for: $ARGUMENTS

Steps to complete:

1. **Identify test framework** - Check what testing tools are available (pytest, unittest, jest, etc.)
2. **Run unit tests** - Execute the test suite and capture output
3. **Check code coverage** - Generate coverage report if tools are available  
4. **Run linting** - Check code style and quality issues
5. **Type checking** - Run type checker if applicable (mypy, tsc, etc.)
6. **Create summary** - Write results to a test-report.md file with:
   - Test results (passed/failed/skipped)
   - Coverage percentage
   - Linting issues found
   - Type errors found
   - Recommendations for improvements

7. **Fix critical issues** - If any tests fail or critical issues found, attempt to fix them
8. **Re-run if fixed** - Verify fixes work

Output a clean summary at the end with:
- ✅ All checks passed, or
- ❌ Issues found (with list)

Focus on the specific area mentioned in $ARGUMENTS if provided, otherwise test the entire project.

