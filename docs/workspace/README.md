# Workspace Context

Context and working space for GitHub Copilot to understand your workspace.

## Files

### context.md

Project-specific information that helps Copilot work better:

- Domain terminology and acronyms
- Architectural patterns in use
- Key conventions and standards
- Tech stack overview
- Repository structure explanation

**Create this file with your project details.**

### goals.md

Current objectives and priorities:

- What you're working on right now
- Sprint goals or milestones
- Technical debt priorities
- Known issues to address

**Keep this updated as your focus changes.**

---

## Getting Started

Create `context.md`:

```bash
cat > docs/workspace/context.md << 'EOF'
# Workspace Context

## Project

**Name:** Your Project Name
**Purpose:** Brief description

## Domain Terminology

| Term      | Definition                                    |
| --------- | --------------------------------------------- |
| Widget    | A reusable UI component                       |
| Pipeline  | Automated build/test/deploy workflow          |

## Architecture

- **Type:** Microservices / Monolith / Jamstack
- **Backend:** Language and framework
- **Frontend:** Language and framework
- **Database:** Type and version

## Key Conventions

- Branch naming: type/issue-number-description
- Commit format: Conventional Commits
- Code review: Required before merge
EOF
```

Create `goals.md`:

```bash
cat > docs/workspace/goals.md << 'EOF'
# Current Goals

## Sprint Focus

- [ ] Implement user authentication
- [ ] Set up CI/CD pipeline
- [ ] Write API documentation

## Technical Debt

- [ ] Upgrade dependencies
- [ ] Refactor legacy module
- [ ] Improve test coverage
EOF
```
