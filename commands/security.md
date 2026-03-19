---
description: 보안 취약점 검증 (OWASP 기반)
---

프로젝트 코드를 OWASP Top 10 기준으로 스캔하여 보안 취약점을 찾아냅니다.
모든 항목을 빠짐없이 검사하고, 발견된 문제는 구체적인 수정 방법까지 제시합니다.

## 검사 항목

### 1. 인증/인가 (Broken Access Control, Authentication)
- 인증 없이 접근 가능한 API 엔드포인트
- 권한 검증 누락 (관리자 기능에 일반 사용자 접근 등)
- 수평적 권한 상승 (다른 사용자의 리소스 접근)
- 세션/토큰 관리 문제 (만료, 갱신, 저장 방식)
- 비밀번호 정책 (최소 길이, 복잡성, 해싱 알고리즘)
- 브루트포스 방어 (로그인 시도 제한, 계정 잠금)
- JWT 검증 (서명, 만료, 알고리즘 강제)

### 2. 입력 검증 (Injection)
- SQL Injection (ORM 우회 포함, raw query 사용처 전수 검사)
- XSS — Stored, Reflected, DOM-based 모두 검사
- Command Injection (child_process, exec, system 등)
- Path Traversal (../ 공격)
- SSRF (Server-Side Request Forgery)
- 파일 업로드 검증 (확장자, MIME 타입, 크기 제한, 저장 경로)
- 역직렬화 공격 (JSON.parse, pickle, eval 등)
- 정규식 DoS (ReDoS)

### 3. 민감 정보 노출 (Sensitive Data Exposure)
- 코드에 하드코딩된 API 키, 비밀번호, 토큰, 인증서
- 에러 응답에 내부 정보 노출 (스택 트레이스, DB 구조, 서버 버전)
- 로그에 민감 정보 출력 (비밀번호, 카드번호, 개인정보)
- .gitignore에 민감 파일 누락 (.env, credentials, 인증서)
- 클라이언트에 불필요한 데이터 전송 (API 응답에 과도한 필드)
- 암호화: 비밀번호는 bcrypt/argon2, 데이터는 AES-256 이상

### 4. 보안 설정 미흡 (Security Misconfiguration)
- 디버그 모드 운영 환경 노출
- 기본 계정/비밀번호 변경 여부
- 불필요한 HTTP 메서드 허용
- 보안 헤더 누락 (CSP, X-Frame-Options, X-Content-Type-Options, HSTS)
- 디렉토리 리스팅 활성화
- 에러 페이지에 정보 노출

### 5. 의존성 (Vulnerable Components)
- 알려진 취약점이 있는 패키지 (npm audit, pip audit, snyk 등 실행)
- 불필요하게 넓은 권한의 패키지
- 더 이상 유지보수되지 않는 패키지
- 라이선스 충돌

### 6. 통신 (Insecure Communication)
- HTTPS 미사용
- CORS 설정 과도하게 열림 (origin: *)
- 쿠키 보안 속성 누락 (Secure, HttpOnly, SameSite)
- API 키가 URL 파라미터로 전송
- WebSocket 인증 누락

### 7. 비즈니스 로직
- Rate Limiting 미적용 (API 남용 가능)
- CSRF 방어 누락 (상태 변경 요청)
- 결제/포인트 등 금액 관련 로직의 클라이언트 의존
- 중복 요청 방어 (멱등성)

## 출력 형식

- 🔴 **위험**: 즉시 수정 필요 — 수정 코드 예시 포함
- 🟡 **주의**: 조건부로 악용 가능 — 개선 방법 제시
- 🟢 **양호**: 잘 처리된 부분

각 항목에 파일 경로, 라인 번호, OWASP 분류를 함께 표시합니다.
검사가 끝나면 위험도별 요약 테이블을 제공합니다.
