---
description: Update stale workspace context
---

# Context Refresh

The workspace context in `workspace.md` may be outdated. Let's verify and update it.

## When to Run

- Major refactoring has occurred
- New modules/features added
- Documentation has moved
- Team conventions have changed
- It's been a while since last refresh

## Process

### Step 1: Read Current Context

I'll read the existing `workspace.md` and summarize what it contains.

### Step 2: Scan Codebase

I'll look for changes:

- New directories or modules
- Changed file patterns
- Updated configuration
- Moved documentation

### Step 3: Report Inconsistencies

```markdown
## Current workspace.md States

- <item 1>
- <item 2>

## Detected Changes

| Item | Current State | Detected State | Action |
|------|---------------|----------------|--------|
| <item> | <old> | <new> | Update/Remove/Verify |

## Questions

- <Question about ambiguous change>
```

### Step 4: Propose Updates

After your input, I'll propose specific updates to `workspace.md`.

### Step 5: Apply Updates

With your approval, I'll update the file.

---

## Staleness Indicators

Signs that `workspace.md` might be stale:

- References files that no longer exist
- Mentions patterns not seen in recent code
- Lists stack components that have changed
- Documentation links are broken
- Conventions don't match observed code

---

## Output

Updated `workspace.md` with:

- Corrected information
- New discoveries
- Removed obsolete content
- Updated timestamp

---

Starting refresh. Reading current context...
