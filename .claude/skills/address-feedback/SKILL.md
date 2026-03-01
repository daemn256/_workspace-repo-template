---
name: address-feedback
description: Implement review feedback on a PR
---

# Address Feedback Workflow

Implement review feedback on a PR systematically without introducing unrelated changes.

## Personas

- **Primary:** Implementer (making changes)
- **Secondary:** Git-Ops (commits)

## Prerequisites

- Review feedback (what was requested)
- Access to codebase
- PR context (branch, changes)

---

## Phase 1: Parse Feedback

**Goal:** Extract and categorize specific requested changes.

1. Read all review comments
2. Categorize by type (Blocking, Suggestion, Nitpick, Question)
3. Identify exact locations and planned actions
4. Summarize in a structured table

### Output Template

```markdown
## Context Anchors

- **PR:** #{{{pr-number}}}
- **Feedback items:** {{{count}}}

## Feedback Analysis

| #   | Feedback      | Category   | Location          | Planned Action       |
| --- | ------------- | ---------- | ----------------- | -------------------- |
| 1   | {{{summary}}} | Blocking   | `{{{file:line}}}` | {{{planned-change}}} |
| 2   | {{{summary}}} | Suggestion | `{{{file:line}}}` | {{{planned-change}}} |
```

### ⛔ CHECKPOINT

Confirm understanding of feedback before implementing. Present the feedback analysis table and await approval.

---

## Phase 2: Implement Changes

**Goal:** Address each feedback item by priority.

1. Work through items by priority (Blocking first)
2. Make focused changes per item
3. Verify each change (build, test)
4. Report progress per item

### Iteration Pattern

- Complete one feedback item
- Verify (build, test)
- Report status
- Continue or checkpoint for significant changes

### ⛔ CHECKPOINT

Per significant change — pause and confirm direction before continuing.

---

## Phase 3: Report

**Goal:** Summarize changes made and prepare for re-review.

1. List all changes made per feedback item
2. Run build and tests
3. Prepare commit message

### Output Template

```markdown
## Context Anchors

- **PR:** #{{{pr-number}}}
- **Feedback addressed:** {{{count}}}

## Changes Made

| #   | Feedback      | File         | Change Made       |
| --- | ------------- | ------------ | ----------------- |
| 1   | {{{summary}}} | `{{{path}}}` | {{{description}}} |
| 2   | {{{summary}}} | `{{{path}}}` | {{{description}}} |

## Verification

- Build: {{{result}}}
- Tests: {{{result}}}

## Commit Message
```

fix(review): address PR feedback

- {{{change-1}}}
- {{{change-2}}}

Addresses feedback on #{{{pr-number}}}

```

## Next Step

Changes implemented. Ready to commit and push for re-review.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

Await approval to commit changes.

---

## Feedback Type Handling

| Type           | Approach                                           |
| -------------- | -------------------------------------------------- |
| **Blocking**   | Must address before merge                          |
| **Suggestion** | Implement if reasonable, otherwise explain why not |
| **Nitpick**    | Optional, can discuss or accept                    |
| **Question**   | Provide answer, may not require code change        |

## Error Handling

| Error                                  | Recovery                               |
| -------------------------------------- | -------------------------------------- |
| Ambiguous feedback                     | Ask for clarification                  |
| Conflicting feedback items             | Flag conflict, ask for resolution      |
| Feedback requires architectural change | Escalate, don't implement unilaterally |
| Tests fail after change                | Report failure, seek guidance          |
