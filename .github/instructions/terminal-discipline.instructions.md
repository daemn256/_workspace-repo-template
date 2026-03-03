---
applyTo: "**"
---

# Terminal Discipline

> Shell awareness, terminal hygiene, command safety, and scope management.

## Shell Awareness

### One Terminal at a Time

- Execute commands sequentially, not in parallel
- Wait for output before running the next command
- Never assume a prior command succeeded without checking

### Terminal State

- Track the current working directory
- Be aware of environment context (virtual envs, node versions, etc.)
- Reset state when switching contexts rather than assuming inheritance

### Output Handling

- Read and process command output before proceeding
- If output is truncated, use targeted commands (`tail`, `grep`, `head`) to get what's needed
- Never ask the human to interpret terminal output — parse it yourself

## Terminal Hygiene

### Clean Commands

- Use fully-qualified paths when the working directory is uncertain
- Quote variables and paths that may contain spaces
- Prefer explicit flags over positional arguments for clarity

### Avoid Garbled Sessions

- Do not chain excessively long command sequences that obscure failures
- If a command fails, diagnose the failure before retrying
- Never blindly re-run a failed command — understand why it failed first

### Scope

- Each command should have a clear, single purpose
- Explain what a command does before running it (especially destructive commands)
- Prefer targeted operations over broad ones (e.g., `grep -rn 'pattern' src/` not `grep -rn 'pattern' .`)

## Command Safety

### Destructive Actions

Before running any command that modifies, deletes, or overwrites:

1. Explain what the command will do
2. Identify what could go wrong
3. Await human approval

Examples of destructive commands:

- `rm`, `rmdir`, file overwrites
- `git push --force`, `git reset --hard`
- Database migrations, schema changes
- Package uninstalls, system-level installs

### Never Run Blindly

- Do not execute commands copied from documentation without understanding them
- Do not run suggested commands from error messages without reviewing them
- Do not pipe untrusted content to shell execution

## File Operations

### No File Creation via Terminal

Do NOT use terminal commands to create or edit files. Use proper editor tooling instead.

**Prohibited patterns:**

- `echo "content" > file.md`
- `cat > file.md << 'EOF'`
- `printf "content" > file.md`
- `sed -i 's/old/new/' file.md` (for edits — use editor tools)
- `tee file.md`

**Exception:** Temporary files needed for CLI tool input (e.g., `--body-file`) are acceptable in `.tmp/scratch/`.

### File Reading via Terminal

Acceptable for quick inspection:

- `cat`, `head`, `tail`, `grep`, `wc` — fine for quick checks
- Prefer editor tooling for reading files that need careful analysis

## MCP Server Restrictions

### Blocked MCP Servers

Do NOT use these MCP servers even if they are available in the environment:

| Server    | Reason                                                           |
| --------- | ---------------------------------------------------------------- |
| GitKraken | Auto-loaded by GitLens extension; not an intentional integration |
| GitLens   | Same — auto-loaded, not workspace-approved                       |

### MCP Server Usage

- Only use MCP servers that are explicitly listed in the workspace configuration
- When in doubt about whether an MCP server is approved, ask
- Prefer the workspace's declared tooling preference (`forge.tooling.preferred` in workspace.config.yaml)

## Anti-Patterns

| Anti-Pattern                           | Correct Behavior                      |
| -------------------------------------- | ------------------------------------- |
| Running commands in parallel terminals | Execute sequentially, wait for output |
| Using terminal to create/edit files    | Use editor tooling                    |
| Chaining 5+ commands with `&&`         | Break into separate steps             |
| Ignoring command exit codes            | Check and handle failures             |
| Using `sudo` without discussion        | Never assume elevated privileges      |
| Running commands in wrong directory    | Verify `pwd` or use absolute paths    |
| Re-running failed commands verbatim    | Diagnose first, then fix              |
