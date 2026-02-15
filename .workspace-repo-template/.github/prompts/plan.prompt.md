---
description: Design and plan implementation approach
---

# Planning Workflow

Create a detailed implementation plan for complex work.

## When to Use

- Complex work with multiple areas affected
- Unclear approach requiring exploration
- Work that benefits from design review before implementation

## Workflow

### Step 1: Understand the Goal

- What problem are we solving?
- What are the success criteria?
- What constraints exist?

### Step 2: Research

- Search for related code and patterns
- Review relevant documentation and ADRs
- Identify dependencies and affected areas

### Step 3: Design Options

Consider multiple approaches before recommending one.

### Step 4: Create Plan

## Output Format

```markdown
## Context Anchors

- **Issue:** #<number> - <title>
- **Scope:** <what's being planned>

## Problem Statement

<Clear description of what needs to be solved>

## Constraints

- <Constraint 1>
- <Constraint 2>

## Research Summary

### Existing Patterns

- <Pattern from codebase>
- <Relevant ADR>

### Affected Areas

- <Area 1>
- <Area 2>

## Options Considered

### Option A: <Name>

- **Approach:** <how it works>
- **Pros:** <benefits>
- **Cons:** <drawbacks>

### Option B: <Name>

- **Approach:** <how it works>
- **Pros:** <benefits>
- **Cons:** <drawbacks>

## Recommended Approach

**Option <X>** because <rationale>.

## Implementation Plan

### Phase 1: <Name>

1. <Step 1>
2. <Step 2>

### Phase 2: <Name>

1. <Step 1>
2. <Step 2>

## Verification Plan

- <How to verify Phase 1>
- <How to verify Phase 2>

## Risks and Mitigations

| Risk | Mitigation |
|------|------------|
| <risk 1> | <mitigation> |

## Next Step

Awaiting approval of plan before implementation.

**Approval Required:** Yes
```

## Planning Principles

1. **Think before coding** — Understand before implementing
2. **Consider alternatives** — Don't jump to first solution
3. **Break down complexity** — Smaller steps are reviewable
4. **Verify incrementally** — Each phase should be testable
