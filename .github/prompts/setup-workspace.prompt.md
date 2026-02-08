---
description: Configure workspace context for the agentic kernel
---

# Workspace Setup

I'll help you configure workspace-specific context. This creates or updates `workspace.md` with information I need to work effectively in this project.

## Modes

### Quick Start (Minimum Viable)

For fast setup, I only need:

1. Project name and purpose
2. Stack confirmation (I'll auto-detect)
3. Key documentation pointers

### Comprehensive

For full setup, we'll cover all sections in the workspace.md schema.

---

## Process

Each step requires your explicit confirmation before proceeding.

### Step 1: Detection

I'll scan for project markers and report what I find:

**Files to detect:**

- [ ] `README.md`
- [ ] `package.json` / `*.csproj` / `pom.xml`
- [ ] `docs/` or `docs/adr/`
- [ ] Configuration files

**Confirm these findings?** (yes/no/corrections)

### Step 2: Stack Inference

Based on detected files, I'll infer:

- **Backend:** [.NET / Node / Java / Python / None]
- **Frontend:** [Angular / React / Vue / None]
- **Docs:** [ADR structure / Custom / None]

**Is this stack correct?** (yes/no/corrections)

### Step 3: Project Identity

Questions:

1. Project name?
2. One-line purpose?
3. Any domain terminology I should know?

### Step 4: Preview and Confirm

Here's the workspace.md I'll create:

```markdown
[preview content]
```

**Approve this workspace.md?** (yes/revise/restart)

---

## Output

After approval, I'll create `.github/workspace.md` with the gathered context.

## Workspace.md Schema

```markdown
# Workspace Context

> Workspace-specific information that amends the agentic kernel.
> Last updated: [DATE]

## Project

**Name:** [PROJECT_NAME]
**Purpose:** [ONE_LINE_PURPOSE]

## Domain Terminology

| Term | Definition |
|------|------------|
| [TERM] | [DEFINITION] |

## Architecture

- **Pattern:** [ARCHITECTURE_PATTERN]
- **Backend:** [BACKEND_STACK]
- **Frontend:** [FRONTEND_STACK]

## Conventions (Amendments to Baseline)

[PROJECT_SPECIFIC_CONVENTIONS]

## Key Documentation

| Document | Location | Purpose |
|----------|----------|---------|
| [NAME] | [PATH] | [PURPOSE] |
```
