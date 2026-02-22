---
description: "From issue selection to implementation completion"
---

# Issue

Orchestrator-led workflow with Implementer support. Analyze an issue, propose approach, create branch, and implement changes with human approval at each checkpoint.

**Prerequisites:** Issue number or context available, access to version control and issue tracker

---

## Phase 1: Analyze

### Gather Context

1. Read the issue (title, description, labels, acceptance criteria)
2. Search for related documentation:
   - ADRs in `docs/adr/`
   - Architecture docs in `docs/architecture/`
   - Implementation guides in `docs/guides/`
   - Parent/child issues (`Part of #N`)
3. Check for existing patterns in the codebase

### Classify Complexity

| Criterion     | Simple     | Complex             |
| ------------- | ---------- | ------------------- |
| Scope         | 1-2 files  | 3+ areas            |
| Certainty     | Clear path | Unknowns exist      |
| Architecture  | No impact  | New patterns needed |
| Design review | Not needed | Would be beneficial |

**Rule:** ANY Complex criterion → Issue is Complex

### Propose Branch

Branch pattern: `<type>/<issue-number>-<kebab-description>`

Types: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `perf`

### Output

```markdown
## Context Anchors

- **Issue:** #<number> - <title>
- **Phase:** 1 — Analyze
- **Branch:** (proposed) `<type>/<number>-<description>`

## Analysis

<findings summary>

## Complexity

**Classification:** Simple | Complex
<rationale>

## Approach

<proposed implementation approach>

## Next Step

Await approval for classification, branch name, and approach.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not proceed until human explicitly approves:

- Complexity classification
- Branch name
- Approach

---

## Phase 2: Branch

### Create Feature Branch

```bash
git checkout {{{base_branch}}} && git pull origin {{{base_branch}}}
git checkout -b <type>/<issue-number>-<kebab-description>
```

### Output

```markdown
## Context Anchors

- **Issue:** #<number> - <title>
- **Phase:** 2 — Branch
- **Branch:** `<branch-name>`

## Branch Created

- Base: `{{{base_branch}}}`
- Branch: `<branch-name>`

## Next Step

Await approval to proceed with implementation.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not proceed until human explicitly approves moving to implementation.

---

## Phase 3: Implement

### Make Changes Iteratively

1. Complete one logical unit of work
2. Run build and tests to verify: `{{{build_command}}}` / `{{{test_command}}}`
3. Report status and progress
4. Checkpoint before next significant unit

### Output

```markdown
## Context Anchors

- **Issue:** #<number> - <title>
- **Phase:** 3 — Implement
- **Branch:** `<branch-name>`

## Progress

<what was completed in this unit>

## Verification

- [ ] Build passes
- [ ] Tests pass

## Next Step

<Continue with next unit | Ready for review>

**Approval Required:** Per significant unit
```

### ⛔ CHECKPOINT

**STOP.** Checkpoint after each significant unit of work.

---

## Phase 4: Review

### Verify Implementation

1. Run full build: `{{{build_command}}}`
2. Run all relevant tests: `{{{test_command}}}`
3. Run lint/format check: `{{{lint_command}}}`
4. Summarize all changes made

### Output

```markdown
## Context Anchors

- **Issue:** #<number> - <title>
- **Phase:** 4 — Review
- **Branch:** `<branch-name>`

## Changes Summary

<summary of all changes>

## Verification Block

- [x] Build passes
- [x] Tests pass
- [x] Lint clean
- [x] Changes summarized

## Next Step

Awaiting approval to commit.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not commit until human explicitly approves.

---

## Phase 5: Commit

### Create Conventional Commit

```bash
git add -A
git commit -m "<type>(<scope>): <description>

<body>

Closes #<issue-number>"
```

### Output

```markdown
## Context Anchors

- **Issue:** #<number> - <title>
- **Phase:** 5 — Commit
- **Branch:** `<branch-name>`

## Commit

- **Message:** `<type>(<scope>): <description>`
- **SHA:** `<sha>`
- **Files:** <count> files changed

## Next Step

Awaiting approval to push or create PR.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not push until human explicitly approves.

---

## Error Handling

| Error                   | Recovery                                      |
| ----------------------- | --------------------------------------------- |
| Blocked by missing info | Report blocker clearly, await human guidance  |
| Complexity escalates    | Re-classify and report, may return to Phase 1 |
| Tests fail              | Report failure details, fix or await guidance |
| Build fails             | Report failure details, do not proceed        |
