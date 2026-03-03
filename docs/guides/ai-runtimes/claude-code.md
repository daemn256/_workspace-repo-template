# Claude Code — AI Runtime Reference

> Comprehensive reference for the Claude Code AI runtime. Covers memory hierarchy, subagent model, skill system, and optimization guidance.
>
> **Last verified:** March 2026

---

## Overview

Claude Code is the second active AI runtime in this workspace. It runs as a terminal-native agent with full IDE integration (VS Code, JetBrains, desktop app). Claude Code uses a hierarchical memory model, subagent delegation via the Task tool, and a permission system that distinguishes it from other runtimes.

---

## Configuration Surface

| Artifact        | Location                                                        | Format                                               | Scope                     |
| --------------- | --------------------------------------------------------------- | ---------------------------------------------------- | ------------------------- |
| Project Memory  | `CLAUDE.md` or `.claude/CLAUDE.md`                              | Plain Markdown (supports `@import` syntax)           | All sessions in project   |
| Modular Rules   | `.claude/rules/*.md`                                            | Optional YAML frontmatter (`paths:` glob) + Markdown | Conditional or global     |
| Subagents       | `.claude/agents/*.md`                                           | YAML frontmatter + Markdown body                     | Per-project               |
| Skills          | `.claude/skills/<name>/SKILL.md`                                | YAML frontmatter + Markdown body + supporting files  | Per-project or user-level |
| Settings        | `.claude/settings.json`                                         | JSON (permissions, hooks, env)                       | Per-project               |
| MCP Servers     | `.mcp.json`                                                     | JSON                                                 | Per-project               |
| Local Overrides | `CLAUDE.local.md`, `.claude/settings.local.json`                | Same formats, gitignored                             | Personal per-project      |
| User-Level      | `~/.claude/CLAUDE.md`, `~/.claude/agents/`, `~/.claude/skills/` | Same formats                                         | All your projects         |

---

## Workspace Inventory

This workspace's current Claude Code instruction files:

| Layer               | Files                       | Count |
| ------------------- | --------------------------- | ----- |
| Project memory      | `CLAUDE.md`                 | 1     |
| Path-specific rules | `.claude/rules/*.md`        | 17    |
| Subagents           | `.claude/agents/*.md`       | 6     |
| Skills              | `.claude/skills/*/SKILL.md` | 20    |

---

## Memory Hierarchy

Claude Code uses a hierarchical memory model (later overrides earlier):

1. **Managed Policy** — Organization-level CLAUDE.md (admin-controlled)
2. **Project Memory** — `CLAUDE.md` at project root
3. **Project Rules** — `.claude/rules/*.md` (path-scoped via `paths:` frontmatter)
4. **User Memory** — `~/.claude/CLAUDE.md` (personal, all projects)
5. **Local Memory** — `CLAUDE.local.md` (personal, per-project, gitignored)
6. **Auto Memory** — `~/.claude/projects/<project>/memory/` (auto-generated)

### Composition with `@import`

`CLAUDE.md` supports `@path/to/file` syntax for composing from multiple files:

```markdown
# Project Instructions

@docs/conventions.md
@.claude/rules/overview.md
```

---

## Schema Details

### Subagent Files (`.claude/agents/*.md`)

```yaml
---
name: <string> # Display name
description: <string> # Brief description
tools: <string> # Comma-separated allowlist (e.g., "Read, Grep, Glob")
disallowedTools: <string> # Comma-separated denylist
model: <string> # sonnet | opus | haiku | inherit
permissionMode: <string> # default | acceptEdits | dontAsk | delegate | bypassPermissions | plan
maxTurns: <number> # Maximum conversation turns
skills: # Preloaded skills (optional)
  - <skill-name>
mcpServers: # MCP server references (optional)
  - <server-name>
hooks: <object> # Hooks scoped to this subagent
memory: <string> # Memory scope: user | project | local
background: <boolean> # Run as background task
isolation: <string> # Isolation mode: worktree
---
<Markdown body = system prompt for the subagent>
```

