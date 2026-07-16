---
paths:
  - "**/*.ts"
  - "**/*.tsx"
---
# TypeScript 규칙 (Next.js 프론트 중심)

> `paths:` 프론트매터로 **.ts/.tsx 파일을 읽을 때만** 자동 로드된다(Claude Code 네이티브 rules 조건부 로드). common.md를 확장한다.

## 타입
- `any` 금지 — `unknown` + 좁히기, 또는 정확한 타입. 라이브러리 경계는 명시 타입.
- API 응답 타입은 수기 중복 정의 대신 OpenAPI 생성 타입으로 단일 출처화(백엔드 스키마와 드리프트 방지).
- `strict` 모드 전제. 널/undefined 처리를 옵셔널 체이닝·기본값으로 명시.

## Next.js (App Router)
- **서버/클라이언트 경계**를 명확히 — 기본은 서버 컴포넌트, `"use client"`는 상호작용 필요한 잎(leaf)에만.
- 시크릿·서버 전용 로직은 서버 컴포넌트/Route Handler/Server Action에만. 클라이언트 번들에 키 노출 금지.
- 데이터 페칭은 서버에서, 캐싱 전략(`fetch` 캐시·revalidate)을 의도적으로 지정.
- 폼·변이는 Server Action 또는 Route Handler. 입력은 서버에서 재검증(클라 검증만 신뢰 금지).

## 상태·렌더
- 공유 상태 변이 대신 불변 업데이트. 파생 상태는 계산으로(중복 소스 금지).
- `useEffect` 남용 금지 — 렌더 중 계산 가능한 건 이펙트로 빼지 않는다.
- 접근성: 시맨틱 태그·라벨·대비. 확인/알림은 시스템 `alert/confirm` 금지, 앱 내 커스텀 모달.

## 보안·검증
- 사용자 입력·URL·외부 데이터는 신뢰 경계. XSS 방지(위험한 `dangerouslySetInnerHTML` 지양).
- 프론트-백 계약 변경 시 타입 정합을 함께 확인.
