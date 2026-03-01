# Proposals

> "We should do Y" — numbered work items with tracked status.

## Format

```
P###-short-description.md
```

## Frontmatter Schema

```yaml
---
id: P001
title: Short title
area: docs | infra | dx | agentic | tooling # topic/project area
status: proposed | completed | rejected | deferred
created: YYYY-MM-DD
completed: YYYY-MM-DD # when status changes
outcome: implemented | rejected | superseded | deferred-indefinitely
tags: [tag1, tag2]
---
```

## Status Lifecycle

```
proposed → completed (outcome: implemented)
         → completed (outcome: rejected)
         → completed (outcome: superseded)
         → deferred
```

## Conventions

- **Future work** from completed proposals → create new proposal to track it
- Completed proposals are archival; active work lives in proposed state
- Number proposals sequentially (P001, P002, P003...)
- Use descriptive kebab-case for file names after the number

## Subdirectories

- `_completed/` — Finished proposals with any outcome (implemented, rejected, superseded)

## Starting Your First Proposal

When you identify an improvement or new feature:

1. Create a new file: `P001-your-idea.md`
2. Add frontmatter with `status: proposed`
3. Describe the problem, proposed solution, and alternatives considered
4. Update status when work begins or completes

Proposals provide a lightweight way to track ideas without heavyweight project management tooling.
