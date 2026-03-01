---
name: planning
description: Architecture design, trade-off analysis, and technical decision-making
---

# Planning Workflow

Guide architectural decisions, design system components, and document trade-offs before implementation.

## Personas

- **Primary:** Architect (system design, trade-offs)
- **Secondary:** Research (feasibility, options)

## Prerequisites

- Clear problem statement or requirement
- Access to existing architecture documentation
- Access to related ADRs

---

## Phase 1: Understand Requirements

**Goal:** Clarify what needs to be designed and why.

1. Gather requirements from issue/request
2. Identify constraints (performance, security, compatibility)
3. Note unknowns and assumptions
4. Understand scope boundaries

### Questions to Answer

- What problem are we solving?
- What are the success criteria?
- What constraints exist?
- What's out of scope?

### Output Template

```markdown
## Context Anchors

- **Issue:** #{{{number}}} - {{{title}}}
- **Area:** {{{architectural-area}}}
- **Phase:** Requirements Gathering

## Requirements Summary

{{{clear-statement-of-what-needs-to-be-designed}}}

## Constraints

- {{{constraint-1}}}
- {{{constraint-2}}}

## Unknowns

- {{{unknown-1}}}
- {{{unknown-2}}}

## Next Step

Confirm this understanding is correct before exploring options.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

Confirm understanding before exploring options.

---

## Phase 2: Explore Options

**Goal:** Identify viable approaches and their trade-offs.

1. Brainstorm potential approaches
2. Research existing patterns (in codebase, ADRs, external)
3. Evaluate each option against requirements
4. Identify pros/cons and trade-offs

### Option Evaluation Criteria

| Criterion     | Questions                                 |
| ------------- | ----------------------------------------- |
| Feasibility   | Can we build this with current resources? |
| Complexity    | How hard to implement and maintain?       |
| Performance   | Does it meet performance requirements?    |
| Security      | Are there security implications?          |
| Compatibility | Does it work with existing systems?       |
| Reversibility | Can we change course if needed?           |

No checkpoint — continue to recommendation.

---

## Phase 3: Present Recommendation

**Goal:** Present recommended approach with rationale.

1. State recommended option
2. Explain why it's preferred
3. Acknowledge trade-offs
4. Outline implementation approach
5. Identify risks and mitigations

### Output Template

```markdown
## Context Anchors

- **Issue:** #{{{number}}} - {{{title}}}
- **Area:** {{{architectural-area}}}
- **Phase:** Recommendation

## Options Considered

| Option        | Pros       | Cons       |
| ------------- | ---------- | ---------- |
| A: {{{name}}} | {{{pros}}} | {{{cons}}} |
| B: {{{name}}} | {{{pros}}} | {{{cons}}} |
| C: {{{name}}} | {{{pros}}} | {{{cons}}} |

## Recommendation

**Option {{{X}}}: {{{name}}}**

{{{rationale-for-this-choice}}}

## Trade-offs Accepted

- {{{trade-off-1}}}
- {{{trade-off-2}}}

## Implementation Outline

1. {{{step-1}}}
2. {{{step-2}}}
3. {{{step-3}}}

## Risks & Mitigations

| Risk         | Mitigation       |
| ------------ | ---------------- |
| {{{risk-1}}} | {{{mitigation}}} |

## Next Step

Awaiting approval to proceed with implementation (or create ADR).

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

Await approval before implementation or ADR creation.

---

## Phase 4: Document Decision

**Goal:** Create ADR or design doc if approved.

1. Create ADR (if architectural decision)
2. Or create design doc (if implementation plan)
3. Link to related issues/PRs
4. Update relevant documentation indexes

### ADR Format

```markdown
# ADR-XXXX: {{{title}}}

## Status

Proposed

## Context

{{{what-is-the-issue-motivating-this-decision}}}

## Decision

{{{what-is-the-change-being-proposed}}}

## Consequences

{{{what-becomes-easier-or-more-difficult}}}
```

No checkpoint — workflow complete.

---

## Error Handling

| Error                   | Recovery                                     |
| ----------------------- | -------------------------------------------- |
| Unclear requirements    | Ask clarifying questions                     |
| No viable options       | Revisit constraints, escalate if needed      |
| Conflicting constraints | Document conflict, seek guidance             |
| Missing context         | Research existing patterns, ask for pointers |
