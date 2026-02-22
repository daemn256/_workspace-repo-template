````skill
---
name: setup-workspace
description: Configure workspace context for the agentic kernel
---

# Setup Workspace Workflow

Guide the creation or update of workspace-specific context. Detects project characteristics and gathers information needed for the agentic kernel to work effectively.

## Personas

- **Primary:** Research (detection, scanning)
- **Secondary:** Orchestrator (process)

## Prerequisites

- Access to project root
- Project files exist (at minimum a README or package manifest)

## Entry Points

- "Set up the workspace" — Start at Mode selection
- "Initialize workspace context" — Start at Mode selection
- "Quick setup" — Start at Phase 1, Quick Start mode

## Modes

### Quick Start (Minimum Viable)

For fast setup, only needs:

1. Project name and purpose
2. Stack confirmation (auto-detected)
3. Key documentation pointers

### Comprehensive

For full setup, covers all sections in the workspace context schema.

---

## Phase 1: Detection

**Goal:** Scan for project markers and report findings.

### Steps

1. Look for README.md
2. Check for package manifests (package.json, \*.csproj, pom.xml)
3. Look for docs/ or docs/adr/ directories
4. Scan for configuration files
5. Report findings

### Output Template

```markdown
## Detection Results

| Marker               | Found | Details           |
| -------------------- | ----- | ----------------- |
| README.md            | {{{yes/no}}} | {{{details}}} |
| Package manifest     | {{{yes/no}}} | {{{manifest-type}}} |
| Documentation dir    | {{{yes/no}}} | {{{doc-structure}}} |
| Configuration files  | {{{yes/no}}} | {{{config-list}}} |

## Next Step

Confirm detection findings are correct.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

Confirm detection findings are correct before proceeding to stack inference.

---

## Phase 2: Stack Inference

**Goal:** Infer technology stack from detected files.

### Steps

1. Classify backend technology
2. Classify frontend technology
3. Identify documentation structure
4. Report inference

### Stack Categories

- Backend: .NET / Node / Java / Python / None
- Frontend: Angular / React / Vue / None
- Docs: ADR structure / Custom / None

### Output Template

```markdown
## Stack Inference

| Layer    | Detected  | Confidence |
| -------- | --------- | ---------- |
| Backend  | {{{backend-tech}}} | {{{confidence}}} |
| Frontend | {{{frontend-tech}}} | {{{confidence}}} |
| Docs     | {{{doc-structure}}} | {{{confidence}}} |

## Next Step

Confirm stack inference is correct.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

Confirm stack inference is correct before proceeding to project identity gathering.

---

## Phase 3: Project Identity

**Goal:** Gather project-specific information.

### Steps

1. Ask project name
2. Ask one-line purpose
3. Ask about domain terminology
4. Ask about project-specific conventions

---

## Phase 4: Preview and Confirm

**Goal:** Generate workspace context and get approval.

### Steps

1. Generate workspace context from gathered information
2. Present preview
3. Apply after approval

### Workspace Context Schema

The workspace context file contains:

- Project identity (name, purpose)
- Domain terminology
- Architecture (pattern, backend, frontend)
- Convention amendments (project-specific overrides)
- Key documentation pointers

### Output Template

```markdown
## Context Anchors

- **Project:** {{{project-name}}}
- **Mode:** {{{quick-start | comprehensive}}}

## Workspace Context Preview

{{{generated-workspace-context-content}}}

## Next Step

Approve workspace context before writing to file.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

Present the complete workspace context preview for approval. Do not write the file until explicitly approved.

---

## Error Handling

| Error                      | Recovery                                    |
| -------------------------- | ------------------------------------------- |
| Empty project (no markers) | Ask user to describe project manually       |
| Conflicting markers        | Present all detected, ask for clarification |
| Existing context file      | Offer to update vs replace                  |

````
