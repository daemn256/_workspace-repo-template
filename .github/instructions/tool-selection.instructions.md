---
applyTo: "**"
---

# Tool Selection

> Decision hierarchy for choosing the right tool surface. MCP-first, CLI-fallback, terminal-last-resort.

## Decision Hierarchy

When multiple tool surfaces can accomplish a task, follow this priority:

1. **MCP Tool** — Preferred. Structured, type-safe, integrated into the editor.
2. **CLI Tool** — Fallback when MCP doesn't cover the operation. Still structured.
3. **Terminal Command** — Last resort. Only when no MCP or CLI tool exists, or for inherently terminal-native tasks.

## Decision Table

| Task Category | First Choice | Fallback | Notes |
| --- | --- | --- | --- |
| Forge ops (issues, PRs, board) | MCP tool | CLI tool (`gh`, `az`) | Never raw API calls in terminal |
| File read/write | Editor tooling (`read_file`, `edit`, `create_file`) | — | Never terminal for writes |
| Code search | Search tools (`semantic_search`, `grep_search`) | Terminal `grep` | Prefer structured tools for accuracy |
| Build / test / lint | Terminal | — | Inherently terminal-native; use `commands.*` from config |
| Git operations | Terminal | — | `git` CLI is the canonical interface |
| Package management | Terminal | — | `npm`, `dotnet`, `pip` are terminal-native |

## Workspace Configuration

Tool preferences are declared in `workspace.config.yaml` under `forge.tooling`:

```yaml
forge:
  tooling:
    preferred: mcp          # Default preference: mcp | cli | api
    github:
      mcp-server: io.github.git  # Approved MCP server for GitHub
      cli: gh                    # Approved CLI tool for GitHub
```

Read this configuration to determine which tools are approved for the current workspace. Each forge provider declares its own MCP server and CLI tool.

## MCP Server Policy

### Approved Servers

Only use MCP servers declared in `forge.tooling.<provider>.mcp-server` in `workspace.config.yaml`. If a workspace adds multiple providers, each declares its own server:

```yaml
forge:
  tooling:
    github:
      mcp-server: io.github.git
    ado:
      mcp-server: some.ado.mcp.server
```

### Blocked Servers

Do NOT use these MCP servers even if available in the environment:

| Server | Reason |
| --- | --- |
| GitKraken | Auto-loaded by GitLens extension; not an intentional workspace integration |
| GitLens | Auto-loaded by extension; not workspace-approved |

When uncertain whether an MCP server is approved, check `workspace.config.yaml`. If not listed, ask.

## Anti-Patterns

| Anti-Pattern | Correct Behavior |
| --- | --- |
| Using terminal `curl` for forge API calls | Use MCP tool or CLI tool |
| Using MCP from an auto-loaded extension | Only use declared MCP servers |
| Defaulting to terminal for everything | Check MCP → CLI → terminal hierarchy |
| Mixing tool surfaces in one operation | Pick one surface and use it consistently |
| Assuming MCP is available without checking | Read `workspace.config.yaml` first |
