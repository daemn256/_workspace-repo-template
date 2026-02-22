# Development Workflow

> How changes flow through the system — from kernel source to downstream workspace. This is the authoritative reference for where to make changes and how they propagate.

---

## The Pipeline

Changes flow **one direction only** — upstream to downstream:

```
┌─────────────────────────────────────┐
│  1. Agentic Kernel                  │
│     (_agentic-system)               │
│                                     │
│  docs/guides → src/ → engine/       │
│  build.sh → verify.sh → release.sh  │
│  tools/templates/sync.sh            │
└──────────────┬──────────────────────┘
               │ sync.sh writes into template containment
               ▼
┌─────────────────────────────────────┐
│  2. Template Source Repos           │
│     (_workspace-repo-template,      │
│      _workspace-repo-template)      │
│                                     │
│  .workspace-repo-template/  ← product│
│  tools/ ← workspace tooling source  │
└──────────────┬──────────────────────┘
               │ git push → consumer fetches
               ▼
┌─────────────────────────────────────┐
│  3. Consumer Workspace              │
│     (your workspace)                │
│                                     │
│  .workspace-repo-template/  ← READ-ONLY containment │
│  tools/sync-upstream.sh     ← updates containment    │
│  tools/copy-template.sh     ← full adoption          │
│  tools/render-instructions.sh ← fills config values  │
│  workspace.config.yaml      ← your config            │
└─────────────────────────────────────┘
```

---

## Where Does the Work Go?

### Decision Tree

Ask yourself: **What am I changing?**

| What You're Changing | Where to Edit | Example |
|---|---|---|
| AI personas, workflows, skillsets | `_agentic-system/src/` | Adding a new persona |
| Build engine / transform rules | `_agentic-system/engine/` | New platform adapter |
| Build/release/verify tooling | `_agentic-system/tools/` | Fixing build.sh |
| Kernel documentation | `_agentic-system/docs/` | New ADR or guide |
| Workspace tooling (sync, drift, check) | `_workspace-repo-template/.workspace-repo-template/tools/` | Fixing sync-upstream.sh |
| Template-owned docs (guides, READMEs) | `_workspace-repo-template/.workspace-repo-template/docs/` | Updating this file |
| Instruction file templates (with `{{{tokens}}}`) | `_workspace-repo-template/.workspace-repo-template/` | Adding a token to CLAUDE.md |
| Your workspace config | `workspace.config.yaml` (workspace root) | Changing build command |
| Your project docs, context, goals | `docs/workspace/` (workspace root) | Updating goals.md |

### The Cardinal Rule

> **NEVER edit the containment directory in a consumer workspace.**
>
> The `.workspace-repo-template/` directory at the workspace root is **read-only**. It is the upstream reference copy. Only `tools/sync-upstream.sh --apply` writes to it.
>
> If you need to change something in containment, make the change in the **source template repo** (`_workspace-repo-template`), push it, then sync downstream.

---

## Propagation Workflows

### Kernel → Template Repos (Maintainer)

When you change kernel source (`_agentic-system`):

```bash
# 1. Build
cd repos/_agentic-system
./tools/build.sh            # All platforms, or: ./tools/build.sh github-copilot

# 2. Verify
./tools/verify.sh

# 3. Release
./tools/release.sh <version>

# 4. Sync to template repos
./tools/templates/sync.sh /path/to/_workspace-repo-template
./tools/templates/sync.sh /path/to/_workspace-repo-template

# 5. Commit and push template repos
cd /path/to/_workspace-repo-template
git add -A && git commit -m "chore: sync kernel vX.Y.Z"
git push origin main
```

### Template Repo → Consumer Workspace (Consumer)

When the upstream template has new content:

```bash
# 1. Check if there are updates
tools/check-upstream.sh

# 2. Sync containment from upstream
tools/sync-upstream.sh --apply

# 3. Review what changed
git diff --cached --stat

# 4. Commit the containment update
git commit -m "chore: sync containment from upstream"

# 5. Adopt changes to workspace root (see Adoption below)
```

### Template Source Repo → Consumer Workspace (Template Maintainer with Local Source)

When you have the template source repo cloned locally (e.g., in a multi-repo workspace):

```bash
# 1. Push source repo changes
cd repos/_workspace-repo-template
git push origin main

# 2. Fetch in workspace
cd /path/to/workspace
git fetch upstream-workspace

# 3. Sync containment
tools/sync-upstream.sh --apply

# 4. Adopt (see below)
```

