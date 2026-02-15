---
description: Parse test output and produce verdict
---

# Test Report Workflow

Parse test execution output and produce a structured verdict.

## Prerequisites

- Test output provided (pasted or from execution)

## Output Format

```markdown
## Context Anchors

- **Issue:** #<number> (if applicable)
- **Test Suite:** <name or path>

## Execution Summary

| Metric | Count |
|--------|-------|
| Total | <n> |
| Passed | <n> |
| Failed | <n> |
| Skipped | <n> |

## Verdict

**<PASS | PARTIAL | FAIL>**

## Failures (if any)

### <Test Name 1>

- **Location:** `file:line`
- **Error:** <error message>
- **Likely Cause:** <analysis>

### <Test Name 2>

...

## Recommendations

<What to do next based on results>

## Next Step

<Based on verdict>
- PASS: Ready to proceed
- PARTIAL: Address skipped tests or warnings
- FAIL: Fix failures before proceeding
```

## Verdict Criteria

| Verdict | Criteria |
|---------|----------|
| **PASS** | All tests pass, no critical warnings |
| **PARTIAL** | Tests pass but with skipped tests or warnings |
| **FAIL** | One or more test failures |

## Analysis Guidelines

For failures:

1. Identify the failing test name
2. Extract the error message
3. Note the file and line if available
4. Analyze likely cause based on error type
5. Suggest remediation approach

## Common Failure Patterns

| Pattern | Likely Cause |
|---------|--------------|
| Assertion failed | Logic error or incorrect expectation |
| Null reference | Missing setup or unexpected null |
| Timeout | Async issue or infinite loop |
| Connection refused | External dependency unavailable |
| Not found | Missing file, resource, or configuration |
