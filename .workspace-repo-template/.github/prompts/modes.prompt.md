---
description: Route to workflow modes
---

# Mode Router

Select a workflow mode based on your intent:

## Available Modes

| Mode | Purpose | Trigger |
|------|---------|---------|
| **issue** | Analyze issue, propose approach, implement | Working on an issue |
| **pr** | Create PR with template and labels | Ready to create PR |
| **test** | Parse test output, produce verdict | Analyzing test results |
| **plan** | Design and plan implementation | Complex work needs design |
| **review-pr** | Structured PR review | Reviewing a PR |
| **review-commit** | Verify commit addresses feedback | Checking PR feedback |

## How to Use

Invoke a mode by saying:

- "Let's work on issue #42" → Issue mode
- "Create a PR for this work" → PR mode
- "Review these test results" → Test mode
- "Let's plan the implementation" → Plan mode
- "Review this PR" → Review PR mode

## Mode Behaviors

Each mode enforces:

1. **Context anchors** — What are we working on?
2. **Workflow steps** — Specific to the mode
3. **Output contract** — Structured output
4. **Next step declaration** — What happens after
