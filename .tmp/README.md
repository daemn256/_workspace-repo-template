# Temporary Files Directory

This folder is designated for transient, working files that support development and exploration activities within the workspace. All contents are gitignored.

## Purpose

The `.tmp` directory serves as a sandbox for:

- **Scratch work** — Quick testing, drafts, and operational working files
- **Session context** — Continuity across AI assistant sessions
- **Generated scripts** — Helper scripts created during workflow automation
- **Generated artifacts** — Build outputs, logs, or test data
- **Documentation drafts** — Work-in-progress files before integration into main docs

## Subdirectories

### `sessions/`

Session context tracking for AI assistant continuity. See the [session tracking protocol](https://github.com/daemn256/_agentic-system/blob/main/src/process/session-tracking-protocol.md) for conventions.

Files here track what was accomplished, decisions made, and next steps across multi-turn sessions.

### `scratch/`

Working space for temporary files created during operations. This includes:

- Issue and PR body drafts
- Planning documents
- Intermediate processing files
- Quick validation scripts

See [scratch/README.md](scratch/README.md) for recognized patterns.

### `scripts/`

Generated helper scripts for workspace automation. Examples:

- `set-project-fields.sh` — Batch-update project board fields
- `sync-labels.sh` — Label synchronization helpers
- `migrate-*.sh` — One-off migration scripts

These are operational scripts generated during sessions, not permanent tooling (which belongs in `tools/`).

## Guidelines

✅ **What belongs here:**

- Active exploration and spike work
- One-off scripts or test files
- Temporary build/test artifacts
- Session-specific analysis
- Drafts awaiting review or integration
- AI assistant session context (in `sessions/`)
- Generated temporary files (in `scratch/`)
- Generated automation scripts (in `scripts/`)

❌ **What does NOT belong here:**

- Source code that should be in `src/` or project directories
- Architecture decisions (use `docs/adr/`)
- Finalized documentation (use `docs/`)
- Permanent project assets
- Sensitive credentials or private data
- Permanent tooling (use `tools/`)

## Lifecycle

- **Not version controlled** — The `.tmp` folder is gitignored
- **Sessions persist** — The `sessions/` directory should persist across sessions but may be archived periodically
- **Scratch is truly temporary** — The `scratch/` directory can be cleaned aggressively
- **Scripts are regenerable** — The `scripts/` directory can be rebuilt from session context
- **Best effort archival** — Important findings should be migrated to appropriate permanent locations
- **Regular maintenance** — Old/stale files should be cleaned up proactively

## Recommended Practices

1. Add a date prefix or context header to files for easy identification
2. Document what each file is for in a brief header comment
3. Move experimental findings to permanent storage when validated
4. Clean up after yourself when work is complete
5. Use subdirectories to organize by project or time period if needed

---

**Last updated:** February 14, 2026
