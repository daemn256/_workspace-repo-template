---
name: session-start
description: Initialize a session with workspace context and prior state.
---

# Session Start

The Orchestrator drives this workflow. Load workspace context, prior session state, and establish the session goal.

**Prerequisites:** Access to workspace configuration files.

---

## Phase 1: Load Context

Read workspace files and check for prior sessions.

### Steps

1. Read `workspace.config.yaml` — process profile, forge topology, board IDs, AI runtimes, commands
2. Read `docs/workspace/context.md` — tech stack, domain terms, architecture, key conventions
3. Read `docs/workspace/goals.md` — current priorities and active work (if exists)
4. List files in `.tmp/sessions/` — read the most recent handoff artifact if any exist
5. Note any incomplete work or open questions from prior sessions

---

## Phase 2: Establish Session

Summarize context and confirm the goal.

### Steps

1. State the process profile and its implications
2. Note active AI runtimes
3. Identify current priorities from goals.md
4. Flag any carry-over from prior sessions
5. Confirm the session goal with the user

### Output

```markdown
## Context Anchors

- **Issue:** #<number> - <title> (if applicable)
- **Branch:** <active branch> (if applicable)
- **Prior Session:** <session file> (if applicable)

## Session Context

**Process Profile:** <lightweight | standard | regulated>
**AI Runtimes:** <list>
**Active Priorities:**

- <priority 1>
- <priority 2>

## Carry-Over (if any)

- <incomplete item from prior session>

## Session Goal

<Clear statement of what this session aims to accomplish>

## Next Step

<First action toward the goal>

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Confirm the session goal before proceeding to execution.

---

## Error Handling

| Situation                     | Recovery                            |
| ----------------------------- | ----------------------------------- |
| workspace.config.yaml missing | Ask user to run setup-workspace     |
| goals.md missing or empty     | Ask user for current priorities     |
| Prior session file is stale   | Verify current state before acting  |
| Context files are outdated    | Use refresh-context skill to update |
