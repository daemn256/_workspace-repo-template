# Contributing

Guidelines for contributing to this repository.

---

## Branch Strategy

### Branch Naming

```
<type>/<issue-number>-<kebab-description>
```

**Types:** `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `perf`, `ci`, `build`

**Examples:**

- `feat/42-redis-cache-service`
- `fix/123-null-pointer-user-service`
- `docs/456-api-documentation`

### Complex Work (Two-Phase)

For larger features that benefit from design review before implementation:

```
Phase 1: docs/<issue-number>-<description>-design
Phase 2: feat/<issue-number>-<description>
```

---

## Commit Format

Use [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

**Types:** `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`

**Examples:**

```
feat(auth): add OAuth2 login support

Implements Google and GitHub OAuth2 providers.

Closes #42
```

```
fix(api): handle null response from upstream service

The upstream service occasionally returns null instead of an empty array.
Added defensive handling to prevent NullPointerException.

Fixes #123
```

---

## Pull Request Workflow

1. **Create a branch** from `main` using the naming convention above
2. **Make changes** with atomic, well-described commits
3. **Push** to your fork or feature branch
4. **Open a PR** with:
   - Clear title matching commit format
   - Description of what and why
   - Link to related issue(s)
5. **Address review feedback** promptly
6. **Merge** after approval (squash or merge commit per project preference)

### PR Checklist

- [ ] Branch name follows convention
- [ ] Commits follow Conventional Commits format
- [ ] Tests pass
- [ ] Documentation updated (if applicable)
- [ ] No unrelated changes included

---

## Code Review

### For Authors

- Keep PRs focused and reasonably sized
- Respond to feedback constructively
- Mark conversations resolved when addressed

### For Reviewers

- Review promptly (within 1 business day when possible)
- Be specific and constructive
- Approve when ready, request changes when blocking issues exist

---

## Development Setup

See [docs/guides/getting-started.md](docs/guides/getting-started.md) for setup instructions.

---

## Questions?

Open an issue or start a discussion if you have questions about contributing.
