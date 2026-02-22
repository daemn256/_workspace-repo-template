---
applyTo: "**/Migrations/**"
---

# Database Migrations Conventions

> Guidelines for database schema changes and migrations.

## Migration Safety

### Always Reversible

Migrations should be reversible when possible:

```csharp
// ✅ Good - can rollback
migrationBuilder.AddColumn<string>("NewColumn", "TableName", nullable: true);

// ⚠️ Careful - data loss on rollback
migrationBuilder.DropColumn("OldColumn", "TableName");
```

### Never Destructive Without Approval

Operations requiring explicit approval:

- Dropping columns or tables
- Changing column types (potential data loss)
- Removing indexes
- Renaming (may break existing code)

## Migration Naming

Pattern: `YYYYMMDDHHMMSS_DescriptiveAction`

Examples:

- `20260201120000_AddUserEmailColumn`
- `20260201130000_CreateOrdersTable`
- `20260201140000_AddIndexOnOrderStatus`

## Schema Changes

### Adding Columns

```csharp
// Nullable first, then backfill, then make required
migrationBuilder.AddColumn<string>("Email", "Users", nullable: true);
// Later migration: UPDATE, then alter to NOT NULL
```

### Adding Indexes

```csharp
// Consider concurrency
migrationBuilder.CreateIndex(
    name: "IX_Orders_Status",
    table: "Orders",
    column: "Status");
```

## Best Practices

### One Change Per Migration

- Single logical change per migration
- Easier to review, test, and rollback
- Clearer history

### Test Migrations

- Run up and down in dev environment
- Verify data preservation
- Check performance impact

### Document Breaking Changes

Include comments for:

- Data transformations
- Assumptions about existing data
- Required coordination with code changes

## Rollback Strategy

Always have a rollback plan:

```bash
# Check current migration
dotnet ef migrations list

# Rollback to specific migration
dotnet ef database update PreviousMigrationName

# Generate rollback script
dotnet ef migrations script CurrentMigration PreviousMigration
```
