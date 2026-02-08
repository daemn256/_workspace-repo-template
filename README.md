# Developer Workspace Template

> A portable, multi-IDE developer workspace with integrated AI assistance.

**Click "Use this template" to create your own workspace.**

---

## What is This?

A complete developer workspace environment designed for managing multiple projects with AI-powered development assistance. This template provides:

- **Multi-project organization** — All your projects in one workspace
- **AI-ready configuration** — GitHub Copilot instructions, agents, and prompts
- **IDE flexibility** — Currently optimized for VS Code, with JetBrains support planned
- **Portable structure** — Fork once, customize, and start building

---

## Quick Start

### 1. Use This Template

Click the **"Use this template"** button at the top of this repository to create your own copy.

### 2. Clone Your Workspace

```bash
git clone git@github.com:your-username/your-workspace.git ~/Developer
cd ~/Developer
```

### 3. Open in VS Code

```bash
code .
```

### 4. Customize

1. Edit [.github/AGENTS.md](.github/AGENTS.md) with your project details
2. Create [docs/workspace/context.md](docs/workspace/README.md) with your conventions
3. Review and adjust [.vscode/](.vscode/) settings

### 5. Add Projects

```bash
cd repos/
git clone git@github.com:your-org/your-project.git
```

---

## Structure

```
Developer/
├── .github/                    # AI assistant configuration
│   ├── copilot-instructions.md # Core behavioral rules
│   ├── AGENTS.md               # Project context (customize this!)
│   ├── workspace.md            # Workspace context
│   ├── agents/                 # Specialized AI personas
│   ├── instructions/           # Path-specific conventions
│   └── prompts/                # Workflow templates
│
├── .vscode/                    # VS Code workspace settings
│   ├── settings.json           # Workspace preferences
│   ├── tasks.json              # Build/run/test tasks
│   ├── launch.json             # Debug configurations
│   └── extensions.json         # Recommended extensions
│
├── docs/                       # Documentation
│   ├── adr/                    # Architecture Decision Records
│   ├── architecture/           # System design docs
│   ├── observations/           # Learnings and notes
│   ├── proposals/              # Pre-ADR ideas
│   └── workspace/              # Copilot context
│
├── tools/                      # Workspace automation scripts
│
├── repos/                      # Your projects (each is own git repo)
│   └── [your projects here]
│
├── sandbox/                    # Experiments and throwaway work
│
└── .tmp/                       # Temporary files and session data
    ├── sessions/               # Copilot session context
    └── scratch/                # Ephemeral working files
```

---

## Key Concepts

### Multi-Project Workspace

This workspace is designed to contain **multiple projects**, each living in `repos/` as its own independent git repository:

```
repos/
├── api-service/        # Own git repo, own remote
├── web-app/            # Own git repo, own remote
└── mobile-app/         # Own git repo, own remote
```

The **workspace itself** is a separate git repository that provides the organizational structure and AI configuration.

### Instruction Layering

AI instructions are **layered**, allowing project-specific overrides:

1. **Workspace baseline** — `.github/copilot-instructions.md` applies to everything
2. **Language conventions** — `.github/instructions/*.instructions.md` apply to matching file patterns
3. **Project overrides** — Individual projects can have their own `.github/` for customization

**Example:** When editing `repos/api-service/src/UserService.cs`:

- ✅ Workspace `.github/copilot-instructions.md` — Applied
- ✅ Workspace `.github/instructions/dotnet.instructions.md` — Applied
- ✅ Project `repos/api-service/.github/instructions/api.instructions.md` — Applied (if exists)

This gives you **workspace-wide standards** with **project-specific flexibility**.

### Git Isolation

The `repos/` directory is **gitignored** in the workspace `.gitignore`:

- ✅ Each project maintains its own git history
- ✅ Projects have their own remote origins
- ✅ No submodules needed
- ✅ Clean separation of concerns

When you run `git status` in the workspace, you won't see changes from projects inside `repos/`.

---

## Customization

### Essential: Update Project Context

Edit [.github/AGENTS.md](.github/AGENTS.md) with your project information. This file helps AI understand your workspace:

```markdown
## Project Overview

**Name:** Your Project/Team Name
**Purpose:** What you're building

## Tech Stack

| Layer    | Technology        |
| -------- | ----------------- |
| Backend  | Node.js, Express  |
| Frontend | React, TypeScript |
| Database | PostgreSQL        |
```

### Optional: Workspace-Specific Context

Create [docs/workspace/context.md](docs/workspace/README.md) for detailed conventions:

```bash
cat > docs/workspace/context.md << 'EOF'
# Workspace Context

## Domain Terminology

| Term    | Definition |
| ------- | ---------- |
| Widget  | ...        |

## Conventions

- Branch naming: type/issue-number-description
- Commit format: Conventional Commits
EOF
```

### Adjust VS Code Settings

Review and modify [.vscode/settings.json](.vscode/settings.json):

- File exclusion patterns
- Editor preferences (format on save, etc.)
- Language-specific settings

### Add Project-Specific Tasks

Edit [.vscode/tasks.json](.vscode/tasks.json) to add tasks for your tech stack. The template includes generic tasks for npm and dotnet projects that prompt for which project to run against.

---

## AI Assistance

### Available Agents

This workspace includes specialized AI agents for different tasks:

