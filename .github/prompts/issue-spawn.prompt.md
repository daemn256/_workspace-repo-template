---
description: Create a follow-up issue linked to existing work
---

# Issue Spawn

Uses **Orchestrator** for issue management. When work-in-progress reveals additional scope, technical debt, or related tasks, spawn a new issue with full traceability back to the parent.

**Prerequisites:** Active work context (parent issue number and title), clear reason for separation

---

## Phase 1: Identify

### Classify Spawn Reason

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

**Entry Points:**

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

<Why this should be separate work>

## Next Step

Confirm spawn is warranted before drafting.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not proceed until human explicitly approves:

- Spawn is warranted
- Categorization is correct
- Separation from parent is appropriate

---

## Phase 2: Draft

### Compose Spawned Issue

**Issue Structure:**

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

**Traceability Requirements:**

Spawned issues MUST include:

1. **Link to parent** — "Spawned from #N"
2. **Context** — Why this was discovered
3. **Separation rationale** — Why it is separate work

**Inheritance Rules:**

- Spawned issues **inherit** the parent's milestone unless explicitly reassigned
- Spawned issues do **NOT** inherit priority or size — those are set independently

### Output

```markdown
## Context Anchors

- **Parent Issue:** #<number> - <title>
- **Reason for Spawn:** <category>
- **Phase:** 2 — Draft

## Proposed Spawned Issue

**Title:** <title>
**Labels:** <label list>

<full issue body>

## Next Step

Awaiting approval of draft content, title, and labels.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not proceed until human explicitly approves:

- Spawned issue content
- Title and labels
- Traceability links are correct

---

## Phase 3: Create and Link

### Create Issue and Update Parent

1. Write the issue body to `.tmp/scratch/issue-body.md`
2. Execute the forge's issue creation operation with:
   - **Title:** derived from Phase 2
   - **Body:** from `.tmp/scratch/issue-body.md`
   - **Labels:** from Phase 2 (use labels that exist on the repo)
3. Add the created issue to the project board
4. Set board fields:
   - **Status:** Backlog (default for new issues)
   - **Priority:** as determined in Phase 1
   - **Size:** as estimated
5. Update the parent issue with a spawn reference:

```markdown
## Spawned Issues

- #<new-number> - <title> (spawned during implementation)
```

### Board Integration

Read `workspace.config.yaml` for board field IDs and option IDs.
The workspace's forge adapter determines the specific tool/command.

### Output

```markdown
## Context Anchors

- **Parent Issue:** #<parent-number> - <parent-title>
- **Spawned Issue:** #<new-number> - <new-title>
- **Phase:** 3 — Create and Link

## Created

- **Number:** #<new-number>
- **URL:** <url>
- **Board status:** Backlog
- **Parent updated:** Yes

## Next Step

Spawned issue created and linked. Continue with parent issue work.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not proceed until human confirms:

- Issue created correctly
- Board fields are set
- Parent issue was updated

---

## Error Handling

| Error                          | Recovery                                                     |
| ------------------------------ | ------------------------------------------------------------ |
| Parent issue context missing   | Ask for the parent issue number — do not guess               |
| Separation rationale weak      | Suggest keeping the work in the parent issue instead         |
| Parent issue cannot be updated | Report failure — spawned issue still has "Spawned from" link |