**Format note:** `tools` and `disallowedTools` use **comma-separated strings**, not YAML arrays.
Example: `tools: Bash, Read, Write, Edit, Grep`

### Skill Files (`.claude/skills/<name>/SKILL.md`)

```yaml
---
name: <string> # Display name
description: <string> # Brief description
argument-hint: <string> # Input placeholder
disable-model-invocation: <boolean> # Prevent auto-invocation
user-invocable: <boolean> # Show in skill picker
allowed-tools: <string> # Comma-separated tool subset
model: <string> # Model override
context: <string> # "fork" for subagent execution
agent: <string> # Run as specific subagent
hooks: <object> # Skill-scoped hooks
---
<Markdown body = skill instructions>
```

**Format note:** `allowed-tools` uses a comma-separated string, same as subagent `tools`.

Skills may include supporting files alongside SKILL.md. Dynamic context injection via `` !`command` `` syntax.

### Rules Files (`.claude/rules/*.md`)

```yaml
---
paths:
  - "**/*.ts"
  - "**/*.tsx"
---
<Markdown body = rule content applied when matching files are active>
```

The `paths:` frontmatter is analogous to GitHub Copilot's `applyTo:` glob pattern. Unlike Copilot, `paths:` uses a **YAML array** (not a comma-separated string).

### Settings (`.claude/settings.json`)

```json
{
  "permissions": {
    "allow": ["Read", "Glob", "Grep", "WebFetch"],
    "ask": ["Write", "Edit", "Bash(npm *)"],
    "deny": ["Bash(rm -rf *)"]
  },
  "hooks": {},
  "env": { "KEY": "value" },
  "model": "sonnet"
}
```

Permission rules support tool-level granularity: `"Tool"` or `"Tool(specifier)"`.

---

## Tool Model

Claude Code has built-in tools (not alias-based like Copilot):

| Tool           | Purpose                             |
| -------------- | ----------------------------------- |
| `Bash`         | Execute shell commands              |
| `Read`         | Read file contents                  |
| `Write`        | Create/overwrite files              |
| `Edit`         | Modify existing files               |
| `Glob`         | Find files by pattern               |
| `Grep`         | Search file contents                |
| `Task`         | Launch subagent tasks               |
| `WebFetch`     | Fetch web page contents             |
| `WebSearch`    | Search the web                      |
| `LSP`          | Language Server Protocol operations |
| `NotebookEdit` | Edit Jupyter notebooks              |
| `Skill`        | Invoke a skill                      |

Additional tools: `TaskCreate`, `TaskGet`, `TaskList`, `TaskUpdate`, `AskUserQuestion`, `MCPSearch`, `KillShell`, `ExitPlanMode`, `TaskOutput`.

---

## Hooks System

Claude Code supports 14 hook events with command, prompt, and agent hook types:

| Event                | Trigger                          |
| -------------------- | -------------------------------- |
| `SessionStart`       | When a session begins            |
| `UserPromptSubmit`   | When user submits a prompt       |
| `PreToolUse`         | Before any tool executes         |
| `PermissionRequest`  | When a permission check occurs   |
| `PostToolUse`        | After tool completes             |
| `PostToolUseFailure` | After tool fails                 |
| `Notification`       | When a notification is generated |
| `SubagentStart`      | When a subagent starts           |
| `SubagentStop`       | When a subagent stops            |
| `Stop`               | When the agent stops             |
| `TeammateIdle`       | When a teammate becomes idle     |
| `TaskCompleted`      | When a task completes            |
| `PreCompact`         | Before context compaction        |
| `SessionEnd`         | When a session ends              |

Hooks support matcher patterns (regex) for filtering. Exit codes: 0 = allow, 2 = block.

Hooks can be scoped at: user, project, local, managed, plugin, skill, or agent frontmatter level.

---

## VS Code Interoperability

VS Code (with GitHub Copilot) natively detects `.claude/agents/*.md` files and registers them as custom agents in the Copilot Chat picker. This is an intentional interop feature.

