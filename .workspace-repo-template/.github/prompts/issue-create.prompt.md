---
description: "Create a new issue from scratch with proper structure, labels, and links"
---

# Issue Create

Orchestrator-led workflow. Draft a well-formed issue with structured content, appropriate labels, and traceability links, then create it via the issue tracker with human approval.

**Prerequisites:** Clear understanding of what needs to be done, knowledge of appropriate labels, access to issue tracker (`gh` CLI)

---

## Phase 1: Gather Context

### Understand and Classify

1. Clarify the problem or feature with the human
2. Search for related issues, ADRs, and documentation
3. Identify the affected area and classify the work type

**Entry points:**

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

<what the issue should address>

## Related

- <related issues, ADRs, docs found>

## Next Step

Confirm understanding before drafting.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not proceed until human confirms understanding is correct.

---

## Phase 2: Draft

### Compose Issue Body

Draft the issue with proper structure:

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

### Output

```markdown
## Context Anchors

- **Type:** <feature | bug | docs | chore>
- **Area:** <affected area>
- **Phase:** 2 — Draft

## Proposed Issue

- **Title:** <title>
- **Labels:** `type:<type>`, `area:<area>`

## Issue Body

<full issue body content>

## Next Step

Awaiting approval of draft content, title, and labels.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not create the issue until human approves the draft content, title, and labels.

---

## Phase 3: Create

### Create via CLI

1. Write the issue body to a temporary file
2. Create the issue via CLI:

```bash
gh issue create \
  --title "<title>" \
  --body-file .tmp/scratch/issue-body.md \
  --label "type:<type>" \
  --label "area:<area>"
```

3. Report the created issue number and URL

### Output

```markdown
## Context Anchors

- **Type:** <feature | bug | docs | chore>
- **Area:** <affected area>
- **Phase:** 3 — Create

## Issue Created

- **Issue:** #<number> - <title>
- **URL:** <url>
- **Labels:** <labels>

## Next Step

Issue created successfully.

**Approval Required:** No
```

### ⛔ CHECKPOINT

**STOP.** Confirm issue created successfully.

---

## Error Handling

| Error                      | Recovery                                           |
| -------------------------- | -------------------------------------------------- |
| Requirements unclear       | Ask clarifying questions, do not guess at scope    |
| Duplicate issue found      | Report duplicate with link, ask whether to proceed |
| Label taxonomy unknown     | Use the label selection table, ask if unsure       |
| `gh` CLI not authenticated | Run `gh auth login`                                |
