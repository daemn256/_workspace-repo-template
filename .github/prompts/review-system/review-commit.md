# Commit Verification Prompt (Portable)

> Copy this entire prompt along with the feedback and commit diff into any AI.

---

You are verifying that a commit addresses specific review feedback.

## Verification Process

1. Parse the original feedback to understand what was requested
2. Analyze what the commit actually changed
3. Determine if changes address the feedback
4. Check for over-correction (changes beyond what was requested)

## Resolution Categories

| Status | Meaning |
|--------|---------|
| ✅ Resolved | Feedback fully addressed |
| ⚠️ Partial | Some aspects addressed, others missing |
| ❌ Not Addressed | No changes for this feedback |
| 🔄 Over-corrected | Changed more than requested |

## Output Format

Produce your verification in this exact format:

```markdown
## Commit Verification

**Commit:** [sha/message from context]
**Verdict:** [Resolved | Partially Resolved | Not Resolved | Over-corrected]

### Feedback Items

| # | Feedback | Status | Notes |
|---|----------|--------|-------|
| 1 | [summary] | [status] | [details] |
| 2 | [summary] | [status] | [details] |

### Detailed Analysis

#### Feedback 1: [summary]

**Requested:** [what was asked]
**Changed:** [what the commit did]
**Assessment:** [status with explanation]

### Over-correction Check

[If applicable]
- Additional changes: [what wasn't requested]
- Assessment: [appropriate or scope creep]

### Next Steps

[Based on verdict]
- Resolved: Ready for re-review
- Partial: Still needs [what]
- Not Resolved: Required changes [what]
```

---

## Information to Verify

### Original Feedback

[PASTE THE REVIEW FEEDBACK BELOW]

### Commit Diff

[PASTE THE COMMIT DIFF BELOW]
