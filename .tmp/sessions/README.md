# Session Files

> Ephemeral session context for GitHub Copilot continuity.

This directory contains session tracking files that help maintain context across GitHub Copilot conversations within a workspace.

## Purpose

When working on complex tasks that span multiple Copilot sessions, session files provide continuity:

- Track what was discussed and decided
- Document work-in-progress state
- Provide context when resuming after interruption
- Link related sessions chronologically

## Format

```
YYYY-MM-DD-descriptive-name.md
```

Example: `2026-02-07-api-migration-progress.md`

## Typical Contents

- Summary of work completed in the session
- Decisions made
- Open questions or blockers
- Next steps
- Links to related files, commits, or issues

## Lifecycle

Session files are:

- **Gitignored** — They contain ephemeral working state
- **Local to your machine** — Not shared with collaborators
- **Disposable** — Can be deleted when no longer needed for context
- **Copilot-friendly** — Written in a format that helps AI assistants understand workspace state

## Attachment Pattern

You can attach this folder to Copilot threads using `#file:.tmp/sessions` to give context about recent work history.

## Related

- [Scratch Directory](../scratch/) — Temporary working files
- [Workspace Context](../../docs/workspace/) — Committed workspace state
