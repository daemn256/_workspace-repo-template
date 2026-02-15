<!-- Source: _workspace-repo-template | File: context.md -->

# Workspace Context

> Project-specific information that helps Copilot work better.

## Project

**Name:** {project-name}
**Purpose:** {brief-description}

## Domain Terminology

| Term   | Definition   |
| ------ | ------------ |
| {term} | {definition} |

## Architecture

- **Type:** {Microservices / Monolith / Jamstack / ...}
- **Backend:** {language and framework}
- **Frontend:** {language and framework}
- **Database:** {type and version}

## Key Conventions

- Branch naming: `<type>/<issue-number>-<description>`
- Commit format: Conventional Commits
- Code review: Required before merge

## Repository Structure

<!-- Describe the high-level layout of your project. -->

```
{project-root}/
├── src/                # Source code
├── tests/              # Test suites
├── docs/               # Documentation
└── tools/              # Build and automation scripts
```
