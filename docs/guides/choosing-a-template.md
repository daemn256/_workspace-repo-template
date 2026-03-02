# Choosing a Template

Three templates serve different needs. Use this guide to pick the right one.

## Quick Decision Tree

```
Do you need VS Code / Copilot integration?
├── No  → _repo-template
│         Minimal scaffold for any repository
│
└── Yes → Will you manage multiple repos in one workspace?
    │
    ├── No  → _workspace-repo-template
    │         Single-project workspace with full AI tooling
    │
    └── Yes → _workspace-root-template
              Multi-repo workspace with shared config
```

## Comparison Table

| Feature                          | \_repo-template | \_workspace-repo-template | \_workspace-root-template |
| -------------------------------- | :-------------: | :-----------------------: | :-----------------------: |
| Repo scaffold (docs, hooks, git) |       ✅        |            ✅             |            ✅             |
| VS Code configuration            |        —        |            ✅             |            ✅             |
| AI agents & instructions         |        —        |            ✅             |            ✅             |
| Skills & prompts                 |        —        |            ✅             |            ✅             |
| Multi-repo support (`repos/`)    |        —        |             —             |            ✅             |
| Sandbox / scratch space          |        —        |            ✅             |            ✅             |
| Session tracking (`.tmp/`)       |        —        |            ✅             |            ✅             |

## When to Use Each

### `_repo-template`

**Best for:** Libraries, packages, standalone tools, repositories that will be cloned into workspaces.

- Minimal footprint — just the essentials
- No IDE or AI tooling opinions
- Foundation for both workspace templates
- Use when the repo will live inside another workspace

### `_workspace-repo-template`

**Best for:** Single-project work where you want full AI assistance.

- One repo = one project = one workspace
- Pre-configured VS Code tasks (no project name prompts)
- Full AI tooling out of the box (Copilot, Claude, Junie)
- Ideal for focused work on a single codebase

### `_workspace-root-template`

**Best for:** Multi-project work, developer workspaces, monorepo-style setups.

- Manage multiple repos under one workspace
- VS Code tasks prompt for project name
- Can sync updates from both `_workspace-root-template` AND `_repo-template`
- Pre-push hooks protect against pushing to template URLs

## Template Inheritance

```
_repo-template (base)
    │
    ├── _workspace-repo-template
    │   Adds: .vscode/, .github/, .tmp/, sandbox/
    │
    └── _workspace-root-template
        Adds: .vscode/, .github/, .tmp/, sandbox/, repos/
```

Both workspace templates track `_repo-template` via the `upstream-repo` remote for cross-cutting improvements.

## Still Not Sure?

- **Start with `_workspace-repo-template`** if you're working on one project and want AI assistance
- You can always restructure later — the templates are scaffolds, not constraints

## See Also

- [Getting Started](getting-started.md) — post-template setup checklist
- [Upstream Sync](upstream-sync.md) — how to pull template updates into your workspace
- [Instruction Model](../architecture/instruction-model.md) — what AI tooling the workspace templates include
