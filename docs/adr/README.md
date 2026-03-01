# Architecture Decision Records

This directory contains Architecture Decision Records (ADRs) documenting significant architectural and design decisions.

> **Fresh start.** Prior ADRs were cleared during the architectural simplification (#77). The numbering restarts at 0001.

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

## Resources

- [ADR GitHub Organization](https://adr.github.io/)
- [Documenting Architecture Decisions](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions)
