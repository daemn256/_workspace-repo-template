# AI Agent Onboarding

> README for AI agents. Project context and quick-start information.

---

## Project Overview

**Name:** {{{project_name}}}
**Purpose:** {{{project_purpose}}}

---

## Available Agents

| Agent        | Description                                                    | When to Use                                                                                      |
| ------------ | -------------------------------------------------------------- | ------------------------------------------------------------------------------------------------ |
| API          | API design, contracts, versioning, integration patterns.       | Controller/endpoint work, OpenAPI/Swagger concerns, API design discussions, integration patterns |
| Architect    | System design, ADRs, trade-off analysis, component design.     | System design, ADR creation or review, architectural decisions, component boundary definition    |
| Data         | Database design, migrations, queries, schema evolution.        | Entity/model changes, migration creation, query optimization, schema design                      |
| Debug        | Troubleshooting, root cause analysis, diagnostics.             | Error investigation, test failures, unexpected behavior, root cause analysis                     |
| Docs         | Documentation, specs, guides, READMEs, changelogs.             | Documentation work, README updates, spec authoring, changelog updates                            |
| Git-Ops      | Handle git operations, commits, and PR creation.               | Branch management, commits, PR creation, conflict resolution, rebasing                           |
| Implementer  | Write code and make file changes following plans.              | Default when no other persona matches, feature implementation, refactoring, source code changes  |
| Ops          | CI/CD, Kubernetes, deployment, infrastructure, monitoring.     | Pipeline work, K8s manifests, deployment issues, monitoring/observability setup                  |
| Orchestrator | Issue/project management, workflow coordination, and planning. | GitHub issue work, project board operations, workflow coordination, process compliance           |
| Planner      | Research, analyze, and plan implementation approaches.         | Complex work requiring upfront design, option analysis, implementation planning                  |
| Research     | Investigation, spikes, learning, feasibility analysis.         | Feasibility questions, technology evaluation, spike investigations, unknown territory            |
| Reviewer     | Code review, PR verification, standards enforcement.           | PR reviews, code quality verification, standards enforcement, commit review                      |
| Security     | Security hardening, vulnerability analysis, auth, compliance.  | Auth/authz work, security reviews, secrets management, vulnerability assessment                  |
| Test         | Test writing, coverage analysis, TDD support.                  | Writing tests, coverage analysis, TDD workflows, test file work                                  |

---

## Available Workflows

| Workflow         | Description                                                              | Invoke              |
| ---------------- | ------------------------------------------------------------------------ | ------------------- |
| Address Feedback | Implement review feedback on a PR                                        | `/address-feedback` |
| Issue            | From issue selection to implementation completion                        | `/issue`            |
| Issue Create     | Create a new issue from scratch with proper structure, labels, and links | `/issue-create`     |
| Issue Spawn      | Create a follow-up issue linked to existing work                         | `/issue-spawn`      |
| Modes            | Route to workflow modes based on intent                                  | `/modes`            |
| Planning         | Architecture design, trade-off analysis, and technical decision-making   | `/planning`         |
| PR               | From committed changes to merged PR                                      | `/pr`               |
| Recover Context  | Recover from missing workspace context                                   | `/recover-context`  |
| Refresh Context  | Update stale workspace context                                           | `/refresh-context`  |
| Review           | Structured review of PRs and verification of feedback implementation     | `/review`           |
| Setup Workspace  | Configure workspace context for the agentic kernel                       | `/setup-workspace`  |
| Test             | Parse test output and produce a structured verdict                       | `/test`             |

---

## Technology Conventions

| Convention | Applies To                                                                                    | Description                                           |
| ---------- | --------------------------------------------------------------------------------------------- | ----------------------------------------------------- |
| Angular    | `**/*.component.ts`, `**/*.service.ts`, `**/*.directive.ts`, `**/*.pipe.ts`, `**/*.module.ts` | Conventions for Angular development                   |
| API        | `**/Controllers/**`, `**/Endpoints/**`                                                        | Guidelines for API design and implementation          |
| Docs       | `docs/**/*.md`                                                                                | Conventions for documentation files                   |
| Dotnet     | `**/*.cs`                                                                                     | Guidelines for C# development                         |
| Jamstack   | `**/jamstack/**`, `**/*.astro`, `**/netlify.toml`, `**/vercel.json`                           | Conventions for Jamstack and static site development  |
| Java       | `**/*.java`, `**/pom.xml`                                                                     | Conventions for Java and Maven development            |
| JFrog      | `**/.jfrog/**`, `**/artifactory/**`, `**/*jfrog*`                                             | Conventions for JFrog Artifactory integration         |
| Migrations | `**/Migrations/**`                                                                            | Guidelines for database schema changes and migrations |
| Testing    | `**/tests/**`, `**/*.test.ts`, `**/*.spec.ts`, `**/*.Tests.csproj`, `**/*Tests.cs`            | Guidelines for writing and running tests              |
| TypeScript | `**/*.ts`, `**/*.tsx`                                                                         | Guidelines for TypeScript development                 |

---

## Core Principles

AI proposes; human approves — never take action without explicit approval. Work in small, reviewable steps, checkpointing after each logical unit. Every action must link to its rationale through Context Anchors, ensuring full traceability. Quality takes precedence over speed: verify before claiming success. When corrected, acknowledge the specific error, re-anchor to the correct constraint, and revise the approach without defensiveness.

---

## Quick Start

### Build

```bash
{{{build_command}}}
```

### Test

```bash
{{{test_command}}}
```

---

## Notes for AI Agents

- Check `docs/workspace/context.md` for project-specific context (if it exists)
- Use path-specific instructions in `.github/instructions/` for detailed conventions
- Follow the approval protocol for destructive operations
- When uncertain, ask rather than assume
