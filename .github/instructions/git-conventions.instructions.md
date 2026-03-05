---
applyTo: "**"
---

# Git Conventions

> Branch naming, commit format, and scopes. These are workspace-overridable defaults.

<!-- BEGIN WORKSPACE-OVERRIDABLE -->

## Branch Strategy

**Flow:** GitHub Flow (trunk-based with feature branches) is the default. All work happens on feature branches. PRs merge into `main` via merge commit (default). Squash is an explicit override for single-logical-change PRs.

Default branch naming:

```
<type>/<issue-number>-<kebab-description>
```

**Types:** `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `perf`, `ci`, `build`

**Examples:**

- `feat/42-redis-cache-service`
- `fix/123-null-pointer-user-service`
- `docs/456-api-documentation`

**Complex Work (Two-Phase):**

```
Phase 1: docs/<issue-number>-<description>-design
Phase 2: feat/<issue-number>-<description>
```

## Commit Format

Use Conventional Commits:

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

**Rules:**

- **Type** is required, from the allowed list
- **Scope** is optional but recommended
- **Description** is required — imperative mood, lowercase, no trailing period
- **Body** is optional — provides additional context
- **Footer** is optional — references issues, breaking changes

**Types:** `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`

**Breaking Changes:** Append `!` after type/scope (e.g., `feat(forge)!: rename command`) or use `BREAKING CHANGE:` footer.

## Scopes

| Scope       | Area                                     |
| ----------- | ---------------------------------------- |
| `process`   | Process domain definitions               |
| `kernel`    | Agentic kernel (personality, skillsets)  |
| `forge`     | Forge abstraction                        |
| `workspace` | Workspace manager and orchestration      |
| `platform`  | Platform adapters (github-copilot, etc.) |
| `build`     | Build pipeline and tooling               |
| `docs`      | Documentation                            |
| `deps`      | Dependencies                             |

<!-- END WORKSPACE-OVERRIDABLE -->
