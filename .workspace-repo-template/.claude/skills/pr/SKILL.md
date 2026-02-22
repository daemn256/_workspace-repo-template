````skill
---
name: pr
description: Create pull requests with proper structure
---

# PR Workflow

From committed changes to a merged PR. Create a pull request with appropriate title, template, labels, and merge strategy.

## Personas

- **Primary:** Git-Ops (source control operations)
- **Secondary:** Docs (PR description)

## Prerequisites

- Branch exists with commits
- Changes pushed to remote
- Verification passed (build, tests)

## Entry Points

- "Create a PR for this branch" — Start at Phase 1
- "Let's open a pull request" — Start at Phase 1
- "PR time" — Start at Phase 1

---

## Phase 1: Determine Configuration

**Goal:** Determine PR title, template, labels, target branch, and merge method.

### Steps

1. Determine PR title from branch type (`<type>(<scope>): <description>`)
2. Select template based on work type (feat, fix, docs, chore, etc.)
3. Determine labels (type, topic, area)
4. Determine target branch (dev, epic branch, or main)
5. Determine merge method (merge commit or squash)

### PR Title Format

`<type>(<scope>): <description>`

### Template Selection

| Work Type     | Template      |
| ------------- | ------------- |
| Features      | `feat.md`     |
| Bug fixes     | `fix.md`      |
| Documentation | `docs.md`     |
| Maintenance   | `chore.md`    |
| Refactoring   | `refactor.md` |

### Target Branch

| Scenario           | Target              |
| ------------------ | ------------------- |
| Standalone work    | `{{{base_branch}}}` |
| Part of epic/phase | Epic/phase branch   |
| Hotfix             | `main`              |

---

## Phase 2: Create PR Body

**Goal:** Compose the PR description.

### Steps

1. Write summary (what and why)
2. List scope (files changed, areas affected)
3. Document validation (build passes, tests pass)
4. Add links (closes issue, related ADRs)

### PR Body Template

```markdown
## Summary

{{{what-this-pr-does-and-why}}}

## Scope

- Files changed: {{{key-files}}}
- Areas affected: {{{areas}}}

## Validation

- [x] Build passes
- [x] Tests pass ({{{test-counts}}})
- [x] Manual verification (if applicable)

## Links

- Closes #{{{issue-number}}}
- Related: {{{other-issues-or-adrs}}}
```

---

## Phase 3: Present Proposal

**Goal:** Present PR configuration for approval before creation.

### Steps

1. Show all configuration (title, template, target, merge method, labels)
2. Show PR body content
3. Show `gh` CLI command that will be used
4. Wait for approval

### Output Template

```markdown
## Context Anchors

- **Issue:** #{{{issue-number}}} - {{{issue-title}}}
- **Branch:** `{{{head-branch}}}` → `{{{target-branch}}}`
- **Changes:** {{{file-count}}} files changed

## PR Configuration

| Property     | Value                            |
| ------------ | -------------------------------- |
| Title        | `{{{type}}}({{{scope}}}): {{{description}}}` |
| Template     | `{{{template}}}.md`             |
| Target       | `{{{target-branch}}}`           |
| Merge method | {{{merge-method}}}              |
| Labels       | `type:{{{type}}}`, `topic:{{{topic}}}` |

## Next Step

Awaiting approval to create PR.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

Present PR configuration and body for approval before creation. Do not execute `gh pr create` until explicitly approved.

---

## Phase 4: Create & Report

**Goal:** Execute PR creation and report result.

### Steps

1. Create PR body file at `.tmp/pr-body.md`
2. Execute `gh pr create` command
3. Report PR number and URL
4. Note next steps (awaiting review)

### Commands

```bash
gh pr create \
  --base {{{base_branch}}} \
  --head {{{head_branch}}} \
  --title "{{{type}}}({{{scope}}}): {{{description}}}" \
  --body-file .tmp/pr-body.md \
  --label "type:{{{type}}}"
```

### Output Template

```markdown
## Context Anchors

- **PR:** #{{{pr-number}}} - {{{title}}}
- **Issue:** #{{{issue-number}}}
- **Status:** Open, awaiting review

## Next Step

PR created. Awaiting review.

**Approval Required:** No
```

---

## Error Handling

| Error                    | Recovery               |
| ------------------------ | ---------------------- |
| Branch not pushed        | Push first, then retry |
| Build/tests not passing  | Fix issues before PR   |
| Missing issue link       | Confirm issue number   |
| gh CLI not authenticated | Run `gh auth login`    |

````
