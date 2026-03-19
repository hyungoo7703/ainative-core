# Go Rules

> 이 규칙은 Go 프로젝트에서만 적용합니다.

## 에러 처리
- 에러는 반드시 처리한다 — `_`로 무시 금지
- `errors.Is()`, `errors.As()`로 에러 비교
- 커스텀 에러는 `fmt.Errorf("context: %w", err)`로 래핑
- panic은 진짜 복구 불가능한 경우에만

## 패턴
- 인터페이스는 사용하는 쪽에서 정의 (소비자 정의 원칙)
- 인터페이스는 작게 유지 (1~3개 메서드)
- `init()` 사용 최소화 — 명시적 초기화 우선
- 제로 값이 유용하도록 구조체 설계

## 네이밍
- MixedCaps 사용 (snake_case 금지)
- 약어는 대문자 유지 (`HTTP`, `URL`, `ID`)
- 패키지명은 소문자 한 단어
- getter에 `Get` 접두사 불필요 (`user.Name()`, not `user.GetName()`)

## 동시성
- goroutine 시작 시 종료 조건 명확히
- `context.Context`를 첫 번째 매개변수로
- channel보다 `sync.Mutex`가 적합한 경우 구분
- `sync.WaitGroup`으로 goroutine 완료 대기

## 도구
- 포매터: `gofmt` (필수)
- 린터: `golangci-lint`
