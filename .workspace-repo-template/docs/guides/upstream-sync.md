# Upstream Sync

Periodically sync your workspace with the template to get improvements, new features, and bug fixes.

## Important: Why `git merge` Doesn't Work

> **Never run `git merge upstream-workspace/main` on a workspace created from a containment-model template.**

The template repository's root is bare — it contains only the containment directory (`.workspace-repo-template/`). Your workspace root has customized files (`README.md`, `CHANGELOG.md`, etc.) that don't exist in upstream. A standard merge would interpret this as "upstream deleted all root files" and try to remove them.

Instead, use **selective extraction** — pulling only the containment directory from upstream while leaving your workspace root untouched.

## When to Sync

- **After template releases** — Check the template repo for new versions
- **Periodically** — Monthly or quarterly to stay reasonably current
- **Before major work** — Sync first to minimize future merge conflicts

## The Sync Workflow

### Option A: Use the Sync Script (Recommended)

```bash
# Preview changes (dry run)
tools/sync-upstream.sh

# Apply changes
tools/sync-upstream.sh --apply

# Review and commit
git diff --cached --stat
git commit -m "chore: sync containment from upstream"
git push origin main
```

The script handles fetching, comparing, extracting, and staging automatically.

### Option B: Manual Sync

If you prefer manual control:

#### Step 1: Fetch Template Changes

```bash
git fetch upstream-workspace
```

#### Step 2: Review What's New

```bash
# See commit summary
git log HEAD..upstream-workspace/main --oneline

# See file changes in containment
git diff HEAD upstream-workspace/main -- .workspace-repo-template/ --stat
```

#### Step 3: Extract Containment Directory

```bash
git checkout upstream-workspace/main -- .workspace-repo-template/
```

This replaces your local `.workspace-repo-template/` with the exact upstream version. Your workspace root files are **completely unaffected**.

#### Step 4: Stage and Commit

```bash
git add .workspace-repo-template/
git commit -m "chore: sync containment from upstream"
```

#### Step 5: Apply Changes to Your Workspace (Optional)

After syncing the containment directory, compare it with your root to see if you want to adopt any changes:

```bash
# See differences between containment reference and your workspace
diff -r .workspace-repo-template/ ./ --exclude=.git --exclude=.workspace-repo-template
```

See the [Development Workflow](development-workflow.md) guide for the full adoption process, including selective adoption vs full adoption (`copy-template.sh`).

For **template-owned files** (agents, instructions, prompts, hooks, tools), copy from containment:

```bash
# Example: adopt a specific tool update
cp .workspace-repo-template/tools/check-drift.sh tools/check-drift.sh
```

For **rendered files** (CLAUDE.md, copilot-instructions.md, etc.), re-render after adoption:

```bash
tools/render-instructions.sh
```

For **consumer-owned files** (`workspace.config.yaml`, `README.md`, `docs/workspace/*`), keep your versions.

#### Step 6: Push

```bash
git push origin main
```

## Ownership Model

The containment directory preserves the complete upstream reference. Your workspace root contains your customized versions. Three ownership tiers exist:

| Location                                  | Tier             | Sync Strategy                                                |
| ----------------------------------------- | ---------------- | ------------------------------------------------------------ |
| `.workspace-repo-template/` (containment) | **Template**     | Always overwritten by sync — this IS the upstream reference  |
| `.github/agents/*`, `.github/instructions/*`, `.github/prompts/*` | **Template** | Copy from containment after sync |
| `.githooks/*`, `.vscode/*`, `tools/*` (from containment) | **Template** | Copy from containment after sync |
| `CLAUDE.md`, `.github/copilot-instructions.md`, `.github/AGENTS.md` | **Rendered** | Re-run `tools/render-instructions.sh` after sync |
| `.junie/guidelines.md`, `.claude/skills/pr/SKILL.md` | **Rendered** | Re-run `tools/render-instructions.sh` after sync |
| `workspace.config.yaml`                   | **Consumer**     | Never overwritten — your config values                       |
| `README.md`, `CHANGELOG.md`, `LICENSE`    | **Consumer**     | Never overwritten by sync                                    |
| `docs/workspace/*` (context, goals)       | **Consumer**     | Never overwritten by sync                                    |
| `docs/adr/*`, `docs/observations/*`       | **Consumer**     | Your workspace-specific docs                                 |

For the complete ownership model, see the [Development Workflow](development-workflow.md) guide.

## Sync Checklist

- [ ] Run `tools/sync-upstream.sh` (or manual fetch + checkout)
- [ ] Review staged changes: `git diff --cached --stat`
- [ ] Commit: `git commit -m "chore: sync containment from upstream"`
- [ ] Compare containment with workspace root for template-owned files to adopt
- [ ] Copy updated template-owned files to root if desired
- [ ] Test workspace: Open in VS Code, verify Copilot works
- [ ] Push: `git push origin main`
- [ ] Update CHANGELOG.md with sync note

## Skipping Specific Changes

Since sync only updates the containment directory, you never need to reject changes there — it's the pure upstream reference. You control whether to adopt changes into your workspace root by choosing which files to copy.

If upstream adds something you don't want in your workspace, simply don't copy it from containment to root. The containment directory will have it (as a reference) but your workspace won't use it.

## See Also

- [Development Workflow](development-workflow.md) — Full pipeline flow, adoption strategies, file ownership
- [Remote Management](remote-management.md) — Remote configuration and the satellite model
