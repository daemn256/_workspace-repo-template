# Claude Code — AI Runtime Reference

> Comprehensive reference for the Claude Code AI runtime. Covers memory hierarchy, subagent model, skill system, and optimization guidance.
>
> **Last verified:** March 9, 2026

---

## Overview

Claude Code is the second active AI runtime in this workspace. It runs as a terminal-native agent with full IDE integration (VS Code, JetBrains, desktop app). Claude Code uses a hierarchical memory model, subagent delegation via the Agent tool, and a permission system that distinguishes it from other runtimes.

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

## Subagent Execution Model

### Built-in Subagents

Claude Code includes built-in subagents that Claude delegates to automatically:

| Subagent            | Model        | Tools                          | Purpose                                           |
| ------------------- | ------------ | ------------------------------ | ------------------------------------------------- |
| **Explore**         | Haiku (fast) | Read-only (denied Write, Edit) | File discovery, code search, codebase exploration |
| **Plan**            | (inherit)    | Read-only                      | Analysis, planning, research                      |
| **general-purpose** | (inherit)    | All inherited                  | General task delegation                           |

### Execution Semantics

- **Isolated context:** Subagents receive only their system prompt (plus basic environment info like working directory), NOT the full Claude Code system prompt or parent conversation history.
- **Foreground (blocking):** By default, the parent blocks until the subagent completes. Permission prompts and clarifying questions pass through to the user.
- **Background (concurrent):** With `background: true` or user request, subagents run concurrently. Background subagents get upfront permission approval and auto-deny anything not pre-approved.
- **Nesting prohibition:** Subagents cannot spawn other subagents. If your workflow requires nested delegation, chain subagents from the main conversation or use skills instead.
- **Resume:** Subagents can be resumed with their full conversation history intact. Transcripts persist at `~/.claude/projects/{project}/{sessionId}/subagents/`.

### Skill Preloading

The `skills:` field in subagent frontmatter injects full skill content into the subagent's context at startup:

```yaml
skills:
  - api-conventions
  - error-handling-patterns
```

Key behavior:

- The **full content** of each skill is injected, not just made available for invocation
- Subagents do **not** inherit skills from the parent conversation — list them explicitly
- Compare with `context: fork`, where the skill body becomes the subagent's prompt — `skills:` injects content into an existing subagent definition, while `context: fork` creates one on the fly

### Restricting Subagent Spawning

Use `Agent(agent_type)` syntax in the `tools` field to control which subagents can be spawned:

```yaml
tools: Agent(worker, researcher), Read, Bash
```

- `Agent(name1, name2)` — allowlist: only named subagents can be spawned
- `Agent` (without parentheses) — any subagent can be spawned
- Omit `Agent` entirely — the agent cannot spawn subagents
- `Agent(agent_type)` has **no effect in subagent definitions** (because subagents can't nest)

### Disabling Subagents

Add subagents to the `deny` array in settings: `"Agent(Explore)"`, `"Agent(my-custom-agent)"`.

---

## Bundled Skills

Claude Code ships with built-in skills available in every session:

| Skill                        | Purpose                                                                                        |
| ---------------------------- | ---------------------------------------------------------------------------------------------- |
| `/simplify`                  | Reviews recently changed files for code reuse, quality, and efficiency. Spawns 3 parallel review agents. |
| `/batch <instruction>`       | Orchestrates large-scale parallel changes across a codebase. Each unit runs in an isolated git worktree. |
| `/debug [description]`       | Troubleshoots the current session by reading the debug log.                                    |
| `/loop [interval] <prompt>`  | Runs a prompt on a recurring schedule (e.g., `/loop 5m check if the deploy finished`).        |
| `/claude-api`                | Loads Claude API + Agent SDK reference. Auto-activates when importing `anthropic` or `claude_agent_sdk`. |

> Bundled skill descriptions reflect Claude Code v2.1.63. Behavioral details (e.g., parallel agent count, worktree isolation) may change between versions.

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
| `Agent`        | Launch subagent tasks               |
| `WebFetch`     | Fetch web page contents             |
| `WebSearch`    | Search the web                      |
| `LSP`          | Language Server Protocol operations |
| `NotebookEdit` | Edit Jupyter notebooks              |
| `Skill`        | Invoke a skill                      |

Additional tools: `TaskCreate`, `TaskGet`, `TaskList`, `TaskUpdate`, `AskUserQuestion`, `MCPSearch`, `KillShell`, `ExitPlanMode`, `TaskOutput`.

**Rename note:** The Task tool was renamed to Agent in v2.1.63. Existing `Task(...)` references in settings and agent definitions still work as aliases.

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

- **Use `context: fork`** to run a skill in an isolated subagent context. The skill's SKILL.md content becomes the subagent's prompt. Use `agent:` to specify which subagent type executes it (defaults to `general-purpose`). Available built-in agents: `Explore`, `Plan`, `general-purpose`, or any custom subagent from `.claude/agents/`.
- **Set `agent:`** to run a skill in the context of a specific subagent (inherits its tools, permissions, and system prompt).
- **Include supporting files** alongside SKILL.md — they're automatically included in the skill's context.
- **Mind the description budget.** Skill descriptions are loaded into context so the model knows what's available. The budget scales at **2% of the context window** (fallback: ~16,000 characters). Run `/context` to check for warnings about excluded skills. Override with `SLASH_COMMAND_TOOL_CHAR_BUDGET` environment variable.

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
| Subagents cannot nest                  | Subagents cannot spawn other subagents — `Agent(type)` in subagent `tools` has no effect                       |

---

## Official Documentation

- [Claude Code Settings](https://code.claude.com/docs/en/settings)
- [Sub-agents](https://code.claude.com/docs/en/sub-agents)
- [Memory](https://code.claude.com/docs/en/memory)
- [Skills](https://code.claude.com/docs/en/skills)
- [Hooks](https://code.claude.com/docs/en/hooks)
- [Agent Skills Standard](https://agentskills.io)
