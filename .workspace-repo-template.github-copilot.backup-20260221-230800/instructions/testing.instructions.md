---
applyTo: "**/tests/**,**/*.test.ts,**/*.spec.ts,**/*.Tests.csproj,**/*Tests.cs"
---

# Testing Conventions

> Guidelines for writing and running tests.

## Test Execution

### CLI Commands Only

Tests MUST be run via explicit CLI commands:

```bash
# .NET
dotnet test path/to/Project.Tests.csproj --logger:"console;verbosity=normal"

# Node/npm
npm test

# Angular
ng test --project=<project-name>

# Jest
npx jest --verbose
```

**Critical:**

- NEVER create launch configurations for tests
- NEVER create VS Code tasks for running tests
- Always parse output, don't trust exit code alone

## Test Structure

### Arrange-Act-Assert

```csharp
[Fact]
public async Task GetById_WhenEntityExists_ReturnsEntity()
{
    // Arrange
    var entity = CreateTestEntity();
    await _repository.AddAsync(entity);

    // Act
    var result = await _service.GetByIdAsync(entity.Id);

    // Assert
    result.IsSuccess.Should().BeTrue();
    result.Value.Should().BeEquivalentTo(expected);
}
```

### Naming Convention

Pattern: `MethodName_Scenario_ExpectedBehavior`

Examples:

- `GetById_WhenNotFound_ReturnsNotFoundError`
- `Create_WithValidInput_ReturnsCreatedEntity`
- `Update_WhenConcurrencyConflict_ReturnsConflictError`

## Test Categories

| Category     | Scope               | Speed  | When                |
| ------------ | ------------------- | ------ | ------------------- |
| Unit         | Single class/method | Fast   | Always              |
| Integration  | Multiple components | Medium | API boundaries      |
| Architecture | Code structure      | Fast   | Solution-wide rules |
| E2E          | Full system         | Slow   | Critical paths      |

## Coverage Guidelines

- Aim for meaningful coverage, not 100%
- Prioritize: happy path → error paths → edge cases
- Test behavior, not implementation

## Verdicts

| Verdict        | Condition           |
| -------------- | ------------------- |
| **PASS** ✅    | Failed=0, Skipped=0 |
| **PARTIAL** ⚠️ | Failed=0, Skipped>0 |
| **FAIL** ❌    | Failed>0            |

**Never trust exit code alone.** Parse and report actual counts.

## Mocking

- Mock external dependencies (APIs, databases, time)
- Don't mock what you own (prefer fakes for internal deps)
- Use builder patterns for complex test data
