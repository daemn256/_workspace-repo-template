# Upstream Sync

Periodically sync your workspace with the template to get improvements, new features, and bug fixes.

## When to Sync

- **After template releases** — Check the template repo for new versions
- **Periodically** — Monthly or quarterly to stay reasonably current
- **Before major work** — Sync first to minimize future merge conflicts

## The Sync Workflow

### Step 1: Fetch Template Changes

```bash
git fetch upstream
```

### Step 2: Review What's New

```bash
# See commit summary
git log HEAD..upstream/main --oneline

# See detailed changes
git log HEAD..upstream/main

# See file diff
git diff HEAD..upstream/main --stat
```

### Step 3: Merge Changes

```bash
git merge upstream/main --no-ff -m "chore: sync with dev-workspace-template"
```

The `--no-ff` creates a merge commit even if fast-forward is possible, making the sync point visible in history.

### Step 4: Resolve Conflicts

If conflicts occur, resolve them following the [Conflict Resolution](#conflict-resolution) guide below.

### Step 5: Push to Your Repo

```bash
git push origin main
```

## Conflict Resolution

When merging template updates, conflicts typically occur in files you've customized.

### Ownership Model

| File | Owner | Resolution Strategy |
|------|-------|---------------------|
| `.github/workspace.md` | **Satellite** | Keep your version |
| `.github/AGENTS.md` | **Satellite** | Keep your version |
| `README.md` | **Satellite** | Keep your version |
| `docs/**` (your docs) | **Satellite** | Keep your version |
| `.github/copilot-instructions.md` | **Template** | Usually take template, merge carefully |
| `.github/agents/*` | **Template** | Usually take template |
| `.github/instructions/*` | **Template** | Usually take template |
| `.github/prompts/*` | **Template** | Usually take template |
| `.githooks/*` | **Template** | Usually take template |
| `.vscode/*` | **Mixed** | Merge — template structure + your customizations |
| `.gitignore` | **Mixed** | Merge — template patterns + your additions |

### Resolving Common Conflicts

#### .github/workspace.md

Always keep your version:

```bash
git checkout --ours .github/workspace.md
git add .github/workspace.md
```

#### README.md

Always keep your version:

```bash
git checkout --ours README.md
git add README.md
```

#### .github/copilot-instructions.md

Merge carefully — template may have important updates:

1. Open the conflicted file
2. Review both versions
3. Keep template structure while preserving any custom rules you added
4. Usually the template version is correct unless you added custom instructions

#### .gitignore

Merge both — take template patterns AND your additions:

1. Open the conflicted file
2. Keep all patterns from both versions
3. Remove true duplicates

### After Resolving All Conflicts

```bash
git add .
git commit -m "chore: sync with dev-workspace-template

Resolved conflicts:
- Kept workspace.md (satellite-owned)
- Kept README.md (satellite-owned)
- Merged .gitignore (combined patterns)"
```

## Automating with .gitattributes

You can configure automatic merge strategies for satellite-owned files:

```gitattributes
# Always keep satellite version for these files
.github/workspace.md merge=ours
.github/AGENTS.md merge=ours
README.md merge=ours
```

To enable the `ours` merge driver:

```bash
git config merge.ours.driver true
```

**Note:** This auto-resolves conflicts but may silently discard template changes to these files. Use with caution.

## Sync Checklist

- [ ] `git fetch upstream`
- [ ] Review changes: `git log HEAD..upstream/main --oneline`
- [ ] Merge: `git merge upstream/main --no-ff -m "chore: sync with dev-workspace-template"`
- [ ] Resolve conflicts (if any)
- [ ] Test workspace: Open in VS Code, verify Copilot works
- [ ] Commit and push: `git push origin main`
- [ ] Update CHANGELOG.md with sync note

## Skipping Specific Changes

If the template introduces something you don't want:

```bash
# After merge with conflicts, discard specific template changes
git checkout --ours path/to/unwanted/file
git add path/to/unwanted/file
```

Or revert specific files after merge:

```bash
git merge upstream/main
git checkout HEAD~1 -- path/to/unwanted/file
git commit --amend
```
