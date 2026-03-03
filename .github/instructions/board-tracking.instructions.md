---
applyTo: "**"
---

# Board Status Tracking

> Mandatory board status updates at every issue lifecycle transition.

## Rule

Agents working on tracked issues **MUST** update the board status at every lifecycle transition. Board status reflects reality — it must never be stale.

## Required Transitions

| When                                       | Set Status To   | Trigger                                                      |
| ------------------------------------------ | --------------- | ------------------------------------------------------------ |
| Issue created                              | **Backlog**     | Default on creation — every new issue starts in Backlog      |
| Issue picked for current work              | **Ready**       | Human moves issue to Ready during refinement/sprint planning |
| Work begins (branch created, first commit) | **In Progress** | Agent starts implementation                                  |
| PR created                                 | **In Review**   | Pull request opened for the issue                            |
| PR merged / issue completed                | **Done**        | Work is verified and merged                                  |

## How to Update

Board status is updated through the workspace's forge tooling. The specific mechanism depends on `workspace.config.yaml`:

1. Read `board.project_id` from workspace config
2. Read `board.fields.status.field_id` for the status field
3. Read `board.status_options.<status>.option_id` for the target status
4. Execute the forge's board update operation

The workspace-level prompts or agents provide the concrete commands for the configured forge provider. The kernel defines WHEN to update; the workspace defines HOW.

## Agent Responsibility

| Agent        | Board Updates Expected                                                            |
| ------------ | --------------------------------------------------------------------------------- |
| Orchestrator | Backlog (on create), Ready (on refinement), verify on session start/end           |
| Implementer  | In Progress (when starting work), In Review (when PR created), Done (when merged) |

## Constraints

- MUST NOT leave board status stale when transitioning between phases
- MUST NOT set status to Done without verifying acceptance criteria
- MUST NOT skip In Progress when starting work (even for quick fixes)
- MUST NOT assume board status — always verify by reading the board

## Error Handling

| Situation                               | Action                                       |
| --------------------------------------- | -------------------------------------------- |
| Board field IDs not in workspace config | Ask human to update workspace.config.yaml    |
| Issue not on board                      | Add it to the board first, then set status   |
| Status update fails                     | Report the failure, do not silently continue |
| Multiple issues being worked            | Track status for each independently          |

## Lifecycle Knowledge Gates

| Transition  | Condition             | Required Artifact                                  |
| ----------- | --------------------- | -------------------------------------------------- |
| → Ready     | Always                | Acceptance criteria documented in issue body       |
| → In Review | Always                | PR description links relevant context (issue, ADR) |
| → Done      | Label: `architecture` | ADR exists or updated in `docs/adr/`               |
| → Done      | Label: `runbook`      | Runbook exists or updated in `docs/guides/`        |
| → Done      | Always                | CHANGELOG updated if release-relevant              |
