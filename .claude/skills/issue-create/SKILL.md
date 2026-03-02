---
name: issue-create
description: Create a new issue from scratch with proper structure, labels, and links.
---

# Issue Create

The Orchestrator drives this workflow. Draft a well-formed issue with structured content, appropriate labels, and traceability links, then create it via the issue tracker with human approval.

**Prerequisites:** Clear understanding of what needs to be done, knowledge of appropriate labels and templates, access to issue tracker.

---

## Phase 1: Gather Context

Understand what the issue should address and how it fits.

### Steps

1. Clarify the problem or feature with the human
2. Search for related issues, ADRs, and documentation
3. Identify the affected area and classify the work type

### Entry Points

- "Create an issue for..." — Start here
- "File a bug about..." — Start here with `type:bug`
- "We need a feature for..." — Start here with `type:feature`

### Output

```markdown
## Context Anchors

- **Type:** <feature | bug | docs | chore>
- **Area:** <affected area>

## Understanding

<What the issue should address and why>

## Next Step

Confirm understanding before drafting.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not proceed until human confirms understanding.

---

## Phase 2: Draft

Compose the issue body with proper structure.

### Issue Structure

```markdown
## Summary

<Brief description of what this issue addresses>

## Context

<Background information and motivation>

## Requirements

- [ ] <Requirement 1>
- [ ] <Requirement 2>

## Acceptance Criteria

- [ ] <Criterion 1>
- [ ] <Criterion 2>

## Technical Notes

<Implementation hints, relevant files, constraints>

## Related

- Related to #<number>
- See also: <ADR or doc link>
```

### Label Selection

| Category | Purpose       | Examples                                     |
| -------- | ------------- | -------------------------------------------- |
| `type:`  | Work type     | `type:feature`, `type:bug`, `type:docs`      |
| `area:`  | Codebase area | `area:api`, `area:ui`, `area:core`           |
| `topic:` | Cross-cutting | `topic:auth`, `topic:perf`, `topic:security` |

### Required Fields

| Field               | Required      | Notes                                        |
| ------------------- | ------------- | -------------------------------------------- |
| Title               | Yes           | Concise, action-oriented                     |
| Summary             | Yes           | What and why — enough context for any reader |
| Acceptance Criteria | Yes           | Checkable conditions that define "done"      |
| Type                | Yes           | Categorization (`type:` label)               |
| Priority            | Yes           | Urgency level (P0–P3)                        |
| Size                | Should        | Effort estimate (XS–XL)                      |
| Milestone           | Should        | Which milestone this issue targets           |
| Parent Link         | If applicable | Spawned issues must link to the parent issue |

### ⛔ CHECKPOINT

**STOP.** Await approval of draft content, title, and labels.

---

## Phase 3: Create and Track

Create the issue in the tracker and add it to the project board.

### Steps

1. Write the issue body to `.tmp/scratch/issue-body.md`
2. Execute the forge's issue creation operation with title, body, and labels
3. Add the created issue to the project board
4. Set board fields:
   - **Status:** Backlog
   - **Priority:** as determined
   - **Size:** as determined
5. Report the created issue number and URL

### Board Integration

Read `workspace.config.yaml` for `board.project_id`, `board.fields.*`, and `board.status_options.*`. The workspace's forge adapter determines the specific tool/command.

### ⛔ CHECKPOINT

**STOP.** Confirm issue created and board fields set.

---

## Error Handling

| Error                  | Recovery                                     |
| ---------------------- | -------------------------------------------- |
| Requirements unclear   | Ask clarifying questions                     |
| Duplicate issue found  | Report the duplicate, ask whether to proceed |
| Label taxonomy unknown | Use the label selection table, ask if unsure |
