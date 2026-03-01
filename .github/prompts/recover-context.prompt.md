---
description: "Recover from missing workspace context"
---

# Recover Context

Orchestrator-led workflow with Research support. When insufficient context is encountered, this workflow provides a structured protocol for acknowledging the gap, describing what's missing, and offering recovery paths.

**Prerequisites:** Agent has identified a context gap, work is blocked by missing information

---

## Behavioral Contract

When context is insufficient:

1. **Stop** — Do not proceed with incomplete information
2. **Describe** — State what was attempted and what's missing
3. **Offer options** — Provide structured recovery paths

**Anti-patterns:**

- MUST NOT invent information
- MUST NOT guess at conventions or patterns
- MUST NOT proceed without acknowledging the gap
- MUST NOT claim to have scanned when it hasn't

---

## Recovery Options

### Option 1: Point to Docs

If the information exists somewhere, the human points to it:

> "Look at docs/architecture/caching.md"

The agent reads it and integrates relevant context.

### Option 2: Direct Answer

The human provides the information directly:

> "We use Redis for caching with a 5-minute TTL by default"

The agent records it in workspace context for future reference.

### Option 3: Create Missing Doc

If the information should be documented but isn't, collaboratively create it.

### Option 4: Proceed with Assumptions

For low-risk situations, state assumptions explicitly:

> "I'll assume X. Please correct if wrong."

---

## Output Contract

The recovery interaction produces:

- Clear statement of what's missing and why
- Recovery option selected
- Resolution (information acquired or assumption stated)
- Workspace context updated if applicable

---

## Error Handling

| Error                        | Recovery                                  |
| ---------------------------- | ----------------------------------------- |
| Human doesn't know either    | Escalate or document as unknown           |
| Pointed doc doesn't exist    | Note the gap, offer to create it          |
| Multiple conflicting sources | Flag conflict, ask which is authoritative |
