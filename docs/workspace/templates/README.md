# Workspace Output Templates

> Fill-in-the-blank templates for creating issues, PRs, and other work items.

These templates define the standard structure for work items created by AI agents. They follow the process conventions documented in the global instructions (`CLAUDE.md`, `.github/copilot-instructions.md`).

## Ticket Templates

| Template                               | Purpose                          |
| -------------------------------------- | -------------------------------- |
| [ticket-bug.md](ticket-bug.md)         | Report a defect                  |
| [ticket-feature.md](ticket-feature.md) | Propose new capability           |
| [ticket-task.md](ticket-task.md)       | Concrete implementation work     |
| [ticket-spike.md](ticket-spike.md)     | Time-boxed research              |
| [ticket-epic.md](ticket-epic.md)       | Parent grouping of issues        |
| [ticket-chore.md](ticket-chore.md)     | Maintenance and operational work |

## PR Templates

| Template                       | Purpose                 |
| ------------------------------ | ----------------------- |
| [pr.md](pr.md)                 | Standard pull request   |
| [pr-hotfix.md](pr-hotfix.md)   | Urgent production patch |
| [pr-release.md](pr-release.md) | Version release         |

## Usage

When creating an issue or PR, copy the relevant template and fill in the sections.

## Customization

These templates are owned by the consumer workspace. The containment directory version is the upstream reference — the root version is yours to customize.

If your project needs additional templates (e.g., `issue-incident.md` for ops), add them here.
