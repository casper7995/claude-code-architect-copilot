Debug and fix the issue: $ARGUMENTS

Systematic debugging approach:

1. **Understand the problem**
   - What is the expected behavior?
   - What is the actual behavior?
   - When did it start happening?
   - Can it be reproduced consistently?

2. **Gather information**
   - Check error messages and stack traces
   - Review recent code changes (git log)
   - Look for related issues or documentation
   - Check logs if available

3. **Reproduce the issue**
   - Create minimal reproduction case
   - Identify exact steps to trigger
   - Note any environmental factors

4. **Isolate the problem**
   - Use binary search to narrow down the cause
   - Add strategic logging/print statements
   - Use debugger if available
   - Check assumptions with assertions

5. **Form hypothesis**
   - Based on evidence, what might be wrong?
   - What are the most likely causes?
   - What can be ruled out?

6. **Test hypothesis**
   - Make targeted changes to test theory
   - Verify if issue is resolved
   - Check for side effects

7. **Implement fix**
   - Apply the minimal fix needed
   - Ensure fix addresses root cause, not symptoms
   - Add guards against future occurrences

8. **Validate fix**
   - Verify original issue is resolved
   - Run related tests
   - Check for regression in other areas
   - Add test to prevent recurrence

9. **Document findings**
   - What was the root cause?
   - How was it fixed?
   - What can prevent this in the future?

Output a clear summary of:
- Root cause identified
- Fix applied
- Tests added/updated
- Lessons learned

