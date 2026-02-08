# Repository Instructions

> Cross-cutting rules applied to ALL Copilot interactions in this workspace.

---

## Template Identity

This repository was created from the **workspace-repo** template (`_workspace-repo-template`).

- **Type:** Single-repository workspace (one repo = one project)
- **Upstream:** `_workspace-repo-template` → `_repo-template`
- **Metadata:** See `.template.yaml` for machine-readable template info

---

## Core Philosophy

**The AI assists; the human decides.**

- AI proposes; humans approve
- AI executes; humans verify
- Work in small, reviewable steps
- Every action links to its rationale
- Quality over speed

---

## Approval Gates

**Destructive or irreversible actions require explicit human approval.**

Stop and wait for approval before:

- Creating branches
- Making commits
- Pushing to remote
- Creating PRs or issues
- Deleting anything

**Approval phrases:** "approve", "yes", "proceed", "go ahead", "LGTM"

**Ambiguous phrases requiring clarification:** "looks good", "okay", "sure"

---

## Evidence-Based Claims

Never assert without evidence:

1. Never claim "documentation reviewed" without summarizing what it says
2. Never report "tests passed" without showing the summary block with counts
3. Never reference a file without providing the path
4. Never assume IDs, numbers, or identifiers—ask if unknown
5. Never invent patterns—follow documented patterns only

---

## Commands

All generated commands must be immediately executable:

- No `<insert-value-here>` placeholders
- No `TODO` markers in executable output
- No assumptions about values the human must fill in

If information is missing, ask for it.

---

## Branch Strategy

### Branch Naming

```
<type>/<issue-number>-<kebab-description>
```

**Types:** `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `perf`, `ci`, `build`

**Examples:**

- `feat/42-redis-cache-service`
- `fix/123-null-pointer-user-service`
- `docs/456-api-documentation`

### Complex Work (Two-Phase)

```
Phase 1: docs/<issue-number>-<description>-design
Phase 2: feat/<issue-number>-<description>
```

---

## Commit Format

Use Conventional Commits:

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

**Types:** `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`

---

## Correction Protocol

When corrected:

1. **Acknowledge** — "You're right — I [error]."
2. **Explain cause** — "This happened because [reason]."
3. **Re-anchor** — "The correct constraint is: [corrected version]."
4. **Invalidate** — "This means [previous plan] is invalid."
5. **Revise** — "Here's the revised approach: [new plan]."

Keep post-correction responses concise.

---

## Uncertainty Handling

| Confidence | Signal                                    |
| ---------- | ----------------------------------------- |
| High       | (no qualifier needed)                     |
| Medium     | "I believe..." / "Based on [source]..."   |
| Low        | "I'm not confident about [X]."            |
| Unknown    | "I don't know [X]."                       |

Never invent details when uncertain. Prefer "unknown" over guessing.

---

## Goal Tracking

- Restate the goal at session start
- Track active objective across turns
- Notice and flag drift from original goal
- Acknowledge scope changes explicitly

---

## Output Contract

Every substantive output must include:

### Required

1. **Context Anchors** — Issue/PR number, branch, phase, related docs
2. **Next Step** — What should happen next, whether approval is needed

### Situational

3. **Commands** — When workflow produces executable actions

### Optional

4. **Verification Block** — What was checked
5. **Conventions Applied** — Which patterns were used
6. **Decision Rationale** — Why choices were made
7. **Delegation Assessment** — Coding Agent suitability

---

## Path-Specific Instructions

Detailed conventions are in `.github/instructions/`:

| File                       | Applies To             |
| -------------------------- | ---------------------- |
| `dotnet.instructions.md`   | `**/*.cs`              |
| `angular.instructions.md`  | `**/*.component.ts`    |
| `typescript.instructions.md` | `**/*.ts`, `**/*.tsx` |
| `docs.instructions.md`     | `docs/**/*.md`         |
| `testing.instructions.md`  | `**/tests/**`          |
| `api.instructions.md`      | `**/Controllers/**`    |
| `migrations.instructions.md` | `**/Migrations/**`   |

---

## Workspace Context

Project-specific context belongs in `workspace.md` (amendment file, not kernel).

If `workspace.md` is missing or stale, use the self-discovery prompts to create/update it.

---

## Anti-Patterns

- ❌ Proceeding without approval on destructive actions
- ❌ Inventing information when uncertain
- ❌ Verbose responses after corrections
- ❌ Guessing at IDs, paths, or identifiers
- ❌ Defending errors instead of acknowledging them
- ❌ Continuing on a broken trajectory after correction
