Perform comprehensive code review for: $ARGUMENTS

Code review checklist:

## 1. Functionality Review
- Does the code do what it's supposed to do?
- Are all requirements met?
- Are edge cases handled?
- Is error handling appropriate?

## 2. Code Quality
**Readability:**
- Is the code easy to understand?
- Are variable/function names descriptive?
- Is the logic flow clear?

**Maintainability:**
- Is the code modular and reusable?
- Does it follow DRY principle?
- Are functions/classes single-purpose?

**Style:**
- Does it follow project conventions?
- Is formatting consistent?
- Are there any linting issues?

## 3. Security Review
- No hardcoded credentials or secrets
- Input validation present
- SQL injection prevention (if applicable)
- XSS prevention (if web-related)
- Proper authentication/authorization
- Secure data handling

## 4. Performance
- Are there obvious bottlenecks?
- Unnecessary loops or computations?
- Appropriate data structures used?
- Database queries optimized?
- Caching used where beneficial?

## 5. Testing
- Are tests included for new code?
- Do tests cover edge cases?
- Are tests readable and maintainable?
- Is test coverage adequate?

## 6. Documentation
- Is code self-documenting where possible?
- Are complex parts commented?
- Is API documentation complete?
- Are assumptions documented?

## 7. Best Practices
- SOLID principles followed?
- Design patterns used appropriately?
- No code smells (long methods, large classes)?
- Proper separation of concerns?

## 8. Specific Checks
**For Python:**
- Type hints used?
- PEP 8 compliance?
- Proper exception handling?

**For JavaScript/TypeScript:**
- Strict equality used?
- Promises handled correctly?
- TypeScript types properly defined?

**For Databricks/Spark:**
- Efficient DataFrame operations?
- Proper resource management?
- Delta Lake best practices?

## Review Output

Provide feedback in categories:

**🔴 Critical Issues** (Must fix)
- Security vulnerabilities
- Bugs or logic errors
- Missing requirements

**🟡 Important** (Should fix)
- Performance issues
- Missing tests
- Poor error handling

**🟢 Suggestions** (Nice to have)
- Style improvements
- Refactoring opportunities
- Documentation enhancements

**✅ Good Practices Observed**
- Highlight what was done well

End with:
- Overall assessment
- Approval status (Approve/Request Changes)
- Priority fixes if changes needed

