# Instruction Model

> How AI behavior is defined across runtimes in this workspace.

---

## The Four Layers

AI instructions are organized in four layers, from broadest to most specific:

| Layer                   | Purpose                                                                                                   | When active                             |
| ----------------------- | --------------------------------------------------------------------------------------------------------- | --------------------------------------- |
| **Global instructions** | Baseline behavior for every interaction — axioms, output format, workspace awareness, process conventions | Always loaded by the runtime            |
| **Path-specific rules** | Technology conventions activated by file patterns (e.g., TypeScript, .NET, Angular)                       | When editing files matching the pattern |
| **Agents**              | Focused roles with constraints, delegation rules, and specialized output formats                          | When invoked by name                    |
| **Skills / Prompts**    | Multi-phase structured workflows with checkpoints and approval gates                                      | When explicitly triggered               |

Layers compose additively. An agent interaction includes global instructions + any active path-specific rules + the agent definition. A skill invocation includes all of those plus the skill/prompt definition.

---

## Per-Runtime Structure

Each AI runtime uses different file paths and formats for the same conceptual layers:

| Layer               | GitHub Copilot                           | Claude Code                 | JetBrains Junie        |
| ------------------- | ---------------------------------------- | --------------------------- | ---------------------- |
| Global instructions | `.github/copilot-instructions.md`        | `CLAUDE.md`                 | `.junie/guidelines.md` |
| Path-specific rules | `.github/instructions/*.instructions.md` | `.claude/rules/*.md`        | _(none)_               |
| Agents              | `.github/agents/*.agent.md`              | `.claude/agents/*.md`       | _(none)_               |
| Skills / Prompts    | `.github/prompts/*.prompt.md`            | `.claude/skills/*/SKILL.md` | _(none)_               |

Junie currently supports only global instructions — a single monolithic file. Copilot and Claude support all four layers but with different frontmatter schemas.

---

## Current Inventory

| Layer               | Copilot | Claude | Junie |
| ------------------- | ------- | ------ | ----- |
| Global instructions | 1       | 1      | 1     |
| Path-specific rules | 10      | 10     | —     |
| Agents              | 19      | 19     | —     |
| Skills / Prompts    | 14      | 13     | —     |

Path-specific rules have identical body content across runtimes — only the frontmatter differs.

Agent definitions share ~80% of their body content. The structural differences are in frontmatter and delegation:

- Copilot agents use `handoffs:` for agent-to-agent transitions
- Claude agents use `## Delegation` sections referencing the Task tool

---

## Frontmatter Reference

### Agents

**Copilot** (`.github/agents/*.agent.md`):

```yaml
---
name: Implementer
description: Write code and make file changes following plans.
tools:
  - edit
  - execute
  - search
  - todo
handoffs:
  - label: "Test verification"
    agent: "Test"
    prompt: "Write tests for the implemented changes"
---
```

**Claude** (`.claude/agents/*.md`):

```yaml
---
name: Implementer
description: Write code and make file changes following plans.
tools: Read, Write, Edit, Bash, Grep, Glob
---
```

### Path-Specific Rules

**Copilot** (`.github/instructions/*.instructions.md`):

```yaml
---
applyTo: "**/*.ts,**/*.tsx"
---
```

**Claude** (`.claude/rules/*.md`):

```yaml
---
paths:
  - "**/*.ts"
  - "**/*.tsx"
---
```

### Skills / Prompts

**Copilot** (`.github/prompts/*.prompt.md`):

```yaml
---
description: From issue selection to implementation completion
---
```

**Claude** (`.claude/skills/*/SKILL.md`):

```yaml
---
name: Issue
description: From issue selection to implementation completion.
context: fork
agent: Orchestrator
---
```

---

## Related

- [Configuration](configuration.md) — How workspace-specific values reach agents
- [File Ownership](file-ownership.md) — Which files come from the template vs consumer
- [Authoring Instructions](../guides/authoring-instructions.md) — How to create and edit instruction files
