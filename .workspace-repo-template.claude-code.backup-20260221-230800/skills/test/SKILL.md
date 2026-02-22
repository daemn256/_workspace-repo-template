````skill
---
name: test
description: Parse test output and produce a structured verdict
---

# Test Workflow

Take test execution output, parse it into structured results, produce a clear verdict, and recommend next actions.

## Personas

- **Primary:** Test (analysis, verdict)

## Prerequisites

- Test output provided (pasted or from execution)

## Entry Points

- "Parse these test results" — Start at Phase 1
- "Did the tests pass?" — Start at Phase 1
- "Analyze test output" — Start at Phase 1

---

## Phase 1: Parse Output

**Goal:** Extract structured data from raw test output.

### Steps

1. Identify the test framework from output format
2. Extract total, passed, failed, skipped counts
3. For failures, extract test name, location, error message

---

## Phase 2: Produce Verdict

**Goal:** Classify the result and provide analysis.

### Steps

1. Apply verdict criteria
2. For failures, analyze likely cause
3. Suggest remediation approach

### Verdict Criteria

| Verdict     | Criteria                                      |
| ----------- | --------------------------------------------- |
| **PASS**    | All tests pass, no critical warnings          |
| **PARTIAL** | Tests pass but with skipped tests or warnings |
| **FAIL**    | One or more test failures                     |

**Critical:** Never trust exit code alone. Parse and report actual counts.

---

## Failure Analysis Guidelines

For each failure:

1. Identify the failing test name
2. Extract the error message
3. Note the file and line if available
4. Analyze likely cause based on error type
5. Suggest remediation approach

### Common Failure Patterns

| Pattern            | Likely Cause                             |
| ------------------ | ---------------------------------------- |
| Assertion failed   | Logic error or incorrect expectation     |
| Null reference     | Missing setup or unexpected null         |
| Timeout            | Async issue or infinite loop             |
| Connection refused | External dependency unavailable          |
| Not found          | Missing file, resource, or configuration |

---

## Output Template

```markdown
## Context Anchors

- **Test suite:** {{{suite-name}}}
- **Issue:** #{{{issue-number}}} (if applicable)

## Execution Summary

| Metric  | Count           |
| ------- | --------------- |
| Total   | {{{total}}}     |
| Passed  | {{{passed}}}    |
| Failed  | {{{failed}}}    |
| Skipped | {{{skipped}}}   |

## Verdict: {{{PASS | PARTIAL | FAIL}}}

{{{verdict-summary}}}

## Failure Details

### {{{failing-test-name}}}

- **Location:** {{{file:line}}}
- **Error:** {{{error-message}}}
- **Likely cause:** {{{analysis}}}
- **Remediation:** {{{suggestion}}}

## Next Step

{{{recommendation-based-on-verdict}}}
```

---

## Error Handling

| Error                   | Recovery                                         |
| ----------------------- | ------------------------------------------------ |
| Unparseable output      | Report what was understood, flag unknown sections |
| Mixed framework output  | Process each framework section separately        |
| No test output provided | Ask user to run tests and paste output           |

````
