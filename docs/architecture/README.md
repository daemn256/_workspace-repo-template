# Architecture

> Structural documentation for this workspace.

This directory describes how the workspace is organized — the instruction model, configuration system, and file ownership rules.

## Contents

| Document                                  | Purpose                                                 |
| ----------------------------------------- | ------------------------------------------------------- |
| [Instruction Model](instruction-model.md) | 4-layer instruction hierarchy and per-runtime structure |
| [Configuration](configuration.md)         | How workspace-specific values reach AI agents           |
| [File Ownership](file-ownership.md)       | Which files come from the template vs the consumer      |

## Relationship to ADRs

Architecture docs describe the current state — how things work today. ADRs (`docs/adr/`) capture specific decisions with their context and consequences. When an architecture document changes significantly, record the rationale in an ADR.

## Related

- [ADR Directory](../adr/) — Decision records
- [Guides](../guides/) — Operational how-to documentation
- [Workspace Context](../workspace/) — Current state and goals
