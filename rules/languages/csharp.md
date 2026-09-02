# C# Rules

> Applies to C# projects only.

## Types
- `var` only when the type is obvious (`var x = new List<string>()`)
- Enable nullable reference types (`<Nullable>enable</Nullable>`)
- Prefer generics over `object`
- Minimize `dynamic`

## Patterns
- Define immutable data with `record`
- Use pattern matching (`is`, `switch` expressions)
- Prefer `is null or ""` over `string.IsNullOrEmpty()`
- Manage resources with `using` declarations (`using var stream = ...`)

## Naming
- Classes, methods, properties: PascalCase
- Parameters, locals: camelCase
- Private fields: `_camelCase`
- Interfaces: `I` prefix (`IRepository`)
- Async methods: `Async` suffix (`GetUserAsync`)

## Async
- Use `async/await`; never `.Result` or `.Wait()` (deadlock risk)
- `Task.Run` only for CPU-bound work
- Pass `CancellationToken` habitually
- `ValueTask` only on hot paths

## LINQ
- Prefer method syntax (`Where().Select()`)
- Split complex queries into steps
- Null-check after `FirstOrDefault`

## Tools
- Formatter: `dotnet format`
- Linter: Roslyn analyzers
