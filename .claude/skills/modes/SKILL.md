---
name: modes
description: Route to workflow modes based on intent
---

# Mode Router

Dispatcher that routes to the appropriate workflow based on stated intent. Acts as the entry point for structured work.

## Personas

- **Primary:** Orchestrator (routing)

## Prerequisites

- User states their intent or selects a mode

---

## Available Modes

| Mode                 | Purpose                                    | Trigger                   |
| -------------------- | ------------------------------------------ | ------------------------- |
| **issue**            | Analyze issue, propose approach, implement | Working on an issue       |
| **pr**               | Create PR with template and labels         | Ready to create PR        |
| **test**             | Parse test output, produce verdict         | Analyzing test results    |
| **plan**             | Design and plan implementation             | Complex work needs design |
| **review**           | Structured PR review                       | Reviewing a PR            |
| **address-feedback** | Implement review feedback                  | Addressing PR comments    |

## Routing Rules

- "Let's work on issue #42" → Issue workflow
- "Create a PR for this work" → PR workflow
- "Review these test results" → Test workflow
- "Let's plan the implementation" → Planning workflow
- "Review this PR" → Review workflow
- "Address the feedback" → Address Feedback workflow

## Mode Behaviors

Each mode enforces:

1. **Context anchors** — What are we working on?
2. **Workflow steps** — Specific to the mode
3. **Output contract** — Structured output
4. **Next step declaration** — What happens after

## Output Contract

The modes workflow itself produces minimal output — it routes to the selected mode's workflow which then governs the interaction.

## Error Handling

| Error            | Recovery                                      |
| ---------------- | --------------------------------------------- |
| Ambiguous intent | Ask user to clarify which mode                |
| No matching mode | Suggest closest match, or operate in freeform |
