# Workspace Tools

Automation scripts for **workspace-level operations** — not project creation or scaffolding.

## Available Scripts

### setup.sh

**Run once after creating your workspace from the template.**

```bash
./tools/setup.sh
```

This script:
1. Configures git to use `.githooks/` for branch protection
2. Adds the template repository as `upstream` remote
3. Blocks push to upstream (prevents accidental template contamination)

See [Getting Started](docs/guides/getting-started.md) for full setup instructions.

---

## Purpose

This directory contains utilities that help maintain and operate the workspace as a whole. These should be practical tools that remain useful regardless of which projects exist in `repos/`.

## What Belongs Here

✅ **Workspace maintenance scripts:**

- Batch operations across multiple repos (status checks, updates)
- Workspace cleanup or validation utilities
- Environment setup or verification scripts
- Git workflow helpers (e.g., sync all repos, check for uncommitted changes)
- Documentation generators or validators
- Workspace export/import utilities

✅ **Cross-cutting automation:**

- Scripts that operate on workspace structure
- Tools that work with `.github/`, `docs/`, or workspace settings
- Utilities referenced by `.vscode/tasks.json`

## What Does NOT Belong Here

❌ **Project scaffolding** — Users clone or create projects directly in `repos/`
❌ **Project-specific tools** — Those belong in the project's own directory
❌ **Build/test/run scripts** — Those belong in individual project repos
❌ **One-off experiments** — Use `sandbox/` or `.tmp/scratch/` instead

## Philosophy

**Real projects are too complex to scaffold.**

The workspace template is meant to be forked as-is. When you need a new project in `repos/`, you either:

1. Clone an existing repository
2. Create manually with AI assistance using workspace instructions
3. Use project-specific generators (e.g., `dotnet new`, `ng new`, etc.)

Don't prematurely create scaffolding tools. Build them only when a clear, repeated pattern emerges.

## Example Tools (Not Included)

If you find yourself repeatedly needing these, consider adding them:

```bash
# Check git status across all repos
./tools/git-status-all.sh

# Verify workspace structure integrity
./tools/validate-workspace.sh

# Update all repos to latest
./tools/sync-repos.sh

# Export workspace configuration
./tools/export-config.sh

# Clean temporary files workspace-wide
./tools/cleanup.sh
```

---

**Last updated:** February 7, 2026
