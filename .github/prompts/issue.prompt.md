---
description: From issue selection to implementation completion
---

# Issue

Uses **Orchestrator** (primary) with **Implementer** support. Analyze an issue, propose approach, create branch, and implement changes with human approval at each checkpoint.

**Prerequisites:** Issue number or context available, access to version control and issue tracker

---

## Phase 1: Analyze

### Gather Context

1. Read the issue (title, description, labels, acceptance criteria)
2. Search for related documentation:
   - Architecture decisions (ADRs) in `docs/adr/`
   - Existing patterns in `docs/architecture/`
   - Implementation guides
   - Parent/child issues (`Part of #N`)
3. Classify complexity
4. Propose branch name

### Complexity Criteria

| Criterion     | Simple     | Complex             |
| ------------- | ---------- | ------------------- |
| Scope         | 1-2 files  | 3+ areas            |
| Certainty     | Clear path | Unknowns exist      |
| Architecture  | No impact  | New patterns needed |
| Design review | Not needed | Would be beneficial |

**Rule:** ANY Complex criterion → Issue is Complex

### Branch Pattern

`<type>/<issue-number>-<kebab-description>`

Types: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `perf`

### Output

```markdown
## Context Anchors

- **Issue:** #<number> - <title>
- **Phase:** 1 — Analyze
- **Branch:** (proposed) `<branch-name>`

## Analysis

<findings from documentation search>

## Classification

- **Complexity:** <Simple | Complex>
- **Rationale:** <why>

## Proposed Approach

<implementation plan>

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

1. Checkout base branch and pull latest:
   ```bash
   git checkout main && git pull origin main
   ```
2. Create feature branch:
   ```bash
   git checkout -b <type>/<issue-number>-<kebab-description>
   ```
3. Verify branch created

### Output

```markdown
## Context Anchors

- **Issue:** #<number> - <title>
- **Phase:** 2 — Branch
- **Branch:** `<branch-name>`

## Branch Created

- **From:** `main`
- **Name:** `<branch-name>`

## Next Step

Await approval to proceed with implementation.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not proceed until human explicitly approves proceeding to implementation.

---

## Phase 3: Implement

### Make Changes Iteratively

1. Make focused changes (one logical unit at a time)
2. Run the workspace's build and test commands (read from `workspace.config.yaml`) after each unit
3. Report progress
4. Checkpoint before next unit (if significant)

### Iteration Pattern

- Complete one logical unit
- Verify (build, test)
- Report status
- Continue or checkpoint

### Output

```markdown
## Context Anchors

- **Issue:** #<number> - <title>
- **Phase:** 3 — Implement
- **Branch:** `<branch-name>`
- **Unit:** <N of total>

## Progress

<what was changed in this unit>

## Verification

- [ ] Build passes
- [ ] Tests pass

## Next Step

<Continue to next unit or proceed to review>

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP** after each significant logical unit. Await approval before proceeding.

---

## Phase 4: Review

### Verify Implementation

1. Run the workspace's build command (read from `workspace.config.yaml`)
2. Run the workspace's test command (read from `workspace.config.yaml`)
3. Run the workspace's lint command if configured
4. Summarize all changes

### Verification Checklist

- [ ] Build passes
- [ ] Tests pass
- [ ] Lint clean
- [ ] Changes summarized

### Output

```markdown
## Context Anchors

- **Issue:** #<number> - <title>
- **Phase:** 4 — Review
- **Branch:** `<branch-name>`

## Changes Summary

<list of all files changed and what was done>

## Verification Block

- [x] Build passes
- [x] Tests pass (<counts>)
- [x] Lint clean

## Next Step

Awaiting approval to commit.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not commit until human explicitly approves:

- All changes are correct
- Verification passes
- No unintended modifications

---

## Phase 5: Commit

### Create Well-Formed Commit

1. Stage changes:
   ```bash
   git add -A
   ```
2. Create commit with conventional format:

   ```bash
   git commit -m "<type>(<scope>): <description>

   <body>

   Closes #<issue-number>"
   ```

3. Report commit details

### Output

```markdown
## Context Anchors

- **Issue:** #<number> - <title>
- **Phase:** 5 — Commit
- **Branch:** `<branch-name>`

## Commit

- **Hash:** <sha>
- **Message:** `<type>(<scope>): <description>`
- **Closes:** #<issue-number>

## Next Step

Awaiting approval to push and create PR.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not push until human explicitly approves.

---

## Knowledge Gates

| Transition         | Required Before Proceeding                  |
| ------------------ | ------------------------------------------- |
| Analyze → Branch   | Complexity classified, approach approved    |
| Branch → Implement | Branch created, approval to proceed         |
| Implement → Review | Logical unit complete, build passes         |
| Review → Commit    | Build + tests + lint pass, changes approved |
| Commit → Push/PR   | Commit created, approval to push            |

---

## Spawned Issues

When implementation reveals work outside the current issue's scope:

1. **Do NOT expand scope** — stay within the original issue boundary
2. **Create a spawned issue** with:
   - Clear title referencing the parent: `<type>: <description> (from #<parent>)`
   - Link to parent issue
   - Enough context to be independently actionable
3. **Note in the parent issue** that a spawned issue was created
4. **Continue with the original scope**

---

## Error Handling

| Error                | Recovery                                                                |
| -------------------- | ----------------------------------------------------------------------- |
| Blocked              | Report blocker clearly, do not proceed, await guidance                  |
| Complexity escalates | Re-classify and report, may require returning to Phase 1                |
| Tests fail           | Report failure details, do not proceed to commit, fix or await guidance |
