---
applyTo: "**/*.ts,**/*.tsx"
---

# TypeScript Instructions

> Conventions for TypeScript development.

## Type Safety

- Enable strict mode in tsconfig
- Avoid `any` — use `unknown` when type is truly unknown
- Prefer interfaces for object shapes
- Use type guards for narrowing

## Type Definitions

```typescript
// Prefer interface for object shapes
interface User {
  id: string;
  name: string;
  email: string;
}

// Use type for unions, intersections, utilities
type Status = 'pending' | 'active' | 'inactive';
type PartialUser = Partial<User>;
```

## Naming Conventions

| Element | Convention | Example |
|---------|------------|---------|
| Interface | PascalCase | `UserProfile` |
| Type | PascalCase | `ButtonVariant` |
| Enum | PascalCase | `UserRole` |
| Function | camelCase | `getUserById` |
| Variable | camelCase | `currentUser` |
| Constant | SCREAMING_SNAKE or PascalCase | `MAX_RETRIES`, `DefaultConfig` |

## Null Handling

- Use strict null checks
- Prefer undefined over null for optional values
- Use optional chaining (`?.`) and nullish coalescing (`??`)
- Type optional properties explicitly

```typescript
// Optional property
interface Config {
  timeout?: number;  // number | undefined
}

// Null handling
const value = data?.nested?.value ?? 'default';
```

## Function Patterns

- Use explicit return types for public functions
- Prefer arrow functions for callbacks
- Use default parameters over conditional logic
- Avoid overloads when union types suffice

```typescript
// Explicit return type
function getUser(id: string): Promise<User | null> {
  // ...
}

// Default parameters
function greet(name: string, greeting = 'Hello'): string {
  return `${greeting}, ${name}`;
}
```

## Import Organization

Order imports:
1. External packages
2. Internal modules (absolute paths)
3. Relative imports
4. Type-only imports last

```typescript
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

import { UserService } from '@app/services';

import { User } from './models';

import type { Config } from './types';
```

## Generics

- Use meaningful generic names (`T`, `K`, `V` or descriptive)
- Constrain generics when possible
- Provide defaults for optional generics

```typescript
function first<T>(array: T[]): T | undefined {
  return array[0];
}

interface Repository<T extends { id: string }> {
  findById(id: string): Promise<T | null>;
}
```

## Anti-Patterns

- ❌ Using `any` (use `unknown` or proper types)
- ❌ Type assertions without validation (`as Type`)
- ❌ Non-null assertions (`!`) without certainty
- ❌ Ignoring TypeScript errors with `@ts-ignore`
- ❌ Mixing default and named exports inconsistently
