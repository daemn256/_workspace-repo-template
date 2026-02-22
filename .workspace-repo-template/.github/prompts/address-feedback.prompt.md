---
description: "Implement review feedback on a PR"
---

# Address Feedback

Implementer-led workflow with Git-Ops support. Parse review feedback, plan changes, and implement them with approval at each step.

**Prerequisites:** Review feedback available, access to codebase, PR context (branch, changes)

---

## Phase 1: Parse Feedback

### Gather and Categorize

1. Read all review comments on the PR
2. Categorize each item by type:
   - **Blocking** — Must address before merge
   - **Suggestion** — Non-blocking improvement
   - **Nitpick** — Style preference, optional
   - **Question** — May not require code change
3. Identify exact file locations and planned actions for each item
4. Summarize in a structured table

### Output

```markdown
## Context Anchors

- **PR:** #<number> - <title>
- **Phase:** 1 — Parse Feedback
- **Feedback items:** <count>

## Feedback Analysis

| #   | Type     | Location    | Summary   | Planned Action   |
| --- | -------- | ----------- | --------- | ---------------- |
| 1   | Blocking | <file:line> | <summary> | <planned change> |
| 2   | ...      | ...         | ...       | ...              |

## Next Step

Confirm understanding of feedback before implementing.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not proceed until human explicitly approves:

- Feedback categorization is correct
- Planned actions are appropriate

---

## Phase 2: Implement Changes

### Address by Priority

1. Work through feedback items by priority (Blocking first, then Suggestion, then Nitpick)
2. For each item:
   - Make focused changes addressing only that item
   - Run build and tests to verify: `{{{build_command}}}` / `{{{test_command}}}`
   - Report status
3. Do not introduce unrelated changes

### Output

```markdown
## Context Anchors

- **PR:** #<number> - <title>
- **Phase:** 2 — Implement Changes
- **Progress:** <N>/<total> items addressed

## Changes Made

| #   | Feedback  | Status         | Files Changed |
| --- | --------- | -------------- | ------------- |
| 1   | <summary> | ✅ Done        | <files>       |
| 2   | <summary> | 🔄 In Progress | <files>       |

## Verification

- [ ] Build passes
- [ ] Tests pass

## Next Step

<Continue with next item | All items addressed>

**Approval Required:** Per significant change
```

### ⛔ CHECKPOINT

**STOP.** Checkpoint after each significant change — do not batch all changes without approval.

---

## Phase 3: Report

### Summarize and Prepare Commit

1. List all changes made per feedback item
2. Run full build and tests: `{{{build_command}}}` / `{{{test_command}}}`
3. Prepare commit message in conventional format:

   ```
   fix(<scope>): address review feedback

   - <change 1>
   - <change 2>

   PR #<number>
   ```

### Output

```markdown
## Context Anchors

- **PR:** #<number> - <title>
- **Phase:** 3 — Report
- **Items addressed:** <count>/<total>

## Summary

| #   | Feedback  | Status      | Notes   |
| --- | --------- | ----------- | ------- |
| 1   | <summary> | ✅ Resolved | <notes> |

## Verification

- [x] Build passes
- [x] Tests pass

## Next Step

Awaiting approval to commit changes.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not commit until human explicitly approves.

---

## Error Handling

| Error                                  | Recovery                               |
| -------------------------------------- | -------------------------------------- |
| Ambiguous feedback                     | Ask for clarification                  |
| Conflicting feedback items             | Flag conflict, ask for resolution      |
| Feedback requires architectural change | Escalate, don't implement unilaterally |
| Tests fail after change                | Report failure, seek guidance          |
