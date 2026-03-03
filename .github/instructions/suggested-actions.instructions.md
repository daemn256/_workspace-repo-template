---
applyTo: "**"
---

# Suggested Actions

> Every substantive agent response should suggest 1–3 contextually relevant follow-up actions from the workspace's registered prompt and agent inventory.

## Format

After the **Next Step** section in every response, include:

```markdown
## Suggested Actions

- `/prompt-name` → @Agent — One-line description
- `/prompt-name` → @Agent — One-line description
```

## Selection Rules

- Suggest 1–3 actions per response (not more)
- Choose based on what was just accomplished and what logically follows
- Prefer the most likely next step first
- Include at least one action from a different agent when applicable (encourage handoff)
- Skip this section only for trivial, single-exchange responses

## Context-Aware Selection Guide

| After This Phase | Suggest These |
| --- | --- |
| Analysis / Research | `/planning` → @Planner, `/issue` → @Orchestrator |
| Planning complete | `/issue` → @Orchestrator, `/commit` → @Implementer |
| Implementation | `/commit` → @Implementer, `/test` → @Test |
| Tests pass | `/commit` → @Implementer (if uncommitted), `/pr` → @Orchestrator |
| Commit made | `/pr` → @Orchestrator, `/review` → @Reviewer |
| PR created | `/review` → @Reviewer, `/address-feedback` → @Implementer |
| Review feedback received | `/address-feedback` → @Implementer |
| PR merged | `/session-end` → @Orchestrator, `/issue-spawn` → @Orchestrator |
| Bug investigation | `/debug` → @Implementer, `/test` → @Test |
| Session starting | `/session-start` → @Orchestrator |
| Configuration work | `/configure-forge` → @Workspace Configurator |
| Template changes | `/sync-templates` → @Workspace Configurator |

## Prompt Reference

| Prompt | Agent | Description |
| --- | --- | --- |
| `/commit` | @Implementer | Stage changes and create a Conventional Commit |
| `/pr` | @Orchestrator | From committed changes to merged PR |
| `/review` | @Reviewer | Structured review of PRs and feedback verification |
| `/issue` | @Orchestrator | From issue selection to implementation completion |
| `/issue-create` | @Orchestrator | Create a new issue with proper structure |
| `/issue-spawn` | @Orchestrator | Create follow-up issue linked to existing work |
| `/planning` | @Planner | Architecture design, trade-off analysis, decisions |
| `/debug` | @Implementer | Hypothesis-driven debugging and root cause analysis |
| `/test` | @Test | Parse test output and produce a structured verdict |
| `/address-feedback` | @Implementer | Implement review feedback on a PR |
| `/session-start` | @Orchestrator | Initialize session with workspace context |
| `/session-end` | @Orchestrator | Clean session closure and handoff |
| `/setup-workspace` | @Workspace Configurator | Configure workspace context |
| `/configure-forge` | @Workspace Configurator | Generate forge binding prompts |
| `/configure-integration` | @Workspace Configurator | Set up MCP server or tool integration |
| `/sync-templates` | @Workspace Configurator | Sync workspace content to template repos |
| `/refresh-context` | @Orchestrator | Update stale workspace context |
| `/recover-context` | @Orchestrator | Recover from missing workspace context |
| `/scaffold-file` | @Workspace Configurator | Create or update a scaffold file |
