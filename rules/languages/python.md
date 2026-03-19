# Python Rules

> 이 규칙은 Python 프로젝트에서만 적용합니다.

## 타입
- type hint 적극 활용 (`def foo(x: int) -> str:`)
- `typing` 모듈 활용 — `Optional`, `Union`, `TypeAlias`
- Python 3.10+ 문법 우선 (`X | Y`, `match/case`)
- `Any` 사용 최소화

## 패턴
- f-string 사용 — `.format()`, `%` 지양
- list/dict comprehension 활용 (단, 중첩은 피한다)
- `dataclass` 또는 `Pydantic` 모델로 데이터 구조 정의
- `Enum` 사용 시 `StrEnum` 우선

## 함수
- 매개변수 3개 초과 시 keyword-only argument 활용 (`*`)
- `async/await` 사용 — 콜백 지양
- 제너레이터/이터레이터 적절히 활용

## import
- 표준 라이브러리 → 서드파티 → 로컬 순서
- 와일드카드 import 금지 (`from x import *`)
- 사용하지 않는 import 제거

## 도구
- 포매터: `ruff format` 또는 `black`
- 린터: `ruff`
- 패키지 관리: `uv` 또는 `poetry`
