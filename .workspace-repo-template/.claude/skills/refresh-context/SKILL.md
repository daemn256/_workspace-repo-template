````skill
---
name: refresh-context
description: Update stale workspace context
---

# Refresh Context Workflow

Verify and update the workspace context file when it may be outdated. Scans the codebase for changes and reconciles with documented state.

## Personas

- **Primary:** Research (scanning, discovery)
- **Secondary:** Orchestrator (process)

## Prerequisites

- Existing workspace context file
- Access to codebase

## Entry Points

- "Refresh the workspace context" — Start at Phase 1
- "The context file is outdated" — Start at Phase 1
- "Check if workspace context is still accurate" — Start at Phase 1

---

## Phase 1: Read Current Context

**Goal:** Understand what the workspace context currently states.

### Steps

1. Read the existing workspace context file
2. Summarize what it contains
3. Note the last-updated timestamp

---

## Phase 2: Scan Codebase

**Goal:** Detect changes since last context refresh.

### Steps

1. Look for new directories or modules
2. Check for changed file patterns
3. Review updated configuration
4. Check for moved documentation
5. Verify convention adherence

### Staleness Indicators

Signs that workspace context might be stale:

- References files that no longer exist
- Mentions patterns not seen in recent code
- Lists stack components that have changed
- Documentation links are broken
- Conventions don't match observed code

---

## Phase 3: Report Inconsistencies

**Goal:** Present findings for human review.

### Steps

1. Compare current context against detected state
2. List items that need updating, removal, or verification
3. Highlight questions about ambiguous changes

### Output Template

```markdown
## Context Anchors

- **Workspace context file:** {{{context-file-path}}}
- **Last updated:** {{{last-updated-timestamp}}}

## Detected Changes

| Item             | Current State         | Detected State        | Action              |
| ---------------- | --------------------- | --------------------- | ------------------- |
| {{{item-1}}}     | {{{current-state-1}}} | {{{detected-state-1}}}| {{{action-1}}}      |
| {{{item-2}}}     | {{{current-state-2}}} | {{{detected-state-2}}}| {{{action-2}}}      |

## Questions for Review

- {{{question-1}}}
- {{{question-2}}}

## Next Step

Awaiting approval to apply updates.

**Approval Required:** Yes
```

### ⛔ CHECKPOINT

Present inconsistencies and proposed changes for human review. Await approval before making any modifications to the workspace context file.

---

## Phase 4: Apply Updates

**Goal:** Update the workspace context file with approved changes.

### Steps

1. Apply approved corrections
2. Add new discoveries
3. Remove obsolete content
4. Update timestamp

### Output Template

```markdown
## Context Anchors

- **Workspace context file:** {{{context-file-path}}}
- **Updates applied:** {{{update-count}}}

## Changes Made

- {{{change-1}}}
- {{{change-2}}}

## Next Step

Workspace context refreshed. No further action needed.

**Approval Required:** No
```

---

## Error Handling

| Error                              | Recovery                                   |
| ---------------------------------- | ------------------------------------------ |
| No workspace context file exists   | Offer to create one via setup workflow      |
| File has incompatible format       | Note format issues, propose migration       |
| Too many changes to review at once | Batch into sections, process incrementally  |

````
