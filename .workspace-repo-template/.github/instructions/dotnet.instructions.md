---
applyTo: "**/*.cs"
---

# .NET Instructions

> Conventions for C# and .NET development.

## Language Conventions

- Use C# 12+ features where appropriate
- Prefer `var` when type is obvious from right-hand side
- Use file-scoped namespaces
- Use primary constructors where appropriate
- Prefer pattern matching over type checking

## Naming Conventions

| Element | Convention | Example |
|---------|------------|---------|
| Class | PascalCase | `UserService` |
| Interface | IPascalCase | `IUserRepository` |
| Method | PascalCase | `GetUserById` |
| Property | PascalCase | `FirstName` |
| Field (private) | _camelCase | `_userRepository` |
| Parameter | camelCase | `userId` |
| Local | camelCase | `currentUser` |
| Constant | PascalCase | `MaxRetryCount` |

## Async Patterns

- Suffix async methods with `Async`
- Use `ConfigureAwait(false)` in library code
- Prefer `ValueTask<T>` for hot paths that often complete synchronously
- Never use `.Result` or `.Wait()` on tasks

## Null Handling

- Enable nullable reference types (`<Nullable>enable</Nullable>`)
- Use `is null` / `is not null` over `== null` / `!= null`
- Guard with early returns for null parameters
- Use null-conditional (`?.`) and null-coalescing (`??`) operators

## Error Handling

- Use exceptions for exceptional conditions
- Create custom exceptions for domain-specific errors
- Include meaningful exception messages
- Never catch `Exception` without good reason

## Dependency Injection

- Register services in appropriate extension methods
- Prefer constructor injection
- Use `IOptions<T>` for configuration
- Scope services appropriately (Singleton, Scoped, Transient)

## Entity Framework

- Use async methods (`ToListAsync`, `FirstOrDefaultAsync`)
- Configure entities in separate configuration classes
- Use migrations for schema changes
- Avoid lazy loading in web applications

## Code Organization

- One class per file (exceptions for nested/related types)
- Order: fields, constructors, properties, methods
- Group related methods together
- Use regions sparingly (prefer smaller classes)

## Anti-Patterns

- ❌ Magic strings/numbers (use constants or config)
- ❌ Catching and swallowing exceptions silently
- ❌ Using `dynamic` without justification
- ❌ Circular dependencies between projects
- ❌ Business logic in controllers
