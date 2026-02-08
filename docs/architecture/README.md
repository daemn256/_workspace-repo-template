# Architecture

> Structural documentation for this workspace.

This directory contains architectural decisions, design documentation, and structural references that describe how this workspace is organized and why.

## Purpose

- Document the workspace's multi-repo structure and git isolation strategy
- Explain directory layout and purpose
- Describe conventions and patterns used across the workspace
- Provide context for new contributors or when revisiting after time away

## Typical Contents

- `workspace.md` — Overview of workspace structure, git model, and organization
- Component diagrams, system architecture drawings (if applicable)
- Cross-cutting design decisions that don't fit in ADRs

## Relationship to ADRs

While ADRs (`docs/adr/`) capture specific decisions with their context and consequences, architecture documentation provides the broader structural picture. Think of ADRs as the "what and why" for individual choices, and architecture docs as the "how it all fits together."

## Related

- [ADR Directory](../adr/) — Decision records
- [Workspace Context](../workspace/) — Current state and goals
