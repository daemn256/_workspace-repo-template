# Documentation

Central documentation for the workspace and its projects.

> **Scope:** This `docs/` folder documents the enclosing workspace. Each repository under `repos/` maintains its own documentation for its own concerns.

## Structure

```
docs/
├── architecture/           # How the workspace is structured
├── guides/                 # Operational how-to documentation
├── adr/                    # Architecture Decision Records
├── notes/                  # Research findings and analysis notes
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

### notes/ — Research and Analysis

Research findings, design thinking, behavioral observations, and analysis notes. Use date-prefixed filenames (`YYYY-MM-DD-title.md`). Broader than observations — captures any durable thinking worth preserving.

### workspace/ — Project Context

Context that helps AI agents understand the workspace:

- `context.md` — Tech stack, domain terms, architecture, key conventions
- `goals.md` — Durable priorities, milestones, backlog

For active sprint state and session continuity, see `.tmp/workspace/` and `.tmp/sessions/`.
