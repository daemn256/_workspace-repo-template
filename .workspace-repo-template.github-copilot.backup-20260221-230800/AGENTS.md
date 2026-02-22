# AI Agent Onboarding

> README for AI agents. Project context and quick-start information.

---

## Project Overview

**Name:** {{{project_name}}}
**Purpose:** {{{project_purpose}}}

---

## Available Agents

| Agent        | Description                                                   | When to Use                                                |
| ------------ | ------------------------------------------------------------- | ---------------------------------------------------------- |
| api          | API design, contracts, versioning, integration patterns       | Designing or reviewing APIs, endpoints, contracts          |
| architect    | System design, ADRs, trade-off analysis, component design     | Architecture decisions, system design, trade-off analysis  |
| data         | Database design, migrations, queries, schema evolution        | Database schema changes, query optimization, data modeling |
| debug        | Troubleshooting, root cause analysis, diagnostics             | Investigating errors, debugging failures, diagnostics      |
| docs         | Documentation, specs, guides, READMEs, changelogs             | Writing or updating documentation                          |
| git-ops      | Handle git operations, commits, and PR creation               | Git operations, branching, commits, PR creation            |
| implementer  | Write code and make file changes following plans              | Implementing features, making code changes                 |
| ops          | CI/CD, Kubernetes, deployment, infrastructure, monitoring     | Infrastructure, deployment, CI/CD, monitoring              |
| orchestrator | Issue/project management, workflow coordination, and planning | Coordinating workflows, managing issues, routing work      |
| planner      | Research, analyze, and plan implementation approaches         | Planning implementation, analyzing approaches              |
| research     | Investigation, spikes, learning, feasibility analysis         | Research spikes, feasibility analysis, learning            |
| reviewer     | Code review, PR verification, standards enforcement           | Reviewing PRs, enforcing standards, verifying changes      |
| security     | Security hardening, vulnerability analysis, auth, compliance  | Security review, vulnerability analysis, auth patterns     |
| test         | Test writing, coverage analysis, TDD support                  | Writing tests, analyzing coverage, TDD                     |

---

## Available Workflows

| Workflow         | Description                                                              | Invoke              |
| ---------------- | ------------------------------------------------------------------------ | ------------------- |
| address-feedback | Implement review feedback on a PR                                        | `/address-feedback` |
| issue            | From issue selection to implementation completion                        | `/issue`            |
| issue-create     | Create a new issue from scratch with proper structure, labels, and links | `/issue-create`     |
| issue-spawn      | Create a follow-up issue linked to existing work                         | `/issue-spawn`      |
| modes            | Route to workflow modes based on intent                                  | `/modes`            |
| planning         | Architecture design, trade-off analysis, and technical decision-making   | `/planning`         |
| pr               | From committed changes to merged PR                                      | `/pr`               |
| recover-context  | Recover from missing workspace context                                   | `/recover-context`  |
| refresh-context  | Update stale workspace context                                           | `/refresh-context`  |
| review           | Structured review of PRs and verification of feedback implementation     | `/review`           |
| setup-workspace  | Configure workspace context for the agentic kernel                       | `/setup-workspace`  |
| test             | Parse test output and produce a structured verdict                       | `/test`             |

---

## Technology Conventions

| Convention | Applies To                                                                        | Description                                           |
| ---------- | --------------------------------------------------------------------------------- | ----------------------------------------------------- |
| angular    | `**/*.component.ts,**/*.service.ts,**/*.directive.ts,**/*.pipe.ts,**/*.module.ts` | Conventions for Angular development                   |
| api        | `**/Controllers/**,**/Endpoints/**`                                               | Guidelines for API design and implementation          |
| docs       | `docs/**/*.md`                                                                    | Conventions for documentation files                   |
| dotnet     | `**/*.cs`                                                                         | Guidelines for C# development                         |
| jamstack   | `**/jamstack/**,**/*.astro,**/netlify.toml,**/vercel.json`                        | Conventions for Jamstack and static site development  |
| java       | `**/*.java,**/pom.xml`                                                            | Conventions for Java and Maven development            |
| jfrog      | `**/.jfrog/**,**/artifactory/**,**/*jfrog*`                                       | Conventions for JFrog Artifactory integration         |
| migrations | `**/Migrations/**`                                                                | Guidelines for database schema changes and migrations |
| testing    | `**/tests/**,**/*.test.ts,**/*.spec.ts,**/*.Tests.csproj,**/*Tests.cs`            | Guidelines for writing and running tests              |
| typescript | `**/*.ts,**/*.tsx`                                                                | Guidelines for TypeScript development                 |

---

## Core Principles

AI proposes; human approves. Work in small, reviewable steps with checkpoints after each logical unit. Every action links to its rationale through Context Anchors. Quality over speed — verify before claiming success. When corrected, acknowledge, re-anchor, and revise without defensiveness.

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

### Run

```bash
{{{run_command}}}
```

---

## Project Structure

```
{{{project_root}}}/
├── src/              # Source code
├── tests/            # Test projects
├── docs/             # Documentation
│   ├── adr/          # Architecture Decision Records
│   ├── architecture/ # Architecture documentation
│   └── workspace/    # Workspace context
└── .github/          # GitHub configuration
    ├── agents/       # AI agent definitions
    ├── prompts/      # Workflow prompts
    └── instructions/ # Technology conventions
```

---

## Notes for AI Agents

- Check `docs/workspace/context.md` for project-specific context (if it exists)
- Use path-specific instructions in `.github/instructions/` for detailed conventions
- Follow the approval protocol for destructive operations
- When uncertain, ask rather than assume
