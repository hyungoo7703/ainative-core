# Python Rules

> Applies to Python projects only.

## Types
- Use type hints (`def foo(x: int) -> str:`)
- Use `typing` helpers: `Optional`, `Union`, `TypeAlias`
- Prefer Python 3.10+ syntax (`X | Y`, `match/case`)
- Minimize `Any`

## Patterns
- Use f-strings, not `.format()` or `%`
- Use list/dict comprehensions, but avoid nesting them
- Define data structures with `dataclass` or Pydantic models
- Prefer `StrEnum` for enums

## Functions
- More than three parameters: use keyword-only arguments (`*`)
- Use `async/await`; avoid callbacks
- Use generators and iterators where appropriate

## Imports
- Order: standard library, third-party, local
- No wildcard imports (`from x import *`)
- Remove unused imports

## Tools
- Formatter: `ruff format` or `black`
- Linter: `ruff`
- Package manager: `uv` or `poetry`