---

## Adoption: Containment → Workspace Root

After syncing containment, you need to **adopt** changes into your workspace root.

### Full Adoption (Initial Setup Only)

```bash
tools/copy-template.sh
```

> **WARNING:** `copy-template.sh` is a **blunt instrument**. It copies everything from containment to root, **overwriting consumer-customized files** (workspace.config.yaml, CHANGELOG.md, LICENSE, README.md, docs/workspace/*, etc.).
>
> **Use only for initial workspace setup.** For incremental updates, use selective adoption instead.

### Selective Adoption (Incremental Updates)

For routine syncs, selectively copy only the files that changed:

```bash
# See what changed in containment
git diff HEAD~1 --name-only -- .workspace-repo-template/

# Copy specific files (examples)
cp .workspace-repo-template/tools/check-drift.sh tools/check-drift.sh
cp .workspace-repo-template/.github/prompts/issue.prompt.md .github/prompts/issue.prompt.md
```

### Re-render Instruction Files

After any adoption that changes instruction file templates:

```bash
tools/render-instructions.sh
```

This reads `workspace.config.yaml` + containment templates → produces root instruction files with your consumer values filled in. Files with a `<!-- GENERATED -->` header are products of this tool.

---

## Drift Detection

Two tools help you understand the relationship between containment and your workspace:

### Am I Behind?

```bash
tools/check-upstream.sh           # Quick: are there upstream updates?
tools/check-upstream.sh --verbose  # Show commit log and diff
```

### What's Different?

```bash
tools/check-drift.sh              # Summary of all file states
tools/check-drift.sh --verbose    # Show diffs for modified files
```

Drift categories:

| Category | Meaning | Action |
|---|---|---|
| **Unchanged** | Root = containment (identical) | Nothing to do |
| **Rendered** | Has `GENERATED` header — expected drift from render-instructions.sh | Normal — re-render if needed |
| **Modified** | Consumer changed a template-owned file | Review: intentional customization or accidental edit? |
| **Not adopted** | In containment but not at root | Newly added upstream — consider adopting |
| **Consumer-owned** | At root but not in containment | Your files — upstream doesn't manage these |

---

## File Ownership Model

Three ownership tiers determine how files are managed:

### Template-Owned

Files that come from containment and should match upstream exactly. After sync, copy from containment to root.

**Examples:** `.claude/rules/*`, `.github/agents/*`, `.github/instructions/*`, `.github/prompts/*`, `.githooks/*`, `tools/sync-upstream.sh`, `tools/copy-template.sh`, `tools/render-instructions.sh`

### Dual-Owned (Rendered)

Files with template-managed structure AND consumer-owned values. Source templates live in containment with `{{{placeholder}}}` tokens. `render-instructions.sh` reads `workspace.config.yaml` and produces the root versions.

**Examples:** `CLAUDE.md`, `.github/copilot-instructions.md`, `.github/AGENTS.md`, `.junie/guidelines.md`, `.claude/skills/pr/SKILL.md`, `.github/prompts/address-feedback.prompt.md`, `.github/prompts/issue.prompt.md`, `.github/prompts/pr.prompt.md`

**Identifying mark:** `<!-- GENERATED by tools/render-instructions.sh -->` header comment.

### Consumer-Owned

Files that exist only at the workspace root. Upstream never creates or modifies these.

**Examples:** `workspace.config.yaml`, `docs/workspace/context.md`, `docs/workspace/goals.md`, `docs/adr/*`, `docs/observations/*`, `docs/proposals/*`, `CHANGELOG.md` (consumer content), `README.md` (consumer content), `LICENSE` (consumer content)

---

## Common Mistakes

| Mistake | Consequence | Prevention |
|---|---|---|
| Editing `.workspace-repo-template/` directly | Next `sync-upstream.sh` overwrites your changes | Edit in source repo, push, sync |
| Running `copy-template.sh` on an established workspace | Clobbers your workspace.config.yaml, CHANGELOG, README, etc. | Use selective adoption instead |
| Editing rendered files (CLAUDE.md, etc.) by hand | Next `render-instructions.sh` overwrites your edits | Edit `workspace.config.yaml` or the containment template |
| Running `git merge upstream-workspace/main` | Deletes all root files (upstream root is empty) | Use `sync-upstream.sh` instead |
