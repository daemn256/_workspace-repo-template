# Getting Started

After creating your workspace from the dev-workspace-template, follow these steps to complete setup.

## Prerequisites

- Git installed and configured
- GitHub CLI (`gh`) installed and authenticated
- VS Code with GitHub Copilot extension

## Step 1: Run Setup Script

From your workspace root:

```bash
./tools/setup.sh
```

This configures:
- Git hooks for branch protection
- Upstream remote pointing to the template
- Push protection to prevent accidental template changes

## Step 2: Create Your GitHub Repository

If you haven't already, create a GitHub repo for your workspace:

```bash
# Create a private repo (recommended)
gh repo create your-username/your-workspace-name --private --source=. --push

# Or public
gh repo create your-username/your-workspace-name --public --source=. --push
```

## Step 3: Customize Workspace Context

Edit `.github/workspace.md` with your specific context:

```markdown
# Workspace Context

## Project

**Name:** Your Workspace Name
**Purpose:** What you're building

## Domain Terminology

| Term | Definition |
|------|------------|
| ... | ... |

## Conventions

- Your workspace-specific patterns
- Branch naming conventions
- etc.
```

This file helps GitHub Copilot understand your workspace.

## Step 4: Replace the README

The template's `README.md` describes the template itself. Replace it with your workspace's README:

```bash
# Backup template README if you want to reference it
mv README.md README.template.md

# Create your own
cat > README.md << 'EOF'
# My Developer Workspace

Description of your workspace and projects.

## Projects

- `repos/project-1/` — Description
- `repos/project-2/` — Description

## Setup

...
EOF
```

## Step 5: Add Your Projects

Clone or create projects in the `repos/` directory:

```bash
cd repos/

# Clone existing repos
git clone git@github.com:your-org/your-project.git

# Or create new ones
mkdir new-project && cd new-project && git init
```

## Step 6: Commit Your Customizations

```bash
git add .
git commit -m "chore: customize workspace"
git push
```

## Verification

Check that your setup is correct:

```bash
# Verify remotes
git remote -v
# Should show:
# origin    git@github.com:you/your-workspace.git (fetch/push)
# upstream  https://github.com/.../dev-workspace-template.git (fetch)
# upstream  no_push (push)

# Verify hooks
git config core.hooksPath
# Should show: .githooks

# Test branch protection (optional)
git switch main
git commit --allow-empty -m "test"
# Should be blocked by pre-commit hook
```

## Next Steps

- Review [Remote Management](remote-management.md) to understand the satellite model
- See [Upstream Sync](upstream-sync.md) when you want to pull template updates
- Explore `.github/` to understand AI assistant configuration
