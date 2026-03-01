````skill
---
name: recover-context
description: Recover from missing workspace context
---

# Recover Context Workflow

When the AI agent encounters insufficient context to proceed, this workflow provides a structured protocol for acknowledging the gap, describing what's missing, and offering recovery paths.

## Personas

- **Primary:** Orchestrator (protocol enforcement)
- **Secondary:** Research (finding missing info)

## Prerequisites

- Agent has identified a context gap
- Work is blocked by missing information

## Entry Points

- "I don't have enough context to proceed" — Start at Behavioral Contract
- "Where is the documentation for X?" — Start at Option 1
- "I need to know about the project conventions" — Start at Option 1

---

## Behavioral Contract

When context is insufficient:

1. **Stop** — Do not proceed with incomplete information
2. **Describe** — State what was attempted and what's missing
3. **Offer options** — Provide structured recovery paths

### Anti-Patterns

- MUST NOT invent information
- MUST NOT guess at conventions or patterns
- MUST NOT proceed without acknowledging the gap
- MUST NOT claim to have scanned when it hasn't

---

## Recovery Option 1: Point to Docs

**When:** The information exists somewhere, the human points to it.

> "Look at docs/architecture/caching.md"

### Steps

1. Accept the pointer from the human
2. Read the referenced document
3. Integrate relevant context into working memory

---

## Recovery Option 2: Direct Answer

**When:** The human provides the information directly.

> "We use Redis for caching with a 5-minute TTL by default"

### Steps

1. Accept the direct answer
2. Record it in workspace context for future reference
3. Continue with the work using the new information

---

## Recovery Option 3: Create Missing Doc

**When:** The information should be documented but isn't.

### Steps

1. Acknowledge the documentation gap
2. Collaboratively draft the missing documentation
3. Present the draft for approval
4. Create the document after approval

### ⛔ CHECKPOINT

Present the proposed documentation content for approval before creating any files.

---

## Recovery Option 4: Proceed with Assumptions

**When:** Low-risk situations where the human approves assumption-based progress.

> "I'll assume X. Please correct if wrong."

### Steps

1. State assumptions explicitly and clearly
2. Assess risk level of proceeding with assumptions
3. Proceed only with human acknowledgment
4. Flag assumptions in output for later verification

---

## Output Contract

The recovery interaction produces:

### Output Template

```markdown
## Context Gap

- **What was attempted:** {{{action-attempted}}}
- **What is missing:** {{{missing-context}}}
- **Why it's needed:** {{{rationale}}}

## Recovery Path Selected

{{{option-chosen}}}

## Resolution

{{{information-acquired-or-assumption-stated}}}

## Workspace Context Updated

{{{yes-or-no-and-what-was-updated}}}
```

---

## Error Handling

| Error                        | Recovery                                  |
| ---------------------------- | ----------------------------------------- |
| Human doesn't know either    | Escalate or document as unknown           |
| Pointed doc doesn't exist    | Note the gap, offer to create it          |
| Multiple conflicting sources | Flag conflict, ask which is authoritative |

````
