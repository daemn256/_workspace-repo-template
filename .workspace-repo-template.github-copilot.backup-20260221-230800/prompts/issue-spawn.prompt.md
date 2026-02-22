---
description: "Create a follow-up issue linked to existing work"
---

# Issue Spawn

Orchestrator-led workflow. When work-in-progress reveals additional scope, technical debt, or related tasks, spawn a new issue with full traceability back to the parent.

**Prerequisites:** Active work context (parent issue number and title), clear reason why this is separate work, access to issue tracker (`gh` CLI)

---

## Phase 1: Identify

### Classify and Confirm Separation

1. Identify the spawn category:

| Category           | Example                                          |
| ------------------ | ------------------------------------------------ |
| **Scope split**    | Original issue too large, splitting              |
| **Follow-up**      | Additional work identified during implementation |
| **Technical debt** | Cleanup or refactoring needed                    |
| **Enhancement**    | Nice-to-have discovered during work              |
| **Bug**            | Defect found while implementing                  |

2. Confirm with the human that this should be separate work
3. Note the parent issue context

**Entry points:**

- "This is out of scope, let's file it separately" — Start here
- "I found a bug while implementing" — Start here with `type:bug`
- "This needs its own issue" — Start here

### Output

```markdown
## Context Anchors

- **Parent Issue:** #<number> - <title>
- **Reason for Spawn:** <category>
- **Phase:** 1 — Identify

## Spawn Justification

<why this should be separate work>

## Next Step

Confirm spawn is warranted.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not proceed until human confirms the spawn is warranted.

---

## Phase 2: Draft

### Compose Spawned Issue

Draft the issue with traceability links:

```markdown
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
```

### Traceability Requirements

Spawned issues MUST include:

1. **Link to parent** — "Spawned from #N"
2. **Context** — Why this was discovered
3. **Separation rationale** — Why it is separate work

### Output

```markdown
## Context Anchors

- **Parent Issue:** #<number> - <title>
- **Reason for Spawn:** <category>
- **Phase:** 2 — Draft

## Proposed Issue

- **Title:** <title>
- **Labels:** `type:<type>`

## Issue Body

<full issue body content>

## Next Step

Awaiting approval of draft content, title, and labels.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not create the issue until human approves the draft content, title, and labels.

---

## Phase 3: Create and Link

### Create and Update Parent

1. Write the issue body to a temporary file
2. Create the issue via CLI:

```bash
gh issue create \
  --title "<title>" \
  --body-file .tmp/scratch/issue-body.md \
  --label "type:<type>"
```

3. Update the parent issue body with a spawn reference:

```markdown
## Spawned Issues

- #<new-number> - <title> (spawned during implementation)
```

### Output

```markdown
## Context Anchors

- **Parent Issue:** #<parent-number> - <parent-title>
- **Spawned Issue:** #<new-number> - <new-title>
- **Phase:** 3 — Create and Link

## Result

- Issue created: #<new-number>
- Parent updated: #<parent-number> now references spawn

## Next Step

Spawned issue created and linked. Return to parent work.

**Approval Required:** No
```

### ⛔ CHECKPOINT

**STOP.** Confirm issue created and parent updated.

---

## Error Handling

| Error                          | Recovery                                                    |
| ------------------------------ | ----------------------------------------------------------- |
| Parent issue context missing   | Ask for the parent issue number, do not guess               |
| Separation rationale weak      | Suggest keeping work in parent issue, let human decide      |
| Parent issue cannot be updated | Report failure; spawned issue still has "Spawned from" link |
| `gh` CLI not authenticated     | Run `gh auth login`                                         |
