---
applyTo: "**/tests/**,**/*.test.ts,**/*.spec.ts,**/*.Tests.csproj,**/*Tests.cs"
---

# Testing Instructions

> Conventions for test files and testing patterns.

## Test Structure

Use Arrange-Act-Assert (AAA) pattern:

```typescript
it('should return user when found', () => {
  // Arrange
  const userId = '123';
  const expectedUser = { id: userId, name: 'Test' };
  mockRepository.findById.mockResolvedValue(expectedUser);

  // Act
  const result = await service.getUser(userId);

  // Assert
  expect(result).toEqual(expectedUser);
});
```

## Test Naming

```
<MethodUnderTest>_<Scenario>_<ExpectedBehavior>
```

Examples:
- `GetUser_WithValidId_ReturnsUser`
- `CreateOrder_WithEmptyCart_ThrowsValidationError`
- `CalculateTotal_WithDiscount_AppliesCorrectly`

## Test Categories

| Category | Purpose | Speed | Isolation |
|----------|---------|-------|-----------|
| Unit | Test single unit | Fast | Fully isolated |
| Integration | Test interactions | Medium | Partial isolation |
| E2E | Test full flows | Slow | No isolation |

## What to Test

### Do Test

- Business logic and calculations
- Edge cases and boundaries
- Error handling paths
- State transitions
- Public API contracts

### Don't Test

- Framework code (Angular, .NET)
- Simple getters/setters
- Third-party library internals
- Private methods directly

## Mocking Guidelines

- Mock external dependencies (APIs, databases)
- Don't mock the thing under test
- Prefer fakes over mocks for complex behavior
- Reset mocks between tests

```typescript
// Good: mock external dependency
const mockHttp = jest.fn();

// Bad: mock internal implementation
const mockPrivateMethod = jest.spyOn(service, 'privateMethod');
```

## Assertions

- One logical assertion per test (multiple expects OK if same concept)
- Use specific matchers (`toEqual`, not `toBeTruthy`)
- Test for absence explicitly when relevant
- Include failure messages for complex assertions

## Test Data

- Use factories or builders for complex objects
- Avoid shared mutable state
- Use meaningful test data (not `test123`)
- Clean up after tests that modify state

## Coverage Guidelines

- Aim for meaningful coverage, not 100%
- Cover critical paths thoroughly
- Don't test trivial code to hit metrics
- Review uncovered code intentionally

## Anti-Patterns

- ❌ Tests that depend on execution order
- ❌ Tests that share mutable state
- ❌ Testing implementation details
- ❌ Ignoring flaky tests
- ❌ Tests without assertions
- ❌ Overly complex test setup
