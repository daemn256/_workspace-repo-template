# Archive

> Historical content preserved for reference but not actively maintained.

This directory stores dated snapshots of content that has been superseded, migrated, or retired.

## Format

```
archive/
├── YYYY-MM-DD_description/   # Dated archive folders
│   ├── README.md            # What was archived and why
│   └── ...                  # Preserved content
└── README.md                # This file
```

## When to Archive

Archive content when:

- **Migrating** — Old structure being replaced (preserve for rollback/reference)
- **Deprecating** — Features or docs being retired
- **Restructuring** — Major reorganization of workspace
- **Versioning** — Point-in-time snapshot before significant changes

## Archive Entry README

Each archive folder should have a README explaining:

```markdown
# Archive: [Description]

**Date:** YYYY-MM-DD
**Reason:** Migration / Deprecation / Restructure / Snapshot

## Contents

- `folder/` — Description of what this contained
- `file.md` — Description of what this was

## Context

Why this was archived and any relevant context for future reference.
```

## Guidelines

- **Date prefix** — Use `YYYY-MM-DD_description` format for easy chronological sorting
- **Include context** — Future you won't remember why this exists
- **Don't over-archive** — Only preserve what has historical value
- **Gitignored** — Archive contents are not tracked in version control

## Lifecycle

Archives are:

- **Gitignored** — Contents not committed (folder structure preserved via this README)
- **Local** — Not shared across clones
- **Permanent** — Keep as long as the workspace exists
- **Read-only** — Don't modify archived content

## Recovery

If you need to recover archived content:

1. Navigate to the relevant dated folder
2. Copy needed files to their new location
3. Update/modernize as needed for current conventions
