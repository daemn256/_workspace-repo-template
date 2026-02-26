---
description: "Structured review of PRs and verification of feedback implementation"
---

# Review

Reviewer-led workflow with Security support. Analyze PRs, provide structured feedback, and verify that commits address feedback.

**Prerequisites:** PR diff available (pasted or accessible), context about the PR's purpose

---

## Phase 1: Understand Scope

### Read and Contextualize

1. Read PR title and description
2. Identify the issue being addressed
3. Understand the intended behavior change
4. Note the scope (files, areas affected)

---

## Phase 2: Analyze Changes

### Review Against Standards

1. **Structure** — Are changes organized logically?
2. **Correctness** — Does implementation achieve the goal?
3. **Conventions** — Does it follow established patterns?
4. **Security** — Any security implications?
5. **Tests** — Adequate coverage?

**Review Principles:**

| Principle             | Application                             |
| --------------------- | --------------------------------------- |
| Focus on what matters | Blocking issues > style nits            |
| Be specific           | File, line, concrete suggestion         |
| Explain why           | Help author understand, not just comply |
| Acknowledge good work | Reinforcement helps                     |
| Stay in scope         | Review what's in the PR, not wishlist   |

---

## Phase 3: Provide Feedback

### Structured Review

1. Determine verdict (Approve, Request Changes, Comment)
2. List blocking issues (must fix before merge)
3. List suggestions (non-blocking improvements)
4. Note positive observations (reinforce good patterns)

**Feedback Categories:**

| Category   | Meaning                               |
| ---------- | ------------------------------------- |
| Blocking   | Must be addressed before merge        |
| Important  | Should be addressed, but not blocking |
| Suggestion | Nice to have improvement              |
| Nitpick    | Style preference, optional            |

### Output

```markdown
## Context Anchors

- **PR:** #<number> - <title>
- **Author:** <author>
- **Target:** `<branch>` → `<base>`
- **Scope:** <brief description>

## Review Summary

**Verdict:** <Approve | Request Changes | Comment>

<One paragraph summary>

## Feedback

### Blocking Issues

1. **[File:Line] <Issue title>**
   - Problem: <what's wrong>
   - Suggestion: <how to fix>

### Suggestions

1. **[File:Line] <Suggestion title>**
   - Current: <what it does now>
   - Suggested: <what would be better>

### Positive Notes

- <positive observation>

## Next Step

<If Request Changes: "Address blocking issues and re-request review">
<If Approve: "Ready to merge">
<If Comment: "Consider suggestions; no changes required">
```

### ⛔ CHECKPOINT

**STOP.** Present review for confirmation before posting.

---

## Entry Point: Commit Verify

**Purpose:** Verify that a commit addresses specific review feedback.

### Process

1. Parse original feedback — What specifically was requested?
2. Analyze commit diff — What did the commit change?
3. Match — Does the change address the feedback?
4. Check for over-correction — Did they change more than needed?

### Output

```markdown
## Context Anchors

- **PR:** #<number>
- **Commit:** <sha> - <message>
- **Feedback being addressed:** <summary>

## Verification Result

**Verdict:** <Resolved | Partially Resolved | Not Resolved | Over-corrected>

### Feedback Items

| Item         | Status           | Notes            |
| ------------ | ---------------- | ---------------- |
| <feedback 1> | ✅ Resolved      | <how>            |
| <feedback 2> | ⚠️ Partial       | <what's missing> |
| <feedback 3> | ❌ Not addressed | <still needed>   |

## Next Step

<If Resolved: "Feedback addressed. Ready for re-review.">
<If Partial/Not: "Still needs: <what>">
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

### Output

```markdown
## Context Anchors

- **PR:** #<number>
- **Feedback items:** <count>

## Feedback Analysis

| #   | Feedback  | Location    | Action           |
| --- | --------- | ----------- | ---------------- |
| 1   | <summary> | <file:line> | <planned change> |

## Next Step

Ready to implement these changes.

**Approval Required:** Yes
```

---

## Mechanical Review Checklist

Before providing any review verdict, verify these mechanically:

- [ ] All changed files reviewed (none skipped)
- [ ] Build passes on the branch
- [ ] Tests pass with counts reported
- [ ] No unresolved merge conflicts
- [ ] Commit messages follow conventional format
- [ ] Branch naming follows convention
- [ ] PR description references the issue
- [ ] No `TODO` or `FIXME` markers in new code (unless tracked by issue)

---

## Error Handling

| Error                    | Recovery                      |
| ------------------------ | ----------------------------- |
| Missing PR context       | Request PR number or diff     |
| Unclear feedback         | Ask for clarification         |
| Conflicting requirements | Escalate to author/maintainer |
