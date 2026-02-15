# Workspace Tools

Automation scripts for **workspace-level operations** — initialization, git configuration, and maintenance.

## Initialization Scripts

These scripts are called by `initialize-workspace.sh` during workspace setup.

### copy-template.sh

**Copies template files from the containment directory to the workspace root.**

Called by `initialize-workspace.sh`. Not typically run standalone.

- Copies all template content (structure, configs, docs, agents, hooks)
- Excludes containment-only files (`initialize-workspace.sh`, `.template.yaml`, itself)
- Uses `rsync` for reliable, idempotent copying

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

## Maintenance Scripts

### sync-upstream.sh

**Safely sync the containment directory from upstream template.**

```bash
# Preview changes (dry run)
./tools/sync-upstream.sh

# Apply changes
./tools/sync-upstream.sh --apply
```

- Selective extraction — only updates the containment directory, never touches root files
- Dry run by default — shows what would change before applying
- Auto-detects containment directory name and upstream remote
- See [Upstream Sync](../docs/guides/upstream-sync.md) for full guide

> **Important:** Never use `git merge upstream-workspace/main` on a containment-model workspace. See the sync guide for why.

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
