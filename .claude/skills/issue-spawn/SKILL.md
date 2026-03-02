---
name: issue-spawn
description: Create follow-up issue linked to existing work.
---

# Issue Spawn

The Orchestrator drives this workflow. When work-in-progress reveals additional scope, technical debt, or related tasks, spawn a new issue with full traceability back to the parent.

**Prerequisites:** Active work context (parent issue number and title), clear reason why this is separate work, access to issue tracker.

---

## Phase 1: Identify

Classify why the spawn is needed and confirm separation.

### Spawn Categories

| Category           | Example                                          |
| ------------------ | ------------------------------------------------ |
| **Scope split**    | Original issue too large, splitting              |
| **Follow-up**      | Additional work identified during implementation |
| **Technical debt** | Cleanup or refactoring needed                    |
| **Enhancement**    | Nice-to-have discovered during work              |
| **Bug**            | Defect found while implementing                  |

### Steps

1. Identify the spawn category
2. Confirm with the human that this should be separate work
3. Note the parent issue context

### Output

```markdown
## Context Anchors

- **Parent Issue:** #<number> - <title>
- **Reason for Spawn:** <category>

## Spawn Rationale

<Why this should be separate work>

## Next Step

Confirm spawn is warranted.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not proceed until human confirms spawn is warranted.

---

## Phase 2: Draft

Compose the spawned issue with traceability links.

### Issue Structure

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

### Inheritance Rules

- Spawned issues **inherit** the parent's milestone unless explicitly reassigned
- Spawned issues do **NOT** inherit priority or size — those are set independently

### ⛔ CHECKPOINT

**STOP.** Await approval of draft content, title, and labels.

---

## Phase 3: Create and Link

Create the issue, add to board, and update the parent.

### Steps

1. Write the issue body to `.tmp/scratch/issue-body.md`
2. Execute the forge's issue creation operation with title, body, and labels
3. Add the created issue to the project board
4. Set board fields: Status → Backlog, Priority, Size
5. Update the parent issue with a spawn reference:

   ```markdown
   ## Spawned Issues

   - #<new-number> - <title> (spawned during implementation)
   ```

### ⛔ CHECKPOINT

**STOP.** Confirm issue created, board fields set, and parent updated.

---

## Error Handling

| Error                          | Recovery                                                               |
| ------------------------------ | ---------------------------------------------------------------------- |
| Parent issue context missing   | Ask for the parent issue number                                        |
| Separation rationale weak      | Suggest keeping work in parent instead                                 |
| Parent issue cannot be updated | The spawned issue's "Spawned from" link provides fallback traceability |
