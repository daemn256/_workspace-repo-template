# GitHub Copilot — AI Runtime Reference

> Comprehensive reference for the GitHub Copilot AI runtime. Covers delivery surfaces, feature matrices, configuration schemas, and optimization guidance.
>
> **Last verified:** March 9, 2026

---

## Overview

GitHub Copilot is the primary AI runtime in this workspace. It operates across multiple delivery surfaces (VS Code, GitHub.com, JetBrains, CLI) with varying feature support. This guide documents native capabilities, configuration schemas, and practical optimization tips for instruction authoring.

---

## Configuration Surface

| Artifact            | Location                                 | Format                                             | Scope                        |
| ------------------- | ---------------------------------------- | -------------------------------------------------- | ---------------------------- |
| Global Instructions | `.github/copilot-instructions.md`        | Plain Markdown                                     | All interactions             |
| Instruction Files   | `.github/instructions/*.instructions.md` | YAML frontmatter (`applyTo:` glob) + Markdown body | Conditional on file pattern  |
| Custom Agents       | `.github/agents/*.agent.md`              | YAML frontmatter + Markdown body                   | Per-workspace                |
| Skills              | `.github/skills/*/SKILL.md`              | YAML frontmatter + Markdown body                   | Per-workspace (VS Code only) |
| AGENTS.md           | Root or any directory                    | Plain Markdown                                     | Governance / onboarding      |
| Setup Steps         | `.github/copilot-setup-steps.yml`        | GitHub Actions YAML                                | Coding Agent environment     |
| MCP Configuration   | `.vscode/mcp.json`                       | JSON                                               | VS Code MCP servers          |

---

## Workspace Inventory

This workspace's current Copilot instruction files:

| Layer               | Files                                    | Count |
| ------------------- | ---------------------------------------- | ----- |
| Global instructions | `.github/copilot-instructions.md`        | 1     |
| Path-specific rules | `.github/instructions/*.instructions.md` | 17    |
| Agents              | `.github/agents/*.agent.md`              | 6     |
| Skills              | `.github/skills/*/SKILL.md`              | 20    |

---

## Delivery Surface Support

GitHub Copilot operates across multiple surfaces with varying feature support:

| Surface           | Context     | Primary Use Case                            |
| ----------------- | ----------- | ------------------------------------------- |
| **VS Code**       | Local IDE   | Interactive development, agent mode         |
| **GitHub.com**    | Web browser | Code review, issue management, Coding Agent |
| **JetBrains**     | Local IDE   | Interactive development                     |
| **Visual Studio** | Local IDE   | Interactive development                     |
| **GitHub CLI**    | Terminal    | Scripted operations                         |

---

## Feature Support Matrices

### Custom Instructions

| Feature                                             | VS Code | GitHub.com Chat | Coding Agent | JetBrains | CLI |
| --------------------------------------------------- | ------- | --------------- | ------------ | --------- | --- |
| Repository-wide (`.github/copilot-instructions.md`) | Yes     | Yes             | Yes          | Yes       | Yes |
| Path-specific (`.instructions.md`)                  | Yes     | No              | Yes          | Yes       | Yes |
| Agent instructions (`AGENTS.md`)                    | Yes     | No              | Yes          | Yes       | Yes |
| Organization instructions                           | No      | Yes             | Yes          | No        | No  |
| `CLAUDE.md` / `GEMINI.md`                           | No      | No              | Yes          | Yes       | Yes |

### Prompt Files

| Feature                     | VS Code | GitHub.com | JetBrains | CLI |
| --------------------------- | ------- | ---------- | --------- | --- |
| Prompt files (`.prompt.md`) | Yes     | No         | No        | No  |
| Slash command invocation    | Yes     | No         | No        | No  |

**Critical**: Prompt files are **VS Code only**. Other surfaces ignore them.

### Custom Agents

| Feature                                  | VS Code | GitHub.com         | JetBrains  | CLI |
| ---------------------------------------- | ------- | ------------------ | ---------- | --- |
| Custom agents (`.agent.md`)              | Yes     | Yes                | Yes (prev) | Yes |
| `name` + `description` (required)        | Yes     | Yes                | Yes        | Yes |
| `tools`                                  | Yes     | Yes                | Yes        | Yes |
| `model`                                  | Yes     | Ignored            | Yes        | No  |
| `handoffs`                               | Yes     | Ignored            | Yes        | No  |
| `target` + `infer`                       | Yes     | Yes                | Yes        | Yes |
| `mcp-servers`                            | No      | Yes (Org/Ent only) | No         | No  |
| `user-invokable` / `disable-model-invoc` | Yes     | Yes                | Yes        | Yes |

