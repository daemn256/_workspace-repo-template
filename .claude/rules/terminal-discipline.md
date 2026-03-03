---
paths:
  - "**"
---

# Terminal Discipline

> Terminal execution model, workspace navigation, command safety, and recovery.

## Terminal Model

- Execute commands sequentially — one terminal at a time
- Wait for output before running the next command
- Never assume a prior command succeeded without checking
- Terminal sessions are stateful — cwd and environment persist within a session
- The **workspace root** (directory containing `workspace.config.yaml`) is the anchor point for all navigation

## Workspace Navigation

### Workspace Root

The workspace root is the directory containing `workspace.config.yaml`. All terminal sessions start here, and all relative paths resolve from here.

### Multi-Repo Pattern

In workspaces with `repos/` sub-directories, navigate explicitly:

- `repos/<name>/` — each cloned repository
- Always `cd` to the target repo before running repo-scoped commands
- Return to workspace root between unrelated operations

### Navigation Rules

- Verify `pwd` before consequential operations (commits, builds, destructive commands)
- When uncertain of cwd, navigate to workspace root first: `cd /path/to/workspace`
- Prefer absolute paths when cwd is ambiguous
- Use relative paths within a known context for readability

## Command Taxonomy

### Read-Only (Always OK)

No approval needed — these commands inspect without modifying state:

- **Files:** `ls`, `cat`, `head`, `tail`, `grep`, `find`, `wc`, `tree`
- **Git:** `git log`, `git status`, `git diff`, `git blame`, `git branch`
- **Environment:** `which`, `type`, `echo $VAR`, `pwd`, `env`

### Mutating (Explain First)

Explain what the command does before running it:

- **Git:** `git add`, `git commit`, `git push`, `git checkout`, `git switch`
- **Packages:** `npm install`, `dotnet restore`, `pip install`
- **Directories:** `mkdir` (when following established patterns)
- **Build/Test:** commands from `workspace.config.yaml` `commands.*`

### Destructive (Approval Required)

Explain → identify risks → await human approval before running:

- **Deletion:** `rm`, `rmdir`, file overwrites
- **Git history:** `git push --force`, `git reset --hard`, `git rebase`
- **System:** database migrations, schema changes, system-level installs (`brew`, `apt`)
- **Uninstalls:** package uninstalls, removal of dependencies

### Never Run Blindly

- Do not execute commands copied from documentation without understanding them
- Do not run suggested commands from error messages without reviewing them
- Do not pipe untrusted content to shell execution

## Command Checklist

For non-trivial operations, follow this sequence:

1. **Pre-condition** — Verify cwd, branch, clean state, and prerequisites
2. **Execute** — Run the command with clear purpose
3. **Verify** — Check exit code, inspect output, confirm the expected result

This is especially important for: git operations, build/test runs, multi-step workflows, and any command in an unfamiliar directory.

## File Operations

### No File Creation via Terminal

Do NOT use terminal commands to create or edit files. Use editor tooling instead.

**Prohibited patterns:**

- `echo "content" > file.md`
- `cat > file.md << 'EOF'`
- `printf "content" > file.md`
- `sed -i 's/old/new/' file.md` (for edits — use editor tools)
- `tee file.md`

**Rationale:** IDE terminal tools do not reliably handle multi-line input. Heredocs, multi-line quoted strings, and interactive editors garble the terminal session, producing malformed files and leaving the terminal in an unrecoverable state.

**Exception:** Temporary files for CLI tool input (e.g., `--body-file`) are acceptable in `.tmp/scratch/`. Write the file content using editor tooling, then reference it in the terminal command.

### File Reading via Terminal

Acceptable for quick inspection:

- `cat`, `head`, `tail`, `grep`, `wc` — fine for quick checks
- Prefer editor tooling for reading files that need careful analysis

## Terminal Recovery

### Symptoms of a Confused Terminal

- Unexpected or garbled prompt characters
- Unresponsive to commands (no output after Enter)
- Stuck in a pager (`less`, `more`, `man`) or editor mode (`vi`, `nano`)
- Unclosed quotes or heredoc markers — input echoes instead of executing
- Error messages about unexpected tokens or syntax after normal commands

### Recovery Protocol

1. Attempt `Ctrl-C` to break the current operation
2. If still stuck, try closing the unclosed construct: type `'` or `"` or `EOF` + Enter
3. If still unresponsive: **kill the terminal** and start a fresh session
4. On the fresh session, verify `pwd` — should be workspace root
5. Re-navigate to the target directory if needed

### Prevention

- **Never** use heredocs or multi-line quoted strings in terminal commands
- Write multi-line content to a file via editor tooling, then reference the file
- Avoid interactive commands (`vi`, `nano`, `less`) — use editor tooling instead
- Keep command chains short (no more than 3–4 with `&&`)

## Anti-Patterns

| Anti-Pattern                           | Correct Behavior                         |
| -------------------------------------- | ---------------------------------------- |
| Running commands in parallel terminals | Execute sequentially, wait for output    |
| Using terminal to create/edit files    | Use editor tooling                       |
| Chaining 5+ commands with `&&`         | Break into separate steps                |
| Ignoring command exit codes            | Check and handle failures                |
| Using `sudo` without discussion        | Never assume elevated privileges         |
| Running commands in wrong directory    | Verify `pwd` before consequential ops    |
| Re-running failed commands verbatim    | Diagnose first, then fix                 |
| Trying to fix a garbled terminal       | Kill the terminal, start fresh           |
| Using heredocs or multi-line strings   | Write to file via editor, then reference |
