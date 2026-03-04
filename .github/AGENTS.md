# AI Agent Onboarding

> README for AI agents. Project context and quick-start information.

---

## Project Overview

Read `workspace.config.yaml` for workspace identity, forge topology, and commands.
Read `docs/workspace/project-overlay.md` for project-specific context.

---

## Available Agents

| Agent                  | Description                                                                    | When to Use                                                         |
| ---------------------- | ------------------------------------------------------------------------------ | ------------------------------------------------------------------- |
| Implementer            | Write code, fix bugs, create docs, and manage source control.                  | Writing code, debugging, documentation, refactoring, git operations |
| Orchestrator           | Issue/project management, workflow coordination, session lifecycle.            | GitHub issue work, project board ops, session start/end             |
| Planner                | Research, design, analyze trade-offs, and plan implementation.                 | Architecture decisions, research, brainstorming, design proposals   |
| Reviewer               | Code review, PR assessment, security assessment, quality verification.         | PR reviews, security review, commit verification, feedback          |
| Test                   | Test analysis, coverage assessment, verdict reporting, TDD support.            | Writing tests, coverage analysis, test verdict interpretation       |
| Workspace Configurator | Create and maintain workspace-level prompts, agents, and forge configurations. | Workspace configuration, tool integration, prompt/agent scaffolding |

---

## Available Workflows

| Workflow              | Description                                                  | Invoke                   |
| --------------------- | ------------------------------------------------------------ | ------------------------ |
| address-feedback      | Implement review feedback on a PR                            | `/address-feedback`      |
| commit                | Stage changes and create a Conventional Commit               | `/commit`                |
| configure-forge       | Generate forge binding prompts from workspace.config.yaml    | `/configure-forge`       |
| configure-integration | Set up a new MCP server, tool integration, or extension      | `/configure-integration` |
| debug                 | Hypothesis-driven debugging and root cause analysis          | `/debug`                 |
| docs                  | Documentation creation, maintenance, and review              | `/docs`                  |
| issue                 | From issue selection to implementation completion            | `/issue`                 |
| issue-create          | Create a new issue with proper structure, labels, and links  | `/issue-create`          |
| issue-spawn           | Create a follow-up issue linked to existing work             | `/issue-spawn`           |
| planning              | Architecture design, trade-off analysis, and decision-making | `/planning`              |
| pr                    | From committed changes to merged PR                          | `/pr`                    |
| recover-context       | Recover from missing workspace context                       | `/recover-context`       |
| refresh-context       | Update stale workspace context                               | `/refresh-context`       |
| review                | Structured review of PRs and feedback verification           | `/review`                |
| scaffold-file         | Create or update a scaffold file in `scaffolds/`             | `/scaffold-file`         |
| session-end           | Clean session closure, context preservation, and handoff     | `/session-end`           |
| session-start         | Initialize a session with workspace context and prior state  | `/session-start`         |
| setup-workspace       | Configure workspace context for the agentic kernel           | `/setup-workspace`       |
| sync-templates        | Sync workspace content to template repos via manifest        | `/sync-templates`        |
| test                  | Parse test output and produce a structured verdict           | `/test`                  |

---

## Technology Conventions

| Convention | Applies To                                                                        | Description                                          |
| ---------- | --------------------------------------------------------------------------------- | ---------------------------------------------------- |
| angular    | `**/*.component.ts,**/*.service.ts,**/*.directive.ts,**/*.pipe.ts,**/*.module.ts` | Conventions for Angular development                  |
| api        | `**/Controllers/**,**/Endpoints/**`                                               | Guidelines for API design and implementation         |
| docs       | `docs/**/*.md`                                                                    | Conventions for documentation files                  |
| dotnet     | `**/*.cs`                                                                         | Guidelines for C# development                        |
| jamstack   | `**/jamstack/**,**/*.astro,**/netlify.toml,**/vercel.json`                        | Conventions for Jamstack and static site development |
| java       | `**/*.java,**/pom.xml`                                                            | Conventions for Java and Maven development           |
| jfrog      | `**/.jfrog/**,**/artifactory/**,**/*jfrog*`                                       | Conventions for JFrog Artifactory integration        |
| migrations | `**/Migrations/**`                                                                | Guidelines for database schema changes               |
| testing    | `**/tests/**,**/*.test.ts,**/*.spec.ts,**/*.Tests.csproj,**/*Tests.cs`            | Guidelines for writing and running tests             |
| typescript | `**/*.ts,**/*.tsx`                                                                | Guidelines for TypeScript development                |

---

## Core Principles

AI proposes, human approves — never act without explicit approval. Work in small, reviewable steps with checkpoints after each logical unit. Every action links to its rationale via Context Anchors. Quality over speed: verify before claiming success. When corrected, acknowledge the error, explain the cause, re-anchor to the correct constraint, and revise the plan.

---

## Quick Start

Read `workspace.config.yaml` for build/test/run/lint commands.
Read `docs/workspace/goals.md` for durable priorities and `.tmp/workspace/goals.md` for active sprint state.

---

## Project Structure

Read `docs/workspace/context.md` for project-specific architecture and structure.

```

---

## Notes for AI Agents

- Check `docs/workspace/context.md` for project-specific context (if it exists)
- Use path-specific instructions in `.github/instructions/` for detailed conventions
- Follow the approval protocol for destructive operations
- When uncertain, ask rather than assume
```
