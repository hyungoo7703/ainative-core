# C# Rules

> 이 규칙은 C# 프로젝트에서만 적용합니다.

## 타입
- `var`는 타입이 명확할 때만 사용 (`var x = new List<string>()`)
- nullable reference type 활성화 (`<Nullable>enable</Nullable>`)
- `object` 대신 제네릭 활용
- `dynamic` 사용 최소화

## 패턴
- record 타입으로 불변 데이터 구조 정의
- pattern matching 활용 (`is`, `switch` expression)
- `string.IsNullOrEmpty()` 대신 `is null or ""`
- `using` 선언으로 리소스 관리 (`using var stream = ...`)

## 네이밍
- 클래스, 메서드, 프로퍼티: PascalCase
- 매개변수, 로컬 변수: camelCase
- private 필드: `_camelCase`
- 인터페이스: `I` 접두사 (`IRepository`)
- 비동기 메서드: `Async` 접미사 (`GetUserAsync`)

## 비동기
- `async/await` 사용 — `.Result`, `.Wait()` 금지 (데드락 위험)
- `Task.Run`은 CPU-bound 작업에만
- `CancellationToken` 전달 습관화
- `ValueTask`는 핫 패스에서만

## LINQ
- 메서드 구문 우선 (`Where().Select()`)
- 복잡한 쿼리는 단계별로 분리
- `FirstOrDefault` 사용 시 null 체크 필수

## 도구
- 포매터: `dotnet format`
- 린터: Roslyn analyzers
