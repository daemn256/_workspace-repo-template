---
paths:
  - "**"
---

# Suggested Actions

> Every substantive agent response should suggest 1–3 contextually relevant follow-up actions from the workspace's registered skill and agent inventory.

## Format

After the **Next Step** section in every response, include:

```markdown
## Suggested Actions

- `/skill:name` → Subagent — One-line description
- `/skill:name` → Subagent — One-line description
```

## Selection Rules

- Suggest 1–3 actions per response (not more)
- Choose based on what was just accomplished and what logically follows
- Prefer the most likely next step first
- Include at least one action from a different subagent when applicable (encourage delegation)
- Skip this section only for trivial, single-exchange responses

## Context-Aware Selection Guide

| After This Phase | Suggest These |
| --- | --- |
| Analysis / Research | `/skill:planning` → Planner, `/skill:issue` → Orchestrator |
| Planning complete | `/skill:issue` → Orchestrator, `/skill:commit` → Implementer |
| Implementation | `/skill:commit` → Implementer, `/skill:test` → Test |
| Tests pass | `/skill:commit` → Implementer (if uncommitted), `/skill:pr` → Orchestrator |
| Commit made | `/skill:pr` → Orchestrator, `/skill:review` → Reviewer |
| PR created | `/skill:review` → Reviewer, `/skill:address-feedback` → Implementer |
| Review feedback received | `/skill:address-feedback` → Implementer |
| PR merged | `/skill:session-end` → Orchestrator, `/skill:issue-spawn` → Orchestrator |
| Bug investigation | `/skill:debug` → Implementer, `/skill:test` → Test |
| Session starting | `/skill:session-start` → Orchestrator |
| Configuration work | `/skill:configure-forge` → Workspace Configurator |
| Template changes | `/skill:sync-templates` → Workspace Configurator |

## Skill Reference

| Skill | Subagent | Description |
| --- | --- | --- |
| `/skill:commit` | Implementer | Stage changes and create a Conventional Commit |
| `/skill:pr` | Orchestrator | From committed changes to merged PR |
| `/skill:review` | Reviewer | Structured review of PRs and feedback verification |
| `/skill:issue` | Orchestrator | From issue selection to implementation completion |
| `/skill:issue-create` | Orchestrator | Create a new issue with proper structure |
| `/skill:issue-spawn` | Orchestrator | Create follow-up issue linked to existing work |
| `/skill:planning` | Planner | Architecture design, trade-off analysis, decisions |
| `/skill:debug` | Implementer | Hypothesis-driven debugging and root cause analysis |
| `/skill:test` | Test | Parse test output and produce a structured verdict |
| `/skill:address-feedback` | Implementer | Implement review feedback on a PR |
| `/skill:session-start` | Orchestrator | Initialize session with workspace context |
| `/skill:session-end` | Orchestrator | Clean session closure and handoff |
| `/skill:setup-workspace` | Workspace Configurator | Configure workspace context |
| `/skill:configure-forge` | Workspace Configurator | Generate forge binding prompts |
| `/skill:configure-integration` | Workspace Configurator | Set up MCP server or tool integration |
| `/skill:sync-templates` | Workspace Configurator | Sync workspace content to template repos |
| `/skill:refresh-context` | Orchestrator | Update stale workspace context |
| `/skill:recover-context` | Orchestrator | Recover from missing workspace context |
| `/skill:scaffold-file` | Workspace Configurator | Create or update a scaffold file |
