# AI Runtimes

> Reference documentation for AI runtime providers supported by this workspace.
>
> **Last verified:** March 2026

---

## Overview

This workspace runs three AI runtimes simultaneously, declared in `workspace.config.yaml` under `adapters.ai-runtimes`. Each runtime has different capabilities, configuration mechanisms, and authoring conventions.

These guides serve two audiences:

- **Humans** setting up or customizing a workspace — understand what each runtime supports and how to optimize your instruction files
- **AI agents** reading during task execution — understand your own loading model, tool surface, and configuration constraints

---

## Runtime Comparison

| Runtime                               | Guide    | Instruction Model     | Agents  | Skills/Prompts | Path Rules | MCP     |
| ------------------------------------- | -------- | --------------------- | ------- | -------------- | ---------- | ------- |
| [GitHub Copilot](github-copilot.md)   | Complete | Multi-file decomposed | Yes (6) | Yes (21)       | Yes (17)   | Yes     |
| [Claude Code](claude-code.md)         | Complete | Multi-file decomposed | Yes (6) | Yes (20)       | Yes (17)   | Yes     |
| [JetBrains Junie](jetbrains-junie.md) | Complete | Single monolith       | No      | No             | No         | Limited |

---

## Feature Matrix (Cross-Runtime)

| Feature             | Copilot                           | Claude Code                       | Junie                      |
| ------------------- | --------------------------------- | --------------------------------- | -------------------------- |
| Global instructions | `.github/copilot-instructions.md` | `CLAUDE.md`                       | `.junie/guidelines.md`     |
| Path-scoped rules   | `.instructions.md` (`applyTo:`)   | `.claude/rules/*.md` (`paths:`)   | N/A — inline in guidelines |
| Agent definitions   | `.agent.md` (handoffs)            | `.claude/agents/*.md` (subagents) | N/A — inline in guidelines |
| Reusable workflows  | `.prompt.md` (VS Code only)       | `.claude/skills/*/SKILL.md`       | N/A — inline in guidelines |
| Multi-agent routing | Handoffs (VS Code)                | Task tool (subagents)             | No                         |
| Lifecycle hooks     | Coding Agent + CLI only           | 14 hook events                    | No                         |
| Model selection     | Per-agent/prompt                  | Per-agent/skill                   | No                         |
| Permission control  | No                                | Allow/Ask/Deny                    | No                         |
| MCP servers         | `.vscode/mcp.json`                | `.mcp.json`                       | Limited                    |

---

## Cross-Runtime Patterns

### Agent Double-Registration in VS Code

When both `github-copilot` and `claude-code` are active, VS Code discovers agents from **both** `.github/agents/` and `.claude/agents/`. If the same persona exists in both locations, it appears twice in the Copilot Chat picker:

- `.github/agents/` variant — fully featured (handoffs, native tool aliases)
- `.claude/agents/` variant — degraded mode (name, description, tool mapping, instructions only)

This is intentional VS Code interop behavior and doesn't cause errors.

### Content Parity Strategy

All three runtimes receive the same core behavioral content. The workspace maintains parity by:

1. **Editing all three** when global content changes (Copilot + Claude + Junie)
2. **Editing two** when structured content changes (Copilot + Claude — Junie gets it inline)
3. **Using `tools/sync-to-templates.sh`** to propagate changes to template repos

---

## Maintenance

These guides are living documentation. They require periodic review to stay accurate as runtimes evolve.

### Currency Policy

Each guide file includes a `Last verified:` date in the header. This date reflects when:

- External documentation links were checked and confirmed working
- Feature matrices were verified against current runtime capabilities
- Schema properties were compared against official documentation

### Review Checklist

When reviewing a runtime guide:

1. **Test external links** — click every URL in the "Official Documentation" section
2. **Verify feature matrices** — check against the runtime's latest release notes
3. **Check schema properties** — compare frontmatter fields against official schema docs
4. **Update `Last verified:` date** — bump the date in the file header after verification
5. **Commit the update** — even if nothing changed, the date bump confirms the review

### Suggested Cadence

- **On runtime major releases** — review the affected guide immediately
- **Quarterly** — review all three guides as a batch
- **On authoring errors** — if an agent produces invalid frontmatter, check whether the guide's schema section is outdated

---

## Related

- [Instruction Model](../../architecture/instruction-model.md) — the 4-layer conceptual model
- [Authoring Instructions](../authoring-instructions.md) — how to create and edit instruction files
- [Configuration](../../architecture/configuration.md) — workspace.config.yaml schema