**What VS Code uses from Claude agent files:**

| Claude Field    | VS Code Behavior                                    |
| --------------- | --------------------------------------------------- |
| `name`          | Agent name in picker                                |
| `description`   | Placeholder text in chat input                      |
| `tools`         | Mapped to VS Code tool equivalents via name mapping |
| Body (markdown) | Used as system prompt / instructions                |

**What VS Code ignores (Claude-specific, no equivalent):**

- `skills` — Claude Code skill system
- `hooks` — Lifecycle hooks
- `memory` — Cross-session learning
- `background` — Background task execution
- `isolation` — Worktree sandboxing
- `permissionMode` — Claude Code permission system
- `maxTurns` — Turn limits

**Model independence:** VS Code's agent detection is model-agnostic — Claude agent files work with any model selected in the VS Code model picker.

---

## Optimization Tips

### Project Memory (`CLAUDE.md`)

- **Keep it concise.** `CLAUDE.md` is loaded in every interaction. Verbose content burns context tokens on every turn.
- **Use `@import` for modular composition** — reference detailed docs instead of inlining everything.
- **Put most-critical rules first.** Instructions earlier in the file get more attention from the model.
- **Use `.claude/rules/` for domain-specific content** rather than putting everything in `CLAUDE.md`.

### Subagent Files

- **Use comma-separated strings for `tools`**, not YAML arrays: `tools: Bash, Read, Write`, not `tools: [Bash, Read]`.
- **Grant minimal tools.** Use `disallowedTools` to block dangerous operations rather than trying to enumerate all allowed ones.
- **Set `permissionMode` appropriately.** Use `acceptEdits` for agents that primarily write files; use `plan` for analysis-only agents.
- **Set `maxTurns`** for agents that tend to loop — prevents runaway token usage.

### Skills

- **Use `context: fork`** for skills that should run as subagent tasks — this gives them a fresh context without polluting the main conversation.
- **Set `agent:`** to run a skill in the context of a specific subagent (inherits its tools, permissions, and system prompt).
- **Include supporting files** alongside SKILL.md — they're automatically included in the skill's context.

### Rules

- **Use `paths:` as YAML arrays** (unlike Copilot's comma-separated string for `applyTo`).
- **Rules without `paths:` frontmatter** are global — they load for every file, same as putting the content in `CLAUDE.md`.
- **Name rules descriptively** — the filename helps humans find and maintain them.

### Permissions

- **Start with `ask` for destructive operations** — `Bash(rm *)`, `Bash(git push --force)`.
- **Use `allow` for common safe operations** — `Read`, `Glob`, `Grep`.
- **Use tool specifiers for granularity** — `Bash(npm test)` allows only that specific command.

---

## Known Limitations & Gotchas

| Issue                                  | Details                                                                                                         |
| -------------------------------------- | --------------------------------------------------------------------------------------------------------------- |
| `tools` must be comma-separated string | YAML arrays in `tools:` cause parsing errors — use `tools: Read, Write, Edit`                                   |
| VS Code interop is degraded            | `.claude/agents/` files work in Copilot Chat but without handoffs, model selection, or Claude-specific features |
| Double registration in VS Code         | Same persona in both `.github/agents/` and `.claude/agents/` appears twice in the picker                        |
| `@import` paths are relative           | Paths in `CLAUDE.md` are relative to the file location, not the project root                                    |
| Auto memory can drift                  | `~/.claude/projects/*/memory/` may accumulate stale preferences that override project rules                     |
| `context: fork` creates a subagent     | The skill runs in a separate context — it can't see or modify the parent conversation                           |

---

## Official Documentation

- [Claude Code Settings](https://code.claude.com/docs/en/settings)
- [Sub-agents](https://code.claude.com/docs/en/sub-agents)
- [Memory](https://code.claude.com/docs/en/memory)
- [Skills](https://code.claude.com/docs/en/skills)
- [Hooks](https://code.claude.com/docs/en/hooks)
- [Agent Skills Standard](https://agentskills.io)
