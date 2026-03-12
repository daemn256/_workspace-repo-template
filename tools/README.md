# Workspace Tools

Automation scripts for workspace-level operations — setup, git configuration, maintenance, and instruction rendering.

---

## Setup

### setup.sh

**One-time workspace setup after creating from the template.**

```bash
./tools/setup.sh
```

- Seeds real files from `.template` variants (first init only — skips if real file exists)
- Configures git to use `.githooks/` directory
- Adds `upstream` remote (this template — fetch-only)
- Adds `upstream-repo` remote (parent template — fetch-only)
- Blocks push to both upstream remotes

### setup-githooks.sh

**Configures git to use the `.githooks/` directory.**

```bash
./tools/setup-githooks.sh
```

- Sets `core.hooksPath` to `.githooks/`
- Idempotent — safe to re-run

### setup-remotes.sh

**Configures upstream template remotes for tracking updates.**

```bash
./tools/setup-remotes.sh
```

- Adds `upstream-workspace` and `upstream-repo` remotes (fetch-only)
- Migrates legacy `upstream` remotes to `upstream-workspace`
- Idempotent — safe to re-run

---

## Rendering

### render-instructions.sh (Deprecated)

**Deprecated.** The token-based rendering system has been replaced by the config-reference pattern. Agents now read `workspace.config.yaml` directly at runtime.

```bash
./tools/render-instructions.sh  # Prints deprecation notice and exits
```

- This stub exists for backward compatibility only
- Use `tools/sync-to-templates.sh` to propagate changes to template repos
- See `docs/architecture/configuration.md` for the config-reference model

---

## Validation

### validate-templates.sh

**Validates template repos in `repos/` for structural consistency.**

```bash
./tools/validate-templates.sh
```

- Checks `.template.yaml` metadata
- Validates directory structure per template type
- Checks for stale references
- Verifies setup.sh URL consistency

---

## Purpose

This directory contains utilities that help maintain and operate the workspace as a whole. These should be practical tools that remain useful regardless of which projects exist in `repos/`.

## What Belongs Here

- Workspace maintenance scripts (batch operations, cleanup, validation)
- Environment setup or verification scripts
- Git workflow helpers
- Tools referenced by `.vscode/tasks.json`

## What Does NOT Belong Here

- Project-specific tools (those belong in the project's own directory)
- Build/test/run scripts (those belong in individual project repos)
- One-off experiments (use `sandbox/` or `.tmp/scratch/` instead)
