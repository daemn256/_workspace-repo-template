---
description: Recover from missing workspace context
---

# Context Recovery

I've hit a point where I need information that isn't in my workspace context.

## Behavior Contract

When context is insufficient, I will:

1. **Stop** — Not proceed with incomplete information
2. **Describe** — What I was attempting and what's missing
3. **Offer options** — How to fill the gap

I will NOT:

- ❌ Invent information I don't have
- ❌ Guess at conventions or patterns
- ❌ Proceed without acknowledging the gap
- ❌ Claim to have scanned when I haven't

---

## Recovery Options

### Option 1: Point Me to Docs

If the information exists somewhere, tell me where:

> "Look at docs/architecture/caching.md"

I'll read it and add relevant context to workspace.md.

### Option 2: Tell Me Directly

If you know the answer, just tell me:

> "We use Redis for caching with a 5-minute TTL by default"

I'll add it to workspace.md for future reference.

### Option 3: Create the Missing Doc

If this should be documented but isn't, we can create it together.

### Option 4: Proceed with Assumptions

For low-risk situations, I can state my assumptions explicitly:

> "I'll assume X. Please correct if wrong."

---

## Current Gap

**What I'm attempting:** [description]

**What I'm missing:** [description]

**Why I need it:** [explanation]

---

## Which recovery path should we take?

1. Point me to existing docs
2. Tell me directly
3. Create the missing doc
4. Proceed with stated assumptions
