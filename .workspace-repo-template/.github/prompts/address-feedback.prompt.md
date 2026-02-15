---
description: Implement review feedback on a PR
---

# Address Feedback Workflow

Help implement review feedback on a PR.

## Prerequisites

- Review feedback (what was requested)
- Access to codebase
- PR context (branch, changes)

## Workflow

### Step 1: Parse Feedback

Extract specific requested changes:

```markdown
## Context Anchors

- **PR:** #<number>
- **Feedback items:** <count>

## Feedback Analysis

| # | Feedback | Category | Location | Planned Action |
|---|----------|----------|----------|----------------|
| 1 | <summary> | Blocking | `file:line` | <planned change> |
| 2 | <summary> | Suggestion | `file:line` | <planned change> |
```

### Step 2: Plan Changes

For each feedback item:
- Identify exact location
- Determine required change
- Consider side effects

### Step 3: Await Approval

```markdown
## Next Step

Ready to implement these changes.

**Approval Required:** Yes (to begin changes)
```

### Step 4: Implement

Make changes per the plan.

### Step 5: Report

```markdown
## Context Anchors

- **PR:** #<number>
- **Feedback addressed:** <count>

## Changes Made

| # | Feedback | File | Change Made |
|---|----------|------|-------------|
| 1 | <summary> | `path` | <description> |
| 2 | <summary> | `path` | <description> |

## Verification

- Build: <result>
- Tests: <result>

## Commit Message

```
fix(review): address PR feedback

- <change 1>
- <change 2>
```

## Next Step

Changes implemented. Ready to commit and push for re-review.

**Approval Required:** Yes (to commit)
```

## Handling Different Feedback Types

| Type | Approach |
|------|----------|
| **Blocking** | Must address before merge |
| **Suggestion** | Implement if reasonable, otherwise explain why not |
| **Nitpick** | Optional, can discuss or accept |
| **Question** | Provide answer, may not require code change |

## Anti-Patterns

- ❌ Addressing feedback without understanding it
- ❌ Making unrelated changes while addressing feedback
- ❌ Ignoring feedback without explanation
- ❌ Over-correcting beyond what was requested
