# Workspace Context

Context files that help AI agents understand your workspace.

## Files

### context.md

Project-specific information that helps agents work effectively:

- Domain terminology and acronyms
- Architectural patterns in use
- Key conventions and standards
- Tech stack overview
- Repository structure explanation

**Fill this in with your project details.**

### goals.md

Durable strategic priorities:

- Milestones and their target dates
- Technical debt items
- Backlog of future work

For active sprint state and current focus, see `.tmp/workspace/goals.md`.

**Update this as milestones shift.**

### project-overlay.md

Project identity injected into agent context:

- Project name and purpose
- Key conventions
- Active repositories
- Operational workflow

**Customize this to give agents project-specific awareness.**

---

## Getting Started

1. Fill in `context.md` with your domain knowledge
2. Set initial goals in `goals.md`
3. Write your project identity in `project-overlay.md`
4. AI agents will read these files automatically during session initialization
