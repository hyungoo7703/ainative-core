# Go Rules

> Applies to Go projects only.

## Error handling
- Always handle errors; never discard them with `_`
- Compare errors with `errors.Is()` and `errors.As()`
- Wrap with context: `fmt.Errorf("context: %w", err)`
- `panic` only for truly unrecoverable states

## Patterns
- Define interfaces on the consumer side
- Keep interfaces small (1 to 3 methods)
- Minimize `init()`; prefer explicit initialization
- Design structs so the zero value is useful

## Naming
- MixedCaps, never snake_case
- Keep acronyms uppercase (`HTTP`, `URL`, `ID`)
- Package names: one lowercase word
- No `Get` prefix on getters (`user.Name()`, not `user.GetName()`)

## Concurrency
- Every goroutine has a clear exit condition
- `context.Context` is the first parameter
- Know when `sync.Mutex` fits better than a channel
- Wait for goroutines with `sync.WaitGroup`

## Tools
- Formatter: `gofmt` (required)
- Linter: `golangci-lint`
