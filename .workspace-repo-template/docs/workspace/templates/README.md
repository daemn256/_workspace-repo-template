# Workspace Output Templates

> Fill-in-the-blank templates for creating issues, PRs, and other work items.

These templates define the standard structure for work items created by AI agents. They are derived from the process domain conventions ([issue-lifecycle](../../../repos/_agentic-system/src/process/issue-lifecycle.md), [pr-lifecycle](../../../repos/_agentic-system/src/process/pr-lifecycle.md), [board-schema](../../../repos/_agentic-system/src/process/board-schema.md)).

## Available Templates

| Template                             | Purpose                         |
| ------------------------------------ | ------------------------------- |
| [issue-bug.md](issue-bug.md)         | Report a defect                 |
| [issue-feature.md](issue-feature.md) | Request new capability          |
| [issue-task.md](issue-task.md)       | Operational or maintenance work |
| [issue-spike.md](issue-spike.md)     | Time-boxed research             |
| [pull-request.md](pull-request.md)   | Propose a code change           |

## Usage

When creating an issue or PR, copy the relevant template and fill in the sections.

## Customization

These templates are owned by the consumer workspace. The containment directory version is the upstream reference — the root version is yours to customize.

If your project needs additional templates (e.g., `issue-incident.md` for ops), add them here.
