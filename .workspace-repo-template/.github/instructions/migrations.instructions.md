---
applyTo: "**/Migrations/**"
---

# Migrations Instructions

> Conventions for database migrations.

## Migration Safety Principles

1. **Always reversible** — Every migration must have a rollback
2. **Data preservation** — Never lose existing data
3. **Idempotent** — Safe to run multiple times
4. **Atomic** — Succeed completely or fail completely

## Naming Convention

```
YYYYMMDDHHMMSS_<Description>.cs
```

Example: `20240115143000_AddUserEmailIndex.cs`

## Safe Operations

| Operation | Safe | Notes |
|-----------|------|-------|
| Add column (nullable) | ✅ | No data impact |
| Add column (with default) | ✅ | Populates existing rows |
| Add index | ✅ | May be slow on large tables |
| Create table | ✅ | No data impact |
| Rename column | ⚠️ | Break queries referencing old name |
| Drop column | ⚠️ | Data loss, break dependent code |
| Drop table | ❌ | Data loss |
| Change column type | ⚠️ | May lose precision/data |

## Adding Columns

```csharp
// Safe: nullable column
migrationBuilder.AddColumn<string>(
    name: "MiddleName",
    table: "Users",
    nullable: true);

// Safe: with default value
migrationBuilder.AddColumn<bool>(
    name: "IsActive",
    table: "Users",
    nullable: false,
    defaultValue: true);
```

## Removing Columns (Two-Phase)

### Phase 1: Deprecate

1. Stop writing to column
2. Remove reads from column
3. Deploy and verify

### Phase 2: Remove

1. Create migration to drop column
2. Deploy during low-traffic window

## Index Considerations

```csharp
// Create index (may lock table)
migrationBuilder.CreateIndex(
    name: "IX_Users_Email",
    table: "Users",
    column: "Email",
    unique: true);

// For large tables, consider CONCURRENTLY (PostgreSQL)
// or ONLINE (SQL Server) options
```

## Data Migrations

- Separate schema and data migrations
- Use SQL for bulk data operations
- Consider batching for large datasets
- Test with production-like data volumes

```csharp
// Data migration in separate step
migrationBuilder.Sql(@"
    UPDATE Users 
    SET Status = 'active' 
    WHERE Status IS NULL");
```

## Rollback Requirements

Every `Up()` needs a corresponding `Down()`:

```csharp
protected override void Up(MigrationBuilder migrationBuilder)
{
    migrationBuilder.AddColumn<string>("NewColumn", "Table", nullable: true);
}

protected override void Down(MigrationBuilder migrationBuilder)
{
    migrationBuilder.DropColumn("NewColumn", "Table");
}
```

## Testing Migrations

1. Test Up migration on copy of production data
2. Test Down migration (rollback)
3. Verify data integrity after migration
4. Test application with migrated schema

## Anti-Patterns

- ❌ Migrations without rollback (`Down()`)
- ❌ Dropping columns without deprecation period
- ❌ Large data migrations in schema migration
- ❌ Assuming empty tables in production
- ❌ Hard-coded IDs or values
- ❌ Running untested migrations in production
