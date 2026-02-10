# Workspace Repository Template

> **Template Type:** `workspace-repo` — Repo-scoped development workspace  
> **Upstream:** [`_workspace-repo-template`](https://github.com/daemn256/_workspace-repo-template)  
> **Parent:** [`_repo-template`](https://github.com/daemn256/_repo-template)

**Click "Use this template" to create your own workspace repository.**

---

## What is This?

A single-repository development workspace with integrated AI assistance. This template provides everything from [`_repo-template`](https://github.com/daemn256/_repo-template) plus:

- **VS Code configuration** — Settings, tasks, launch configs, recommended extensions
- **GitHub Copilot integration** — Instructions, agents, prompts for AI-assisted development
- **Workspace utilities** — Sandbox for experiments, session tracking for context continuity

Use this template when you want a **single repository** with full workspace tooling. For managing **multiple repositories**, see [`_workspace-root-template`](https://github.com/daemn256/_workspace-root-template).

**Not sure which to choose?** See [Choosing a Template](https://github.com/daemn256/template-workspace/blob/main/docs/guides/choosing-a-template.md).

---

## Quick Start

### 1. Use This Template

Click **"Use this template"** to create your repository.

### 2. Clone and Setup

```bash
git clone git@github.com:your-username/your-project.git
cd your-project
./tools/setup.sh
```

### 3. Open in VS Code

```bash
code .
```

### 4. Customize

1. Edit [.github/AGENTS.md](.github/AGENTS.md) with your project details
2. Review [.github/copilot-instructions.md](.github/copilot-instructions.md)
3. Replace this `README.md` with your project description

---

## Structure

```
your-project/
├── .github/                    # AI assistant configuration
│   ├── copilot-instructions.md # Core behavioral rules
│   ├── AGENTS.md               # Project context (customize this!)
│   ├── agents/                 # Specialized AI personas
│   ├── instructions/           # Language/path-specific conventions
│   └── prompts/                # Workflow templates
│
├── .vscode/                    # VS Code workspace settings
│   ├── settings.json           # Workspace preferences
│   ├── tasks.json              # Build/run/test tasks
│   ├── launch.json             # Debug configurations
│   └── extensions.json         # Recommended extensions
│
├── .githooks/                  # Git hooks for branch protection
│
├── docs/                       # Documentation
│   ├── adr/                    # Architecture Decision Records
│   ├── architecture/           # System design docs
│   ├── guides/                 # How-to guides
│   ├── observations/           # Learnings and notes
│   ├── proposals/              # Pre-ADR ideas
│   └── workspace/              # Copilot context files
│
├── tools/                      # Automation scripts
│   └── setup.sh                # Post-clone setup
│
├── sandbox/                    # Experiments and throwaway work
│
├── .tmp/                       # Temporary files
│   ├── sessions/               # Copilot session context
│   └── scratch/                # Ephemeral working files
│
├── archive/                    # Archived content
│
├── .template.yaml              # Template identity metadata
├── CONTRIBUTING.md             # Contribution guidelines
├── CHANGELOG.md                # Version history
└── LICENSE                     # License file
```

---

## `.template` File Convention

This template uses `.template.` variants for files that downstream consumers must customize:

| Template File                                | Creates                       | Consumer Action                          |
| -------------------------------------------- | ----------------------------- | ---------------------------------------- |
| `README.template.md`                         | `README.md`                   | Replace with project description         |
| `CHANGELOG.template.md`                      | `CHANGELOG.md`                | Update with project-specific entry       |
| `LICENSE.template`                            | `LICENSE`                     | Set copyright holder and year            |
| `.gitconfig.template`                         | `.gitconfig`                  | Add repo-safe git configuration          |
| `.github/AGENTS.template.md`                  | `.github/AGENTS.md`           | Fill in project context placeholders     |
| `.github/copilot-instructions.template.md`    | `copilot-instructions.md`     | Update Template Identity section         |
| `docs/workspace/context.template.md`          | `docs/workspace/context.md`   | Fill in project details                  |
| `docs/workspace/goals.template.md`            | `docs/workspace/goals.md`     | Set current priorities                   |

**Lifecycle:**

1. **First init** — `tools/setup.sh` copies each `.template` file to its real filename (skips if real already exists)
2. **Template sync** — `git merge upstream/main` updates `.template` files but never overwrites your real copies
3. **Consumer ownership** — You own the real files; the template owns the `.template` references

Each `.template` file includes a source header identifying which template it came from.

---

## AI Assistance

### GitHub Copilot Configuration

This workspace includes comprehensive Copilot configuration:

| Directory                         | Purpose                                                     |
| --------------------------------- | ----------------------------------------------------------- |
| `.github/copilot-instructions.md` | Core behavioral rules for all interactions                  |
| `.github/AGENTS.md`               | Project context — **customize this!**                       |
| `.github/agents/`                 | Specialized personas (planner, implementer, reviewer, etc.) |
| `.github/instructions/`           | Language-specific conventions (TypeScript, .NET, etc.)      |
| `.github/prompts/`                | Workflow templates (issue analysis, PR creation, etc.)      |

### Key Agents

| Agent          | Purpose                           |
| -------------- | --------------------------------- |
| `orchestrator` | Routes requests, manages workflow |
| `planner`      | Architecture and design planning  |
| `implementer`  | Code implementation               |
| `reviewer`     | Code review and quality           |
| `test`         | Testing strategy                  |
| `docs`         | Documentation                     |

### Workflow Prompts

- `/issue` — Analyze and implement GitHub issues
- `/plan` — Create implementation plans
- `/pr` — Generate pull requests
- `/review-pr` — Review pull requests

---

## VS Code Tasks

Pre-configured tasks for common workflows:

| Task            | Command         |
| --------------- | --------------- |
| 📦 npm install  | `npm install`   |
| ▶️ npm start    | `npm start`     |
| 🧪 npm test     | `npm test`      |
| 🔨 npm build    | `npm run build` |
| 🔨 dotnet build | `dotnet build`  |
| ▶️ dotnet run   | `dotnet run`    |
| 🧪 dotnet test  | `dotnet test`   |

Run via: `Ctrl+Shift+P` → "Tasks: Run Task"

---

## Upstream Sync

This repository tracks the template as an upstream source. To pull template improvements:

```bash
git fetch upstream
git log HEAD..upstream/main --oneline  # Review changes
git merge upstream/main --no-ff -m "chore: sync with _workspace-repo-template"
```

See [docs/guides/upstream-sync.md](docs/guides/upstream-sync.md) for details.

---

## Conventions

See [CONTRIBUTING.md](CONTRIBUTING.md) for:

- Branch naming (`<type>/<issue>-<description>`)
- Commit format (Conventional Commits)
- Pull request workflow

---

## Related Templates

| Template                                                                           | Purpose                               |
| ---------------------------------------------------------------------------------- | ------------------------------------- |
| [`_repo-template`](https://github.com/daemn256/_repo-template)                     | Tool-agnostic repo scaffold (parent)  |
| [`_workspace-repo-template`](https://github.com/daemn256/_workspace-repo-template) | This template — single-repo workspace |
| [`_workspace-root-template`](https://github.com/daemn256/_workspace-root-template) | Multi-repo workspace                  |

---

## License

This template is released under the MIT License. See [LICENSE](LICENSE) for details.
