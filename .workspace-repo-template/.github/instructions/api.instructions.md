---
applyTo: "**/Controllers/**,**/Endpoints/**"
---

# API Instructions

> Conventions for API controllers and endpoints.

## REST Conventions

| Verb | Purpose | Success | Body |
|------|---------|---------|------|
| GET | Retrieve | 200 | Response |
| POST | Create | 201 | Created resource |
| PUT | Replace | 200 | Updated resource |
| PATCH | Partial update | 200 | Updated resource |
| DELETE | Remove | 204 | None |

## Status Codes

| Code | Meaning | When to Use |
|------|---------|-------------|
| 200 | OK | Successful GET, PUT, PATCH |
| 201 | Created | Successful POST |
| 204 | No Content | Successful DELETE |
| 400 | Bad Request | Invalid input |
| 401 | Unauthorized | Missing/invalid auth |
| 403 | Forbidden | Valid auth, no permission |
| 404 | Not Found | Resource doesn't exist |
| 409 | Conflict | State conflict |
| 422 | Unprocessable | Validation failed |
| 500 | Server Error | Unexpected error |

## Error Response (Problem Details - RFC 9457)

```json
{
  "type": "https://api.example.com/problems/validation-error",
  "title": "Validation Error",
  "status": 400,
  "detail": "One or more validation errors occurred.",
  "errors": {
    "email": ["Invalid email format"]
  }
}
```

## URL Patterns

```
/api/v1/{resource}           # Collection
/api/v1/{resource}/{id}      # Single item
/api/v1/{resource}/{id}/{sub}  # Sub-resource
```

- Use plural nouns for resources (`/users`, not `/user`)
- Use kebab-case for multi-word resources (`/order-items`)
- Avoid verbs in URLs (use HTTP methods instead)

## Versioning

- Include version in URL path (`/api/v1/...`)
- Maintain backwards compatibility within major version
- Document breaking changes
- Deprecate before removing

## Pagination

```json
{
  "data": [...],
  "pagination": {
    "page": 1,
    "pageSize": 20,
    "totalCount": 100,
    "totalPages": 5
  }
}
```

Query parameters: `?page=1&pageSize=20`

## Filtering and Sorting

```
GET /api/v1/users?status=active&sort=name:asc,createdAt:desc
```

- Use query parameters for filtering
- Support multiple sort fields with direction

## Controller Patterns

```csharp
[ApiController]
[Route("api/v1/[controller]")]
public class UsersController : ControllerBase
{
    [HttpGet("{id}")]
    [ProducesResponseType<User>(StatusCodes.Status200OK)]
    [ProducesResponseType<ProblemDetails>(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> GetById(string id)
    {
        // ...
    }
}
```

## Anti-Patterns

- ❌ Verbs in URLs (`/api/getUser`)
- ❌ Inconsistent naming (mixing `/User` and `/orders`)
- ❌ Returning 200 for errors
- ❌ Exposing internal IDs or implementation details
- ❌ Missing Content-Type headers
- ❌ Ignoring Accept headers
