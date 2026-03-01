# Configuration

> How workspace-specific values reach AI agents.

---

## workspace.config.yaml

The central configuration file at the workspace root. Consumer-owned — never overwritten by template sync.

Agents read this file during session orientation to understand:

- What kind of workspace this is
- Which forge provider and tools to use
- Which AI runtimes are active
- What process profile governs the SDLC
- How the project board is wired
- What commands to run for build/test/lint

---

## Key Sections

| Section                | What it controls                                       | Who reads it                                 |
| ---------------------- | ------------------------------------------------------ | -------------------------------------------- |
| `workspace`            | Name and description                                   | Agents (identity), render tooling            |
| `forge.topology`       | Which provider handles repos, boards, CI, releases     | Agents (tool selection)                      |
| `forge.tooling`        | Preferred tool surface (MCP, CLI, API)                 | Agents (how to interact with forge)          |
| `adapters.ai-runtimes` | Which runtimes are active                              | Build tooling, documentation                 |
| `process.profile`      | Lightweight / standard / regulated                     | Agents (review requirements, approval gates) |
| `board`                | Project ID, field IDs, status/priority/size option IDs | Agents (board operations)                    |
| `commands`             | Build, test, run, lint commands                        | Agents (verification steps)                  |
| `project`              | Base branch, branch pattern, overlay file path         | Agents (git operations, project context)     |

---

## Config-Reference Pattern

Agents consume configuration by reading `workspace.config.yaml` directly at runtime — values are not baked into instruction files.

**Example:** When an agent needs to run the build, it reads `commands.build` from config rather than having the command hardcoded in a prompt.

**Example:** When an agent needs to update the board, it reads `board.fields.status.field_id` and `board.status_options.in-progress.option_id` from config.

This pattern means:

- Instruction files work across workspaces without modification
- Changing a build command requires editing one config field, not multiple prompts
- Board IDs, forge topology, and process profile are all discoverable

---

## Project Context Files

Beyond the machine-readable config, agents read several human-authored context files:

| File                                | Purpose                                                            | Ownership |
| ----------------------------------- | ------------------------------------------------------------------ | --------- |
| `workspace.config.yaml`             | Machine-readable configuration                                     | Consumer  |
| `docs/workspace/context.md`         | Domain knowledge, architecture overview, terminology               | Consumer  |
| `docs/workspace/project-overlay.md` | Project-specific agent context (injected into global instructions) | Consumer  |
| `docs/workspace/goals.md`           | Current priorities and active work                                 | Consumer  |

These files form the **session orientation** set — agents read all of them at the start of a session to understand where they are and what matters.

---

## Transitional: Token System

Template repos currently use `{{{placeholder}}}` tokens in some instruction files. Consumers run `tools/render-instructions.sh` after initial setup to replace tokens with values from `workspace.config.yaml`.

| Token                   | Config source                      |
| ----------------------- | ---------------------------------- |
| `{{{project_name}}}`    | `workspace.name`                   |
| `{{{project_purpose}}}` | `workspace.description`            |
| `{{{project_overlay}}}` | Contents of `project.overlay-file` |
| `{{{build_command}}}`   | `commands.build`                   |
| `{{{test_command}}}`    | `commands.test`                    |
| `{{{base_branch}}}`     | `project.base-branch`              |

Convention: Underscored tokens (`{{{project_name}}}`) are consumer-fill — replaced by the render tool. Hyphenated tokens (`{{{issue-number}}}`) are AI-runtime-fill — left for the AI to fill at runtime.

**Direction:** Moving toward full config-reference, where agents read config directly and no render step is needed. The token system is transitional.

---

## For Consumers

1. Copy `workspace.config.yaml` from the template
2. Fill in real values (workspace name, board IDs, commands, forge topology)
3. Run `tools/render-instructions.sh` to fill tokens in instruction files
4. Agent behavior adapts automatically based on config values

---

## Related

- [Instruction Model](instruction-model.md) — The four layers of AI instructions
- [File Ownership](file-ownership.md) — Which files come from the template vs consumer
- [Getting Started](../guides/getting-started.md) — Setup checklist for new workspaces
