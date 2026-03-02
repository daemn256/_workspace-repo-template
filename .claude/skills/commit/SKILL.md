---
name: commit
description: Stage changes and create a Conventional Commit.
---

# Commit

The Implementer drives this workflow. Stage file changes and create a well-formed Conventional Commit with appropriate type, scope, and description.

**Prerequisites:** Changes ready to commit, understanding of what was changed and why.

---

## Phase 1: Review Changes

Inspect and group changes for the commit.

### Steps

1. Run `git status` to see changed files
2. Run `git diff` to review changes
3. Group related changes — separate unrelated work into distinct commits
4. Verify no unintended changes are included

---

## Phase 2: Compose and Commit

### Conventional Commit Format

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

### Type Selection

| Type       | When to Use                             |
| ---------- | --------------------------------------- |
| `feat`     | New feature or capability               |
| `fix`      | Bug fix                                 |
| `docs`     | Documentation only                      |
| `style`    | Formatting, no code change              |
| `refactor` | Code change that neither fixes nor adds |
| `perf`     | Performance improvement                 |
| `test`     | Adding or updating tests                |
| `build`    | Build system or external dependencies   |
| `ci`       | CI configuration                        |
| `chore`    | Maintenance tasks                       |

### Scope Selection

Use workspace-defined scopes from git conventions. Common:

| Scope       | Area                                    |
| ----------- | --------------------------------------- |
| `process`   | Process domain definitions              |
| `kernel`    | Agentic kernel (personality, skillsets) |
| `forge`     | Forge abstraction                       |
| `workspace` | Workspace manager and orchestration     |
| `platform`  | Platform adapters                       |
| `build`     | Build pipeline and tooling              |
| `docs`      | Documentation                           |
| `deps`      | Dependencies                            |

### Rules

- **Description:** imperative mood, lowercase, no trailing period
- **Body:** explain what and why (not how)
- **Footer:** reference issues with `Refs: #<number>` or `Closes: #<number>`
- **Breaking changes:** append `!` after type/scope or use `BREAKING CHANGE:` footer

### Output

```markdown
## Context Anchors

- **Issue:** #<number> - <title>
- **Branch:** <current branch>

## Commit

**Message:** `<type>(<scope>): <description>`
**Files committed:** <count>

## Next Step

<push / continue working / create PR>

**Approval Required:** No
```
