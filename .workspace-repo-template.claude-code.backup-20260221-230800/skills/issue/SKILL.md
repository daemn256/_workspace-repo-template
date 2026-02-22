---
name: issue
description: From issue selection to implementation completion
---

# Issue Workflow

Analyze an issue, propose approach, create branch, and implement changes with human approval at each checkpoint.

## Personas

- **Primary:** Orchestrator (workflow coordination)
- **Secondary:** Implementer (implementation)

## Prerequisites

- Issue number or context available
- Access to version control
- Access to issue tracker

---

## Phase 1: Analyze

**Goal:** Gather context and classify the work.

1. Read the issue (title, description, labels, acceptance criteria)
2. Search for related documentation:
   - Architecture decisions (ADRs)
   - Existing patterns
   - Implementation guides
   - Parent/child issues
3. Classify complexity
4. Propose branch name

### Complexity Classification

| Criterion     | Simple     | Complex             |
| ------------- | ---------- | ------------------- |
| Scope         | 1-2 files  | 3+ areas            |
| Certainty     | Clear path | Unknowns exist      |
| Architecture  | No impact  | New patterns needed |
| Design review | Not needed | Would be beneficial |

**Rule:** ANY Complex criterion → Issue is Complex

### Branch Pattern

`{{{type}}}/{{{issue-number}}}-{{{kebab-description}}}`

Types: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `perf`

### Output Template

```markdown
## Context Anchors

- **Issue:** #{{{number}}} - {{{title}}}
- **Labels:** {{{labels}}}
- **Related:** {{{adrs-docs}}}
- **Branch:** `{{{proposed-branch}}}` from `{{{base}}}`

## Verification Block

- [x] Issue exists and is open
- [x] Labels verified
- [x] Related docs reviewed: {{{list}}}
- [x] Complexity classified: {{{Simple|Complex}}}

## Decision Rationale

**Complexity: {{{Simple|Complex}}}**

- {{{reason}}}

**Branch strategy:** {{{rationale}}}

## Next Step

Awaiting approval to create branch and begin implementation.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

Await approval of complexity classification, branch name, and approach.

---

## Phase 2: Branch

**Goal:** Create the feature branch.

1. Checkout base branch and pull latest
2. Create feature branch
3. Verify branch created

### Commands

```bash
git checkout {{{base}}} && git pull origin {{{base}}} && git checkout -b {{{branch}}}
```

### ⛔ CHECKPOINT

Await approval to proceed with implementation.

---

## Phase 3: Implement

**Goal:** Make changes iteratively, one logical unit at a time.

1. Make focused changes
2. Run builds/tests
3. Report progress
4. Checkpoint before next unit (if significant)

### Iteration Pattern

- Complete one logical unit
- Verify (build, test)
- Report status
- Continue or checkpoint

### ⛔ CHECKPOINT

Per significant unit — pause and confirm direction before continuing.

---

## Phase 4: Review

**Goal:** Verify implementation before committing.

1. Run full build
2. Run all relevant tests
3. Check lint/format
4. Summarize all changes

### Verification Checklist

- [ ] Build passes
- [ ] Tests pass
- [ ] Lint clean
- [ ] Changes summarized

### Output Template

```markdown
## Context Anchors

- **Issue:** #{{{number}}} - {{{title}}}
- **Branch:** `{{{branch}}}`

## Changes Summary

{{{summary-of-all-changes}}}

## Verification Block

- [{{{x-or-space}}}] Build passes
- [{{{x-or-space}}}] Tests pass
- [{{{x-or-space}}}] Lint clean
- [{{{x-or-space}}}] Changes summarized

## Next Step

Ready to commit.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

Await approval to commit.

---

## Phase 5: Commit

**Goal:** Create a well-formed commit.

### Commit Format

```
{{{type}}}({{{scope}}}): {{{description}}}

{{{body}}}

Closes #{{{issue-number}}}
```

### Steps

1. Stage changes
2. Create commit with conventional format
3. Report commit details

### Commands

```bash
git add -A
git commit -m "{{{type}}}({{{scope}}}): {{{description}}}

{{{body}}}

Closes #{{{issue-number}}}"
```

### Output Template

```markdown
## Context Anchors

- **Issue:** #{{{number}}} - {{{title}}}
- **Branch:** `{{{branch}}}`
- **Commit:** `{{{sha}}}`

## Commit Details

{{{commit-message}}}

## Next Step

Ready to push and/or create PR.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

Await approval to push/create PR.

---

## Error Handling

| Error                          | Recovery                                                                |
| ------------------------------ | ----------------------------------------------------------------------- |
| Blocked by external dependency | Report the blocker clearly; do not proceed; await human guidance        |
| Complexity escalates mid-work  | Re-classify and report; may require returning to Phase 1                |
| Tests fail                     | Report failure details; do not proceed to commit; fix or await guidance |
