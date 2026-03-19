---
description: 현재 프로젝트 실행 방법 안내
---

현재 프로젝트의 파일 구조를 분석해서 실행 방법을 안내해주세요.

## 판단 기준

프로젝트 유형을 파일로 판단:

- `manifest.json` (browser_action/action 포함) → **Chrome 확장 프로그램**
- `package.json`의 `"type": "module"` 또는 MCP 관련 의존성 → **MCP 서버**
- `package.json`의 `"bin"` 필드 → **CLI 도구**
- `package.json`의 `"scripts"."dev"` → **웹 앱** (Next.js, Vite 등)
- `Cargo.toml` → **Rust 프로젝트**
- `go.mod` → **Go 프로젝트**
- `requirements.txt` 또는 `pyproject.toml` → **Python 프로젝트**
- `Dockerfile` → **Docker 컨테이너**

## 안내 포맷

```
## 프로젝트 유형
(판단 결과)

## 실행 방법
(단계별 안내)

## 자주 쓰는 명령어
(해당되면)

## 주의사항
(해당되면)
```

실행에 필요한 사전 설치(Node.js, Python 등)가 있으면 함께 안내합니다.
