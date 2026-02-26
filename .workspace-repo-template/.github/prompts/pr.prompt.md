---
description: "From committed changes to merged PR"
---

# PR

Git-Ops-led workflow with Docs support. Create a pull request with appropriate title, template, labels, and merge strategy.

**Prerequisites:** Branch exists with commits, changes pushed to remote, verification passed (build, tests)

---

## Phase 1: Determine Configuration

### PR Settings

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

| Scenario           | Target              |
| ------------------ | ------------------- |
| Standalone work    | `{{{base_branch}}}` |
| Part of epic/phase | Epic/phase branch   |
| Hotfix             | `main`              |

5. Determine merge method (merge commit or squash)

---

## Phase 2: Create PR Body

### Compose Description

1. Write summary (what and why)
2. List scope (files changed, areas affected)
3. Document validation (build passes, tests pass)
4. Add links (closes issue, related ADRs)

**PR Body Template:**

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

### Show Configuration for Approval

1. Show all configuration (title, template, target, merge method, labels)
2. Show PR body content
3. Show the `gh` CLI command that will be used
4. Wait for approval

### Output

```markdown
## Context Anchors

- **Issue:** #<number> - <title>
- **Branch:** `<branch>` → `<target>`
- **Changes:** <X files changed>

## PR Configuration

| Property     | Value                            |
| ------------ | -------------------------------- |
| Title        | `<type>(<scope>): <description>` |
| Template     | `<template>.md`                  |
| Target       | `<target-branch>`                |
| Merge method | Merge commit / Squash            |
| Labels       | `type:...`, `topic:...`          |

## PR Body

<body content>

## Command

\`\`\`bash
gh pr create \
 --base <target> \
 --head <branch> \
 --title "<type>(<scope>): <description>" \
 --body-file .tmp/pr-body.md \
 --label "type:<type>"
\`\`\`

## Next Step

Awaiting approval to create PR.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not create the PR until human explicitly approves.

---

## Phase 4: Create & Report

### Execute PR Creation

1. Write PR body to `.tmp/pr-body.md`
2. Execute:

```bash
gh pr create \
  --base {{{base_branch}}} \
  --head <branch> \
  --title "<type>(<scope>): <description>" \
  --body-file .tmp/pr-body.md \
  --label "type:<type>"
```

3. Report PR number and URL
4. Note next steps (awaiting review)

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

| Profile       | Reviewers | CI Required | Self-Merge |
| ------------- | --------- | ----------- | ---------- |
| `lightweight` | 0         | No          | Yes        |
| `standard`    | 1         | Yes         | No         |
| `regulated`   | 2         | Yes         | No         |

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

| Error                    | Recovery               |
| ------------------------ | ---------------------- |
| Branch not pushed        | Push first, then retry |
| Build/tests not passing  | Fix issues before PR   |
| Missing issue link       | Confirm issue number   |
| gh CLI not authenticated | Run `gh auth login`    |
