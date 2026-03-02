# Getting Started

After creating your workspace from a template, follow these steps to complete setup.

## Prerequisites

- Git installed and configured
- GitHub CLI (`gh`) installed and authenticated
- VS Code with GitHub Copilot extension (recommended)

---

## Step 1: Create Your Repository

Use the GitHub template mechanism to create your workspace:

```bash
# From the template repo on GitHub, click "Use this template"
# Or use the CLI:
gh repo create your-org/your-workspace --template daemn-ai/_workspace-root-template --private
```

Clone it locally:

```bash
git clone git@github.com:your-org/your-workspace.git
cd your-workspace
```

> **Which template?** See [Choosing a Template](choosing-a-template.md) if you're not sure which one to use.

---

## Step 2: Configure workspace.config.yaml

This is the central configuration file. Open it and fill in your values:

```yaml
workspace:
  name: "your-workspace"
  description: "What this workspace is for"

forge:
  topology:
    repos: github
    boards: github
    ci: github-actions
    releases: github

process:
  profile: lightweight # or standard, regulated

commands:
  build: "npm run build" # your build command
  test: "npm test" # your test command
  lint: "npm run lint" # your lint command

project:
  base-branch: "main"
  branch-pattern: "<type>/<issue-number>-<kebab-description>"
  overlay-file: "docs/workspace/project-overlay.md"
```

Board configuration (if using GitHub Projects):

```yaml
board:
  provider: "github-projects-v2"
  url: "https://github.com/orgs/your-org/projects/1"
  project_id: "PVT_..."
  fields:
    status: { field_id: "PVTSSF_..." }
    priority: { field_id: "PVTSSF_..." }
    size: { field_id: "PVTSSF_..." }
```

See [Configuration](../architecture/configuration.md) for the full schema reference.

---

## Step 3: Set Up Project Context

Three files give AI agents context about your workspace:

**`docs/workspace/context.md`** — Domain knowledge and architecture:

```markdown
## Identity

| Field | Value                           |
| ----- | ------------------------------- |
| Name  | your-workspace                  |
| Type  | Multi-repository workspace root |

## Domain Terminology

| Term | Definition |
| ---- | ---------- |
| ...  | ...        |
```

**`docs/workspace/project-overlay.md`** — Project-specific agent context:

```markdown
## Project: Your Project Name

Description of what this project does and its key conventions.
```

**`docs/workspace/goals.md`** — Current priorities:

```markdown
## Sprint Focus

- [ ] Current objective 1
- [ ] Current objective 2
```

---

## Step 4: Replace the README

The template's `README.md` describes the template itself. Replace it with your own.

---

## Step 5: Add Your Projects

For multi-repo workspaces, clone or create projects in the `repos/` directory:

```bash
cd repos/
git clone git@github.com:your-org/your-api.git api
git clone git@github.com:your-org/your-web.git web
```

Each project under `repos/` is an independent git repository.

---

## Step 6: Commit and Push

```bash
git add .
git commit -m "chore: customize workspace"
git push
```

---

## Verification

Check that your setup is correct:

- [ ] `workspace.config.yaml` has real values (not placeholders)
- [ ] `docs/workspace/context.md` has your domain terms and repo inventory
- [ ] `docs/workspace/project-overlay.md` describes your project
- [ ] Git hooks are active: `git config core.hooksPath` shows `.githooks`

---

## Next Steps

- [Upstream Sync](upstream-sync.md) — How to pull template updates
- [Authoring Instructions](authoring-instructions.md) — How to customize AI behavior
- [Architecture docs](../architecture/) — How the instruction system works
