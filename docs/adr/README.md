# Architecture Decision Records

This directory contains Architecture Decision Records (ADRs) documenting significant architectural and design decisions.

## Format

Use the standard ADR format:

```markdown
# ADR-####: Title

## Status

[Proposed | Accepted | Deprecated | Superseded by ADR-####]

## Context

What is the issue we're addressing? What factors are relevant?

## Decision

What decision did we make? Be specific and actionable.

## Consequences

What are the positive and negative outcomes of this decision?
```

## Numbering

- Use sequential 4-digit numbers: `0001`, `0002`, `0003`
- Numbers are never reused, even if an ADR is deprecated
- Use hyphens in filenames: `0001-use-postgresql.md`

## Lifecycle

1. **Proposed** — Under discussion, not yet decided
2. **Accepted** — Decision is made and active
3. **Deprecated** — No longer relevant
4. **Superseded** — Replaced by a newer ADR (reference the new one)