**Key**: `model`, `handoffs`, and `argument-hint` are VS Code/JetBrains only — they're silently ignored on other surfaces.

### MCP Support

| Feature     | VS Code          | GitHub.com          | JetBrains |
| ----------- | ---------------- | ------------------- | --------- |
| MCP servers | Yes (`mcp.json`) | Yes (repo settings) | Yes       |
| Tools       | Yes              | Yes                 | Yes       |
| Resources   | Yes              | No                  | No        |
| Prompts     | Yes              | No                  | No        |

### Hooks (Coding Agent + CLI Only)

| Hook                  | Trigger                  | VS Code | Coding Agent | CLI |
| --------------------- | ------------------------ | ------- | ------------ | --- |
| `sessionStart`        | Agent session begins     | No      | Yes          | Yes |
| `sessionEnd`          | Agent session ends       | No      | Yes          | Yes |
| `preToolUse`          | Before any tool executes | No      | Yes          | Yes |
| `postToolUse`         | After tool completes     | No      | Yes          | Yes |
| `userPromptSubmitted` | User submits a prompt    | No      | Yes          | Yes |
| `errorOccurred`       | Error in session         | No      | Yes          | Yes |

---

## Schema Details

### Agent Files (`.agent.md`)

```yaml
---
name: <string> # Display name (required)
description: <string> # Brief description (required)
tools: # Tool alias categories (optional)
  - <alias>
handoffs: # Agent delegation (VS Code/JetBrains only)
  - label: <string>
    agent: <string>
    prompt: <string> # Pre-filled prompt (optional)
    send: <boolean> # Auto-submit (optional)
    model: <string> # Override model for the handoff target (optional)
model: <string|array> # Prioritized model list (optional)
agents: <string> # Subagent allowlist: "*", "[]" (optional)
user-invokable: <boolean> # Show in agent picker (default: true)
disable-model-invocation: <boolean> # Prevent auto-routing (default: false)
target: <string> # Execution target (optional)
mcp-servers: # MCP server references (optional)
  - <server-name>
argument-hint: <string> # Input placeholder text (optional)
---
<Markdown body = agent system prompt>
```

**Deprecated properties:**

- `mode:` → replaced by `agent:` in prompt files
- `infer:` → replaced by `user-invokable` + `disable-model-invocation`
- `.chatmode.md` extension → renamed to `.agent.md`

### Prompt Files (`.prompt.md`)

```yaml
---
description: <string> # Brief description (required)
name: <string> # Display name (optional)
argument-hint: <string> # Placeholder text (optional)
agent: <string> # Target agent: "ask", "agent", "plan", or custom (optional)
model: <string> # Model preference (optional)
tools: # Tool overrides (optional)
  - <alias>
---
<Markdown body = prompt instructions>
```

**Variables:** `${workspaceFolder}`, `${selection}`, `${file}`, `${input:varName}`

**Tool priority:** Prompt tools > Agent tools > Default tools

### Instruction Files (`.instructions.md`)

```yaml
---
applyTo: "<glob-pattern>" # Comma-separated globs (required, must be string)
---
<Markdown body = rule content>
```

**Critical:** `applyTo` must be a **comma-separated string**, not a YAML array.

### Skills (`.github/skills/<name>/SKILL.md`)

