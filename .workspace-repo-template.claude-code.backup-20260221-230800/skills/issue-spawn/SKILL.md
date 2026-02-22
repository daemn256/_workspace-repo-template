---
name: issue-spawn
description: Create follow-up issue linked to existing work
---

# Issue Spawn Workflow

When work-in-progress reveals additional scope, technical debt, or related tasks, spawn a new issue with full traceability back to the parent.

## Personas

- **Primary:** Orchestrator (issue management)

## Prerequisites

- Active work context (parent issue number and title)
- Clear reason why this is separate work
- Access to issue tracker (`gh` CLI)

## Entry Points

- "This is out of scope, let's file it separately" — Start at Phase 1
- "I found a bug while implementing" — Start at Phase 1 with `type:bug`
- "This needs its own issue" — Start at Phase 1

---

## Phase 1: Identify

**Goal:** Classify why the spawn is needed and confirm separation.

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

### ⛔ CHECKPOINT

Confirm spawn is warranted. Present the category and separation rationale for approval.

---

## Phase 2: Draft

**Goal:** Compose the spawned issue with traceability links.

### Issue Structure

```markdown
## Summary

{{{what-this-spawned-issue-addresses}}}

## Context

Spawned from #{{{parent-number}}} during {{{activity}}}.

{{{why-this-is-separate-work}}}

## Requirements

- [ ] {{{requirement-1}}}
- [ ] {{{requirement-2}}}

## Links

- Spawned from #{{{parent-number}}}
- Related to #{{{other-related}}}
```

### Traceability Requirements

Spawned issues MUST include:

1. **Link to parent** — "Spawned from #N"
2. **Context** — Why this was discovered
3. **Separation rationale** — Why it is separate work

### Output Template

```markdown
## Context Anchors

- **Parent Issue:** #{{{parent-number}}} - {{{parent-title}}}
- **Reason for Spawn:** {{{category}}}

## Proposed Issue

**Title:** {{{concise-title}}}

**Labels:** `type:{{{type}}}`, `area:{{{area}}}`

**Body:**

{{{issue-body-content}}}

## Next Step

Awaiting approval to create spawned issue.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

Await approval of draft content, title, and labels before creating.

---

## Phase 3: Create and Link

**Goal:** Create the issue and update the parent.

### Steps

1. Write the issue body to a temporary file
2. Create the issue via CLI
3. Update the parent issue with a spawn reference

### Commands

```bash
gh issue create \
  --title "{{{title}}}" \
  --body-file .tmp/scratch/issue-body.md \
  --label "type:{{{type}}}"
```

### Parent Issue Update

After spawning, add to the parent issue body:

```markdown
## Spawned Issues

- #{{{new-number}}} - {{{title}}} (spawned during implementation)
```

### Output Template

```markdown
## Context Anchors

- **Parent Issue:** #{{{parent-number}}} - {{{parent-title}}}
- **Spawned Issue:** #{{{new-number}}} - {{{new-title}}}

## Next Step

Spawned issue created. Parent issue updated with reference.

**Approval Required:** No
```

### ⛔ CHECKPOINT

Confirm issue created and parent updated.

---

## Error Handling

| Error                          | Recovery                                                                                         |
| ------------------------------ | ------------------------------------------------------------------------------------------------ |
| Parent issue context missing   | Ask for the parent issue number; do not guess at parent linkage                                  |
| Separation rationale is weak   | Suggest keeping the work in the parent issue instead; let human decide                           |
| Parent issue cannot be updated | Report the failure; the spawned issue still has the "Spawned from" link as fallback traceability |
