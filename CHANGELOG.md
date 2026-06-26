# 변경 이력 (CHANGELOG)

**버전 규칙**: `메이저.마이너`
- 마이너 올림 (1.2 → 1.3): 체크 항목 추가, 표현 다듬기 등 작은 개선
- 메이저 올림 (1.x → 2.0): 역할·출력 형식·동작이 크게 바뀔 때

**작업 규칙**: 수정은 항상 원본(`d:\auto_agent`)에서 하고, `sync-agents.bat`을 실행해 전역(`C:\Users\PC\.claude\agents`)에 반영한다. 변경 시 ① 해당 에이전트의 frontmatter `version`/`updated`를 올리고 ② 아래에 기록하고 ③ `README.md`의 버전 표도 갱신한 뒤 ④ `git commit` + `git push` 한다.

---

## 1.1 (2026-06-26) — 모델 티어링 + 외부 문서/보안 정보 연동

**모델 재배정 (난이도 기반)**
- `opus`로 상향: `code-reviewer`, `security-reviewer`, `db-optimizer`, `data-modeler`, `design-system-architect`, `system-architect`
- `haiku`로 하향: `test-runner` (기계적 실행·분석)
- `sonnet` 유지: `api-doc-writer`, `ui-ux-reviewer`

**도구 추가 (+ 사용 지침 문단)**
- `api-doc-writer` 1.1 — Context7(`resolve-library-id`/`get-library-docs`) 추가: 버전 민감한 FastAPI/Pydantic 동작 확인
- `design-system-architect` 1.1 — Context7 추가: Tailwind v3/v4 등 버전별 설정 문법 확인
- `system-architect` 1.1 — Context7 추가: 프레임워크 권장 패턴(App Router, 의존성/백그라운드 작업 등) 버전 확인
- `security-reviewer` 1.1 — WebSearch/WebFetch 추가: 의존성 CVE·보안 권고(GHSA/NVD) 확인 (코드 분석 보조 수단)
- `code-reviewer` 1.1, `db-optimizer` 1.1, `data-modeler` 1.1 — `opus`로 상향 (프롬프트 변경 없음)
- `test-runner` 1.1 — `haiku`로 변경

**문서/도구**
- `CLAUDE.md` — 에이전트 표에 4종(ui-ux-reviewer, design-system-architect, data-modeler, system-architect) 추가, 모델 티어링·frontmatter 스키마 설명, `sync.ps1` 기반 위치·동기화 섹션
- `sync.ps1` 신규 — PowerShell 동기화 스크립트

> `ui-ux-reviewer`는 1.0 유지 (변경 없음).

---

## 1.0 (2026-06-23) — 최초 버전 기준선

9개 에이전트 첫 버전 등록.

**품질/QA**
- `code-reviewer` 1.0 — 변경분(git diff) 기반 코드 리뷰
- `security-reviewer` 1.0 — OWASP 보안 점검(라우터 레벨 인증·CSRF/SSRF·Mass Assignment 포함)
- `test-runner` 1.0 — 테스트 실행·실패 분석

**문서/DB**
- `api-doc-writer` 1.0 — FastAPI 엔드포인트 카탈로그(WebSocket·다단계 prefix·라우터 인증 반영)
- `db-optimizer` 1.0 — MySQL 쿼리·인덱스 성능 튜닝(커넥션 풀 포함)

**디자인**
- `ui-ux-reviewer` 1.0 — UI/UX·접근성·반응형 점검
- `design-system-architect` 1.0 — 디자인 토큰·컴포넌트 시스템 설계

**설계**
- `data-modeler` 1.0 — 데이터 모델/스키마 설계
- `system-architect` 1.0 — 시스템 아키텍처 설계