| Agent        | Purpose                                    |
| ------------ | ------------------------------------------ |
| orchestrator | Routes requests and manages agent handoffs |
| planner      | Architecture and design planning           |
| implementer  | Code implementation                        |
| reviewer     | Code review and quality checks             |
| test         | Testing strategy and implementation        |
| docs         | Documentation writing                      |
| debug        | Troubleshooting and debugging              |
| git-ops      | Git workflows and operations               |
| security     | Security review and best practices         |
| api          | API design and implementation              |
| data         | Data modeling and database design          |
| ops          | DevOps and infrastructure                  |
| architect    | System architecture                        |
| research     | Technical research                         |

### Workflow Prompts

Use these prompts to trigger structured workflows:

- `/issue` — Analyze and implement GitHub issues
- `/plan` — Create implementation plans
- `/pr` — Generate pull requests
- `/review-pr` — Review pull requests
- `/review-commit` — Verify commits address feedback

### Path-Specific Instructions

Instructions automatically apply based on file patterns:

- `**/*.ts`, `**/*.tsx` → TypeScript conventions
- `**/*.cs` → .NET conventions
- `**/tests/**` → Testing patterns
- `**/Controllers/**`, `**/Endpoints/**` → API conventions
- And more...

See [.github/instructions/](.github/instructions/) for all available instruction files.

---

## Adding Projects

### Method 1: Clone Existing Repository

```bash
cd repos/
git clone git@github.com:org/your-project.git
```

### Method 2: Create New Project

```bash
cd repos/
mkdir my-new-project
cd my-new-project
git init
# Create your project structure
git add .
git commit -m "Initial commit"
git remote add origin git@github.com:org/my-new-project.git
git push -u origin main
```

---

## Working with Multiple IDEs

### VS Code (Current)

This template is currently optimized for VS Code with GitHub Copilot. All configuration is in place.

### JetBrains IDEs (Planned)

JetBrains support is planned. The `.github/` structure will work with JetBrains AI Assistant when it supports external instruction files. You may want to add `.idea/` configuration and gitignore `.vscode/` if your team uses JetBrains exclusively.

### Other IDEs

The workspace structure is IDE-agnostic. Only the `.vscode/` directory is VS Code-specific. Other IDEs can ignore it.

---

## Updating the AI Kernel

This workspace uses the [agentic kernel](https://github.com/your-org/_agentic-system) for AI instructions. When new kernel versions are released:

### Check for Updates

Visit the [\_agentic-system releases](https://github.com/your-org/_agentic-system/releases) page.

### Update Instructions

```bash
# 1. Download new release
cd /tmp
wget https://github.com/your-org/_agentic-system/releases/download/v2.2.0/github-copilot-v2.2.0.tar.gz
tar -xzf github-copilot-v2.2.0.tar.gz

# 2. Backup your customizations
cp .github/AGENTS.md .github/AGENTS.md.backup
cp .github/workspace.md .github/workspace.md.backup

# 3. Update kernel files
rm -rf .github/agents .github/instructions .github/prompts .github/copilot-instructions.md
cp -r /tmp/github-copilot-v2.2.0/.github/* .github/

# 4. Restore customizations
cp .github/AGENTS.md.backup .github/AGENTS.md
cp .github/workspace.md.backup .github/workspace.md

# 5. Review and commit
git diff .github/
git add .github/
git commit -m "chore: update agentic kernel to v2.2.0"
```

---

## Best Practices

### Workspace Management

1. **Keep the workspace git repo clean** — Only commit workspace-level changes
2. **Don't commit project code** — Projects in `repos/` have their own git repos
3. **Document conventions** — Update `AGENTS.md` and `workspace/context.md` as patterns emerge
4. **Clean up regularly** — Remove stale experiments from `sandbox/`

### Project Organization

1. **One project = one git repository** — Keep projects independent
2. **Use project-specific overrides sparingly** — Most conventions belong at workspace level
3. **Each project should be self-contained** — Can be developed independently
4. **Mirror team structure** — If projects span teams, consider separate workspaces

### AI Assistance

1. **Provide context** — The better your `AGENTS.md`, the better the AI assistance
2. **Use agents for complex tasks** — Invoke specialized agents for architectural decisions
3. **Review AI suggestions** — AI assists, humans decide
4. **Update conventions** — When patterns emerge, add them to instruction files

---

## Troubleshooting

### Copilot not finding instructions

- Verify you opened the workspace root (not a project inside `repos/`)
- Check that `.github/copilot-instructions.md` exists
- Reload VS Code window: `Cmd+Shift+P` → "Developer: Reload Window"

### Tasks not working

- Ensure the project name matches the directory in `repos/`
- Check that the task's `cwd` setting points to the correct path
- Verify the project has the expected files (e.g., `package.json` for npm tasks)

### Git confusion

- Remember the workspace `.git/` is separate from project `.git/` directories
- Use `git status` from project directories to see project changes
- Use `git status` from workspace root to see workspace changes

---

## Contributing

Found a way to improve this template? Contributions welcome!

1. Fork the template repository
2. Make your improvements
3. Submit a pull request

---

## License

This template is released under the MIT License. See [LICENSE](LICENSE) for details.

---

## Related Resources

- [\_agentic-system](https://github.com/your-org/_agentic-system) — The AI kernel that powers this workspace
- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)
- [VS Code Workspaces](https://code.visualstudio.com/docs/editor/workspaces)

---

**Start building** — Add your first project to `repos/` and start developing!
