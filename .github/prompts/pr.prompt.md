---
description: Create PR with template and labels
---

# PR Creation Workflow

Create a pull request with appropriate title, template, labels, and merge strategy.

## Prerequisites

- Branch exists with commits
- Changes pushed to remote
- Build and tests pass

## Workflow

### Step 1: Determine Configuration

| Property | How to Determine |
|----------|------------------|
| Title | `<type>(<scope>): <description>` matching branch |
| Template | Match branch type (feat→feat.md, fix→fix.md) |
| Target | `dev` (standalone) or epic branch (part of epic) |
| Labels | `type:*` required, `topic:*` and `area:*` recommended |
| Merge method | Merge commit to dev, squash to main |

### Step 2: Generate PR Body

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

### Step 3: Present Proposal

```markdown
## Context Anchors

- **Issue:** #<number> - <title>
- **Branch:** `<branch>` → `<target>`
- **Changes:** <X files changed>

## PR Configuration

| Property | Value |
|----------|-------|
| Title | `<type>(<scope>): <description>` |
| Template | `<template>.md` |
| Target | `<target-branch>` |
| Merge method | <Merge commit | Squash> |
| Labels | `type:...`, `topic:...` |

## Commands

```bash
gh pr create \
  --base <target> \
  --head <branch> \
  --title "<title>" \
  --body-file .tmp/pr-body.md \
  --label "type:<type>"
```

## Next Step

Awaiting approval to create PR.

**Approval Required:** Yes
```

### Step 4: Post-Creation

Report PR number and link. Mention that Address Feedback workflow handles review feedback.

## Template Mapping

| Branch Type | Template |
|-------------|----------|
| feat/* | feat.md |
| fix/* | fix.md |
| docs/* | docs.md |
| chore/* | chore.md |
| refactor/* | refactor.md |
| test/* | test.md |
| perf/* | perf.md |
| ci/* | ci.md |
