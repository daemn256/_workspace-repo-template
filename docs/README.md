# Documentation

Central documentation for the workspace and its projects.

> **Scope:** This `docs/` folder documents the enclosing workspace. Each repository under `repos/` maintains its own documentation for its own concerns.

## Structure

```
docs/
├── architecture/           # How the workspace is structured
├── guides/                 # Operational how-to documentation
├── adr/                    # Architecture Decision Records
├── observations/           # Learnings and behavioral notes
├── proposals/              # Pre-ADR ideas and proposals
└── workspace/              # Project context for AI agents
```

## Directory Purposes

### architecture/ — Workspace Structure

How the instruction model, configuration, and file ownership work:

- [Instruction Model](architecture/instruction-model.md) — 4-layer hierarchy and per-runtime structure
- [Configuration](architecture/configuration.md) — How workspace-specific values reach AI agents
- [File Ownership](architecture/file-ownership.md) — Template-provided vs consumer-owned files

### guides/ — Operational Guides

How-to documentation for workspace setup and maintenance:

- [Choosing a Template](guides/choosing-a-template.md) — Which template fits your needs
- [Getting Started](guides/getting-started.md) — Post-template setup checklist
- [Authoring Instructions](guides/authoring-instructions.md) — Creating agents, skills, and rules
- [Upstream Sync](guides/upstream-sync.md) — How to pull template updates

### adr/ — Architecture Decision Records

Formal decisions about architecture, design, or technology choices. Use the [ADR format](https://adr.github.io/). Numbering starts fresh from #77.

### observations/ — Learnings and Notes

Behavioral observations, patterns discovered, things learned during development. Use date-prefixed filenames (`YYYY-MM-DD-title.md`).

### proposals/ — Pre-ADR Ideas

Ideas and proposals that haven't yet been formalized into ADRs. Use numbered prefixes (`P001-title.md`). When accepted, promote to an ADR.

### workspace/ — Project Context

Context that helps AI agents understand the workspace:

- `context.md` — Tech stack, domain terms, architecture, key conventions
- `goals.md` — Current objectives and priorities

For session continuity and temporary files, see [.tmp/](../.tmp/README.md).
