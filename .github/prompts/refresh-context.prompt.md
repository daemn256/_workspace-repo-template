---
description: "Update stale workspace context"
---

# Refresh Context

Research-led workflow with Orchestrator support. Verify and update the workspace context file when it may be outdated. Scans the codebase for changes and reconciles with documented state.

**Prerequisites:** Existing workspace context file, access to codebase

---

## Phase 1: Read Current Context

### Understand Documented State

1. Read the existing workspace context file
2. Summarize what it contains
3. Note the last-updated timestamp

---

## Phase 2: Scan Codebase

### Detect Changes

1. Look for new directories or modules
2. Check for changed file patterns
3. Review updated configuration
4. Check for moved documentation
5. Verify convention adherence

---

## Phase 3: Report Inconsistencies

### Present Findings

1. Compare current context against detected state
2. List items that need updating, removal, or verification
3. Highlight questions about ambiguous changes

### Staleness Indicators

Signs that workspace context might be stale:

- References files that no longer exist
- Mentions patterns not seen in recent code
- Lists stack components that have changed
- Documentation links are broken
- Conventions don't match observed code

### Output

```markdown
## Context Anchors

- **File:** <workspace context path>
- **Phase:** 3 — Report Inconsistencies

## Detected Changes

| Item   | Current State | Detected State | Action   |
| ------ | ------------- | -------------- | -------- |
| <item> | <documented>  | <actual>       | <update> |

## Questions

- <question about ambiguous change>

## Next Step

Awaiting human input before making changes.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

**STOP.** Do not update the workspace context until human reviews and approves changes.

---

## Phase 4: Apply Updates

### Update Workspace Context

1. Apply approved corrections
2. Add new discoveries
3. Remove obsolete content
4. Update timestamp

### Output

```markdown
## Context Anchors

- **File:** <workspace context path>
- **Phase:** 4 — Apply Updates

## Updates Applied

- <change 1>
- <change 2>

## Next Step

Workspace context updated.

**Approval Required:** No
```

---

## Error Handling

| Error                              | Recovery                                   |
| ---------------------------------- | ------------------------------------------ |
| No workspace context file exists   | Offer to create one via setup workflow     |
| File has incompatible format       | Note format issues, propose migration      |
| Too many changes to review at once | Batch into sections, process incrementally |
