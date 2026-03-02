---
name: pr
description: From committed changes to merged PR.
---

# PR

The Implementer drives this workflow. Create a pull request with appropriate title, template, labels, and merge strategy.

**Prerequisites:** Branch exists with commits, changes pushed to remote, verification passed (build, tests).

---

## Phase 1: Determine Configuration

Determine PR title, template, labels, target branch, and merge method.

### Steps

1. Determine PR title: `<type>(<scope>): <description>`
2. Select template based on work type
3. Determine labels (type, topic, area)
4. Determine target branch
5. Determine merge method

### Template Selection

| Work Type     | Template      |
| ------------- | ------------- |
| Features      | `feat.md`     |
| Bug fixes     | `fix.md`      |
| Documentation | `docs.md`     |
| Maintenance   | `chore.md`    |
| Refactoring   | `refactor.md` |

### Target Branch

| Scenario           | Target            |
| ------------------ | ----------------- |
| Standalone work    | `main`            |
| Part of epic/phase | Epic/phase branch |
| Hotfix             | `main`            |

---

## Phase 2: Create PR Body

Compose the PR description.

### Steps

1. Write summary (what and why)
2. List scope (files changed, areas affected)
3. Document validation (build passes, tests pass)
4. Add links (closes issue, related ADRs)

### PR Body Template

```markdown
## Summary

<What this PR does and why>

## Scope

- Files changed: <key files>
- Areas affected: <areas>

## Validation

- [x] Build passes
- [x] Tests pass (<counts>)
- [x] Manual verification (if applicable)

## Links

- Closes #<issue-number>
- Related: <other issues, ADRs>
```

---

## Phase 3: Present Proposal

Present PR configuration for approval before creation.

### Steps

1. Show all configuration (title, template, target, merge method, labels)
2. Show PR body content
3. Show the forge operation that will be executed
4. Wait for approval

### Output

```markdown
## Context Anchors

- **Issue:** #<number> - <title>
- **Branch:** `<branch>` → `<target>`
- **Changes:** <X files changed>

## PR Configuration

| Property     | Value                            |
| ------------ | -------------------------------- | ------- |
| Title        | `<type>(<scope>): <description>` |
| Template     | `<template>.md`                  |
| Target       | `<target-branch>`                |
| Merge method | <Merge commit                    | Squash> |
| Labels       | `type:...`, `topic:...`          |

## Next Step

Awaiting approval to create PR.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not proceed until human approves PR configuration.

---

## Phase 4: Create & Report

Execute PR creation, update board status, and report result.

### Steps

1. Write PR body to `.tmp/pr-body.md`
2. Execute the forge's PR creation operation with:
   - **Base:** `main` (or epic/phase branch)
   - **Head:** feature branch
   - **Title:** `<type>(<scope>): <description>`
   - **Body:** from `.tmp/pr-body.md`
   - **Labels:** from Phase 1
3. Update board status to **In Review** for the linked issue
4. Report PR number and URL

### Output

```markdown
## Context Anchors

- **PR:** #<pr-number> - <title>
- **Issue:** #<issue-number>
- **Status:** Open, awaiting review

## Next Step

PR created. Awaiting review.
```

---

## Review Requirements by Profile

| Profile       | Reviewers | CI Required | Self-Merge | Approval Expires |
| ------------- | --------- | ----------- | ---------- | ---------------- |
| `lightweight` | 0         | No          | Yes        | Never            |
| `standard`    | 1         | Yes         | No         | On new commits   |
| `regulated`   | 2         | Yes         | No         | On new commits   |

Check `process.profile` in `workspace.config.yaml` to determine which rules apply.

---

## Merge Strategy

| Strategy     | When to Use                                         |
| ------------ | --------------------------------------------------- |
| Merge commit | Feature branches with meaningful commit history     |
| Squash       | Small fixes, single-logical-change PRs              |
| Rebase       | Linear history preferred, clean single-topic branch |

---

## Error Handling

| Error                   | Recovery                    |
| ----------------------- | --------------------------- |
| Branch not pushed       | Push first, then retry      |
| Build/tests not passing | Fix issues before PR        |
| Missing issue link      | Confirm issue number        |
| Forge not authenticated | Check authentication status |
