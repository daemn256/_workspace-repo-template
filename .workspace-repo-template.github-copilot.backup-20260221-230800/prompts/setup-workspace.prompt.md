---
description: "Configure workspace context for the agentic kernel"
---

# Setup Workspace

Research-led workflow with Orchestrator support. Guide the creation or update of workspace-specific context. Detects project characteristics and gathers information needed for the agentic kernel to work effectively.

**Prerequisites:** Access to project root, project files exist (at minimum a README or package manifest)

---

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

### Scan for Project Markers

1. Look for `README.md`
2. Check for package manifests (`package.json`, `*.csproj`, `pom.xml`)
3. Look for `docs/` or `docs/adr/` directories
4. Scan for configuration files
5. Report findings

### Output

```markdown
## Context Anchors

- **Project:** <detected name>
- **Phase:** 1 — Detection

## Detection Results

| Marker           | Found | Details         |
| ---------------- | ----- | --------------- |
| README           | ✅/❌ | <path>          |
| Package manifest | ✅/❌ | <type and path> |
| Docs directory   | ✅/❌ | <structure>     |
| Config files     | ✅/❌ | <list>          |

## Next Step

Confirm detection findings are correct.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not proceed until human confirms detection findings.

---

## Phase 2: Stack Inference

### Classify Technology

1. Classify backend technology
2. Classify frontend technology
3. Identify documentation structure
4. Report inference

**Stack Categories:**

| Category | Options                            |
| -------- | ---------------------------------- |
| Backend  | .NET / Node / Java / Python / None |
| Frontend | Angular / React / Vue / None       |
| Docs     | ADR structure / Custom / None      |

### Output

```markdown
## Context Anchors

- **Project:** <name>
- **Phase:** 2 — Stack Inference

## Stack Inference

| Category | Detected | Confidence |
| -------- | -------- | ---------- |
| Backend  | <tech>   | High/Med   |
| Frontend | <tech>   | High/Med   |
| Docs     | <type>   | High/Med   |

## Next Step

Confirm stack inference is correct.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not proceed until human confirms stack inference.

---

## Phase 3: Project Identity

### Gather Project Information

1. Ask project name
2. Ask one-line purpose
3. Ask about domain terminology
4. Ask about project-specific conventions

---

## Phase 4: Preview and Confirm

### Generate and Approve

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

### Output

```markdown
## Context Anchors

- **Project:** <name>
- **Phase:** 4 — Preview

## Workspace Context Preview

<generated workspace context content>

## Next Step

Approve workspace context before writing.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not write the workspace context file until human approves.

---

## Error Handling

| Error                      | Recovery                                    |
| -------------------------- | ------------------------------------------- |
| Empty project (no markers) | Ask user to describe project manually       |
| Conflicting markers        | Present all detected, ask for clarification |
| Existing context file      | Offer to update vs replace                  |
