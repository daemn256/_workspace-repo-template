---
description: Create a new issue from scratch with proper structure, labels, and links
---

# Issue Create

Uses **Orchestrator** for issue management. Draft a well-formed issue with structured content, appropriate labels, and traceability links, then create it via the issue tracker with human approval.

**Prerequisites:** Clear understanding of what needs to be done, knowledge of appropriate labels and templates

---

## Phase 1: Gather Context

### Understand the Issue

1. Clarify the problem or feature with the human
2. Search for related issues, ADRs, and documentation
3. Identify the affected area and classify the work type

**Entry Points:**

- "Create an issue for..." — Start here
- "File a bug about..." — Start here with `type:bug`
- "We need a feature for..." — Start here with `type:feature`

### Output

```markdown
## Context Anchors

- **Type:** <feature | bug | docs | chore>
- **Area:** <affected area>
- **Phase:** 1 — Gather Context

## Understanding

<Summary of what the issue should address>

## Related Work

- <related issues, ADRs, or docs found>

## Next Step

Confirm understanding before drafting.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not proceed until human explicitly approves:

- Problem/feature understanding is correct
- Work type classification is accurate
- Related work has been identified

---

## Phase 2: Draft

### Compose Issue Body

**Issue Structure:**

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

### Label Selection

| Category | Purpose       | Examples                                     |
| -------- | ------------- | -------------------------------------------- |
| `type:`  | Work type     | `type:feature`, `type:bug`, `type:docs`      |
| `area:`  | Codebase area | `area:api`, `area:ui`, `area:core`           |
| `topic:` | Cross-cutting | `topic:auth`, `topic:perf`, `topic:security` |

### Guidelines

- **Title:** Start with area/component, be specific
- **Summary:** One paragraph explaining what and why
- **Requirements:** Concrete, testable items
- **Acceptance criteria:** How we know it's done

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

### Output

```markdown
## Context Anchors

- **Type:** <feature | bug | docs | chore>
- **Area:** <affected area>
- **Phase:** 2 — Draft

## Proposed Issue

**Title:** <title>
**Labels:** <label list>

<full issue body>

## Next Step

Awaiting approval of draft content, title, and labels.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not proceed until human explicitly approves:

- Issue title and content
- Label selection
- Requirements and acceptance criteria

---

## Phase 3: Create and Track

### Create Issue and Configure Board

1. Write the issue body to `.tmp/scratch/issue-body.md`
2. Execute the forge's issue creation operation with:
   - **Title:** derived from Phase 1
   - **Body:** from `.tmp/scratch/issue-body.md`
   - **Labels:** from Phase 2 label selection (use labels that exist on the repo)
3. Add the created issue to the project board
4. Set board fields:
   - **Status:** Backlog (default for new issues)
   - **Priority:** as determined in Phase 1
   - **Size:** as determined in Phase 1
5. Report the created issue number and URL

### Board Integration

Read `workspace.config.yaml` for:

- `board.project_id` — which project to add the issue to
- `board.fields.status.field_id` — status field identifier
- `board.status_options.backlog.option_id` — Backlog status value
- `board.fields.priority.field_id` — priority field identifier
- `board.fields.size.field_id` — size field identifier

The workspace's forge adapter determines the specific tool/command.

### Output

```markdown
## Context Anchors

- **Issue:** #<number> - <title>
- **Phase:** 3 — Create and Track

## Created Issue

- **Number:** #<number>
- **URL:** <url>
- **Board status:** Backlog
- **Priority:** <priority>

## Next Step

Issue created and tracked. Ready for work.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not proceed until human confirms:

- Issue created correctly
- Board fields are set

---

## Error Handling

| Error                  | Recovery                                               |
| ---------------------- | ------------------------------------------------------ |
| Requirements unclear   | Ask clarifying questions — do not guess                |
| Duplicate issue found  | Report the duplicate with link, ask whether to proceed |
| Label taxonomy unknown | Use the label selection table above, ask if unsure     |
