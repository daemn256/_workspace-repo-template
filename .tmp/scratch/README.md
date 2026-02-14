# Scratch Files

> Temporary working files for operations and experiments.

This directory is for ephemeral files created during work sessions that don't need to persist long-term.

## Purpose

- Draft content being shaped before moving to final location
- Temporary outputs from tools or scripts
- Experimental code snippets being tested
- Working files during refactoring or migration tasks
- Generated output that needs review before committing elsewhere

## Recognized Patterns

These patterns are **conventions, not rules** — use them when they fit, ignore them when they don't.

| Pattern | Purpose | Example |
|---------|---------|---------|
| `issues/NN-slug.md` | Issue body files for `gh issue create -F` | `issues/42-redis-cache.md` |
| `prs/branch-name.md` | PR body files for `gh pr create --body-file` | `prs/feat-42-redis-cache.md` |
| `plan-*.md` | Planning documents | `plan-m2-sprint.md` |
| `*.sh` | One-off automation scripts | `bulk-rename.sh` |

## Lifecycle

Scratch files are:

- **Gitignored** — Never committed to version control
- **Short-lived** — Delete when no longer needed
- **Unstructured** — No naming conventions required beyond the optional patterns above
- **Safe to wipe** — Entire directory can be cleared without losing important work

## When to Use

Use scratch/ when you need:

- A place to dump working output temporarily
- Space to experiment without cluttering committed directories
- Intermediate files during multi-step operations
- Issue or PR body drafts before submission

## When NOT to Use

Don't use scratch/ for:

- **Session context** — Use [.tmp/sessions/](../sessions/) instead
- **Generated automation** — Use [.tmp/scripts/](../scripts/) for reusable helper scripts
- **Documentation** — Commit to appropriate `docs/` directory
- **Archival content** — Use `archive/` for historical preservation
- **Tracked experiments** — Consider `sandbox/` for committed experimental work

## Typical Contents

- `output.json` — API response being analyzed
- `draft.md` — Content being shaped
- `test-snippet.py` — Quick code test
- `refactor-plan.txt` — Working notes

Clear this directory periodically to prevent clutter.
