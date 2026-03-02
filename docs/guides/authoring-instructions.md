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
name: skill-name
description: One-line description.
---
```

**Note:** The `name` must match the folder name exactly (lowercase, kebab-case).

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

When you've authored or edited instruction files in this workspace, propagate them to template repositories using the manifest-driven sync:

1. Run `tools/sync-to-templates.sh --dry-run` to preview what will change
2. Review the output — verify copy/scaffold/skip counts look correct
3. Run `tools/sync-to-templates.sh` to execute the sync
4. Run `tools/validate-templates.sh` to verify template health
5. Commit changes in each template repo

The `/sync-templates` workflow automates this process with checkpoints at each step.

### How propagation works

The `template-manifest.yaml` at the workspace root declares rules for each file:

| Action       | Behavior                                                                   |
| ------------ | -------------------------------------------------------------------------- |
| **copy**     | File is copied verbatim — it uses config-references, not embedded values   |
| **scaffold** | An example version is copied from `scaffolds/` — consumer fills in details |
| _(unlisted)_ | File is ignored — it's consumer-only and never propagated                  |

See [Operating Model](../architecture/operating-model.md) for full details.

---

## Creating Scaffold Files

Scaffold files provide example versions of consumer-owned files. They live in `scaffolds/` and are copied to template repos during sync. Consumers replace the placeholder content with their real values.

### When to create a scaffold

- The file contains project-specific data (IDs, names, domain terms)
- The file's structure matters but its content varies per workspace
- Consumers need a starting template to fill in

Common scaffold candidates: `workspace.config.yaml`, `README.md`, `CHANGELOG.md`, `docs/workspace/*.md`, `.vscode/tasks.json`.

### Directory structure

```
scaffolds/
├── common/          # Used by all targets (both root and repo)
│   ├── workspace.config.yaml
│   ├── CHANGELOG.md
│   └── docs/workspace/goals.md
├── root/            # Root workspace overrides (multi-repo)
│   ├── README.md
│   ├── .vscode/tasks.json
│   └── docs/workspace/context.md
└── repo/            # Repo workspace overrides (single-repo)
    ├── README.md
    ├── .vscode/tasks.json
    └── docs/workspace/context.md
```

### Resolution order

When syncing to a target (e.g., `root`):

1. Check `scaffolds/root/<path>` — if it exists, use it
2. Fall back to `scaffolds/common/<path>` — if it exists, use it
3. If neither exists and the manifest says `scaffold`, the validation tool will flag an error

### Creating a new scaffold

1. **Decide placement** — same for both targets → `common/`, differs → target-specific
2. **Create the file** at the appropriate path under `scaffolds/`
3. **Content rules:**
   - Use placeholder values, never real consumer data
   - Include comments explaining what to customize
   - Follow the same format/schema as the real file
   - Keep it minimal but complete enough to be useful
4. **Add a manifest rule** if one doesn't already exist for this path:
   ```yaml
   - pattern: "path/to/file"
     action: scaffold
   ```
5. **Verify** — run `tools/sync-to-templates.sh --dry-run` and `tools/validate-templates.sh`

The `/scaffold-file` workflow guides you through this process interactively.

### Example scaffold content

**YAML config** — valid YAML with placeholder values and inline comments:

```yaml
# workspace.config.yaml — Fill in your project's values
project:
  name: my-project # Your project name
  description: "A brief description of this project"
```

**Markdown doc** — section headers with TODO guidance:

```markdown
# Goals

<!-- TODO: Add your current project priorities below -->

## Current Milestone

_No active milestone defined yet._
```

---

## Related

- [Instruction Model](../architecture/instruction-model.md) — The four layers explained
- [Operating Model](../architecture/operating-model.md) — Manifest-driven sync and config-reference patterns
- [File Ownership](../architecture/file-ownership.md) — Copy, scaffold, and ignore tiers
- [Configuration](../architecture/configuration.md) — How agents consume workspace config
