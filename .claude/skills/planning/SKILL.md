---
name: planning
description: Architecture design, trade-off analysis, and technical decision-making.
---

# Planning

The Planner drives this workflow. Guide architectural decisions, design system components, and document trade-offs before implementation.

**Prerequisites:** Clear problem statement or requirement, access to existing architecture documentation and related ADRs.

---

## Phase 1: Understand Requirements

Clarify what needs to be designed and why.

### Steps

1. Gather requirements from issue/request
2. Identify constraints (performance, security, compatibility)
3. Note unknowns and assumptions
4. Understand scope boundaries

### Questions to Answer

- What problem are we solving?
- What are the success criteria?
- What constraints exist?
- What's out of scope?

### Output

```markdown
## Context Anchors

- **Issue:** #<number> - <title>
- **Area:** <architectural area>
- **Phase:** Requirements Gathering

## Requirements Summary

<Clear statement of what needs to be designed>

## Constraints

- <constraint 1>
- <constraint 2>

## Unknowns

- <unknown 1>
- <unknown 2>

## Next Step

Confirm this understanding is correct before exploring options.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not proceed until human confirms understanding is correct.

---

## Phase 2: Explore Options

Identify viable approaches and their trade-offs.

### Steps

1. Brainstorm potential approaches
2. Research existing patterns (in codebase, ADRs, external)
3. Evaluate each option against requirements
4. Identify pros/cons and trade-offs

### Evaluation Criteria

| Criterion     | Questions                                 |
| ------------- | ----------------------------------------- |
| Feasibility   | Can we build this with current resources? |
| Complexity    | How hard to implement and maintain?       |
| Performance   | Does it meet performance requirements?    |
| Security      | Are there security implications?          |
| Compatibility | Does it work with existing systems?       |
| Reversibility | Can we change course if needed?           |

---

## Phase 3: Present Recommendation

Present recommended approach with rationale.

### Steps

1. State recommended option
2. Explain why it's preferred
3. Acknowledge trade-offs
4. Outline implementation approach
5. Identify risks and mitigations

### Output

```markdown
## Context Anchors

- **Issue:** #<number> - <title>
- **Area:** <architectural area>
- **Phase:** Recommendation

## Options Considered

| Option    | Pros   | Cons   |
| --------- | ------ | ------ |
| A: <name> | <pros> | <cons> |
| B: <name> | <pros> | <cons> |
| C: <name> | <pros> | <cons> |

## Recommendation

**Option <X>: <name>**

<Rationale for this choice>

## Trade-offs Accepted

- <trade-off 1>
- <trade-off 2>

## Implementation Outline

1. <step 1>
2. <step 2>

## Risks & Mitigations

| Risk     | Mitigation   |
| -------- | ------------ |
| <risk 1> | <mitigation> |

## Next Step

Awaiting approval to proceed with implementation (or create ADR).

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not proceed until human approves recommendation.

---

## Phase 4: Document Decision

Create ADR or design doc if approved.

### Steps

1. Create ADR (if architectural decision) or design doc (if implementation plan)
2. Link to related issues/PRs
3. Update relevant documentation indexes

### ADR Format

```markdown
# ADR-XXXX: <Title>

## Status

Proposed

## Context

<What is the issue that we're seeing that is motivating this decision?>

## Decision

<What is the change that we're proposing?>

## Consequences

<What becomes easier or more difficult to do because of this change?>
```

---

## Error Handling

| Error                   | Recovery                                     |
| ----------------------- | -------------------------------------------- |
| Unclear requirements    | Ask clarifying questions                     |
| No viable options       | Revisit constraints, escalate if needed      |
| Conflicting constraints | Document conflict, seek guidance             |
| Missing context         | Research existing patterns, ask for pointers |
