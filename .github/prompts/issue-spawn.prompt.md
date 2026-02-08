---
description: Create follow-up issue from existing work
---

# Issue Spawn

Create a follow-up issue linked to existing work.

## When to Use

- During implementation, discover related work needed
- Scope creep identified and needs separate tracking
- Technical debt discovered
- Enhancement idea while working on something else

## Spawn Categories

| Category | Example |
|----------|---------|
| **Scope split** | Original issue too large, splitting |
| **Follow-up** | Additional work identified during implementation |
| **Technical debt** | Cleanup or refactoring needed |
| **Enhancement** | Nice-to-have discovered during work |
| **Bug** | Defect found while implementing |

## Output Format

```markdown
## Context Anchors

- **Parent Issue:** #<number> - <title>
- **Reason for Spawn:** <category from above>

## Proposed Issue

**Title:** <concise title>

**Labels:** `type:...`, `area:...`, `topic:...`

**Body:**

## Summary

<What this spawned issue addresses>

## Context

Spawned from #<parent-number> during <activity>.

<Why this is separate work>

## Requirements

- [ ] <Requirement 1>
- [ ] <Requirement 2>

## Links

- Spawned from #<parent-number>
- Related to #<other-related>

## Commands

```bash
gh issue create \
  --title "<title>" \
  --body-file .tmp/issue-body.md \
  --label "type:<type>"
```

## Next Step

Awaiting approval to create spawned issue.

**Approval Required:** Yes
```

## Traceability Requirements

Spawned issues MUST include:

1. **Link to parent** — "Spawned from #N"
2. **Context** — Why this was discovered
3. **Separation rationale** — Why it's separate work

## Parent Issue Update

After spawning, update the parent issue:

```markdown
## Spawned Issues

- #<new-number> - <title> (spawned during implementation)
```
