# Rust Rules

> Applies to Rust projects only.

## Ownership and borrowing
- No unnecessary `.clone()`; check whether borrowing solves it first
- Take `&str` instead of `String` where possible
- Write lifetimes only when the compiler cannot infer them

## Error handling
- Minimize `unwrap()` and `expect()`; prefer `?`
- Libraries define custom error types (`thiserror`)
- Applications use `anyhow::Result`
- `panic!` only for truly impossible states

## Patterns
- `match` handles every case; do not overuse wildcards
- Chain `Option`/`Result` (`map`, `and_then`, `unwrap_or`)
- Use `impl Trait` in parameter and return positions
- Derive freely (`Debug`, `Clone`, `PartialEq`)

## Performance
- Minimize heap allocation; prefer the stack
- Iterator chains are zero-cost; use them
- Use `with_capacity` when the `Vec` size is known

## Tools
- Formatter: `rustfmt`
- Linter: `clippy`
- Package manager: `cargo`
