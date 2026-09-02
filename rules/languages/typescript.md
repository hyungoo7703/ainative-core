# TypeScript Rules

> Applies to TypeScript projects only.

## Type system
- No `any`: use `unknown` and narrow with type guards
- `strict: true` is required
- Omit type annotations where inference is sufficient
- Minimize `as` assertions; prefer type guards

## Patterns
- Use `as const` objects instead of `enum`
- `interface` for extensible object types, `type` for unions and utilities
- Use optional chaining (`?.`) and nullish coalescing (`??`)
- No `!` non-null assertions; narrow with conditionals

## Functions
- Annotate return types only on complex functions
- More than three parameters: take an object
- Use `async/await`; avoid `.then()` chains

## Imports
- Use `import type` for type-only imports
- Configure a path alias (`@/` etc.)
- Remove unused imports
