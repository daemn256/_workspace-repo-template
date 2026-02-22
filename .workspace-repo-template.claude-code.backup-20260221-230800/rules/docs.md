---
paths:
  - "docs/**/*.md"
---

# Documentation Conventions

> Conventions for documentation files.

## Markdown Style

- Use ATX-style headings (`#`, not underlines)
- Use dash bullets (`-`, not `*` or `+`)
- Use fenced code blocks with language identifier
- One sentence per line (improves diffs)
- Blank line before and after headings

## Heading Hierarchy

- `#` — Document title (one per file)
- `##` — Major sections
- `###` — Subsections
- `####` — Details (use sparingly)

Never skip levels (e.g., `#` to `###`).

## Code Blocks

Always specify the language:

````markdown
```typescript
const example = "code";
```
````

Common languages: `typescript`, `javascript`, `csharp`, `bash`, `json`, `yaml`, `markdown`

## Links

- Use relative paths for internal links
- Use descriptive link text (not "click here")
- Check links work before committing

```markdown
See [Architecture Decisions](../adr/README.md) for context.
```

## Tables

- Use for structured data
- Align columns for readability
- Keep tables simple (complex data → nested lists)

```markdown
| Column 1 | Column 2 | Column 3 |
| -------- | -------- | -------- |
| Value    | Value    | Value    |
```

## ADR Format

Architecture Decision Records follow this template:

```markdown
# ADR-NNNN: Title

## Status

<Proposed | Accepted | Deprecated | Superseded>

## Context

<What is the issue that we're seeing that is motivating this decision?>

## Decision

<What is the change that we're proposing and/or doing?>

## Consequences

<What becomes easier or more difficult because of this change?>
```

## README Structure

Standard README sections:

1. Title and description
2. Quick start / Installation
3. Usage examples
4. Configuration
5. Contributing
6. License

## Anti-Patterns

- ❌ Walls of text without structure
- ❌ Broken or outdated links
- ❌ Duplicating content (link instead)
- ❌ Screenshots without alt text
- ❌ Mixing formatting styles
- ❌ Orphan documents (update indexes)
