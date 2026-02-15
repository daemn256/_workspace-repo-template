# Documentation

Central documentation for this project.

## Structure

```
docs/
├── guides/                 # Operational guides for setup and maintenance
├── adr/                    # Architecture Decision Records
├── architecture/           # System architecture documentation
├── observations/           # Learnings and behavioral notes
├── proposals/              # Pre-ADR ideas and proposals
└── workspace/              # Copilot context and working space
```

## Directory Purposes

### guides/ — Operational Guides

How-to documentation for project setup and maintenance:

- [Getting Started](guides/getting-started.md) — Post-template setup checklist
- [Upstream Sync](guides/upstream-sync.md) — How to pull template updates

### adr/ — Architecture Decision Records

Formal decisions about architecture, design, or technology choices. Use the [ADR format](https://adr.github.io/):

```markdown
# ADR-0001: Use PostgreSQL for Primary Database

## Status

Accepted

## Context

...

## Decision

...

## Consequences

...
```

### architecture/ — System Architecture

High-level system design, diagrams, and architectural documentation. This is for understanding how the system works, not why decisions were made (that's in ADRs).

### observations/ — Learnings and Notes

Behavioral observations, patterns discovered, things learned during development. Use date-prefixed filenames:

```
observations/
├── 2026-02-07-copilot-instruction-layering.md
└── 2026-02-10-build-optimization.md
```

### proposals/ — Pre-ADR Ideas

Ideas and proposals that haven't yet been formalized into ADRs. Use numbered prefixes:

```
proposals/
├── P001-api-versioning-strategy.md
├── P002-implement-caching-layer.md
└── P003-adopt-event-sourcing.md
```

When a proposal is accepted, promote it to an ADR.

### workspace/ — Copilot Context

Context that helps GitHub Copilot understand the project:

- `context.md` — Project-specific terminology, patterns, conventions
- `goals.md` — Current objectives and priorities

For session continuity and temporary files, see [.tmp/](../.tmp/README.md).

---

## Best Practices

1. **Be concise** — Documentation should be easy to scan
2. **Use examples** — Show, don't just tell
3. **Keep it up to date** — Stale docs are worse than no docs
4. **Link liberally** — Connect related documents
5. **Date observations** — Use YYYY-MM-DD prefix for chronological sorting
