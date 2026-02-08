# Scratch Files

> Temporary working files for operations and experiments.

This directory is for ephemeral files that Copilot or you create during work sessions but don't need to persist long-term.

## Purpose

- Temporary outputs from tools or scripts
- Draft content being shaped before moving to final location
- Experimental code snippets being tested
- Working files during refactoring or migration tasks
- Generated output that needs review before committing elsewhere

## Lifecycle

Scratch files are:

- **Gitignored** — Never committed to version control
- **Short-lived** — Delete when no longer needed
- **Unstructured** — No naming conventions required
- **Safe to wipe** — Entire directory can be cleared without losing important work

## When to Use

Use scratch/ when you need:

- A place to dump working output temporarily
- Space to experiment without cluttering committed directories
- Intermediate files during multi-step operations

## When NOT to Use

Don't use scratch/ for:

- **Session context** — Use [.tmp/sessions/](../sessions/) instead
- **Documentation** — Commit to appropriate `docs/` directory
- **Archival content** — Use `archive/` for historical preservation
- **Tracked experiments** — Consider `sandbox/` for committed experimental work

## Typical Contents

- `output.json` — API response being analyzed
- `draft.md` — Content being shaped
- `test-snippet.py` — Quick code test
- `refactor-plan.txt` — Working notes

Clear this directory periodically to prevent clutter.
