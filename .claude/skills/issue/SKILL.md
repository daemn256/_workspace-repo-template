---
name: issue
description: From issue selection to implementation completion.
---

# Issue

The Orchestrator drives this workflow with the Implementer handling code changes. Analyze an issue, propose approach, create branch, and implement changes with human approval at each checkpoint.

**Prerequisites:** Issue number or context available, access to version control and issue tracker.

---

## Phase 1: Analyze

Gather context and classify the work.

### Steps

1. Read the issue (title, description, labels, acceptance criteria)
2. Search for related documentation — ADRs, existing patterns, implementation guides, parent/child issues
3. Classify complexity using the criteria below
4. Propose branch name: `<type>/<issue-number>-<kebab-description>`

### Complexity Criteria

| Criterion     | Simple     | Complex             |
| ------------- | ---------- | ------------------- |
| Scope         | 1-2 files  | 3+ areas            |
| Certainty     | Clear path | Unknowns exist      |
| Architecture  | No impact  | New patterns needed |
| Design review | Not needed | Would be beneficial |

**Rule:** ANY Complex criterion → Issue is Complex

### Output

```markdown
## Context Anchors

- **Issue:** #<number> - <title>
- **Phase:** Analyze
- **Branch:** `<proposed-branch-name>`

## Analysis

**Complexity:** Simple | Complex
**Scope:** <files/areas affected>
**Approach:** <proposed implementation approach>

## Next Step

Approve complexity classification, branch name, and approach.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not proceed until human explicitly approves:

- Complexity classification
- Branch name
- Implementation approach

---

## Phase 2: Branch

Create the feature branch.

### Steps

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
- **Phase:** Branch
- **Branch:** `<branch-name>`

## Branch Created

Branch `<branch-name>` created from `main`.

## Next Step

Begin implementation.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not proceed until human approves to begin implementation.

---

## Phase 3: Implement

Make changes iteratively, one logical unit at a time.

### Steps

1. Make focused changes for one logical unit
2. Run the workspace's build and test commands (read from `workspace.config.yaml`)
3. Report progress
4. Checkpoint before next unit (if significant)

### Output

```markdown
## Context Anchors

- **Issue:** #<number> - <title>
- **Phase:** Implement
- **Branch:** `<branch-name>`

## Changes Made

<description of changes in this unit>

## Verification Block

- [x] Build passes
- [x] Tests pass

## Next Step

<continue implementation | proceed to review>

**Approval Required:** Yes | No
```

### ⛔ CHECKPOINT

**STOP.** Checkpoint after each significant logical unit.

---

## Phase 4: Review

Verify implementation before committing.

### Steps

1. Run the workspace's build command (read from `workspace.config.yaml`)
2. Run the workspace's test command (read from `workspace.config.yaml`)
3. Run the workspace's lint command if configured
4. Summarize all changes

### Output

```markdown
## Context Anchors

- **Issue:** #<number> - <title>
- **Phase:** Review
- **Branch:** `<branch-name>`

## Changes Summary

<summary of all changes made>

## Verification Block

- [x] Build passes
- [x] Tests pass
- [x] Lint clean
- [x] Changes summarized

## Next Step

Approve changes to proceed to commit.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not proceed until human approves all changes.

---

## Phase 5: Commit

Create a well-formed commit.

### Steps

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
- **Phase:** Commit
- **Branch:** `<branch-name>`

## Commit

`<sha>` — `<type>(<scope>): <description>`

## Next Step

Approve to push and create PR.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not proceed until human approves to push/create PR.

---

## Spawned Issues

When implementation reveals work outside the current issue's scope:

1. **Do NOT expand scope** — stay within the original issue boundary
2. **Create a spawned issue** with clear title, link to parent, and enough context
3. **Note in the parent issue** that a spawned issue was created
4. **Continue with the original scope**

---

## Error Handling

| Error                | Recovery                                         |
| -------------------- | ------------------------------------------------ |
| Blocked              | Report the blocker clearly, await guidance       |
| Complexity escalates | Re-classify and report, may return to Phase 1    |
| Tests fail           | Report failure details, do not proceed to commit |
