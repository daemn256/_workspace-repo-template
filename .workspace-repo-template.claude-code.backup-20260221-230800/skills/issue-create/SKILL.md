---
name: issue-create
description: Create a new issue from scratch with proper structure, labels, and links
---

# Issue Create Workflow

Draft a well-formed issue with structured content, appropriate labels, and traceability links, then create it via the issue tracker with human approval.

## Personas

- **Primary:** Orchestrator (issue management)

## Prerequisites

- Clear understanding of what needs to be done
- Knowledge of appropriate labels and templates
- Access to issue tracker (`gh` CLI)

## Entry Points

- "Create an issue for..." — Start at Phase 1
- "File a bug about..." — Start at Phase 1 with `type:bug`
- "We need a feature for..." — Start at Phase 1 with `type:feature`

---

## Phase 1: Gather Context

**Goal:** Understand what the issue should address and how it fits.

1. Clarify the problem or feature with the human
2. Search for related issues, ADRs, and documentation
3. Identify the affected area and classify the work type

### ⛔ CHECKPOINT

Confirm understanding before drafting. Present the problem summary and classification for approval.

---

## Phase 2: Draft

**Goal:** Compose the issue body with proper structure.

### Issue Structure

```markdown
## Summary

{{{brief-description}}}

## Context

{{{background-and-motivation}}}

## Requirements

- [ ] {{{requirement-1}}}
- [ ] {{{requirement-2}}}
- [ ] {{{requirement-3}}}

## Acceptance Criteria

- [ ] {{{criterion-1}}}
- [ ] {{{criterion-2}}}

## Technical Notes

{{{implementation-hints-files-constraints}}}

## Related

- Related to #{{{number}}}
- See also: {{{adr-or-doc-link}}}
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

### Output Template

```markdown
## Context Anchors

- **Type:** {{{feature | bug | docs | chore}}}
- **Area:** {{{affected-area}}}

## Proposed Issue

**Title:** {{{concise-title}}}

**Labels:** `type:{{{type}}}`, `area:{{{area}}}`

**Body:**

{{{issue-body-content}}}

## Next Step

Awaiting approval to create issue.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

Await approval of draft content, title, and labels before creating.

---

## Phase 3: Create

**Goal:** Create the issue in the tracker.

1. Write the issue body to a temporary file
2. Create the issue via CLI
3. Report the created issue number and URL

### Commands

```bash
gh issue create \
  --title "{{{title}}}" \
  --body-file .tmp/scratch/issue-body.md \
  --label "type:{{{type}}}" \
  --label "area:{{{area}}}"
```

### Output Template

```markdown
## Context Anchors

- **Issue:** #{{{number}}} - {{{title}}}
- **URL:** {{{url}}}

## Next Step

Issue created successfully.

**Approval Required:** No
```

### ⛔ CHECKPOINT

Confirm issue created successfully.

---

## Error Handling

| Error                  | Recovery                                                                     |
| ---------------------- | ---------------------------------------------------------------------------- |
| Requirements unclear   | Ask clarifying questions; do not guess at scope or acceptance criteria       |
| Duplicate issue found  | Report the duplicate with link; ask whether to proceed or close as duplicate |
| Label taxonomy unknown | Use the label selection table above; ask if unsure about area classification |
