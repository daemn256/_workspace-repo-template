# Temporary Files Directory

This folder is designated for transient, working files that support development and exploration activities within the workspace.

## Purpose

The `.tmp` directory serves as a sandbox for:

- **Experiment notebooks** - Jupyter notebooks, Python scripts, or other explorations
- **Scratch work** - Quick testing grounds that don't belong in permanent storage
- **Generated artifacts** - Build outputs, logs, or test data
- **Process files** - Utilities created during active development sessions
- **Documentation drafts** - Work-in-progress files before integration into main docs

## Subdirectories

### `sessions/`

Session context tracking for GitHub Copilot. This directory maintains continuity between Copilot sessions by storing:

- Session state and context snapshots
- Active work summaries
- References useful across sessions
- Progress checkpoints

These files help Copilot understand what has been accomplished and what remains to be done when resuming work.

### `scratch/`

Working space for temporary files that Copilot needs to create during operations. This includes:

- Intermediate processing files
- Temporary data structures
- Quick validation scripts
- Files created during analysis or code generation

Files here are truly ephemeral and can be deleted immediately after the operation completes.

## Guidelines

✅ **What belongs here:**

- Active exploration and spike work
- One-off scripts or test files
- Temporary build/test artifacts
- Session-specific notebooks or analysis
- Drafts awaiting review or integration
- Copilot session context (in `sessions/`)
- Copilot-generated temporary files (in `scratch/`)

❌ **What does NOT belong here:**

- Source code that should be in `repos/`
- Architecture decisions (use `docs/adr/`)
- Finalized documentation (use `docs/`)
- Permanent project assets
- Sensitive credentials or private data

## Lifecycle

- **No guarantees** - Files may be deleted without notice during cleanup
- **Sessions exception** - The `sessions/` directory should persist across Copilot sessions but may be archived periodically
- **Scratch is truly temporary** - The `scratch/` directory can be cleaned aggressively and frequently
- **Best effort archival** - Important findings should be migrated to appropriate permanent locations
- **Regular maintenance** - Old/stale files should be cleaned up proactively
- **Not version controlled** - The `.tmp` folder should not be committed to git

## Recommended Practices

1. Add a date prefix or context header to files for easy identification
2. Document what each file is for in a brief header comment
3. Move experimental findings to permanent storage when validated
4. Clean up after yourself when work is complete
5. Use subdirectories to organize by project or time period if needed

---

**Last updated:** February 7, 2026
