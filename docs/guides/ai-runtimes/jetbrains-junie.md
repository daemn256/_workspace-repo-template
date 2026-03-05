# JetBrains Junie — AI Runtime Reference

> Comprehensive reference for the JetBrains Junie AI runtime. Covers the monolithic guidelines model, IDE support, and optimization guidance.
>
> **Last verified:** March 2026

---

## Overview

Junie is the third active AI runtime in this workspace. Unlike GitHub Copilot and Claude Code, which distribute configuration across many specialized files, Junie uses a **single monolithic file** for all agent instructions. Everything — personas, workflows, conventions, domain rules — funnels into one Markdown document.

This simplicity makes Junie the easiest runtime to configure but the least flexible for multi-agent or path-scoped patterns.

---

## Configuration Surface

| Artifact    | Location                                    | Format         | Scope                  |
| ----------- | ------------------------------------------- | -------------- | ---------------------- |
| Guidelines  | `.junie/guidelines.md`                      | Plain Markdown | All Junie interactions |
| Alternative | `AGENTS.md` (configurable path in settings) | Plain Markdown | All Junie interactions |

That's it. The entire configuration surface is one Markdown file.

---

## Workspace Inventory

This workspace's current Junie instruction content:

| Layer      | Files                  | Count |
| ---------- | ---------------------- | ----- |
| Guidelines | `.junie/guidelines.md` | 1     |

---

## Guidelines File

### Location

`.junie/guidelines.md` (default). The path is configurable in Junie Settings. `AGENTS.md` is supported as an alternative.

### Format

Plain Markdown — no YAML frontmatter, no special schema. Structure is free-form, but the community convention is:

```markdown
# Project Guidelines

## Code Style

<coding conventions>

## Architecture

<architectural patterns and constraints>

## Testing

<testing requirements and patterns>

## Dependencies

<dependency management rules>

## Workflow

<development workflow preferences>
```

### Mapping from Other Runtimes

Since Junie has no separate file types, all content from other runtimes maps into sections of `guidelines.md`:

| Content Type       | In Copilot                        | In Claude Code               | In Junie                   |
| ------------------ | --------------------------------- | ---------------------------- | -------------------------- |
| Global principles  | `.github/copilot-instructions.md` | `CLAUDE.md`                  | Opening section            |
| Agent personas     | `.github/agents/*.agent.md`       | `.claude/agents/*.md`        | Section in `guidelines.md` |
| Workflow skills    | `.github/skills/*/SKILL.md`       | `.claude/skills/*/SKILL.md`  | Section in `guidelines.md` |
| Domain conventions | `.github/instructions/*.md`       | `.claude/rules/*.md`         | Section in `guidelines.md` |
| Path-scoped rules  | `applyTo:` glob in frontmatter    | `paths:` glob in frontmatter | Not supported              |

---

## IDE Support

Junie is available across the JetBrains IDE family:

| IDE           | Language Focus | Junie Support |
| ------------- | -------------- | ------------- |
| IntelliJ IDEA | Java, Kotlin   | Yes           |
| PyCharm       | Python         | Yes           |
| WebStorm      | JavaScript, TS | Yes           |
| GoLand        | Go             | Yes           |
| PhpStorm      | PHP            | Yes           |
| RubyMine      | Ruby           | Yes           |
| RustRover     | Rust           | Yes           |
| Rider         | C#, .NET       | Yes           |

---

## Capabilities

### What Junie Can Do

- Analyze existing codebase and project structure
- Search code using IDE-level understanding
- Make edits using IDE inspections and refactorings
- Run code and tests to verify changes
- Use project context for informed decisions
- Auto-generate guidelines from existing codebase

### What Junie Cannot Do (vs. Copilot / Claude Code)

| Feature                  | Junie   | Copilot             | Claude Code          |
| ------------------------ | ------- | ------------------- | -------------------- |
| Multi-agent routing      | No      | Yes (handoffs)      | Yes (subagents)      |
| Separate prompt files    | No      | Yes (.prompt.md)    | Yes (skills)         |
| Path-scoped instructions | No      | Yes (applyTo globs) | Yes (paths: globs)   |
| Lifecycle hooks          | No      | Yes (Coding Agent)  | Yes (14 events)      |
| MCP server integration   | Limited | Yes                 | Yes                  |
| Model selection          | No      | Yes                 | Yes                  |
| Permission control       | No      | No                  | Yes (allow/ask/deny) |

---

## JetBrains AI Assistant (Separate Product)

JetBrains AI Assistant is a **separate plugin** from Junie:

- Code completion and next edit suggestions
- AI Chat with agent mode
- Context management for conversations
- Cloud LLMs and local model support

AI Assistant and Junie can coexist in the same IDE. They serve different purposes:

- **Junie** = autonomous coding agent (task execution)
- **AI Assistant** = inline assistant (code completion, chat, suggestions)

---

## Optimization Tips

### Guidelines Structure

- **Put the most important rules first.** Junie reads top-to-bottom; critical constraints should appear early.
- **Use clear headings** — Junie's Markdown parser benefits from well-structured `##` sections.
- **Keep it focused.** Unlike multi-file runtimes, everything competes for attention in one document. Be concise.
- **Organize by domain** — group related conventions (code style, architecture, testing, workflow) into distinct sections.

### Content Strategy

- **Don't duplicate the codebase.** Reference patterns by example rather than reproducing large code blocks.
- **Include "do" and "don't" examples** — Junie responds well to clear positive and negative examples.
- **Update the guidelines when conventions change** — there's no automatic inheritance from other configuration files.

### Multi-Runtime Harmony

- **Use the render pipeline** to keep `guidelines.md` in sync with Copilot and Claude Code instructions. The `render-instructions.sh` tool generates Junie guidelines from the same source as other runtimes.
- **Accept the fidelity gap.** Junie cannot express path-scoped rules or multi-agent routing. Focus on what it can do well: clear coding conventions and workflow guidance.
- **Don't try to replicate agent personas.** Instead, describe the preferred behaviors directly: "When writing commits, use Conventional Commit format."

### Community Guidelines as Starting Points

The JetBrains community guidelines catalog provides pre-built guidelines for common stacks. Use these as starting points, then customize for your project:

- Java + Spring Boot
- TypeScript + Nuxt
- Python + Django
- Go + Gin

Repository: [github.com/JetBrains/junie-guidelines](https://github.com/JetBrains/junie-guidelines)

---

## Known Limitations & Gotchas

| Issue                       | Details                                                                    |
| --------------------------- | -------------------------------------------------------------------------- |
| No path-scoped rules        | All instructions apply globally — you can't target TypeScript vs. C# files |
| No multi-agent routing      | Everything runs through one agent; no persona switching                    |
| No prompt/skill files       | Reusable workflows must be described inline in the guidelines              |
| Guidelines can get long     | Without file splitting, large projects may hit readability limits          |
| No hooks system             | Cannot trigger actions on lifecycle events                                 |
| No permission model         | Junie has full access; no fine-grained allow/ask/deny controls             |
| Auto-generate may overwrite | Junie's auto-generate feature can overwrite manual customizations          |

---

## Official Documentation

- [Junie Overview (JetBrains)](https://www.jetbrains.com/help/idea/junie.html)
- [Coding Guidelines for AI Agents (Blog)](https://blog.jetbrains.com/idea/2025/05/coding-guidelines-for-your-ai-agents/)
- [Community Guidelines Catalog](https://github.com/JetBrains/junie-guidelines)
- [JetBrains AI Assistant](https://www.jetbrains.com/help/idea/ai-assistant-in-jetbrains-ides.html)
