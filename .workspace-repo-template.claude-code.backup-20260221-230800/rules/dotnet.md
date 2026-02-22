---
paths:
  - "**/*.cs"
---

# C# Conventions

> Guidelines for C# development.

## Naming

| Element          | Convention     | Example           |
| ---------------- | -------------- | ----------------- |
| Classes          | PascalCase     | `UserService`     |
| Interfaces       | I + PascalCase | `IUserRepository` |
| Methods          | PascalCase     | `GetUserById`     |
| Properties       | PascalCase     | `FirstName`       |
| Fields (private) | \_camelCase    | `_userRepository` |
| Parameters       | camelCase      | `userId`          |
| Constants        | PascalCase     | `MaxRetryCount`   |

## Async/Await

### Suffix Async Methods

```csharp
// ✅ Good
public async Task<User> GetUserAsync(string id)

// ❌ Avoid
public async Task<User> GetUser(string id)
```

### Avoid async void

```csharp
// ✅ Good
public async Task HandleEventAsync()

// ❌ Avoid (exceptions can't be caught)
public async void HandleEvent()
```

## Null Handling

### Use Nullable Reference Types

```csharp
// Enable in .csproj
<Nullable>enable</Nullable>

// Explicit nullability
public User? FindById(string id);
public User GetById(string id); // never null, throws if not found
```

### Prefer Null Coalescing

```csharp
// ✅ Good
var name = user?.Name ?? "Unknown";

// ❌ Avoid
var name = user != null && user.Name != null ? user.Name : "Unknown";
```

## Error Handling

### Result Pattern (Prefer over Exceptions)

```csharp
public Result<User> GetUser(string id)
{
    var user = _repository.Find(id);
    if (user is null)
        return Result.NotFound<User>($"User {id} not found");

    return Result.Ok(user);
}
```

### Exception Guidelines

- Use exceptions for exceptional conditions
- Prefer Result types for expected failure modes
- Include context in exception messages

## Collections

### Prefer Immutable Returns

```csharp
// ✅ Good
public IReadOnlyList<User> GetUsers() => _users.AsReadOnly();

// ❌ Avoid (caller can modify)
public List<User> GetUsers() => _users;
```

### Use Collection Expressions (C# 12+)

```csharp
// ✅ Good
List<int> numbers = [1, 2, 3];
int[] array = [4, 5, 6];

// ❌ Avoid
var numbers = new List<int> { 1, 2, 3 };
```

## LINQ

### Prefer Method Syntax

```csharp
// ✅ Preferred
var adults = users.Where(u => u.Age >= 18).ToList();

// ⚠️ Use query syntax only for complex joins
var result = from u in users
             join o in orders on u.Id equals o.UserId
             select new { u.Name, o.Total };
```

## Dependency Injection

### Constructor Injection

```csharp
public class UserService
{
    private readonly IUserRepository _repository;
    private readonly ILogger<UserService> _logger;

    public UserService(IUserRepository repository, ILogger<UserService> logger)
    {
        _repository = repository;
        _logger = logger;
    }
}
```

### Primary Constructors (C# 12+)

```csharp
public class UserService(IUserRepository repository, ILogger<UserService> logger)
{
    public async Task<User?> GetAsync(string id) =>
        await repository.FindAsync(id);
}
```
