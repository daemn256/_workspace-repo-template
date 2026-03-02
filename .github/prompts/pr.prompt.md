---
description: From committed changes to merged PR
---

# PR

Uses **Implementer**. Create a pull request with appropriate title, template, labels, and merge strategy.

**Prerequisites:** Branch exists with commits, changes pushed to remote, verification passed (build, tests)

## Phase 1: Determine Configuration

### PR Setup

1. Determine PR title from branch type: `<type>(<scope>): <description>`
2. Select template based on work type:

| Work Type     | Template      |
| ------------- | ------------- |
| Features      | `feat.md`     |
| Bug fixes     | `fix.md`      |
| Documentation | `docs.md`     |
| Maintenance   | `chore.md`    |
| Refactoring   | `refactor.md` |

3. Determine labels (type, topic, area)
4. Determine target branch:

| Scenario           | Target            |
| ------------------ | ----------------- |
| Standalone work    | `main`            |
| Part of epic/phase | Epic/phase branch |
| Hotfix             | `main`            |

5. Determine merge method (merge commit or squash)

### Output

```markdown
## Context Anchors

- **Issue:** #<number> - <title>
- **Branch:** `<branch>` → `<target>`
- **Phase:** 1 — Determine Configuration

## PR Configuration

| Property     | Value                            |
| ------------ | -------------------------------- | ------- |
| Title        | `<type>(<scope>): <description>` |
| Template     | `<template>.md`                  |
| Target       | `<target-branch>`                |
| Merge method | <Merge commit                    | Squash> |
| Labels       | `type:...`, `topic:...`          |

## Next Step

Continue to PR body creation.

**Approval Required:** No
```

---

## Phase 2: Create PR Body

### Compose Description

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

### Output

```markdown
## Context Anchors

- **Issue:** #<number> - <title>
- **Branch:** `<branch>` → `<target>`
- **Phase:** 2 — Create PR Body

## PR Body

<composed body content>

## Next Step

Continue to proposal.

**Approval Required:** No
```

---

## Phase 3: Present Proposal

### Show Configuration for Approval

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

## PR Body Preview

<full body content>

## Next Step

Awaiting approval to create PR.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not create PR until human explicitly approves:

- PR title and labels
- Target branch and merge method
- PR body content

---

## Phase 4: Create and Report

### Execute PR Creation

1. Create PR body file at `.tmp/pr-body.md`
2. Execute the forge's PR creation operation with:
   - **Base:** `main` (or epic/phase branch)
   - **Head:** feature branch
   - **Title:** `<type>(<scope>): <description>`
   - **Body:** from `.tmp/pr-body.md`
   - **Labels:** from Phase 1
3. Update board status to **In Review** for the linked issue
4. Report PR number and URL
5. Note next steps (awaiting review)

### Board Integration

Read `workspace.config.yaml` for board field IDs.
Set issue status to In Review (`board.status_options.in-review.option_id`).
The workspace's forge adapter determines the specific tool/command.

### Output

```markdown
## Context Anchors

- **PR:** #<pr-number> - <title>
- **Issue:** #<issue-number>
- **Status:** Open, awaiting review

## Next Step

PR created. Awaiting review.

**Approval Required:** No
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

## Knowledge Gates

| Transition        | Required Before Proceeding                 |
| ----------------- | ------------------------------------------ |
| Config → Body     | Title, template, labels, target determined |
| Body → Proposal   | PR body composed                           |
| Proposal → Create | Human approval of PR configuration         |
| Create → Complete | PR created, URL reported                   |

---

## Error Handling

| Error                   | Recovery                    |
| ----------------------- | --------------------------- |
| Branch not pushed       | Push first, then retry      |
| Build/tests not passing | Fix issues before PR        |
| Missing issue link      | Confirm issue number        |
| Forge not authenticated | Check authentication status |
