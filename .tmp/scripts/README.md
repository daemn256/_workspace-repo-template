# Generated Scripts

> Helper scripts generated during workspace automation sessions.

This directory is for operational scripts created by AI assistants or during workflow sessions. Unlike `tools/` (permanent, committed tooling), these are regenerable and gitignored.

## Examples

- `set-project-fields.sh` — Batch-update project board field values
- `sync-labels.sh` — Label synchronization across repos
- `migrate-issues.sh` — One-off issue migration helpers
- `bulk-rename.sh` — Batch file operations

## Conventions

- Scripts should include a header comment explaining their purpose
- Mark scripts as executable (`chmod +x`)
- Prefer idempotent operations where possible
- Reference the session or issue that generated them

## When to Use

Use scripts/ when:

- An AI assistant generates a reusable automation script during a session
- You need a helper script that will be used multiple times but isn't permanent tooling
- A workflow produces scripts that others might re-run

## When NOT to Use

Don't use scripts/ for:

- **Permanent tooling** — Commit to `tools/` instead
- **One-shot commands** — Just run them in the terminal
- **Scratch files** — Use [.tmp/scratch/](../scratch/) for truly ephemeral files
