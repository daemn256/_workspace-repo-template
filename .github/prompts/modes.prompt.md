---
description: "Route to workflow modes based on intent"
---

# Modes

Orchestrator-led dispatcher. Routes to the appropriate workflow based on stated intent. Acts as the entry point for structured work.

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
| **issue-create**     | Create a new issue from scratch            | Need to file an issue     |
| **issue-spawn**      | Spawn follow-up issue from current work    | Out-of-scope work found   |

## Routing Rules

- "Let's work on issue #42" → `/issue`
- "Create a PR for this work" → `/pr`
- "Review these test results" → `/test`
- "Let's plan the implementation" → `/planning`
- "Review this PR" → `/review`
- "Address the feedback" → `/address-feedback`
- "Create an issue for..." → `/issue-create`
- "This needs its own issue" → `/issue-spawn`

## Mode Behaviors

Each mode enforces:

1. **Context anchors** — What are we working on?
2. **Workflow steps** — Specific to the mode
3. **Output contract** — Structured output
4. **Next step declaration** — What happens after

---

## Error Handling

| Error            | Recovery                                      |
| ---------------- | --------------------------------------------- |
| Ambiguous intent | Ask user to clarify which mode                |
| No matching mode | Suggest closest match, or operate in freeform |
