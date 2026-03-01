---
applyTo: "**/Controllers/**,**/Endpoints/**"
---

# API Design Conventions

> Guidelines for API design and implementation.

## HTTP Methods

| Method | Purpose        | Idempotent |
| ------ | -------------- | ---------- |
| GET    | Retrieve       | Yes        |
| POST   | Create         | No         |
| PUT    | Full update    | Yes        |
| PATCH  | Partial update | Yes        |
| DELETE | Remove         | Yes        |

## Response Codes

| Code | When                      |
| ---- | ------------------------- |
| 200  | Success with body         |
| 201  | Created (POST)            |
| 204  | Success, no body (DELETE) |
| 400  | Bad request (syntax)      |
| 401  | Unauthenticated           |
| 403  | Unauthorized              |
| 404  | Not found                 |
| 409  | Conflict                  |
| 422  | Validation error          |

## Problem Details (RFC 7807)

All errors return Problem Details format:

```json
{
  "type": "https://api.example.com/problems/validation-error",
  "title": "Validation Error",
  "status": 422,
  "detail": "One or more fields failed validation",
  "errors": { "field": ["error message"] }
}
```

## Pagination

Standard query parameters:

```
GET /api/entities?page=1&pageSize=20
```

Response includes:

- `items`: Array of results
- `totalCount`: Total items
- `page`: Current page
- `pageSize`: Items per page

## Naming

### URIs

- Plural nouns for collections: `/users`, `/orders`
- Kebab-case for multi-word: `/order-items`
- Nested resources for ownership: `/users/{id}/orders`

### Query Parameters

- camelCase: `pageSize`, `sortBy`
- Standard filters: `search`, `status`, `from`, `to`

## Versioning

Prefer URL path versioning:

```
/api/v1/users
/api/v2/users
```

## Contract-First

- Define OpenAPI/Swagger spec before implementation
- Use spec for validation and documentation
- Generate client SDKs from spec when possible
