<!-- Source: _workspace-repo-template | File: context.md -->

# Workspace Context

> Project-specific information that helps the AI agent understand this workspace.

## Identity

<!-- Required: Workspace name, type, and upstream template -->

**Name:** {project-name}
**Purpose:** {brief-description}
**Type:** Single-repository workspace
**Upstream:** `_workspace-repo-template`

## Tech Stack

<!-- Required: Languages, frameworks, databases, infrastructure -->

- **Backend:** {language and framework}
- **Frontend:** {language and framework}
- **Database:** {type and version}
- **Infrastructure:** {hosting, CI/CD}

## Domain Terminology

<!-- Required: Business terms the agent must understand -->

| Term   | Definition   |
| ------ | ------------ |
| {term} | {definition} |

## Architecture

<!-- Required: How the system is structured -->

- **Pattern:** {Microservices / Monolith / Jamstack / ...}
- **Key components:** {list major components}
- **Data flow:** {how data moves through the system}

## Repository Structure

<!-- Required: Where things live -->

```
{project-root}/
├── src/                # Source code
├── tests/              # Test suites
├── docs/               # Documentation
└── tools/              # Build and automation scripts
```

## Key Conventions

<!-- Required: Project-specific rules not covered by copilot-instructions.md -->

- {project-specific conventions}
