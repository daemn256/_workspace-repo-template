# Project Repositories

This directory contains your individual project repositories. Each project is its own independent git repository with its own remote origin and history.

## Structure

```
repos/
├── project-1/          # Independent git repo
├── project-2/          # Independent git repo
└── project-3/          # Independent git repo
```

## Adding a New Project

### Option 1: Clone an Existing Repository

```bash
cd repos/
git clone git@github.com:org/your-project.git
```

### Option 2: Create a New Project

```bash
cd repos/
mkdir my-new-project
cd my-new-project
git init
# ... create your project files
git add .
git commit -m "Initial commit"
```

## Project-Specific Customization

Each project can have its own `.github/` directory with project-specific instructions that layer on top of the workspace baseline:

```
repos/my-project/
├── .github/
│   ├── instructions/
│   │   └── custom.instructions.md
│   └── prompts/
│       └── project-specific.prompt.md
└── src/
```

**Instruction Layering Example:**

When editing `repos/my-project/src/file.ts`:

1. Workspace `.github/copilot-instructions.md` — Applied (baseline rules)
2. Workspace `.github/instructions/typescript.instructions.md` — Applied (language conventions)
3. Project `.github/instructions/custom.instructions.md` — Applied (project overrides)

## Git Isolation

The workspace `.gitignore` excludes `repos/*`, which means:

- ✅ Each project maintains its own git history
- ✅ Each project can have its own remote origin
- ✅ Projects don't pollute the workspace git status
- ✅ No submodules needed — just regular git repos

## VS Code Task Integration

The workspace `.vscode/tasks.json` includes generic tasks that work with any project in this directory:

- **npm install** — Install dependencies for any npm project
- **npm start** — Start development server
- **npm test** — Run tests
- **npm build** — Build for production
- **dotnet build** — Build .NET projects
- **dotnet run** — Run .NET projects
- **dotnet test** — Test .NET projects

These tasks will prompt you to select which project to run against.

## Best Practices

1. **Keep projects independent** — Each project should be self-contained
2. **Use project-specific .github/ sparingly** — Most conventions belong in the workspace baseline
3. **Document project structure** — Each project should have its own README
4. **Commit projects separately** — Never commit the repos/ directory itself to the workspace repo

---

**Note:** This directory is intentionally gitignored in the workspace. Only individual projects inside are tracked by their own git repositories.
