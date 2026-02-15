---
description: Structured PR review
---

# PR Review Workflow

Analyze a PR and provide structured, actionable feedback.

## Prerequisites

- PR diff available (pasted or accessible)
- Understanding of PR purpose

## Review Process

1. **Understand scope** — What is this PR trying to do?
2. **Check structure** — Are changes organized logically?
3. **Check correctness** — Does implementation achieve the goal?
4. **Check conventions** — Does it follow established patterns?
5. **Identify issues** — What needs to change?
6. **Prioritize feedback** — What's blocking vs nice-to-have?

## Output Format

```markdown
## Context Anchors

- **PR:** #<number> - <title>
- **Author:** <author>
- **Target:** `<branch>` → `<base>`
- **Scope:** <brief description>

## Review Summary

**Verdict:** <Approve | Request Changes | Comment>

<One paragraph summary>

## Blocking Issues

Issues that must be addressed before merge:

### 1. [File:Line] <Issue Title>

- **Problem:** <what's wrong>
- **Impact:** <why it matters>
- **Suggestion:** <how to fix>

## Suggestions

Non-blocking improvements:

### 1. [File:Line] <Suggestion Title>

- **Current:** <what it does now>
- **Suggested:** <what would be better>
- **Rationale:** <why it's better>

## Nitpicks

Style preferences (optional):

- <nitpick 1>
- <nitpick 2>

## Positive Notes

Things done well:

- <positive observation>
- <good pattern used>

## Questions

Clarifications needed:

- <question about implementation>

## Next Step

<Based on verdict>
- **Approve:** Ready to merge
- **Request Changes:** Address blocking issues, re-request review
- **Comment:** Consider suggestions, no changes required
```

## Review Principles

| Principle | Application |
|-----------|-------------|
| **Focus on what matters** | Blocking issues > style nits |
| **Be specific** | File, line, concrete suggestion |
| **Explain why** | Help author understand, not just comply |
| **Acknowledge good work** | Reinforcement builds trust |
| **Stay in scope** | Review what's in the PR |

## Feedback Categories

| Category | Marker | Merge Blocking |
|----------|--------|----------------|
| Critical | 🚨 | Yes |
| Important | ⚠️ | Yes |
| Suggestion | 💡 | No |
| Nitpick | 📝 | No |
