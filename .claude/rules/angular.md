---
paths:
  - "**/*.component.ts"
  - "**/*.service.ts"
  - "**/*.directive.ts"
  - "**/*.pipe.ts"
  - "**/*.module.ts"
---

# Angular Conventions

> Conventions for Angular development.

## Component Conventions

- Use standalone components (Angular 14+)
- Prefer OnPush change detection
- Use signals for reactive state (Angular 16+)
- Keep components focused (single responsibility)

## Naming Conventions

| Element   | Convention           | Example            |
| --------- | -------------------- | ------------------ |
| Component | kebab-case selector  | `app-user-profile` |
| Service   | PascalCase + Service | `UserService`      |
| Directive | camelCase selector   | `appHighlight`     |
| Pipe      | camelCase name       | `dateFormat`       |
| Module    | PascalCase + Module  | `SharedModule`     |

## File Naming

```
<name>.<type>.ts
```

Examples:

- `user-profile.component.ts`
- `auth.service.ts`
- `highlight.directive.ts`
- `date-format.pipe.ts`

## Signals (Angular 16+)

- Prefer `signal()` over BehaviorSubject for component state
- Use `computed()` for derived state
- Use `effect()` for side effects
- Convert observables with `toSignal()`

```typescript
// Preferred
count = signal(0);
doubled = computed(() => this.count() * 2);

// Avoid for simple state
count$ = new BehaviorSubject(0);
```

## Reactive Patterns

- Use async pipe in templates for observables
- Unsubscribe properly (takeUntilDestroyed, async pipe)
- Avoid nested subscriptions
- Use appropriate RxJS operators

## Template Conventions

- Use `@if` / `@for` control flow (Angular 17+)
- Avoid complex logic in templates
- Use trackBy for `@for` loops
- Prefer template references over DOM queries

## Service Patterns

- Provide in root for singletons (`providedIn: 'root'`)
- Use HttpClient for API calls
- Return observables from services (caller decides subscription)
- Handle errors at appropriate level

## Selector Prefixes

- Components: `app-` or project-specific prefix
- Directives: `app` or project-specific prefix (camelCase)

## Anti-Patterns

- ❌ Logic in constructors (use ngOnInit or injection)
- ❌ Manual change detection (use signals/async pipe)
- ❌ Subscribing in components without cleanup
- ❌ Large monolithic components
- ❌ Direct DOM manipulation (use Angular APIs)
