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
area: docs | infra | dx | agentic | tooling
status: proposed | completed | rejected | deferred
created: YYYY-MM-DD
completed: YYYY-MM-DD
outcome: implemented | rejected | superseded | deferred-indefinitely
tags: [tag1, tag2]
---
```

## Status Lifecycle

```
proposed → completed (outcome: implemented)
         → completed (outcome: rejected)
         → deferred (outcome: deferred-indefinitely)
```
