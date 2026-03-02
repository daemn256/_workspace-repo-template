---
name: docs
description: Documentation creation, maintenance, and review.
---

# Docs

The Implementer drives this workflow. Create, update, and review documentation following established conventions.

**Prerequisites:** Clear documentation target, access to relevant source material.

---

## Phase 1: Assess Documentation Need

Identify the scope and type of documentation.

### Steps

1. Determine the documentation type:
   - **ADR** — Architectural Decision Record (`docs/adr/`)
   - **Guide** — How-to or getting-started (`docs/guides/`)
   - **Architecture** — System design documentation (`docs/architecture/`)
   - **README** — Project or directory overview
   - **Inline** — Code comments and doc comments
   - **Observation** — Experimental findings (`docs/observations/`)
2. Check for existing documentation to update vs. create new
3. Identify the target audience

---

## Phase 2: Draft

Write the documentation following conventions.

### Writing Rules

- Follow markdownlint conventions
- Use ATX-style headings (`#` not underlines)
- One sentence per line in source (for clean diffs)
- Use tables for structured comparisons
- Include code examples where helpful
- Link to related documentation

### ADR Format

```markdown
# <number>. <Title>

Date: YYYY-MM-DD

## Status

Proposed | Accepted | Deprecated | Superseded by [ADR-NNNN]

## Context

<What is the issue motivating this decision?>

## Decision

<What is the change being proposed/done?>

## Consequences

<What becomes easier or more difficult?>
```

### Output

```markdown
## Context Anchors

- **Issue:** #<number> - <title>

## Documentation Created/Updated

**File:** <path>
**Type:** <ADR | Guide | Architecture | README>
**Summary:** <what was documented>

## Next Step

Review for accuracy and completeness.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not finalize without human review of content accuracy.

---

## Phase 3: Review and Finalize

### Review Checklist

- [ ] Content is accurate and complete
- [ ] Links to related docs are correct
- [ ] Code examples are tested/verified
- [ ] Follows markdownlint conventions
- [ ] Appropriate for target audience

---

## Error Handling

| Situation                 | Recovery                                |
| ------------------------- | --------------------------------------- |
| Conflicting documentation | Flag conflict, propose resolution       |
| Missing source material   | Ask for clarification before drafting   |
| Outdated referenced docs  | Update references as part of the change |
