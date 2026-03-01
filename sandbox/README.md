# Sandbox

Experimental and throwaway work that doesn't belong in permanent storage.

## Purpose

This directory is for:

- **Quick experiments** — Testing ideas without creating a full project
- **Spike work** — Proof-of-concept implementations
- **Temporary analysis** — One-off scripts or data exploration
- **Learning exercises** — Tutorials, courses, practice code
- **Prototypes** — Early-stage explorations before committing to a full project

## Lifecycle

- **No guarantees** — Files may be deleted without notice during cleanup
- **Not version controlled** — This directory is gitignored
- **Migrate when ready** — If an experiment becomes valuable, move it to `repos/` as a proper project

## Guidelines

✅ **What belongs here:**

- One-off scripts
- Quick prototypes
- Experimental notebooks
- Tutorial follow-alongs
- Temporary test data

❌ **What does NOT belong here:**

- Production code
- Anything you need to keep long-term
- Shared code for reuse
- Project source code
- Important analysis results (use `docs/` instead)

## Recommended Practices

1. Add a date prefix to files/folders for easy identification (e.g., `2026-02-07-experiment/`)
2. Include a brief README or comment explaining what the experiment is
3. Clean up regularly — don't let this directory become a junk drawer
4. Move validated experiments to `repos/` as proper projects

## Example Structure

```
sandbox/
├── 2026-02-07-test-api/
│   └── test.js
├── 2026-02-10-ml-prototype/
│   ├── README.md
│   └── model.py
└── temp-analysis.ipynb
```

---

**Note:** This directory is gitignored. Nothing here will be tracked by version control.
