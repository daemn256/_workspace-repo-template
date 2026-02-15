---
description: Analyze issue and begin implementation
---

# Issue Workflow

Analyze an issue, propose an approach, and begin implementation.

## Prerequisites

- Issue number or context provided
- Access to version control

## Workflow

### Phase 1: Analyze

1. Read the issue (title, description, labels)
2. Search for related documentation (ADRs, existing patterns)
3. Classify complexity (Simple vs Complex)
4. Assess delegation suitability (Coding Agent candidate?)
5. Propose branch name

### Phase 2: Present Analysis

Output:

```markdown
## Context Anchors

- **Issue:** #<number> - <title>
- **Labels:** <labels>
- **Related:** <ADRs, docs>
- **Branch:** `<proposed-branch>` from `<base>`

## Verification Block

- [x] Issue exists and is open
- [x] Labels verified
- [x] Related docs reviewed: <list>
- [x] Complexity classified: <Simple|Complex>

## Decision Rationale

**Complexity: <Simple|Complex>**
- <reason>

**Branch strategy:** <rationale>

## Delegation Assessment

**Coding Agent Candidate:** <Yes ✅ | No ❌>
- <reason>

## Commands

```bash
git checkout <base> && git pull origin <base> && git checkout -b <branch>
```

## Next Step

Awaiting approval to create branch and begin implementation.

**Approval Required:** Yes
```

### Phase 3: Create Branch (After Approval)

Execute branch creation and report success.

### Phase 4: Implement

Make changes incrementally with verification at each step.

## Complexity Classification

| Criterion | Simple | Complex |
|-----------|--------|---------|
| Scope | 1-2 files | 3+ areas |
| Certainty | Clear approach | Unknowns exist |
| Architecture | No impact | New patterns needed |
| Design review | Not needed | Would be beneficial |

**Rule:** If ANY criterion is Complex → Issue is Complex
