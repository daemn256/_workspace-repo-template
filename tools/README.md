# Workspace Tools

Automation scripts for **workspace-level operations** — git configuration, instruction rendering, and maintenance.

## Setup Scripts

### setup-githooks.sh

**Configures git to use the `.githooks/` directory for branch protection.**

```bash
./tools/setup-githooks.sh
```

- Sets `core.hooksPath` to `.githooks/`
- Idempotent — safe to re-run at any time
- Can be run standalone from anywhere in the repository

### setup-remotes.sh

**Configures upstream template remotes for tracking updates.**

```bash
./tools/setup-remotes.sh
```

- Adds `upstream-workspace` remote (this workspace template)
- Adds `upstream-repo` remote (parent repository template)
- Blocks push to both remotes (fetch-only)
- Migrates legacy `upstream` remotes to `upstream-workspace`
- Idempotent — safe to re-run at any time

## Rendering

### render-instructions.sh

**Replaces `{{{placeholder}}}` tokens in instruction files with values from `workspace.config.yaml`.**

```bash
./tools/render-instructions.sh
```

- Finds files with consumer-fill tokens and replaces them with config values
- Adds a generated-file header comment
- Reports unfilled tokens as warnings
- See [Configuration](../docs/architecture/configuration.md) for the token reference

## Purpose

This directory contains utilities that help maintain and operate the workspace as a whole. These should be practical tools that remain useful regardless of which projects exist in `repos/`.

## What Belongs Here

- Workspace maintenance scripts (batch operations, validation)
- Environment setup or verification
- Git workflow helpers
- Documentation generators or validators

## What Doesn't Belong Here

- Project-specific build or test scripts (belong in individual repos)
- One-off scripts (use `sandbox/` or `.tmp/scratch/`)
- Secrets, credentials, or environment-specific configs
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
