---
description: Create a new issue from scratch
---

# Issue Creation

Create a new issue with proper structure, labels, and links.

## Prerequisites

- Clear understanding of what needs to be done
- Knowledge of appropriate labels and templates

## Issue Structure

```markdown
## Summary

<Brief description of what this issue addresses>

## Context

<Background information and motivation>

## Requirements

- [ ] <Requirement 1>
- [ ] <Requirement 2>
- [ ] <Requirement 3>

## Acceptance Criteria

- [ ] <Criterion 1>
- [ ] <Criterion 2>

## Technical Notes

<Implementation hints, relevant files, constraints>

## Related

- Related to #<number>
- See also: <ADR or doc link>
```

## Label Selection

| Category | Purpose | Examples |
|----------|---------|----------|
| `type:` | Work type | `type:feature`, `type:bug`, `type:docs` |
| `area:` | Codebase area | `area:api`, `area:ui`, `area:core` |
| `topic:` | Cross-cutting | `topic:auth`, `topic:perf`, `topic:security` |

## Output Format

```markdown
## Context Anchors

- **Type:** <feature | bug | docs | chore>
- **Area:** <affected area>

## Proposed Issue

**Title:** <concise title>

**Labels:** `type:...`, `area:...`, `topic:...`

**Body:**

<issue body content>

## Commands

```bash
gh issue create \
  --title "<title>" \
  --body-file .tmp/issue-body.md \
  --label "type:<type>" \
  --label "area:<area>"
```

## Next Step

Awaiting approval to create issue.

**Approval Required:** Yes
```

## Guidelines

- **Title:** Start with area/component, be specific
- **Summary:** One paragraph explaining what and why
- **Requirements:** Concrete, testable items
- **Acceptance criteria:** How we know it's done
