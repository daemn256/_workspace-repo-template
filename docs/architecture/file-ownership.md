# File Ownership

> Which files come from the template and which are yours.

---

## Three Tiers

Every file in the workspace belongs to one of three ownership tiers, defined by `template-manifest.yaml`. The tier determines what happens during upstream sync.

### Copy (Template-Owned)

Files that are copied verbatim from the workspace to template repos. Updated by syncing with upstream.

**On sync:** Accept the upstream version. Your customizations (if any) are overwritten.

**Examples:**

- `.github/agents/*.agent.md` — Agent definitions
- `.github/instructions/*.instructions.md` — Path-specific rules
- `.github/prompts/*.prompt.md` — Workflow prompts (except `forge-ops`)
- `.claude/agents/*.md` — Claude agent definitions
- `.claude/rules/*.md` — Claude path-specific rules
- `.claude/skills/*/SKILL.md` — Claude skills
- `.junie/**` — Junie configuration
- `.githooks/*` — Git hooks
- `tools/*` — Workspace tooling
- `docs/architecture/*` — Architecture documentation
- `docs/guides/*` — Guides

### Scaffold (Initial Structure)

Files that exist in templates with example structure. Consumer fills in real values after creating a workspace. Never overwritten by sync.

**On sync:** Keep your version. Scaffold provides the starting point only.

**Examples:**

- `workspace.config.yaml` — Workspace configuration
- `README.md` — Project README
- `CHANGELOG.md` — Project changelog
- `docs/workspace/context.md` — Domain knowledge
- `docs/workspace/goals.md` — Current priorities
- `docs/workspace/project-overlay.md` — Project identity for agents
- `.vscode/tasks.json` — VS Code task definitions

### Ignore (Consumer-Only)

Files that are never propagated. Created and maintained entirely by the consumer.

**On sync:** Not involved — these files don't exist in templates.

**Examples:**

- `docs/adr/*.md` — Architecture decisions (except README)
- `docs/observations/*.md` — Working notes (except README)
- `docs/proposals/*.md` — Design proposals (except README)
- `.github/prompts/forge-ops.prompt.md` — Consumer-specific forge bindings
- `repos/*` — Project repositories (multi-repo workspaces)
- `.tmp/*` — Ephemeral working directory

---

## File Classification

| Path                          | Tier     | Sync Behavior     |
| ----------------------------- | -------- | ----------------- |
| `.github/agents/`             | Copy     | Replaced on sync  |
| `.github/instructions/`       | Copy     | Replaced on sync  |
| `.github/prompts/*`           | Copy     | Replaced on sync  |
| `.github/prompts/forge-ops.*` | Ignore   | Consumer-specific |
| `.claude/agents/`             | Copy     | Replaced on sync  |
| `.claude/rules/`              | Copy     | Replaced on sync  |
| `.claude/skills/`             | Copy     | Replaced on sync  |
| `.junie/`                     | Copy     | Replaced on sync  |
| `.githooks/`                  | Copy     | Replaced on sync  |
| `.vscode/tasks.json`          | Scaffold | Keep yours        |
| `.vscode/settings.json`       | Copy     | Replaced on sync  |
| `tools/`                      | Copy     | Replaced on sync  |
| `docs/architecture/`          | Copy     | Replaced on sync  |
| `docs/guides/`                | Copy     | Replaced on sync  |
| `docs/workspace/templates/`   | Copy     | Replaced on sync  |
| `workspace.config.yaml`       | Scaffold | Keep yours        |
| `README.md`                   | Scaffold | Keep yours        |
| `CHANGELOG.md`                | Scaffold | Keep yours        |
| `docs/workspace/context.md`   | Scaffold | Keep yours        |
| `docs/workspace/goals.md`     | Scaffold | Keep yours        |
| `docs/workspace/overlay.md`   | Scaffold | Keep yours        |
| `docs/adr/*.md`               | Ignore   | Consumer-only     |
| `docs/observations/*.md`      | Ignore   | Consumer-only     |
| `docs/proposals/*.md`         | Ignore   | Consumer-only     |
| `repos/*`                     | Ignore   | Consumer-only     |
| `.tmp/*`                      | Ignore   | Consumer-only     |

The full classification is defined in `template-manifest.yaml` at the workspace root.

---

## Sync Model

1. Consumer fetches upstream template: `git fetch upstream-workspace`
2. Merge: `git merge upstream-workspace/main`
3. Copy-tier files: accept upstream changes
4. Scaffold-tier files: keep your version, resolve any conflicts
5. Ignore-tier files: not involved in sync

The [Upstream Sync](../guides/upstream-sync.md) guide covers the full procedure.

---

## Related

- [Operating Model](operating-model.md) — How content flows from workspace to templates
- [Configuration](configuration.md) — The config-reference pattern
- [Instruction Model](instruction-model.md) — What the template-provided instruction files contain
- [Upstream Sync](../guides/upstream-sync.md) — Step-by-step sync procedure
