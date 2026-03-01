# Upstream Sync

Periodically sync your workspace with the upstream template to get improvements, new agents, instruction updates, and bug fixes.

## Remote Setup

Your workspace has two Git remotes:

| Remote               | Points To                         | Purpose                    |
| -------------------- | --------------------------------- | -------------------------- |
| `origin`             | Your workspace repo               | Your day-to-day work       |
| `upstream-workspace` | The template repo you forked from | Source of template updates |

### Adding the Upstream Remote

If you created your workspace from a GitHub template (not a fork), add the upstream remote manually:

```bash
git remote add upstream-workspace https://github.com/<org>/<template-repo>.git
```

### Push Protection

Prevent accidental pushes to the template repo:

```bash
git remote set-url --push upstream-workspace no-push
```

This sets the push URL to the literal string `no-push`, which will fail if you accidentally try to push upstream. Pulls still work normally.

## When to Sync

- **After template releases** — check the template repo's CHANGELOG or releases
- **Periodically** — monthly or quarterly to stay reasonably current
- **Before major work** — sync first to minimize future merge conflicts

## Sync Workflow

Template files live at root (no containment extraction needed). Sync is a standard `git merge`:

### Step 1: Fetch

```bash
git fetch upstream-workspace
```

### Step 2: Review What Changed

```bash
git log HEAD..upstream-workspace/main --oneline
git diff HEAD..upstream-workspace/main --stat
```

### Step 3: Merge

```bash
git merge upstream-workspace/main --no-edit
```

Git handles this like any merge. Template-provided files update automatically. Consumer-owned files you've modified may produce merge conflicts — resolve them by keeping your versions.

### Step 4: Resolve Conflicts

If conflicts occur, they'll almost always be in consumer-owned files where both you and the template made changes. Resolution rule:

| File Tier             | Resolution                                  |
| --------------------- | ------------------------------------------- |
| **Template-provided** | Accept upstream (theirs) — template owns it |
| **Consumer-owned**    | Keep yours (ours) — you own it              |

```bash
# Accept upstream version for a template-provided file
git checkout --theirs .github/agents/implementer.agent.md
git add .github/agents/implementer.agent.md

# Keep your version for a consumer-owned file
git checkout --ours workspace.config.yaml
git add workspace.config.yaml
```

See [File Ownership](../architecture/file-ownership.md) for the complete tier classification.

### Step 5: Test and Push

```bash
# Verify the workspace is functional
# Open in VS Code, confirm agent/instruction files load correctly

git push origin main
```

## What Gets Updated

During sync, files update based on their ownership tier:

| Tier                  | Examples                                                 | Sync Behavior            |
| --------------------- | -------------------------------------------------------- | ------------------------ |
| **Template-provided** | `.github/agents/*`, `.claude/agents/*`, `tools/*`, hooks | Updated by merge         |
| **Consumer-owned**    | `workspace.config.yaml`, `docs/workspace/*`, `README.md` | Unchanged (you own them) |

Template-provided files include all agent definitions, path-specific rules/instructions, skills/prompts, Git hooks, VS Code settings, and tooling scripts. Consumer-owned files include your project configuration, documentation, and any files you created.

For the full file classification, see [File Ownership](../architecture/file-ownership.md).

## Skipping Specific Changes

If upstream adds a template-provided file you don't want:

1. Let the merge bring it in (it's template-owned)
2. Delete it in a separate commit with a clear message
3. On future syncs, the file will reappear — delete it again, or add it to `.gitignore`

For more targeted control, use `git merge` with `--no-commit` to review before finalizing:

```bash
git merge upstream-workspace/main --no-commit
# Review staged changes
git diff --cached --stat
# Unstage anything you don't want
git reset HEAD <file>
git checkout -- <file>
# Commit the rest
git commit -m "chore: sync from upstream template"
```

## Sync Checklist

- [ ] Fetch upstream: `git fetch upstream-workspace`
- [ ] Review changes: `git log HEAD..upstream-workspace/main --oneline`
- [ ] Merge: `git merge upstream-workspace/main`
- [ ] Resolve any conflicts (template=theirs, consumer=ours)
- [ ] Test workspace: open in VS Code, verify agents load
- [ ] Push: `git push origin main`
- [ ] Update CHANGELOG with sync note

## Troubleshooting

**"fatal: refusing to merge unrelated histories"** — Your workspace was created from a GitHub template (which doesn't share Git history). Add `--allow-unrelated-histories` to the first merge only:

```bash
git merge upstream-workspace/main --allow-unrelated-histories
```

**Push protection blocks your push** — You're pushing to the wrong remote. Use `git push origin main`, not `git push upstream-workspace main`.

**Too many conflicts** — If a sync produces overwhelming conflicts, abort and try a more targeted approach:

```bash
git merge --abort
# Cherry-pick specific commits instead
git cherry-pick <commit-hash>
```

## See Also

- [File Ownership](../architecture/file-ownership.md) — which files come from template vs consumer
- [Getting Started](getting-started.md) — initial workspace setup including remote configuration
- [Choosing a Template](choosing-a-template.md) — single-repo vs multi-repo template differences
