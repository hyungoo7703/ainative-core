# Rust Rules

> 이 규칙은 Rust 프로젝트에서만 적용합니다.

## 소유권 / 빌림
- 불필요한 `.clone()` 사용 금지 — 빌림으로 해결 가능한지 먼저 확인
- `&str`을 매개변수로 받을 수 있으면 `String` 대신 `&str` 사용
- 라이프타임은 컴파일러가 추론 못 할 때만 명시

## 에러 처리
- `unwrap()`, `expect()` 사용 최소화 — `?` 연산자 우선
- 라이브러리는 커스텀 에러 타입 정의 (`thiserror`)
- 애플리케이션은 `anyhow::Result` 활용
- `panic!`은 진짜 불가능한 상태에서만

## 패턴
- `match`는 모든 케이스 처리 (와일드카드 남용 금지)
- `Option`/`Result` 체이닝 활용 (`map`, `and_then`, `unwrap_or`)
- `impl Trait`을 매개변수/반환 타입에 활용
- `derive` 매크로 적극 활용 (`Debug`, `Clone`, `PartialEq`)

## 성능
- 힙 할당 최소화 — 스택 할당 우선
- 이터레이터 체이닝은 zero-cost abstraction이므로 적극 활용
- `Vec` 사이즈를 아는 경우 `with_capacity` 사용

## 도구
- 포매터: `rustfmt`
- 린터: `clippy`
- 패키지 관리: `cargo`
