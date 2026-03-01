# Authoring Instructions

> How to create and edit AI instruction files in this workspace.

See [Instruction Model](../architecture/instruction-model.md) for the conceptual overview of the four layers.

---

## Which Files to Edit

| What you want to change                          | Files to edit                                                             | Runtimes affected |
| ------------------------------------------------ | ------------------------------------------------------------------------- | ----------------- |
| Global behavior (axioms, output format, process) | `CLAUDE.md`, `.github/copilot-instructions.md`, `.junie/guidelines.md`    | All three         |
| Technology rules (TypeScript, .NET, etc.)        | `.github/instructions/<name>.instructions.md` + `.claude/rules/<name>.md` | Copilot + Claude  |
| Agent definitions                                | `.github/agents/<name>.agent.md` + `.claude/agents/<name>.md`             | Copilot + Claude  |
| Skills / Prompts                                 | `.github/prompts/<name>.prompt.md` + `.claude/skills/<name>/SKILL.md`     | Copilot + Claude  |

Junie only uses the global instructions file (`.junie/guidelines.md`). It has no support for agents, rules, or skills.

---

## Creating a New Agent

Create two files — one for each runtime that supports agents.

### 1. Copilot agent: `.github/agents/<name>.agent.md`

```yaml
---
name: Your Agent Name
description: One-line description of what this agent does.
tools:
  - edit
  - execute
  - search
  - todo
handoffs:
  - label: "Descriptive label"
    agent: "Target Agent"
    prompt: "What to tell the target agent"
---
```

### 2. Claude agent: `.claude/agents/<name>.md`

```yaml
---
name: Your Agent Name
description: One-line description of what this agent does.
tools: Read, Write, Edit, Bash, Grep, Glob
---
```

### Body content (shared structure)

Both files use the same body structure:

```markdown
# Agent Name

Role description paragraph.

## Constraints

**You MUST NOT:**

- Constraint 1
- Constraint 2

**You MUST:**

- Requirement 1
- Requirement 2

## Rules

- Rule 1
- Rule 2

## Output Format

(markdown template for this agent's output)
```

**Key differences:**

- Copilot uses `handoffs:` in frontmatter for agent-to-agent transitions
- Claude uses a `## Delegation` body section referencing the Task tool

---

## Creating a New Skill / Prompt

### 1. Copilot prompt: `.github/prompts/<name>.prompt.md`

```yaml
---
description: One-line description of what this workflow does
---
```

### 2. Claude skill: `.claude/skills/<name>/SKILL.md`

Note the directory structure — each skill lives in its own folder.

```yaml
---
name: Skill Name
description: One-line description.
context: fork
agent: Primary Agent Name
---
```

### Body content

Both use a multi-phase structure with checkpoints:

```markdown
# Skill Name

Overview paragraph.

**Prerequisites:** What's needed before starting.

---

## Phase 1: Name

### Steps

1. Step one
2. Step two

### Output

(markdown template)

### ⛔ CHECKPOINT

**STOP.** Await approval before proceeding.

---

## Phase 2: Name

(repeat pattern)
```

---

## Creating Path-Specific Rules

### 1. Copilot: `.github/instructions/<name>.instructions.md`

```yaml
---
applyTo: "**/*.ts,**/*.tsx"
---
```

### 2. Claude: `.claude/rules/<name>.md`

```yaml
---
paths:
  - "**/*.ts"
  - "**/*.tsx"
---
```

Body content is identical between runtimes — technology-specific conventions and examples.

---

## Testing Changes

| Runtime     | How to verify                                                                                            |
| ----------- | -------------------------------------------------------------------------------------------------------- |
| **Copilot** | Restart VS Code. Agents appear in the agent picker (`@agent-name`). Prompts appear in the prompt picker. |
| **Claude**  | Start a new conversation. Skills invoked with `/skill:name`. Agents with `/agent:name`.                  |
| **Junie**   | Restart the IDE. Guidelines loaded automatically.                                                        |

**Tip:** VS Code scans both `.github/agents/` and `.claude/agents/` — agents may appear twice in the picker. This is expected VS Code behavior, not a bug.

---

## Propagating to Template Repos

When you've authored or edited instruction files in this workspace (template-workspace), they need to be copied to the template repositories for consumers to receive them.

1. Copy the files to the template repo
2. Replace workspace-specific values with `{{{tokens}}}` where needed
3. Commit and push the template repo

The Workspace Configurator agent can assist with this process.

---

## Related

- [Instruction Model](../architecture/instruction-model.md) — The four layers explained
- [File Ownership](../architecture/file-ownership.md) — Which files are template-provided vs consumer-owned
- [Configuration](../architecture/configuration.md) — How agents consume workspace config
