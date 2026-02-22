---
applyTo: "**/*.java,**/pom.xml"
---

# Java Conventions

> Conventions for Java and Maven development.

## Language Conventions

- Use Java 17+ features where appropriate
- Prefer `var` for local variables when type is obvious
- Use records for immutable data classes
- Use sealed classes for restricted hierarchies

## Naming Conventions

| Element   | Convention      | Example             |
| --------- | --------------- | ------------------- |
| Class     | PascalCase      | `UserService`       |
| Interface | PascalCase      | `UserRepository`    |
| Method    | camelCase       | `getUserById`       |
| Variable  | camelCase       | `currentUser`       |
| Constant  | SCREAMING_SNAKE | `MAX_RETRY_COUNT`   |
| Package   | lowercase       | `com.example.users` |

## Package Structure

```
src/main/java/com/example/
├── config/          # Configuration classes
├── controller/      # REST controllers
├── service/         # Business logic
├── repository/      # Data access
├── model/           # Domain entities
├── dto/             # Data transfer objects
└── exception/       # Custom exceptions
```

## Records (Java 16+)

```java
// Preferred for DTOs and value objects
public record UserDto(
    String id,
    String name,
    String email
) {}
```

## Optional Handling

- Return `Optional<T>` for nullable returns
- Never pass `Optional` as parameter
- Use `orElseThrow()` for required values
- Avoid `isPresent()` + `get()` pattern

```java
// Good
return userRepository.findById(id)
    .orElseThrow(() -> new UserNotFoundException(id));

// Avoid
if (optional.isPresent()) {
    return optional.get();
}
```

## Null Handling

- Use `@NonNull` / `@Nullable` annotations
- Validate parameters early
- Use Objects.requireNonNull() for constructor parameters

```java
public UserService(@NonNull UserRepository repository) {
    this.repository = Objects.requireNonNull(repository);
}
```

## Exception Handling

- Create custom exceptions for domain errors
- Use unchecked exceptions for programming errors
- Include context in exception messages
- Don't catch Exception without good reason

## Spring Patterns

- Use constructor injection (not `@Autowired` on fields)
- Mark services with appropriate stereotype annotations
- Use `@Transactional` at service layer
- Prefer `@RestController` for REST APIs

```java
@RestController
@RequestMapping("/api/v1/users")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }
}
```

## Maven Conventions

- Use dependency management in parent POM
- Specify explicit versions for dependencies
- Use properties for version numbers
- Keep plugins in pluginManagement

## Anti-Patterns

- ❌ Field injection with `@Autowired`
- ❌ Catching and ignoring exceptions
- ❌ Mutable DTOs
- ❌ Business logic in controllers
- ❌ Raw types (use generics)
- ❌ Wildcard imports
