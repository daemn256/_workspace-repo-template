---
applyTo: "**/*.ts,**/*.tsx"
---

# TypeScript Conventions

> Guidelines for TypeScript development.

## Type Safety

### Prefer Explicit Types

```typescript
// ✅ Good
function getUser(id: string): Promise<User | null> {
  return userService.findById(id);
}

// ❌ Avoid
function getUser(id) {
  return userService.findById(id);
}
```

### Use `unknown` Over `any`

```typescript
// ✅ Good
function parseJson(json: string): unknown {
  return JSON.parse(json);
}

// ❌ Avoid
function parseJson(json: string): any {
  return JSON.parse(json);
}
```

## Null Handling

### Prefer Optional Chaining

```typescript
// ✅ Good
const name = user?.profile?.name ?? "Anonymous";

// ❌ Avoid
const name = (user && user.profile && user.profile.name) || "Anonymous";
```

### Use Strict Null Checks

Assume `strictNullChecks: true` in tsconfig.

## Interfaces vs Types

| Use         | When                                  |
| ----------- | ------------------------------------- |
| `interface` | Object shapes, especially extendable  |
| `type`      | Unions, intersections, computed types |

```typescript
// Interface for objects
interface User {
  id: string;
  name: string;
}

// Type for unions/computed
type Status = "pending" | "active" | "completed";
type UserWithStatus = User & { status: Status };
```

## Enums

Prefer const objects or union types over enums:

```typescript
// ✅ Preferred
const Status = {
  Pending: "pending",
  Active: "active",
  Completed: "completed",
} as const;
type Status = (typeof Status)[keyof typeof Status];

// ❌ Avoid (runtime overhead, quirks)
enum Status {
  Pending = "pending",
  Active = "active",
}
```

## Async/Await

Always use async/await over raw Promises:

```typescript
// ✅ Good
async function fetchUser(id: string): Promise<User> {
  const response = await api.get(`/users/${id}`);
  return response.data;
}

// ❌ Avoid
function fetchUser(id: string): Promise<User> {
  return api.get(`/users/${id}`).then((r) => r.data);
}
```

## Error Handling

Use discriminated unions for result types:

```typescript
type Result<T, E = Error> =
  | { success: true; data: T }
  | { success: false; error: E };

async function getUser(id: string): Promise<Result<User>> {
  try {
    const user = await repository.findById(id);
    return { success: true, data: user };
  } catch (error) {
    return { success: false, error };
  }
}
```
