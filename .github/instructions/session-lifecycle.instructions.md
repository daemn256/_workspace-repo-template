---
applyTo: "**"
---

# Session Lifecycle

> Phases of an AI agent session — from initialization through closure. Governs how agents enter, operate, and exit sessions.

## Phases

### Initialization

Load context and establish the session goal.

- Read workspace context (`workspace.config.yaml`, `docs/workspace/context.md`, `docs/workspace/goals.md`)
- Read active sprint state (`.tmp/workspace/goals.md`) if available
- Load prior session handoff artifact if available (`.tmp/sessions/`)
- Restate the goal and active constraints
- Acknowledge approval gates and conventions

→ Transitions to: **Execution**

### Execution

Perform incremental work toward the session goal.

- Work in small, reviewable steps
- Maintain a todo list for multi-step tasks
- Request approval at destructive action gates
- Produce intermediate artifacts (code, docs, commits)

→ Transitions to: **Handoff** (normal exit), **Interrupted** (context limit, error, user abort)

### Interrupted

Session ended before completing planned work.

- Produce a partial handoff artifact with current state
- Flag incomplete work and next steps

→ Transitions to: **Handoff**

### Handoff

Produce a handoff artifact for the next session to resume with full context.

- Enumerate files touched, decisions made, open questions
- Update `.tmp/workspace/goals.md` with current sprint state
- Store session handoff in `.tmp/sessions/` (ephemeral)
- Document concrete next steps

→ Transitions to: **Closure**

### Closure

Session complete. Handoff artifact produced. Terminal state.

## Knowledge Gates

| Transition  | Required Artifact                         |
| ----------- | ----------------------------------------- |
| → Execution | Session goal stated, context acknowledged |
| → Handoff   | Handoff artifact produced                 |
| → Closure   | Next steps documented                     |

## Context Contracts

**What the agent receives (Initialization):**

| Source                      | Content                          | Durability |
| --------------------------- | -------------------------------- | ---------- |
| `workspace.config.yaml`     | Process profile, forge topology  | Durable    |
| `docs/workspace/context.md` | Project context, terminology     | Durable    |
| `docs/workspace/goals.md`   | Milestones, tech debt, backlog   | Durable    |
| `.tmp/workspace/goals.md`   | Active sprint, current focus     | Ephemeral  |
| `.tmp/sessions/<id>.md`     | Prior session's handoff artifact | Ephemeral  |

**What the agent produces (Handoff):**

| Field          | Required | Description                                          |
| -------------- | -------- | ---------------------------------------------------- |
| Summary        | Yes      | What was accomplished this session                   |
| Files Touched  | Yes      | Files created, modified, or deleted (relative paths) |
| Decisions Made | If any   | Key decisions with rationale                         |
| Next Steps     | Yes      | Ordered by priority, each actionable                 |
| Open Questions | If any   | Unresolved items needing human input                 |
| Blocked On     | If any   | What blocks further progress                         |
| Active Branch  | If any   | Git branch being worked on                           |

## Session Tracking

> When and how to create session files for cross-session continuity.

### When to Create a Session File

| Trigger                            | Example                                         |
| ---------------------------------- | ----------------------------------------------- |
| Multi-turn work on a tracked issue | Working on #42 across several conversations     |
| Decisions that need to persist     | Chose architecture A over B — rationale matters |
| Complex multi-step implementation  | 5+ step plan that can't complete in one session |
| Context approaching token limit    | Long conversation near context window           |
| Explicit user request              | "Save session state" or "Create a session file" |

**Do NOT create a session file for:** quick one-off questions, simple single-turn edits, or work fully captured by commit messages and PR descriptions.

### File Convention

**Location:** `.tmp/sessions/` (gitignored — ephemeral by design)

**Naming:** `YYYY-MM-DD-<kebab-title>.md`

**Example:** `.tmp/sessions/2026-02-11-process-conventions.md`

If multiple sessions occur on the same date for different topics, use distinct titles. If continuing the same topic, update the existing file.

### Required Sections

| Section        | Required | Guidance                                              |
| -------------- | -------- | ----------------------------------------------------- |
| Context        | Yes      | Issue/PR links, branch, prior sessions                |
| Decisions Made | If any   | Choices with rationale — future sessions need these   |
| Work Completed | Yes      | Checkboxes; unchecked items indicate partial progress |
| Open Questions | If any   | Unresolved items the next session should address      |
| Next Steps     | Yes      | Concrete actions, not vague intentions                |

### Lifecycle

- **Create** at session start when a trigger condition is met
- **Update** incrementally during the session
- **Finalize** at session end — all sections current, next steps concrete
- **Resume** — next session reads the file during initialization
- **Archive** — leave in place (gitignored), delete when merged, or promote durable content to `docs/workspace/context.md` or an ADR
