# Remote Management

This workspace uses a **satellite model** where your workspace is a separate repository that tracks the template as an upstream source.

## The Two Remotes

| Remote | Points To | Purpose |
|--------|-----------|---------|
| `origin` | Your workspace repo | Where you push your changes |
| `upstream` | dev-workspace-template | Where you pull template updates |

### Example Configuration

```bash
$ git remote -v
origin    git@github.com:your-username/your-workspace.git (fetch)
origin    git@github.com:your-username/your-workspace.git (push)
upstream  https://github.com/org/dev-workspace-template.git (fetch)
upstream  no_push (push)
```

Note that `upstream` shows `no_push` — this is intentional protection.

## Why This Model?

```
dev-workspace-template (GitHub)      ← Canonical template
    │
    ├── your-workspace (GitHub)      ← Your personal/team workspace
    │       └── ~/Developer (local)  ← Where you work
    │
    ├── team-workspace-1 (GitHub)    ← Another satellite
    └── team-workspace-2 (GitHub)    ← Another satellite
```

Benefits:
- **Your customizations stay yours** — workspace.md, custom docs, additional projects
- **Template improvements flow downstream** — Merge when you want them
- **No accidental template pollution** — Push protection prevents mistakes
- **Independent evolution** — Your workspace can diverge as needed

## Protection Layers

Multiple mechanisms prevent accidental template changes:

### 1. Remote URL Protection

Push URL for upstream is set to `no_push`:

```bash
git remote set-url --push upstream no_push
```

Any `git push upstream` will fail with a clear error.

### 2. Git Hooks

The `.githooks/pre-push` hook blocks:
- Pushes to any URL containing `dev-workspace-template`
- Pushes to `main` or `master` branches

### 3. Branch Protection

The `.githooks/pre-commit` hook blocks direct commits on `main`.

## Common Operations

### Push Your Changes

```bash
# Always goes to YOUR repo
git push origin main

# Or just (origin is default)
git push
```

### Fetch Template Updates

```bash
# Fetch without merging
git fetch upstream

# See what's new
git log HEAD..upstream/main --oneline
```

### Merge Template Updates

See [Upstream Sync](upstream-sync.md) for the full workflow.

## Troubleshooting

### "I accidentally set origin to the template"

Fix it:

```bash
# Rename wrong origin to upstream
git remote rename origin upstream

# Add correct origin
git remote add origin git@github.com:you/your-workspace.git

# Block upstream push
git remote set-url --push upstream no_push

# Push to correct origin
git push -u origin main
```

### "I don't have an upstream remote"

Add it:

```bash
git remote add upstream https://github.com/org/dev-workspace-template.git
git remote set-url --push upstream no_push
```

### "I want to contribute to the template"

Fork the template repo on GitHub, then:

```bash
# Add your fork as a separate remote
git remote add template-fork git@github.com:you/dev-workspace-template.git

# Create a branch, make changes, push to fork
git switch -c feat/my-template-improvement
# ... make changes ...
git push template-fork feat/my-template-improvement

# Open PR from fork to template
```

Your workspace's `origin` stays separate from template contributions.
