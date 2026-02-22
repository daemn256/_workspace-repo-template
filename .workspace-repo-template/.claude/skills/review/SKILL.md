````skill
---
name: review
description: Structured review of PRs and verification of feedback implementation
---

# Review Workflow

Analyze PRs, provide structured feedback, and verify that commits address feedback.

## Personas

- **Primary:** Reviewer (code review, standards enforcement)
- **Secondary:** Security (security implications)

## Prerequisites

- PR diff available (pasted or accessible)
- Context about the PR's purpose

## Entry Points

- "Review this PR" — Start at Phase 1
- "Check if this commit addresses feedback" — Start at Entry Point: Commit Verify
- "Help me address this review feedback" — Start at Entry Point: Address Feedback

---

## Phase 1: Understand Scope

**Goal:** Understand what the PR is trying to accomplish.

### Steps

1. Read PR title and description
2. Identify the issue being addressed
3. Understand the intended behavior change
4. Note the scope (files, areas affected)

---

## Phase 2: Analyze Changes

**Goal:** Review the implementation against requirements and standards.

### Steps

1. Check structure — Are changes organized logically?
2. Check correctness — Does implementation achieve the goal?
3. Check conventions — Does it follow established patterns?
4. Check security — Any security implications?
5. Check tests — Adequate coverage?

### Review Principles

| Principle             | Application                             |
| --------------------- | --------------------------------------- |
| Focus on what matters | Blocking issues > style nits            |
| Be specific           | File, line, concrete suggestion         |
| Explain why           | Help author understand, not just comply |
| Acknowledge good work | Reinforcement helps                     |
| Stay in scope         | Review what's in the PR, not wishlist   |

---

## Phase 3: Provide Feedback

**Goal:** Present structured, actionable feedback.

### Steps

1. Determine verdict (Approve, Request Changes, Comment)
2. List blocking issues (must fix before merge)
3. List suggestions (non-blocking improvements)
4. Note positive observations (reinforce good patterns)

### Feedback Categories

| Category   | Meaning                               |
| ---------- | ------------------------------------- |
| Blocking   | Must be addressed before merge        |
| Important  | Should be addressed, but not blocking |
| Suggestion | Nice to have improvement              |
| Nitpick    | Style preference, optional            |

### Output Template

```markdown
## Context Anchors

- **PR:** #{{{pr-number}}} - {{{title}}}
- **Author:** {{{author}}}
- **Target:** `{{{head-branch}}}` → `{{{base-branch}}}`
- **Scope:** {{{brief-description}}}

## Review Summary

**Verdict:** {{{Approve | Request Changes | Comment}}}

{{{one-paragraph-summary}}}

## Feedback

### Blocking Issues

1. **[{{{file}}}:{{{line}}}] {{{issue-title}}}**
   - Problem: {{{what-is-wrong}}}
   - Suggestion: {{{how-to-fix}}}

### Suggestions

1. **[{{{file}}}:{{{line}}}] {{{suggestion-title}}}**
   - Current: {{{what-it-does-now}}}
   - Suggested: {{{what-would-be-better}}}

### Positive Notes

- {{{positive-observation}}}

## Next Step

{{{next-step-based-on-verdict}}}
```

### ⛔ CHECKPOINT

Present the review for confirmation before posting. Do not submit review comments until explicitly approved.

---

## Entry Point: Commit Verify

**Purpose:** Verify that a commit addresses specific review feedback.

### Process

1. Parse original feedback — What specifically was requested?
2. Analyze commit diff — What did the commit change?
3. Match — Does the change address the feedback?
4. Check for over-correction — Did they change more than needed?

### Output Template

```markdown
## Context Anchors

- **PR:** #{{{pr-number}}}
- **Commit:** {{{sha}}} - {{{message}}}
- **Feedback being addressed:** {{{summary}}}

## Verification Result

**Verdict:** {{{Resolved | Partially Resolved | Not Resolved | Over-corrected}}}

### Feedback Items

| Item             | Status           | Notes            |
| ---------------- | ---------------- | ---------------- |
| {{{feedback-1}}} | ✅ Resolved      | {{{how}}}        |
| {{{feedback-2}}} | ⚠️ Partial       | {{{missing}}}    |
| {{{feedback-3}}} | ❌ Not addressed | {{{still-needed}}}|

## Next Step

{{{next-step-based-on-verdict}}}
```

---

## Entry Point: Address Feedback

**Purpose:** Help implement review feedback on a PR.

### Process

1. Parse feedback — Extract specific requested changes
2. Plan changes — Map feedback to code locations
3. Implement — Make the changes
4. Verify — Ensure changes address feedback
5. Report — Summarize what was done

### Output Template

```markdown
## Context Anchors

- **PR:** #{{{pr-number}}}
- **Feedback items:** {{{count}}}

## Feedback Analysis

| #   | Feedback      | Location        | Action              |
| --- | ------------- | --------------- | ------------------- |
| 1   | {{{summary}}} | {{{file:line}}} | {{{planned-change}}}|

## Next Step

Ready to implement these changes.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

Present the feedback analysis and planned changes for approval before implementing.

---

## Error Handling

| Error                    | Recovery                      |
| ------------------------ | ----------------------------- |
| Missing PR context       | Request PR number or diff     |
| Unclear feedback         | Ask for clarification         |
| Conflicting requirements | Escalate to author/maintainer |

````
