# Getting Started

After creating your project from the workspace-repo-template, follow these steps to complete setup.

## Prerequisites

- Git installed and configured
- GitHub CLI (`gh`) installed and authenticated
- VS Code with GitHub Copilot extension

## Step 1: Run Setup Script

From your project root:

```bash
./tools/setup.sh
```

This configures:

- Git hooks for branch protection
- Upstream remote pointing to the template
- Push protection to prevent accidental template changes

## Step 2: Create Your GitHub Repository

If you haven't already, create a GitHub repo:

```bash
# Create a private repo (recommended)
gh repo create your-username/your-project-name --private --source=. --push

# Or public
gh repo create your-username/your-project-name --public --source=. --push
```

## Step 3: Customize Workspace Context

Edit `.github/workspace.md` with your project's context:

```markdown
# Workspace Context

## Project

**Name:** Your Project Name
**Purpose:** What you're building

## Domain Terminology

| Term | Definition |
| ---- | ---------- |
| ...  | ...        |

## Conventions

- Your project-specific patterns
- Branch naming conventions
- etc.
```

This file helps GitHub Copilot understand your project.

## Step 4: Replace the README

The template's `README.md` has placeholder content. Replace it with your project's README:

```bash
# Create your own (overwrite the template placeholder)
cat > README.md << 'EOF'
# My Project

Description of your project.

## Quick Start

...

## Development

...
EOF
```

## Step 5: Start Building

Your project structure is ready. Key directories:

- `src/` — Your source code (create as needed)
- `docs/` — Project documentation
- `sandbox/` — Exploration and scratch space
- `tools/` — Development utilities

## Step 6: Commit Your Customizations

```bash
git add .
git commit -m "chore: customize project"
git push
```

## Verification

Check that your setup is correct:

```bash
# Verify remotes
git remote -v
# Should show:
# origin       git@github.com:you/your-project.git (fetch/push)
# upstream     https://github.com/.../workspace-repo-template.git (fetch)
# upstream     no_push (push)

# Verify hooks
git config core.hooksPath
# Should show: .githooks

# Test branch protection (optional)
git switch main
git commit --allow-empty -m "test"
# Should be blocked by pre-commit hook
```

## Next Steps

- See [Upstream Sync](upstream-sync.md) when you want to pull template updates
- Explore `.github/` to understand AI assistant configuration
- Review VS Code tasks (`Cmd+Shift+P` → "Tasks: Run Task")
