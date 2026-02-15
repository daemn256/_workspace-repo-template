---
description: Verify commit addresses review feedback
---

# Commit Verification Workflow

Verify that a commit actually addresses specific review feedback.

## Prerequisites

- Original feedback (what was requested)
- Commit diff (what was changed)

## Verification Process

1. **Parse feedback** — What specifically was requested?
2. **Analyze commit** — What did the commit change?
3. **Match** — Does the change address the feedback?
4. **Check for over-correction** — Did they change more than needed?

## Output Format

```markdown
## Context Anchors

- **PR:** #<number>
- **Commit:** `<sha>` - <message>
- **Feedback Being Addressed:** <summary>

## Verification Result

**Verdict:** <Resolved | Partially Resolved | Not Resolved | Over-corrected>

## Feedback Items

| # | Feedback | Status | Notes |
|---|----------|--------|-------|
| 1 | <feedback summary> | ✅ Resolved | <how addressed> |
| 2 | <feedback summary> | ⚠️ Partial | <what's missing> |
| 3 | <feedback summary> | ❌ Not addressed | <still needed> |

## Detailed Analysis

### Feedback 1: <summary>

**Original request:** <what was asked>

**What changed:** <what the commit modified>

**Assessment:** <Resolved | Partial | Not addressed>

<Explanation if not fully resolved>

### Feedback 2: <summary>

...

## Over-correction Check

<If changes went beyond what was requested>

- **Additional changes:** <what was changed that wasn't requested>
- **Assessment:** <Appropriate extension | Scope creep>

## Next Step

<Based on verdict>
- **Resolved:** Feedback fully addressed. Ready for re-review.
- **Partially Resolved:** Still needs: <what>
- **Not Resolved:** Changes required: <what>
- **Over-corrected:** Consider reverting <x> unless intentional
```

## Resolution Criteria

| Status | Criteria |
|--------|----------|
| ✅ **Resolved** | Feedback fully addressed as requested |
| ⚠️ **Partial** | Some aspects addressed, others missing |
| ❌ **Not addressed** | No changes related to feedback |
| 🔄 **Over-corrected** | Changed more than requested |