Skills extend agent capabilities with domain-specific knowledge and workflows. They follow the [Agent Skills](https://agentskills.io/) open standard.

#### Frontmatter Reference

```yaml
---
name: <string>                       # Slash-command name (default: directory name)
description: <string>                # When to use this skill (recommended)
argument-hint: <string>              # Input placeholder (e.g., "[issue-number]")
user-invocable: <boolean>            # Show in / menu (default: true)
disable-model-invocation: <boolean>  # Prevent auto-routing (default: false)
---
<Markdown body = skill instructions>
```

#### Progressive Disclosure Model

Skills use a three-level loading model to manage context efficiently:

| Level          | When Loaded                                         | What's Included                         |
| -------------- | --------------------------------------------------- | --------------------------------------- |
| 1 — Discovery  | Always (skill is registered)                        | `name` + `description` only             |
| 2 — Invocation | When skill is triggered (`/name` or model-selected) | Full SKILL.md body                      |
| 3 — Resources  | On-demand during execution                          | Supporting files in the skill directory |

#### Invocation Control

| Configuration                    | User Can Invoke | Model Can Invoke | Description in Context |
| -------------------------------- | --------------- | ---------------- | ---------------------- |
| (defaults)                       | Yes             | Yes              | Always loaded          |
| `disable-model-invocation: true` | Yes             | No               | Not loaded             |
| `user-invocable: false`          | No              | Yes              | Always loaded          |

`disable-model-invocation: true` — Use for workflows with side effects (deploy, commit) that should only run on explicit user command.

`user-invocable: false` — Use for background knowledge (codebase conventions, domain context) that the model should apply automatically but that isn't meaningful as a user command.

### Subagent Behavior

When an agent spawns a sub-agent (via the `agent` tool alias), VS Code creates an isolated execution context:

- **Isolated context:** Sub-agents do NOT inherit the parent agent's instructions, conversation history, or loaded skills. They receive only their own system prompt plus basic environment info.
- **Summary return:** When a sub-agent completes, its full output is summarized and returned to the parent. The parent sees only the summary, not the full sub-agent conversation.
- **Synchronous execution:** The parent agent blocks until the sub-agent completes.
- **Parallel support:** Multiple sub-agents can run in parallel when tasks are independent.
- **No nesting:** Sub-agents cannot spawn other sub-agents.

#### The `agents` Field

The `agents` field in agent frontmatter controls which sub-agents can be spawned:

| Value                               | Behavior                                                        |
| ----------------------------------- | --------------------------------------------------------------- |
| `agents: "*"`                       | Can spawn any registered agent (default if `agents` is omitted) |
| `agents: "[]"`                      | Cannot spawn any sub-agents                                     |
| `agents: "['Planner', 'Reviewer']"` | Can only spawn the named agents                                 |

**Override behavior:** Explicitly listing an agent in `agents` overrides that agent's `disable-model-invocation: true` — the parent can still delegate to it even though the model can't auto-invoke it from user chat.

---

## Tool Alias Model

Copilot uses tool aliases as shorthand for groups of related tools:

| Alias     | Included Tools                                                                                                    | Purpose                  |
| --------- | ----------------------------------------------------------------------------------------------------------------- | ------------------------ |
| `execute` | `run_in_terminal`, `run_vscode_command`, `run_notebook_cell`, `run_task`, `runTests`                              | Run commands and scripts |
| `read`    | `read_file`, `list_dir`, `copilot_getNotebookSummary`, `get_errors`, `get_terminal_output`, `get_task_output`     | Read files and outputs   |
| `edit`    | `create_file`, `replace_string_in_file`, `multi_replace_string_in_file`, `edit_notebook_file`, `create_directory` | Create and modify files  |
| `search`  | `semantic_search`, `grep_search`, `file_search`, `list_code_usages`, `get_search_view_results`                    | Find code and content    |
| `agent`   | `runSubagent`                                                                                                     | Delegate to sub-agents   |
| `web`     | `fetch_webpage`, `open_simple_browser`                                                                            | Access web content       |
| `todo`    | `manage_todo_list`                                                                                                | Track task progress      |

**Common combinations:**

| Profile         | Tools                                                       | Use Case           |
| --------------- | ----------------------------------------------------------- | ------------------ |
| Read-Only       | `read`, `search`                                            | Analysis, review   |
| Standard Dev    | `read`, `edit`, `search`, `execute`                         | Normal development |
| Documentation   | `read`, `edit`, `search`                                    | Docs-only work     |
| Full Autonomous | `read`, `edit`, `search`, `execute`, `agent`, `web`, `todo` | All capabilities   |

---

## Configuration Precedence

Settings cascade in this order (later overrides earlier):

1. **Organization-level** — Global rules
2. **Repository-level** — `.github/copilot-instructions.md`
3. **Path-specific** — `.github/instructions/*.instructions.md` (file-pattern scoped)
4. **Personal** — User profile agents and instructions

All applicable instructions are combined and sent to the model. Higher precedence instructions take priority when conflicting.

---

## Premium Request Billing

GitHub Copilot uses a premium request model for advanced features. Understanding this helps optimize agent design for cost efficiency.

### Billing Unit

One user prompt in Copilot Chat = **one premium request** × the model's multiplier. Sub-agent spawns are internal to the same request — they do not generate additional premium requests.

### Model Multipliers (Paid Plans)

Included models (GPT-5 mini, GPT-4.1, GPT-4o) consume **0 premium requests** on paid plans.

| Model                             | Multiplier |
| --------------------------------- | ---------- |
| Claude Haiku 4.5                  | 0.33×      |
| Claude Sonnet 4 / 4.5 / 4.6       | 1×         |
| Claude Opus 4.5 / 4.6             | 3×         |
| Gemini 3 Flash                    | 0.33×      |
| Gemini 2.5 Pro / 3 Pro / 3.1 Pro  | 1×         |
| GPT-5.1 / 5.2                     | 1×         |
| Grok Code Fast 1                  | 0.25×      |

**Auto model selection discount:** Using Copilot's auto model selection provides a 10% multiplier discount on paid plans (e.g., Sonnet 4 at 0.9× instead of 1×).

**Cost optimization:** Use lower-multiplier models (Haiku 0.33×, Gemini Flash 0.33×) for analysis or exploration sub-agents. Reserve high-multiplier models (Opus 3×) for complex reasoning tasks.

For the full multiplier table and plan details, see [GitHub Copilot Billing](https://docs.github.com/en/copilot/concepts/billing/copilot-requests).

---

## Optimization Tips

### Instruction Files

- **Keep `applyTo` patterns specific.** Broad patterns like `**/*` load for every file — use specific extensions where possible (e.g., `**/*.ts,**/*.tsx`).
- **Use comma-separated strings for `applyTo`**, not YAML arrays: `applyTo: "**/*.ts,**/*.tsx"`, not `applyTo: ["**/*.ts"]`.
- **Cross-reference, don't duplicate.** If a rule references content in another file, link to it rather than copying the content.

### Agent Files

- **Always include `description`** — it's required and used for agent-routing decisions when `user-invokable: true`.
- **Use `handoffs` for multi-step workflows.** They create UI buttons in VS Code that delegate to other agents with pre-filled prompts.
- **Grant minimal tools.** Only include tool aliases that the agent actually needs — excess tools increase the attack surface and context window usage.
- **Test cross-platform.** Properties like `handoffs` and `model` are VS Code-only but harmlessly ignored elsewhere.

### Prompt Files

- **Remember: VS Code only.** Other surfaces (Coding Agent, JetBrains, CLI) do not load prompt files. If you need cross-platform workflows, use agent instructions instead.
- **Set `agent:` to target a specific agent** rather than running in the default chat mode.
- **Use `${input:varName}`** for parameterized prompts — creates input dialogs in VS Code.

### MCP Servers

- **Declare approved MCP servers in `workspace.config.yaml`** under `forge.tooling.<provider>.mcp-server`.
- **Block auto-loaded servers** (GitKraken, GitLens) in your tool-selection instruction file.
- **Name secrets with `COPILOT_MCP_` prefix** for Coding Agent MCP access.

---

## Known Limitations & Gotchas

| Issue                         | Details                                                                  |
| ----------------------------- | ------------------------------------------------------------------------ |
| `applyTo` must be string      | YAML arrays cause schema violations — always use comma-separated strings |
| Prompt files VS Code only     | Coding Agent, JetBrains, and CLI do not load `.prompt.md` files          |
| `model` ignored on GitHub.com | Agent model preferences only work in VS Code and JetBrains               |
| `handoffs` VS Code only       | Delegation buttons don't appear on GitHub.com or CLI                     |
| `.chatmode.md` deprecated     | Rename to `.agent.md` — the old extension still works but is deprecated  |
| `mode:` deprecated            | Use `agent:` in prompt frontmatter instead                               |
| `infer:` deprecated           | Use `user-invokable` + `disable-model-invocation` instead                |
| `fetch` alias doesn't exist   | Use `web` for web access tools                                           |

---

## Official Documentation

- [Custom agents](https://code.visualstudio.com/docs/copilot/copilot-customization#_custom-agents)
- [Prompt files](https://code.visualstudio.com/docs/copilot/copilot-customization#_reusable-prompt-files-experimental)
- [Instruction files](https://code.visualstudio.com/docs/copilot/copilot-customization#_instruction-files)
- [Coding Agent](https://docs.github.com/en/copilot/using-github-copilot/using-the-copilot-coding-agent)
- [Agent Skills](https://agentskills.io)
- [MCP in VS Code](https://code.visualstudio.com/docs/copilot/chat/mcp-servers)
