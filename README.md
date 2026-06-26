# claude-agents

**Next.js + FastAPI + MySQL** 풀스택 개발을 위한 [Claude Code](https://claude.com/claude-code) 서브에이전트 모음입니다.
코드 리뷰·보안 점검·테스트·문서화·DB·디자인·아키텍처 설계를 각각 전문 에이전트가 담당합니다.

- 에이전트 수: **9종**
- 언어: 한국어 프롬프트
- 성격: **읽기 전용** — 분석·리뷰·설계·제안만 하고 코드/스키마를 직접 수정하지 않음
- 현재 버전: 대부분 **v1.1** (`ui-ux-reviewer`만 v1.0) — 상세 이력은 [CHANGELOG.md](CHANGELOG.md)

---

## 목차
- [에이전트 9종](#에이전트-9종)
- [공통 규칙](#공통-규칙)
- [설치 / 등록](#설치--등록)
- [사용 방법](#사용-방법)
- [슬래시 명령](#슬래시-명령)
- [바탕화면 런처](#바탕화면-런처)
- [버전 관리](#버전-관리)
- [업데이트 워크플로우](#업데이트-워크플로우)
- [저장소 구조](#저장소-구조)

---

## 에이전트 9종

| # | 에이전트 | 슬래시 | 분류 | 버전 | 역할 | 도구 |
|---|---|---|---|---|---|---|
| 1 | `code-reviewer` | `/review` | 품질 | 1.1 | 코드 품질·가독성·버그 리뷰 | Read, Grep, Glob, Bash |
| 2 | `security-reviewer` | `/sec` | 품질 | 1.1 | 보안 취약점(OWASP) 점검 | Read, Grep, Glob, WebSearch, WebFetch |
| 3 | `test-runner` | `/test` | 품질 | 1.1 | 테스트 실행·실패 분석 | Bash, Read, Grep, Glob |
| 4 | `api-doc-writer` | `/apidoc` | 문서 | 1.1 | FastAPI 엔드포인트 카탈로그 | Read, Grep, Glob, Context7 |
| 5 | `db-optimizer` | `/db` | DB | 1.1 | MySQL 쿼리·인덱스 성능 튜닝 | Read, Grep, Glob, Bash |
| 6 | `ui-ux-reviewer` | `/ui` | 디자인 | 1.0 | UI/UX·접근성·반응형 점검 | Read, Grep, Glob |
| 7 | `design-system-architect` | `/dsystem` | 디자인 | 1.1 | 디자인 토큰·컴포넌트 설계 | Read, Grep, Glob, Context7 |
| 8 | `data-modeler` | `/datamodel` | 설계 | 1.1 | 데이터 모델/스키마 설계 | Read, Grep, Glob |
| 9 | `system-architect` | `/arch` | 설계 | 1.1 | 시스템 아키텍처 설계 | Read, Grep, Glob, Context7 |

### 🔍 품질 / QA

<details>
<summary><b>1. code-reviewer</b> (<code>/review</code>) — 코드 품질·버그 리뷰</summary>

- **언제**: 커밋/PR 전 셀프 리뷰, 리팩터링 검토
- **범위 결정**: `git diff` / `git diff --staged`로 변경분을 파악해 그 범위에 집중 (Bash는 범위 식별 전용, 실행·수정 금지)
- **백엔드(FastAPI)**: Pydantic 스키마·타입힌트, async 일관성(블로킹 I/O), DB 세션/트랜잭션 경계, 예외 처리, 계층 분리
- **프론트(Next.js)**: 서버/클라 컴포넌트 경계, 데이터 페칭·캐싱, useEffect 의존성, 로딩/에러 처리, 타입 안전성
- **출력**: 요약 → Must fix → Should fix → Nit (분류 내 영향도순, `파일:줄` 명시)
- **구분**: 보안 전용은 `security-reviewer`
</details>

<details>
<summary><b>2. security-reviewer</b> (<code>/sec</code>) — 보안 취약점 점검</summary>

- **언제**: PR/새 기능 머지 전, 보안 점검 필요 시
- **기준**: OWASP Top 10
- **점검**: 인증/인가(라우터 레벨 의존성까지 확인해 오탐 방지), IDOR, RBAC, 경로 탐색, JWT(알고리즘·exp·저장 위치), 인젝션, XSS, 민감정보 노출, CSRF/SSRF, Pydantic 과잉 수용(Mass Assignment), CORS
- **출력**: 심각도(Critical~Low)순 + "즉시 고쳐야 할 Top 3"
</details>

<details>
<summary><b>3. test-runner</b> (<code>/test</code>) — 테스트 실행·분석</summary>

- **언제**: 코드 수정 후 테스트 실행·실패 진단
- **러너**: pytest(FastAPI), Jest/Vitest(Next.js)
- **원칙**: 프로덕션 코드·환경(설치·venv)을 임의로 건드리지 않음 — 사전 조건으로 보고, 명시 요청 시만 실행
- **출력**: 통과/실패/스킵 집계 → 실패별 원인 분류(코드 버그/테스트 오류/환경/외부 의존성)·제안, 플레이키 표시
</details>

### 📚 문서 / DB

<details>
<summary><b>4. api-doc-writer</b> (<code>/apidoc</code>) — API 문서화</summary>

- **언제**: 프론트 연동 전 API 명세 파악, 미문서화 엔드포인트 발견
- **수집**: 라우터/WebSocket 데코레이터, 다단계(중첩) prefix 합성, 라우터/앱 레벨 의존성까지 본 인증 판정, `tags`/`response_model`/`deprecated` 반영
- **출력**: 리소스/태그별 표 + 미인증·무응답모델·deprecated 엔드포인트 목록
</details>

<details>
<summary><b>5. db-optimizer</b> (<code>/db</code>) — MySQL 성능 튜닝</summary>

- **언제**: 느린 쿼리 진단, N+1, 인덱스 설계, 마이그레이션 검토
- **점검**: N+1, 인덱스(복합 컬럼 순서·중복), SELECT */함수 래핑/OFFSET 페이지네이션, 타입 적정성, 트랜잭션·락, 커넥션 풀
- **안전장치**: ALTER/DROP 직접 실행 안 함. `EXPLAIN`/`EXPLAIN ANALYZE`는 명시 요청 시만
- **출력**: 영향도별 문제 + "가장 효과 큰 개선 3가지"
- **구분**: 스키마 "설계"는 `data-modeler`
</details>

### 🎨 디자인

<details>
<summary><b>6. ui-ux-reviewer</b> (<code>/ui</code>) — UI/UX·접근성 점검</summary>

- **언제**: 화면 머지 전 디자인 품질 점검
- **점검**: 레이아웃/간격, 타이포 위계, 색 대비(WCAG AA), 반응형·터치 타깃, 접근성(시맨틱·aria·키보드·alt·label), 상태 표현(로딩/빈/에러), 컴포넌트 일관성
- **출력**: 요약 → Must/Should/Nit
- **구분**: 토큰/시스템 설계는 `design-system-architect`
</details>

<details>
<summary><b>7. design-system-architect</b> (<code>/dsystem</code>) — 디자인 시스템 설계</summary>

- **언제**: 흩어진 스타일을 일관된 시스템으로 정비
- **설계**: 디자인 토큰(색/타이포/스페이싱/래디우스/섀도), 테마(다크모드), 컴포넌트 계층·variant, 네이밍, Tailwind 토큰화, 중복 통합, 문서화(Storybook)
- **출력**: 현황 진단 → 제안 토큰 세트 → 컴포넌트 구조 → 마이그레이션 단계
</details>

### 🏗 설계

<details>
<summary><b>8. data-modeler</b> (<code>/datamodel</code>) — 데이터 모델 설계</summary>

- **언제**: 새 도메인 테이블/관계 설계, 기존 모델 재설계 (ERP 등 복잡 도메인)
- **설계**: 엔터티/관계(N:M 연결 테이블), 정규화, 키 전략(대리키/자연키/FK 동작), 타입 선택, 제약·무결성, 이력/감사/soft delete/채번, 확장성
- **출력**: 텍스트 ERD → 테이블별 설계(DDL) → 트레이드오프 → 가정/확인 필요
- **구분**: 기존 쿼리 성능 튜닝은 `db-optimizer`
</details>

<details>
<summary><b>9. system-architect</b> (<code>/arch</code>) — 시스템 아키텍처 설계</summary>

- **언제**: 기능 구현 전 구조 설계, 기존 아키텍처 점검
- **설계**: 계층 분리, 모듈 경계·의존성, API 계약, 인증 구조, 비동기/작업(큐·워커), 캐싱, 폴더 구조, 확장성
- **출력(설계)**: 요구사항/가정 → 옵션 비교(장단점) → 권장안(흐름도) → 단계 적용
- **출력(점검)**: 현황 진단 → 구조적 문제(영향도순) → 개선 설계 → 마이그레이션
</details>

### 역할이 겹치기 쉬운 쌍

| 쌍 | 구분 |
|---|---|
| code-reviewer ↔ security-reviewer | 일반 품질/버그 ↔ 보안 전용 |
| db-optimizer ↔ data-modeler | 기존 쿼리·인덱스 "튜닝" ↔ 테이블·관계 "설계" |
| ui-ux-reviewer ↔ design-system-architect | 개별 화면 "점검" ↔ 토큰·컴포넌트 "시스템 설계" |
| code-reviewer(프론트) ↔ ui-ux-reviewer | 로직·타입·구조 ↔ 시각·사용성·접근성 |

---

## 공통 규칙

모든 에이전트가 지키는 규칙:
- 발견/제안은 **영향도(심각도) 순으로 정렬**
- 근거에 `파일경로:줄번호` 명시
- 확신이 없으면 추측하지 않고 **"확인 필요" / "검토 필요" / "추정"** 으로 표시
- 실행·수정이 필요한 작업(테스트 실행, 진단 쿼리 등)은 **명시적으로 요청받았을 때만** 수행
- 도구는 **최소 권한** — 읽기 전용이면 `Read, Grep, Glob`, 실행이 꼭 필요한 경우만 `Bash`

---

## 설치 / 등록

### 1) 저장소 클론
```bash
git clone https://github.com/rhl0509/claude-agents.git
cd claude-agents
```

### 2) 에이전트 등록 위치
Claude Code는 아래 위치의 `.md` 파일을 에이전트로 인식합니다.

| 위치 | 적용 범위 |
|---|---|
| `~/.claude/agents/` (전역) | **모든 프로젝트** — 권장 |
| `<프로젝트>/.claude/agents/` | 해당 프로젝트만 |

### 3) 전역 등록 (Windows)
저장소의 9개 에이전트 `.md`를 전역 폴더로 복사합니다. 동봉된 스크립트를 쓰면 편합니다.
```bat
sync-agents.bat
```
> `sync-agents.bat`은 9개 에이전트 파일을 `%USERPROFILE%\.claude\agents\`로 복사합니다.

슬래시 명령(`/review` 등)을 쓰려면 `commands/` 내용을 `~/.claude/commands/`에도 두세요.

---

## 사용 방법

### A. 자동 호출 (가장 간단)
Claude Code 채팅창에 자연어로 요청하면, `description`을 보고 알맞은 에이전트가 자동 선택됩니다.
```
이번 변경분 리뷰해줘            → code-reviewer
이 기능 머지 전에 보안 점검해줘   → security-reviewer
주문/결제 ERP 모델 설계해줘      → data-modeler
```

### B. 명시적 호출
```
security-reviewer 서브에이전트로 src/auth 점검해줘
```

### C. 슬래시 명령
```
/review                 # 현재 git 변경분 리뷰
/sec src/auth           # 특정 경로 보안 점검
/test tests/test_user.py
```

> 분석 대상 코드(Next.js/FastAPI/MySQL 프로젝트)가 있는 폴더에서 Claude Code를 실행해야 합니다.

---

## 슬래시 명령

| 명령 | 에이전트 | 인자(선택) |
|---|---|---|
| `/review` | code-reviewer | 경로 |
| `/sec` | security-reviewer | 경로 |
| `/test` | test-runner | 테스트 경로/패턴 |
| `/apidoc` | api-doc-writer | 경로 |
| `/db` | db-optimizer | 경로/쿼리 |
| `/ui` | ui-ux-reviewer | 경로 |
| `/dsystem` | design-system-architect | 경로 |
| `/datamodel` | data-modeler | 요구사항/경로 |
| `/arch` | system-architect | 기능 설명/경로 |

> 슬래시 명령은 추가 후 다음 세션부터 목록에 나타납니다.

---

## 바탕화면 런처

VS Code 없이 바로 쓰고 싶을 때를 위한 런처(`launchers/claude.bat` 참고)도 포함되어 있습니다.
더블클릭 → 프로젝트 폴더 선택 → 터미널에서 Claude 실행.
> `.bat` 파일은 한글이 깨질 수 있어 **ASCII로만** 작성합니다.

---

## 버전 관리

버전 번호는 `메이저.마이너` 두 자리를 씁니다.

| 변경 종류 | 예시 | 버전 |
|---|---|---|
| 체크 항목 추가, 표현 다듬기 등 **작은 개선** | 1.2 → 1.3 | 마이너 |
| 역할·출력 형식·동작이 **크게 바뀜** | 1.x → 2.0 | 메이저 |

- 각 에이전트의 현재 버전은 파일 frontmatter의 `version`/`updated`에 기록됩니다.
- 전체 변경 이력은 [CHANGELOG.md](CHANGELOG.md)에 정리됩니다.
- 이 README의 [에이전트 표](#에이전트-9종) 버전 칸도 버전업 시 함께 갱신됩니다.

---

## 업데이트 워크플로우

에이전트를 수정할 때는 항상 아래 순서를 따릅니다. **원본은 이 저장소의 `*.md` 한 곳에서만** 수정합니다.

1. 원본 `*.md` 수정
2. frontmatter `version`/`updated` 갱신 (마이너/메이저 판단)
3. `CHANGELOG.md`에 변경 기록
4. **`README.md`의 버전 표 갱신** (버전업 시)
5. `sync-agents.bat`으로 전역(`~/.claude/agents/`)에 반영
6. `git commit` + `git push`

---

## 저장소 구조

```
claude-agents/
├─ README.md                     # 이 문서
├─ CHANGELOG.md                  # 버전별 변경 이력
├─ AGENTS.md                     # 9개 에이전트 통합 정리
├─ design-agents.md              # 디자인 에이전트 4종 상세
├─ CLAUDE.md                     # 저장소 작업 가이드(Claude Code용)
├─ sync-agents.bat               # 전역 동기화 스크립트
├─ .gitignore
│
├─ code-reviewer.md              # ── 에이전트 정의 (9개) ──
├─ security-reviewer.md
├─ test-runner.md
├─ api-doc-writer.md
├─ db-optimizer.md
├─ ui-ux-reviewer.md
├─ design-system-architect.md
├─ data-modeler.md
└─ system-architect.md
```

---

## 라이선스

개인용 프로젝트(비공개 저장소). 별도 라이선스 미지정.
