# claude-agents

**Next.js + FastAPI + MySQL** 풀스택 개발을 위한 [Claude Code](https://claude.com/claude-code) 서브에이전트 모음입니다.
코드 리뷰·보안 점검·테스트·문서화·DB·디자인·아키텍처 설계를 각각 전문 에이전트가 담당합니다. 여기에 더해, 개발 스택과 무관하게 **AI 작업환경·프롬프트 시스템 자체**를 재설계하는 메타 에이전트 1종(`ai-workspace-architect`)과, **마케팅 카피·상세페이지·SEO·팩트체크·콘텐츠 재활용·브랜드 보이스**를 다루는 콘텐츠 에이전트 6종(`copy-reviewer`·`landing-reviewer`·`seo-optimizer`·`fact-checker`·`content-repurposer`·`brand-voice-guardian`)이 포함됩니다. 여기에 프롬프트(뼈대)에 살을 붙여 이야기를 짓는 **창작 특화(Fable) 스토리 생성 에이전트 1종**(`storyteller`)이 더해집니다. 보안 계열은 코드 취약점(`security-reviewer`)에 더해 **설계 단계 위협 모델링(`threat-modeler`)과 AI/LLM 보안 심화(`llm-ai-security-reviewer`)**까지 다룹니다. 여기에 더해 **Unity + C# 게임 개발(싱글플레이어 2D 캐주얼)**을 위한 게임 도메인 에이전트 7종(`unity-code-reviewer`·`game-design-architect`·`game-ui-reviewer`·`game-feel-reviewer`·`unity-perf-auditor`·`playtest-designer`·`unity-build-auditor`)이 시범 추가되었습니다(🎮 게임 클러스터).

- 에이전트 수: **38종** (개발 스택 리뷰·엔지니어링·문서 19종 + 메타 2종 + 콘텐츠/마케팅 6종 + 창작 1종 + 보안 심화 2종 + 게임 7종 + 인프라 1종)
- 언어: 한국어 프롬프트
- 성격: **읽기 전용** — 분석·리뷰·설계·제안만 하고 코드/스키마를 직접 수정하지 않음
- 현재 버전: `db-optimizer` **v1.10**, `security-reviewer` **v1.11**, `test-runner` **v1.10**, `code-reviewer` **v1.11**, `devops-reviewer` **v1.8**, `data-modeler` **v1.6**, `api-doc-writer` **v1.6**, `ui-ux-reviewer` **v1.5**, `system-architect` **v1.5**, `design-system-architect`·`perf-auditor`·`test-strategy` **v1.4**, `observability-reviewer` **v1.3**, `migration-reviewer` **v1.2**, `api-contract-reviewer`·`dependency-auditor` **v1.1**, 메타 2종 `ai-workspace-architect` **v1.3**·`agent-definition-reviewer` **v1.1**, 콘텐츠 6종 `copy-reviewer`·`content-repurposer` **v1.1**·`landing-reviewer`·`seo-optimizer`·`fact-checker`·`brand-voice-guardian` **v1.0**, 보안 심화 `threat-modeler`·`llm-ai-security-reviewer` **v1.1**, 게임 7종 `unity-code-reviewer` **v1.2**·`game-design-architect` **v1.2**·`game-ui-reviewer` **v1.0**·`game-feel-reviewer` **v1.1**·`unity-perf-auditor`·`playtest-designer`·`unity-build-auditor` **v1.0**, 인프라 `memory-recaller` **v1.3**, 엔지니어링 `refactor-strategist` **v1.0**, 문서 `docs-writer` **v1.1**, 창작 `storyteller` **v1.0**, 디버깅 `debugger` **v1.0** — 상세 이력은 [CHANGELOG.md](CHANGELOG.md)
- 추론 강도(`effort`): opus 심층추론 34종은 frontmatter `effort: high`로 고정해 세션 설정과 무관하게 추론 깊이를 보장하고, 그중 **`xhigh` 4종**(`security-reviewer`·`threat-modeler`·`llm-ai-security-reviewer`·`ai-workspace-architect`)은 더 깊게 돈다. 창작 에이전트 `storyteller`는 `fable` 모델 + `effort: high`로 창작 품질 플로어를 둔다(저장소 첫 `fable` 에이전트). `sonnet`·`haiku`(api-doc-writer·test-runner·memory-recaller)는 세션 상속 — 상세는 [CHANGELOG.md](CHANGELOG.md) effort 튜닝 요약

---

## 목차
- [에이전트 38종](#에이전트-38종)
- [공통 규칙](#공통-규칙)
- [설치 / 등록](#설치--등록)
- [사용 방법](#사용-방법)
- [슬래시 명령](#슬래시-명령)
- [바탕화면 런처](#바탕화면-런처)
- [버전 관리](#버전-관리)
- [업데이트 워크플로우](#업데이트-워크플로우)
- [저장소 구조](#저장소-구조)

---

## 에이전트 38종

**관련된 것끼리 묶은 표**다(추가된 순서가 아니라 역할 기준). `#`은 아래 상세 블록의 번호와 같아서, 번호를 따라가면 그 에이전트의 상세를 찾을 수 있다(상세 블록은 추가 순서대로 있음).

#### 🔍 코드 품질 · 디버깅 · 테스트

| # | 에이전트 | 슬래시 | 버전 | 모델 | 역할 | 도구 |
|---|---|---|---|---|---|---|
| 1 | `code-reviewer` | `/review` `/리뷰` | 1.11 | opus | 코드 품질·가독성·버그 리뷰(증상 없는 정적 탐색) | Read, Grep, Glob, Bash |
| 38 | `debugger` | `/debug` `/디버그` | 1.0 | opus | 이미 난 버그·에러·간헐 실패의 근본 원인 규명(재현·가설 검증·이분 탐색) | Read, Grep, Glob, Bash |
| 3 | `test-runner` | `/test` `/테스트` | 1.10 | sonnet | 테스트 실행·실패 분석(1차 원인 분류) | Bash, Read, Grep, Glob |
| 4 | `test-strategy` | `/coverage` `/커버리지` | 1.4 | opus | 테스트 커버리지 공백·약한 테스트 진단 | Read, Grep, Glob |
| 34 | `refactor-strategist` | `/refactor` `/리팩터` | 1.0 | opus | 동작 보존 리팩터 계획·단계 설계(추출·중복·의존·seam) | Read, Grep, Glob |

#### 🔒 보안 (설계 → 코드 → AI)

| # | 에이전트 | 슬래시 | 버전 | 모델 | 역할 | 도구 |
|---|---|---|---|---|---|---|
| 24 | `threat-modeler` | `/threat` | 1.1 | opus | 설계 단계 위협 모델링(STRIDE) — 구현 **전** | Read, Grep, Glob, WebSearch, WebFetch |
| 2 | `security-reviewer` | `/sec` `/보안` | 1.11 | opus | 코드 보안 취약점(OWASP) 점검 — 구현 **후** | Read, Grep, Glob, WebSearch, WebFetch |
| 25 | `llm-ai-security-reviewer` | `/aisec` | 1.1 | opus | AI/LLM 보안 심화(OWASP LLM Top 10) | Read, Grep, Glob, WebSearch, WebFetch |

#### 🗄 데이터 / DB

| # | 에이전트 | 슬래시 | 버전 | 모델 | 역할 | 도구 |
|---|---|---|---|---|---|---|
| 12 | `data-modeler` | `/datamodel` `/데이터모델` | 1.6 | opus | 데이터 모델/스키마 **설계**(ERD·키·제약) | Read, Grep, Glob |
| 8 | `db-optimizer` | `/db` `/디비` | 1.10 | opus | MySQL 쿼리·인덱스 **성능 튜닝** | Read, Grep, Glob, Bash |
| 9 | `migration-reviewer` | `/migrate` `/마이그레이션` | 1.2 | opus | 스키마 마이그레이션 **안전성**(락·백필·롤백) | Read, Grep, Glob |

#### 🏗 아키텍처 · API · 문서

| # | 에이전트 | 슬래시 | 버전 | 모델 | 역할 | 도구 |
|---|---|---|---|---|---|---|
| 13 | `system-architect` | `/arch` `/아키텍처` | 1.5 | opus | 시스템 아키텍처 설계(계층·경계·확장성) | Read, Grep, Glob, Context7 |
| 6 | `api-contract-reviewer` | `/contract` `/계약` | 1.1 | opus | 프론트-백 API 계약 정합성 점검 | Read, Grep, Glob |
| 7 | `api-doc-writer` | `/apidoc` | 1.6 | sonnet | FastAPI 엔드포인트 카탈로그 | Read, Grep, Glob, Context7 |
| 35 | `docs-writer` | `/docs` `/문서` | 1.1 | opus | 개발자용 기술문서(README·아키텍처·온보딩·ADR) | Read, Grep, Glob |

#### 🎨 프론트엔드 (화면 · 디자인 · 성능)

| # | 에이전트 | 슬래시 | 버전 | 모델 | 역할 | 도구 |
|---|---|---|---|---|---|---|
| 10 | `ui-ux-reviewer` | `/ui` `/화면` | 1.5 | opus | UI/UX·접근성·반응형·다크패턴 점검 | Read, Grep, Glob |
| 11 | `design-system-architect` | `/dsystem` | 1.4 | opus | 디자인 토큰·컴포넌트 설계(DESIGN.md) | Read, Grep, Glob, Context7 |
| 5 | `perf-auditor` | `/perf` `/성능` | 1.4 | opus | Next.js 프론트 성능(번들·CWV·캐싱) | Read, Grep, Glob |

#### 🚀 운영 (배포 · 의존성 · 관측성)

| # | 에이전트 | 슬래시 | 버전 | 모델 | 역할 | 도구 |
|---|---|---|---|---|---|---|
| 14 | `devops-reviewer` | `/devops` `/배포` | 1.8 | opus | Docker·CI/CD·배포 설정 점검 | Read, Grep, Glob |
| 15 | `dependency-auditor` | `/deps` `/의존성` | 1.1 | opus | 의존성 취약점·버전·라이선스 점검 | Read, Grep, Glob, Bash |
| 16 | `observability-reviewer` | `/obs` `/관측성` | 1.3 | opus | 로깅·트레이싱·관측성 점검 | Read, Grep, Glob |

#### 🎮 게임 (Unity + C#, 2D 캐주얼)

| # | 에이전트 | 슬래시 | 버전 | 모델 | 역할 | 도구 |
|---|---|---|---|---|---|---|
| 27 | `game-design-architect` | `/gdd` | 1.2 | opus | 게임 디자인·시스템 설계(코어 루프·난이도·수직 슬라이스) | Read, Grep, Glob |
| 26 | `unity-code-reviewer` | `/ureview` | 1.2 | opus | Unity C# 코드 리뷰(수명주기·GC·프레임/물리) | Read, Grep, Glob, Bash |
| 29 | `game-feel-reviewer` | `/feel` | 1.1 | opus | 게임플레이 손맛/juice(입력 관대성·히트스톱·카메라) | Read, Grep, Glob |
| 28 | `game-ui-reviewer` | `/gui` | 1.0 | opus | 게임 UI/UX(HUD·메뉴·스케일링·내비·가독성) | Read, Grep, Glob |
| 30 | `unity-perf-auditor` | `/uperf` | 1.0 | opus | 런타임 성능·렌더링(배칭·오버드로우·메모리·Profiler) | Read, Grep, Glob |
| 31 | `playtest-designer` | `/playtest` | 1.0 | opus | 플레이테스트 프로토콜 설계(가설·참가자·지표·텔레메트리) | Read, Grep, Glob |
| 32 | `unity-build-auditor` | `/ubuild` | 1.0 | opus | 빌드/릴리스·스토어 제출 점검(PlayerSettings·서명·권한) | Read, Grep, Glob |

#### 📣 콘텐츠 / 마케팅

| # | 에이전트 | 슬래시 | 버전 | 모델 | 역할 | 도구 |
|---|---|---|---|---|---|---|
| 18 | `copy-reviewer` | `/copy` `/카피` | 1.1 | opus | 마케팅 카피 품질 리뷰(후킹·CTA·과장/윤리) | Read, Grep, Glob |
| 19 | `landing-reviewer` | `/landing` | 1.0 | opus | 상세페이지·랜딩 전환 구조 리뷰 | Read, Grep, Glob |
| 20 | `seo-optimizer` | `/seo` | 1.0 | opus | 블로그·페이지 SEO 점검 | Read, Grep, Glob, WebSearch, WebFetch |
| 21 | `fact-checker` | `/factcheck` | 1.0 | opus | 콘텐츠 사실·수치·출처 검증 | Read, Grep, Glob, WebSearch, WebFetch |
| 22 | `content-repurposer` | `/repurpose` | 1.1 | opus | 1소스 → 멀티 포맷 재활용 | Read, Grep, Glob |
| 23 | `brand-voice-guardian` | `/voice` | 1.0 | opus | 브랜드 보이스(문체·톤) 일관성 점검 | Read, Grep, Glob |
| 37 | `storyteller` | `/story` `/이야기` | 1.0 | **fable** | 프롬프트(뼈대)에 살 붙여 완성형 이야기 작성 | Read, Grep, Glob |

#### 🧭 메타 / 인프라 (내 작업환경 자체)

| # | 에이전트 | 슬래시 | 버전 | 모델 | 역할 | 도구 |
|---|---|---|---|---|---|---|
| 17 | `ai-workspace-architect` | `/fable` | 1.3 | opus | AI 작업환경 진단·재설계(프롬프트·CLAUDE.md·SKILL.md·모델별 전략) | Read, Grep, Glob, WebSearch, WebFetch |
| 36 | `agent-definition-reviewer` | `/agentdef` | 1.1 | opus | 이 라이브러리의 에이전트 정의(.md) 스펙·경계·규범 점검 | Read, Grep, Glob |
| 33 | `memory-recaller` | `/recall` `/회상` | 1.3 | **haiku** | 파일 기반 장기기억 회상(`E:\claude_memory`) — 값싼 Haiku 회상 | Read, Grep, Glob |

### 🔍 품질 / QA

<details>
<summary><b>1. code-reviewer</b> (<code>/review</code>) — 코드 품질·버그 리뷰</summary>

- **언제**: 커밋/PR 전 셀프 리뷰, 리팩터링 검토
- **범위 결정**: `git diff` / `git diff --staged`로 변경분을 파악해 그 범위에 집중 (Bash는 범위 식별 전용, 실행·수정 금지)
- **백엔드(FastAPI)**: Pydantic 스키마·타입힌트, async 일관성(블로킹 I/O), DB 세션/트랜잭션 경계, 예외 처리, 계층 분리
- **프론트(Next.js)**: 서버/클라 컴포넌트 경계, 데이터 페칭·캐싱, useEffect 의존성, 로딩/에러 처리, 타입 안전성
- **Next.js 15/16(v1.4)**: Server Actions 보안(서버 재검증·인가), `use cache`/Cache Components 오캐시, React Compiler 도입 시 중복 수동 메모 (버전 불명확하면 "확인 필요")
- **출력**: 요약 → Must fix → Should fix → Nit (분류 내 영향도순, `파일:줄` 명시)
- **구분**: 보안 전용은 `security-reviewer`, 시각·접근성·UX는 `ui-ux-reviewer`, 프론트-백 API 계약 정합은 `api-contract-reviewer`, 로깅·관측성은 `observability-reviewer`, 동작 보존 리팩터 계획은 `refactor-strategist`, 이미 발생한 증상의 원인 규명은 `debugger`(v1.11 — 코드리뷰는 증상 없이 변경분에서 잠재 결함을 찾음)
</details>

<details>
<summary><b>2. security-reviewer</b> (<code>/sec</code>) — 보안 취약점 점검</summary>

- **언제**: PR/새 기능 머지 전, 보안 점검 필요 시
- **기준**: OWASP Top 10 (2025) — A03 공급망·A10 예외 처리 오류(fail-open) 포함
- **점검**: 인증/인가(라우터 레벨 의존성까지 확인해 오탐 방지), IDOR/BOLA·BFLA·WebSocket(CSWSH), **Next.js 미들웨어 인가 우회(CVE-2025-29927)**, **Server Actions/Route Handler 내부 인가·입력 재검증(v1.10)**, RBAC, 경로 탐색, JWT(알고리즘 고정·alg confusion·kid/jku 헤더 주입·exp·저장 위치), 인젝션(SQL·SSTI·OS/NoSQL), XSS, 과잉 응답(API3, response_model), CSRF/SSRF, Mass Assignment/BOPLA, CORS
- **LLM 보안(v1.4, OWASP LLM Top 10 2025)**: 간접 프롬프트 인젝션(LLM01), 출력 처리(LLM05), 과도한 행위성(LLM06, 도구 권한·human-in-the-loop), 벡터/임베딩 약점(LLM08, RAG 포이즈닝·테넌트 격리), 시스템 프롬프트 유출(LLM02), 무제한 소비(LLM10)
- **출력**: 심각도(Critical~Low)순 + "즉시 고쳐야 할 Top 3"
- **구분(v1.5)**: 일반 코드 품질·버그는 `code-reviewer`, 배포·CI 설정·시크릿 취급은 `devops-reviewer`, 의존성 취약·버전·라이선스는 `dependency-auditor`
</details>

<details>
<summary><b>3. test-runner</b> (<code>/test</code>) — 테스트 실행·분석</summary>

- **언제**: 코드 수정 후 테스트 실행·실패 진단
- **러너**: pytest(FastAPI), Vitest/Jest 유닛(Next.js), Playwright/Cypress E2E
- **러너 구분(v1.5)**: 유닛과 E2E를 별개 러너로 인식 — E2E는 실행 비용·서버 기동 전제 때문에 요청 범위 밖이면 임의 실행 안 함. Vitest/jsdom은 async Server Component를 렌더 못 함 → 해당 실패는 프로덕션 버그로 단정하지 말고 Playwright E2E 영역임을 알림
- **원칙**: 프로덕션 코드·환경(설치·venv)을 임의로 건드리지 않음 — 사전 조건으로 보고, 명시 요청 시만 실행
- **테스트 품질 스캔(v1.3)**: 통과한 테스트도 훑어 change-detector(리터럴/카운트 동결)·목 그린을 "테스트 자체 약점"으로 표시 — green을 커버리지 양호로 칭찬하지 않음
- **출력**: 통과/실패/스킵 집계 → 실패별 원인 분류(코드 버그/테스트 오류/환경/외부 의존성)·제안, 플레이키 표시
- **1차 진단 한계(v1.10)**: 위 분류로 안 잡히는 실패(간헐/플레이키, 환경에서만 재현, "어제까진 됐는데" 회귀)는 억지로 결론내지 않고 `debugger`로 넘김
- **구분**: 커버리지 공백·약한 테스트 진단·보강 전략은 `test-strategy`, 근본 원인 규명(재현·가설 검증·이분 탐색)은 `debugger`
</details>

<details>
<summary><b>4. test-strategy</b> (<code>/coverage</code>) — 테스트 커버리지·약한 테스트 진단</summary>

- **언제**: 테스트가 회귀를 실제로 잡는지 점검, 보강할 케이스 설계
- **점검**: 커버리지 공백(분기·경계·에러·인증 경로), 약한 단언(change-detector·목 그린·단언 약함), 테스트 구조(중복·플레이키), 스택별 핵심 경로
- **원칙**: 통과(green)가 품질의 증거가 아니다 — 통과해도 약한 테스트는 지적. 테스트 코드를 직접 작성하지 않고 케이스를 설계(요청 시 단언 골격 예시)
- **출력**: 요약 → 커버리지 공백(입력→기대결과) → 약한 테스트(왜·어떻게 바꿀지) → 제안
- **구분**: 테스트 실행·실패 진단은 `test-runner`, 일반 코드 품질은 `code-reviewer`
</details>

<details>
<summary><b>5. perf-auditor</b> (<code>/perf</code>) — Next.js 프론트 성능 점검</summary>

- **언제**: "화면이 느리다", "번들이 크다", 배포 전 성능 점검
- **점검**: 번들/코드 스플리팅, 서버/클라 경계, 데이터 페칭·캐싱(워터폴), 이미지/폰트(next/image·next/font), 렌더 비용(리렌더·가상화), Core Web Vitals(LCP/CLS/INP)
- **Next.js 15/16(v1.2)**: Cache Components/`use cache` opt-in 누락·오캐시, PPR 정적 셸+Suspense 경계, React Compiler 자동 메모와 중복되는 수동 메모 (버전 불명확하면 "확인 필요")
- **원칙**: 빌드를 실행하지 않는 정적 분석 — 측정이 필요한 항목은 "확인 필요(빌드 분석 권장)"로 표시
- **출력**: 요약 → 지표를 크게 해치는 Top 3(작용 지표 명시) → 주의 → 제안
- **구분**: 시각·접근성은 `ui-ux-reviewer`, MySQL 성능은 `db-optimizer`, 정확성·버그는 `code-reviewer`
</details>

<details>
<summary><b>6. api-contract-reviewer</b> (<code>/contract</code>) — 프론트-백 API 계약 정합성 점검</summary>

- **언제**: 프론트-백 연동 직후, API 계약 변경 머지 전
- **가정**: 프론트와 백엔드는 서로 다른 시점·다른 사람이 고친다 → 한쪽만 바뀌면 런타임에서 깨진다
- **점검**: 요청/응답 필드·타입 일치, 필수/옵셔널·널·enum 차이, 타입 드리프트(수기 중복 vs OpenAPI 생성 타입 동기화), 경로·메서드·상태코드, 깨지는 변경(필드 제거·이름·타입 축소·필수화), 페이지네이션·공통 래퍼·인증/Content-Type
- **출력**: 요약 → 불일치 Top 3(`프론트:줄` ↔ `백엔드:줄`, 어느 쪽을 맞출지) → 주의 → 제안
- **구분**: 한쪽 코드 품질·버그는 `code-reviewer`, 백엔드 엔드포인트 카탈로그·문서화는 `api-doc-writer`
</details>

### 📚 문서 / DB

<details>
<summary><b>7. api-doc-writer</b> (<code>/apidoc</code>) — API 문서화</summary>

- **언제**: 프론트 연동 전 API 명세 파악, 미문서화 엔드포인트 발견
- **수집**: 라우터/WebSocket 데코레이터, 다단계(중첩) prefix 합성, 라우터/앱 레벨 의존성까지 본 인증 판정, `tags`/`response_model`/`deprecated` 반영
- **현대 문법(v1.3)**: `Annotated[User, Depends(...)]`·`Annotated[str|None, Query()/Header()]`(FastAPI 0.95.0+ 권장) 양식을 구식 기본값 문법과 동등 인식. prefix 합성 불확실 시 OpenAPI 3.1 `/openapi.json` 교차 점검을 제안(직접 실행 불가 → "확인 필요")
- **출력**: 리소스/태그별 표 + 미인증·무응답모델·deprecated 엔드포인트 목록
- **구분**: 프론트-백 계약 정합 검증은 `api-contract-reviewer`, 일반 개발문서(README·아키텍처·온보딩·ADR)는 `docs-writer`
</details>

<details>
<summary><b>8. db-optimizer</b> (<code>/db</code>) — MySQL 성능 튜닝</summary>

- **언제**: 느린 쿼리 진단, N+1, 인덱스 설계, 마이그레이션의 성능·인덱스 영향 검토
- **점검**: N+1, 인덱스(복합 컬럼 순서·중복), SELECT */함수 래핑/OFFSET 페이지네이션, 타입 적정성, 트랜잭션·락, 커넥션 풀, 벡터 검색(MySQL 9 `VECTOR` k-NN·사전필터, 거리 함수·인덱스 지원은 엔진별 확인)
- **안전장치**: ALTER/DROP 직접 실행 안 함. `EXPLAIN`/`EXPLAIN ANALYZE`는 명시 요청 시만
- **출력**: 영향도별 문제 + "가장 효과 큰 개선 3가지"
- **구분**: 스키마 "설계"는 `data-modeler`, 마이그레이션 안전성(락·무중단·롤백)은 `migration-reviewer`, 프론트엔드 렌더·번들 등 화면 성능은 `perf-auditor`(v1.8)
</details>

<details>
<summary><b>9. migration-reviewer</b> (<code>/migrate</code>) — 마이그레이션 안전성 점검</summary>

- **언제**: 스키마 마이그레이션(Alembic 등) 머지·배포 전 안전성 리뷰
- **가정**: 운영 데이터가 많은 큰 테이블 + 마이그레이션 도중에도 트래픽이 흐른다
- **점검**: 락 범위·무중단 가능성, NOT NULL+백필 순서(expand-contract), 인덱스 생성 비용·동시성, 타입 변경 재작성, FK/유니크 제약 위반, 롤백 가능성(downgrade), 대량 DML 배치, 배포 순서(코드↔스키마 호환)
- **안전장치**: 마이그레이션을 직접 실행하지 않음. 버전·엔진 의존 동작은 "확인 필요"로 표시
- **출력**: 요약(무중단 가능 여부) → 위험 Top 3(안전한 대안 제시) → 주의 → 제안
- **구분**: 테이블·관계 "설계"는 `data-modeler`, 쿼리·인덱스 "성능 튜닝"은 `db-optimizer`
</details>

### 🎨 디자인

<details>
<summary><b>10. ui-ux-reviewer</b> (<code>/ui</code>) — UI/UX·접근성 점검</summary>

- **언제**: 화면 머지 전 디자인 품질 점검
- **점검**: 레이아웃/간격, 타이포 위계, 색 대비(WCAG AA), 반응형·터치 타깃, 접근성(시맨틱·aria·키보드·alt·label·reduced-motion), 상태 표현(로딩/빈/에러), 컴포넌트 일관성
- **확장(v1.3)**: 폼/입력(검증 시점·에러 위치), 마이크로카피/콘텐츠, 국제화(i18n/RTL·텍스트 확장), 다크모드 품질(표면 위계), **다크 패턴/윤리**, Nielsen 사용성 휴리스틱 렌즈 (실무 디자인 감사 카테고리 기반)
- **출력**: 요약 → Must/Should/Nit
- **구분**: 코드 로직·버그는 `code-reviewer`, 토큰/시스템 설계는 `design-system-architect`, 로드·렌더 성능(번들·CWV)은 `perf-auditor`
</details>

<details>
<summary><b>11. design-system-architect</b> (<code>/dsystem</code>) — 디자인 시스템 설계</summary>

- **언제**: 흩어진 스타일을 일관된 시스템으로 정비, 디자인 시스템을 `DESIGN.md` 단일 소스로 정리
- **설계**: 디자인 토큰(색/타이포/스페이싱/래디우스/섀도), 테마(다크모드), 컴포넌트 계층·variant, 네이밍, Tailwind 토큰화, 중복 통합, 문서화(Storybook)
- **DESIGN.md(v1.3)**: [google-labs-code/design.md](https://github.com/google-labs-code/design.md) 포맷(프런트매터 토큰 + 산문 근거)으로 단일 소스 초안 작성. 토큰 참조 `{colors.primary}`, WCAG 대비 명시. `@google/design.md` CLI(`lint`/`export` → Tailwind v3 JSON·v4 `@theme`·DTCG/`diff`)는 실행하지 않고 다음 단계로 안내
- **출력**: 현황 진단 → 제안 토큰 세트(DESIGN.md 형태) → DESIGN.md 초안 → 컴포넌트 구조 → 마이그레이션 단계
- **구분**: 개별 화면 UI/UX 점검은 `ui-ux-reviewer`
</details>

### 🏗 설계

<details>
<summary><b>12. data-modeler</b> (<code>/datamodel</code>) — 데이터 모델 설계</summary>

- **언제**: 새 도메인 테이블/관계 설계, 기존 모델 재설계 (ERP 등 복잡 도메인)
- **설계**: 엔터티/관계(N:M 연결 테이블), 정규화, 키 전략(대리키/자연키/FK 동작), 타입 선택, 제약·무결성, 이력/감사/soft delete/채번, 확장성
- **AI 데이터(v1.3)**: 임베딩/시맨틱 검색을 위한 MySQL 9 `VECTOR(N)` 타입·저장 구조(거리 함수·벡터 인덱스 지원은 엔진별 상이 — HeatWave vs 커뮤니티, 함수명 단정 금지·"확인 필요"; MySQL 8 이하나 미지원 시 외부 벡터 DB 트레이드오프)
- **출력**: 텍스트 ERD → 테이블별 설계(DDL) → 트레이드오프 → 가정/확인 필요
- **구분**: 기존 쿼리 성능 튜닝은 `db-optimizer`, 마이그레이션 안전성(락·백필·롤백)은 `migration-reviewer`
</details>

<details>
<summary><b>13. system-architect</b> (<code>/arch</code>) — 시스템 아키텍처 설계</summary>

- **언제**: 기능 구현 전 구조 설계, 기존 아키텍처 점검
- **설계**: 계층 분리, 모듈 경계·의존성, API 계약, 인증 구조, 비동기/작업(큐·워커), 캐싱, 폴더 구조, 확장성
- **LLM/AI 연동(v1.3)**: 스트리밍(SSE) 경로, RAG/벡터 스토어(MySQL 9 `VECTOR` vs 외부), LLM 호출 비동기·재시도·비용, MCP 등 도구 연동 경계
- **출력(설계)**: 요구사항/가정 → 옵션 비교(장단점) → 권장안(흐름도) → 단계 적용
- **출력(점검)**: 현황 진단 → 구조적 문제(영향도순) → 개선 설계 → 마이그레이션
</details>

### 🚀 운영 (DevOps)

<details>
<summary><b>14. devops-reviewer</b> (<code>/devops</code>) — Docker·CI/CD·배포 설정 점검</summary>

- **언제**: 머지·배포 전 인프라/파이프라인 설정 점검
- **점검**: Dockerfile(이미지 핀·멀티스테이지·비루트·HEALTHCHECK), 시크릿/환경변수(하드코딩·이미지 잔존·.env 커밋), docker-compose(포트 노출·헬스체크), CI/CD(액션 핀·권한·시크릿 노출·게이트), 배포 안전성(롤백·무중단), 빌드 재현성(락파일)
- **공급망·OIDC(v1.2)**: 장기 시크릿 대신 GitHub OIDC 키리스 인증, SBOM 생성, 이미지 서명·출처 증명(cosign/sigstore·provenance), digest 핀, 의존성 자동 업데이트
- **GHA 외 파이프라인(v1.3)**: Harness Open Source/Drone(`.harness/*.yaml`·`.drone.yml`, `kind: pipeline`)·GitLab CI·CircleCI도 같은 렌즈로 — 플러그인/스텝 이미지 핀, 시크릿 참조(`secrets.get`/`from_secret`) vs 하드코딩, `privileged`·docker.sock(DinD) 격리, 트리거/클론 범위
- **레지스트리·개발환경(v1.4)**: 아티팩트 레지스트리(Harness OSS·GHCR·ECR·Nexus) 불변 태그·업스트림 프록시·레지스트리단 스캔·풀/푸시 최소 권한; devcontainer/Gitspaces(`.devcontainer/devcontainer.json`) 베이스 이미지·`features` 핀·`postCreateCommand` 신뢰성·docker.sock/`privileged`·시크릿 하드코딩
- **관측성 수집 파이프라인(v1.6)**: OTel Collector·Grafana Alloy 등 수집기 설정(`config.alloy`·`*.river`·Collector `config.yaml`·Helm `values`)을 점검 — 익스포터 인증 시크릿 하드코딩 vs `sys.env`, 엔드포인트 TLS, 수집기 이미지 핀, batch/큐/리소스 limits, tail sampling 토폴로지(headless Service·`routing_key="traceID"`·spanmetrics 위치), 컴포넌트 `stabilityLevel` 게이팅. **앱 측 계측(SDK·스팬)은 `observability-reviewer`**, 여기선 수집기/파이프라인 설정만
- **전제**: 대상 레포에 Docker/CI 설정 파일이 있어야 의미가 있음 — 없으면 그 사실을 보고
- **출력**: 요약(안전 배포 가능 여부) → 위험 Top 3(안전한 대안) → 주의 → 제안
- **구분**: 코드 보안은 `security-reviewer`, 마이그레이션 안전성은 `migration-reviewer`, 구조 설계는 `system-architect`, 의존성 자체의 취약·버전·라이선스는 `dependency-auditor`, 앱 런타임 로깅·트레이싱은 `observability-reviewer`
</details>

<details>
<summary><b>15. dependency-auditor</b> (<code>/deps</code>) — 의존성 취약점·버전·라이선스 점검</summary>

- **언제**: 머지·배포 전 또는 정기 의존성 점검
- **점검**: 알려진 취약점(CVE, 직접/전이 경로), 버전 신선도·방치/deprecated, lockfile 무결성·드리프트(npm/pnpm/yarn·poetry·**uv.lock·PEP 751 pylock.toml**(v1.1)), 미사용·누락 의존성, dependencies/devDependencies 오분류, 라이선스 위험(GPL/AGPL·불명), 공급망 신호(타이포스쿼팅·postinstall·비공식 레지스트리·**lockfile 포이즈닝·provenance/Trusted Publishing·릴리스 숙성**(v1.1))
- **안전장치**: 매니페스트·lockfile 정적 분석이 기본. `npm audit`·`pip-audit` 등 읽기 전용 진단은 명시 요청 시만, 설치·업그레이드는 안 함
- **출력**: 요약(취약점 개수·lockfile 상태) → 위험 Top 3(패키지·현재/권장 버전·조치) → 주의 → 제안
- **구분**: 앱 코드 보안 취약점은 `security-reviewer`, CI/공급망(SBOM·서명) 설정은 `devops-reviewer`
</details>

<details>
<summary><b>16. observability-reviewer</b> (<code>/obs</code>) — 로깅·트레이싱·관측성 점검</summary>

- **언제**: "장애가 나도 추적이 안 된다", 운영 투입·머지 전 관측성 점검
- **가정**: 새벽 3시 장애 알림 — 로그·트레이스만으로 "어떤 요청이, 누가/무엇에서, 어디서, 왜 실패했는가"를 답할 수 있는가
- **점검**: 구조적 로깅(맥락·레벨·노이즈), 상관관계 ID(request/trace) 전파, 에러 캡처·리포팅(예외 삼킴·Sentry·4xx/5xx 구분), 메트릭, 분산 트레이싱(OpenTelemetry), 민감정보 로그 노출, 프론트 에러 바운더리·웹 바이탈
- **트레이싱 경계(v1.1)**: 컨텍스트 전파 포맷 일관성(W3C `traceparent`/`tracestate` vs B3)까지 본다. 점검 범위는 **앱 측 계측**까지 — 수집·샘플링 파이프라인(OTel Collector·Grafana Alloy의 익스포터·tail sampling·배치)은 `devops-reviewer` 영역으로 구분
- **출력**: 요약(장애 추적 가능성) → 위험 Top 3(민감정보 로그·예외 삼킴·추적 불가) → 주의 → 제안
- **구분**: 배포·인프라(로그·트레이스 수집·샘플링 파이프라인·대시보드: OTel Collector·Grafana Alloy 등) 설정은 `devops-reviewer`, 일반 예외 처리·코드 품질은 `code-reviewer`, 이미 발생한 장애의 원인 규명은 `debugger`(v1.3 — 이 에이전트는 추적 "가능성" 자체의 공백을 점검)
</details>

### 🧭 메타 / 워크플로우

<details>
<summary><b>17. ai-workspace-architect</b> (<code>/fable</code>) — AI 작업환경 진단·재설계</summary>

- **언제**: 프롬프트·지침·`CLAUDE.md`·`SKILL.md`·커스텀 인스트럭션·반복 업무 규칙을 상위 수준으로 재설계할 때
- **성격**: 다른 16종과 달리 특정 개발 스택이 아니라 **AI 작업환경 자체**를 다루는 메타 에이전트. 마케팅·콘텐츠 제작(릴스·카드뉴스·블로그·상세페이지·강의자료) 결과물 품질을 시스템화
- **범위**: 여러 모델(Claude/GPT/Gemini/Cursor)에서 일관되게 작동하는 범용 AI 운영체제 설계 — 바로 붙여넣을 커스텀 인스트럭션·CLAUDE.md·SKILL.md 초안 + 모델별 사용 전략
- **품질 엔진(모델 무관)**: 실행 모델과 무관하게 뼈대→초안→자가채점 루브릭(완성형·밀도·구체성·구조·근거·신뢰도)→재작성 절차를 강제. 도장찍기 금지(각 점수 근거 인용 + 진짜 약점 1개 이상 발굴·수정)
- **출력**: 총평 → 진단표 → 병목 5 → A.커스텀 인스트럭션 → B.CLAUDE.md → C.SKILL.md → D.모델별 전략 → 운영 규칙 → 자기비판 후 최종본
- **구분**: 개발 스택 아키텍처는 `system-architect`, 디자인 시스템은 `design-system-architect`, 이 라이브러리의 에이전트 정의(.md) 점검은 `agent-definition-reviewer`. 파일 직접 수정 없이 진단·초안만 제시
</details>

### 📣 콘텐츠 / 마케팅

<details>
<summary><b>18. copy-reviewer</b> (<code>/copy</code>) — 마케팅 카피 품질 리뷰</summary>

- **언제**: 릴스·카드뉴스·블로그·상세페이지·제안서·광고 문구를 발행하기 전 카피 점검
- **점검**: 후킹(첫 3초/첫 줄), 1메시지 집중, 독자 언어(vs 공급자 언어), 구체성(추상어·공허한 최상급), CTA 명확성·마찰, 신뢰도·윤리(근거 없는 보장·허위·다크패턴), 톤·문체 일관성, 포맷 적합(분량·구조). 변동 수치엔 `⚠️검증필요`
- **출력**: 요약(강점·핵심 문제) → Must fix / Should fix / Nit(위치·문제·근거·**리라이트 예시**)
- **구분**: 화면 레이아웃·시각·접근성은 `ui-ux-reviewer`, 전환 구조는 `landing-reviewer`, 검색 최적화는 `seo-optimizer`, 프롬프트·지침 시스템은 `ai-workspace-architect`
</details>

<details>
<summary><b>19. landing-reviewer</b> (<code>/landing</code>) — 상세페이지·랜딩 전환 리뷰</summary>

- **언제**: 판매·전환 페이지(상세페이지·랜딩)를 게시하기 전 전환 관점 점검
- **점검**: 히어로 가치 제안, 문제-공감-해결 흐름, 차별점의 benefit 번역, 사회적 증거, 반론 처리(FAQ·보증), CTA 전략(수·배치·마찰), 오퍼·가격 표현, 긴급성·희소성 윤리(다크패턴), 스캔 가능성·모바일 흐름
- **출력**: 요약 → 전환 저해 Top 3(위치·문제·왜 이탈·개선) → 주의·제안
- **구분**: 문장 카피 품질은 `copy-reviewer`, 시각·접근성은 `ui-ux-reviewer`, 검색 유입은 `seo-optimizer`
</details>

<details>
<summary><b>20. seo-optimizer</b> (<code>/seo</code>) — 블로그·페이지 SEO 점검</summary>

- **언제**: 블로그·랜딩을 발행하기 전 검색 최적화 점검
- **점검**: 검색 의도 매칭, 타이틀·메타, 헤딩 구조(H1 유일·계층), 키워드 배치·과최적화, 내부/외부 링크, 이미지 alt, 슬러그, 구조화 데이터(schema.org), E-E-A-T·스니펫, 카니발라이제이션. 키워드·SERP는 WebSearch로 확인(미확인은 "추정")
- **출력**: 요약(SEO 성숙도·타깃 키워드) → 개선 Top 3(위치·문제·근거·문안 예시) → 주의·제안
- **구분**: 설득·문장은 `copy-reviewer`, 전환 구조는 `landing-reviewer`, 렌더·번들 등 기술 성능(CWV)은 `perf-auditor`
</details>

<details>
<summary><b>21. fact-checker</b> (<code>/factcheck</code>) — 콘텐츠 사실·수치·출처 검증</summary>

- **언제**: 통계·수치·인용이 든 마케팅·블로그·강의자료·제안서를 발행하기 전
- **검증**: 검증 가능한 진술만 추출(의견·일반론 제외) → ✅확인 / ⚠️부분사실 / ❌틀림 / ❓출처없음 / 🔒검증불가로 판정 + 출처(발행처·URL·날짜). 통계·가격·날짜·연구 인용·비교 최상급("업계 1위")·법률/의료/금융 주장을 특히 주의. 미확인은 사실로 단정하지 않음
- **출력**: 요약(진술 수·위험 건수) → 위험 Top 3(진술·판정·출처·수정안) → 진술별 검증표
- **구분**: 문장 설득력·톤은 `copy-reviewer`, 검색 최적화는 `seo-optimizer`, 전환 구조는 `landing-reviewer`
</details>

<details>
<summary><b>22. content-repurposer</b> (<code>/repurpose</code>) — 1소스 → 멀티 포맷 재활용</summary>

- **언제**: 블로그·영상 스크립트·강의·뉴스레터 등 기존 자산을 릴스·카드뉴스·스레드·뉴스레터·상세페이지 섹션으로 재활용할 때
- **원칙**: 소스에서 핵심 추출 → 매체별 관행(릴스 훅3초·카드뉴스 1장1메시지·스레드 연쇄·뉴스레터 구조)에 맞춤. 포맷마다 다른 각도로(중복 파생 금지), 원본 수치·주장 왜곡·새 사실 창작 금지(변동 정보 `⚠️검증필요`)
- **출력**: 핵심 메시지 정리 → 포맷별 완성형 초안(+왜 이 각도로) → 재활용 맵(1소스→N파생)
- **구분**: 카피 품질은 `copy-reviewer`, 검색 최적화는 `seo-optimizer`, 사실 검증은 `fact-checker`
</details>

<details>
<summary><b>23. brand-voice-guardian</b> (<code>/voice</code>) — 브랜드 보이스 일관성 점검</summary>

- **언제**: 채널 톤을 일관되게 지키고 싶을 때, 여러 사람이 같은 채널 글을 쓸 때, 발행 전 보이스 점검
- **기준 소스**(이 순서): `voice.md` → `voice/examples/` 확정글 → 제공된 예시 추론(근거 명시) → 아무 기준도 없으면 보이스를 지어내지 않고 `/fable`로 `voice.md`부터 만들라고 안내
- **점검**: 문장 습관(길이·종결어미), 거리감·호칭, 어휘(자주 쓰는 표현·**금지 표현**), 시그니처, 톤 일관성(한 글 내 흔들림), 번역투·클리셰, 채널별 톤 변주 범위
- **출력**: 요약(기준 소스·부합도) → 벗어난 구간(위치·위반 기준·**원문→교정**) → 미세 조정·유지 → (기준 부재 시) 보이스 정의 보강 제안
- **구분**: 일반 카피 품질(후킹·CTA)은 `copy-reviewer`, 보이스 정의·시스템 설계는 `ai-workspace-architect`
</details>

### 🔒 품질 / QA — 보안 심화

> `security-reviewer`(`/sec`, 위 품질 카테고리)와 함께 보안 방어를 이룬다: 설계 단계(threat-modeler) → 코드 취약점(security-reviewer) → AI/LLM 특화(llm-ai-security-reviewer).

<details>
<summary><b>24. threat-modeler</b> (<code>/threat</code>) — 설계 단계 위협 모델링(STRIDE)</summary>

- **언제**: 새 기능·인증/결제/파일업로드/외부연동을 **구현하기 전** 또는 큰 변경 전
- **절차**: 자산 식별 → 진입점·공격 표면 → 신뢰 경계·데이터 흐름(텍스트 DFD) → STRIDE(스푸핑·변조·부인·정보노출·DoS·권한상승) per element → 악용 시나리오 → 위험 순위 → 완화책·보안 요구사항
- **출력**: 범위·가정 → 자산 → 진입점·신뢰 경계 → STRIDE 위협 표 → 악용 시나리오 Top → 보안 요구사항 체크리스트(구현·리뷰 시 확인용)
- **구분**: 이미 있는 코드의 취약점은 `security-reviewer`, AI/LLM 특화 위협은 `llm-ai-security-reviewer`, 시스템 구조 설계는 `system-architect`
</details>

<details>
<summary><b>25. llm-ai-security-reviewer</b> (<code>/aisec</code>) — AI/LLM 보안 심화(OWASP LLM Top 10)</summary>

- **언제**: 앱이 LLM/AI 기능(챗봇·RAG·에이전트·툴 호출·파인튜닝)을 포함하고, 머지 전 AI 보안을 깊게 볼 때
- **점검**(OWASP LLM Top 10 2025): 프롬프트 인젝션(직접·**간접**: RAG·문서·외부페이지), 부적절한 출력 처리(SQL/명령/HTML/툴 전파), 과도한 행위성(도구 권한·human-in-the-loop), 민감정보·시스템 프롬프트 유출, 벡터/RAG 포이즈닝·멀티테넌시, 모델·데이터 공급망, 무제한 소비(Denial of Wallet), 가드레일·평가/레드팀
- **출력**: 심각도별(LLMxx 표기) 발견 → 즉시 고칠 Top 3
- **구분**: 웹 앱 일반 보안(인증·인젝션·XSS·IDOR)은 `security-reviewer`, 배포·시크릿·모델 서빙 인프라는 `devops-reviewer`, 설계 단계 위협은 `threat-modeler`
</details>

### 🎮 게임 (Unity + C#)

> 웹 스택과 별개인 **게임 개발 도메인**의 시작점(싱글플레이어 2D 캐주얼). 색상은 8색 소진으로 `cyan`(문서 카테고리)을 공유하되 문서에서 게임 클러스터로 묶는다. 로드맵: game-feel-reviewer·unity-perf-auditor·playtest-designer·unity-build-auditor(같은 필요 3회 반복 시 승격).

<details>
<summary><b>26. unity-code-reviewer</b> (<code>/ureview</code>) — Unity C# 게임 코드 리뷰</summary>

- **언제**: Unity + C# 코드를 커밋·머지하기 직전 셀프 리뷰 (2D 캐주얼 — 퍼즐/플랫포머)
- **범위 결정**: `git diff`로 변경분의 `Assets/` 하위 `.cs`에 집중 (Bash는 범위 식별 전용, 실행·수정 금지)
- **점검(게임 엔진 고유)**: ① MonoBehaviour 수명주기(Awake/OnEnable/Start 혼동, OnDisable 구독 해제 누락), ② 프레임 루프 비용(Update 내 GetComponent/Find/Camera.main), ③ GC 할당(매 프레임 new·박싱·문자열·LINQ·풀링 부재), ④ 코루틴/async 취소 누수, ⑤ 물리·프레임률 의존(Time.deltaTime·FixedUpdate·Rigidbody2D), ⑥ fake-null(파괴된 오브젝트 참조·`?.` 우회), ⑦ ScriptableObject 런타임 원본 오염
- **원칙**: 성능·GC는 정적 리뷰로 의심 지점만 짚고 실제 수치는 **Profiler 측정 권고**로 분리(단정 금지)
- **출력**: 요약 → Must fix → Should fix → Nit → 측정 권고 (분류 내 영향도순, `파일:줄`), 가장 먼저 고칠 Top 3
- **구분**: 일반 웹 코드 리뷰는 `code-reviewer`, 게임 설계·코어 루프·시스템 분해는 `game-design-architect`, 이미 발생한 런타임 오동작·크래시의 원인 규명은 `debugger`(v1.2 — 이 에이전트는 증상 없는 정적 리뷰)
</details>

<details>
<summary><b>27. game-design-architect</b> (<code>/gdd</code>) — 2D 캐주얼 게임 디자인·시스템 설계</summary>

- **언제**: 새 게임·메카닉·레벨 시스템을 구현하기 전 설계, 기존 설계 점검
- **설계**: 코어 게임플레이 루프(핵심 동사·재미 가설), 난이도 곡선·페이싱·진행(메카닉 도입→연습→응용→조합), 시스템 분해(GameManager 상태머신·이벤트 흐름·씬 구성·세이브), ScriptableObject 데이터 경계, 게임필 피드백 계획
- **원칙**: 솔로 개발 최대 리스크는 "미완성" — 모든 야심 기능에 **컷 후보** 강제, 재미부터(수직 슬라이스) 콘텐츠는 나중. 재미는 단정하지 않고 "가설 + 플레이테스트로 검증할 질문"으로
- **출력(설계)**: 요구/가정 → 코어 루프·재미 가설 → 시스템 분해 → 진행·난이도 → 수직 슬라이스·컷 라인 → 플레이테스트 검증 질문. (점검): 진단 → 문제 → 개선 설계 → 범위 재조정
- **구분**: Unity C# 코드 품질·프레임 리뷰는 `unity-code-reviewer`, 풀스택 웹 아키텍처는 `system-architect`
</details>

<details>
<summary><b>28. game-ui-reviewer</b> (<code>/gui</code>) — 게임 UI/UX 점검</summary>

- **언제**: UI 씬·프리팹·UI 스크립트를 커밋하기 직전 (2D 캐주얼, 모바일 우선)
- **점검**: HUD·메뉴 레이아웃/정보 위계, CanvasScaler 해상도·종횡비 스케일링(Scale With Screen Size·reference resolution·match), 세이프 에어리어(노치), 캔버스 렌더 모드, 게임패드·터치 내비게이션·포커스(EventSystem·explicit navigation), 움직이는 화면 위 텍스트 가독성·색약/명도 대비, UI 상태(로딩/빈/에러/전환), 온보딩 UI, (수익화 시) F2P 다크패턴
- **원칙**: YAML 설정·코드로 확정 가능한 것만 심각도 부여, 실제 보임새는 **기기 확인 권고**로 분리(화면을 못 봄)
- **출력**: 요약 → Must/Should/Nit → 기기 확인 권고 → 위임, 가장 먼저 고칠 Top 3
- **구분(경계)**: UI 조작 피드백은 이 에이전트, 게임플레이 동작 피드백은 `game-feel-reviewer`. 코어 루프·난이도는 `game-design-architect`, 코드·프레임은 `unity-code-reviewer`, 웹 화면·WCAG 폼·i18n은 `ui-ux-reviewer`
</details>

<details>
<summary><b>29. game-feel-reviewer</b> (<code>/feel</code>) — 게임플레이 손맛/juice 점검</summary>

- **언제**: 조작이 뻣뻣·타격감 없다고 느낄 때, 플레이어 컨트롤러·카메라·이펙트 코드 커밋 직전
- **점검**: 입력 응답 관대성(코요테 타임·점프 버퍼·입력 버퍼링·가변 점프), 히트스톱/타임프리즈, 화면 흔들림·카메라 추적/룩어헤드, 스쿼시&스트레치·파티클·플래시, 사운드/햅틱 타이밍, 가감속 커브, 페이싱·리듬
- **원칙**: 장치의 유무·구조는 확정 보고, 손맛 체감·세부 튜닝값은 **프로토타입 검증 항목**으로 분리(정적 단정 금지)
- **출력**: 요약 → Must/Should/Nit → 핵심 동사 × 피드백 채널 매트릭스 → 프로토타입 검증 항목 → 위임, Top 3
- **구분(경계)**: 게임플레이 동작 피드백(HUD 표시 포함)은 이 에이전트, UI 조작·위젯 배치는 `game-ui-reviewer`. 재미 가설·난이도는 `game-design-architect`, 코드·GC는 `unity-code-reviewer`
</details>

<details>
<summary><b>30. unity-perf-auditor</b> (<code>/uperf</code>) — Unity 런타임 성능·렌더링 점검</summary>

- **언제**: "프레임이 떨어진다"·"기기가 뜨겁다", Profiler 캡처를 들고 왔을 때, 릴리스 전 성능 패스
- **점검**: 드로우콜·배칭(SpriteAtlas·머티리얼/소팅), 오버드로우·필레이트(모바일 2D GPU 병목), 텍스처 압축(ASTC/ETC2)·`.meta` 임포트·텍스처/오디오 메모리, Fixed Timestep·2D 충돌 비용, 퀄리티/프로젝트 설정, Profiler/Frame Debugger 캡처 수치 해석
- **원칙**: 정적 리뷰로 "느리다" 단정 금지 — 설정 존재/부재는 확정, 실제 비용은 **측정 계획**으로 분리(수치 제공 시 수치가 근거)
- **출력**: 요약 → Must/Should/Nit → 측정 계획 → 캡처 해석 → 위임, Top 3
- **구분(경계)**: GC 유발 코드 원인은 `unity-code-reviewer`(증상·측정 해석이 이 에이전트), 빌드 용량은 `unity-build-auditor`, 웹 성능은 `perf-auditor`, 카메라 지터의 손맛은 `game-feel-reviewer`
</details>

<details>
<summary><b>31. playtest-designer</b> (<code>/playtest</code>) — 플레이테스트 프로토콜 설계</summary>

- **언제**: 검증 질문 목록이 생겼거나 빌드를 외부인에게 처음 보여주기 직전 (수직 슬라이스/프로토타입)
- **설계**: 검증 질문→행동 지표→판정 기준, 참가자·회차(타깃·신선한 눈 배분), 세션 프로토콜(콜드 스타트·진행자 스크립트·개입 규칙), 관찰 지표(FTUE·막힘·이탈·재시도·리텐션 프록시), 설문(유도 질문 배제), 텔레메트리 이벤트, 결과 해석·우선순위화
- **원칙**: 재미의 판정자는 데이터 — 관찰이 진술을 이긴다, 소규모 n을 백분율로 포장 안 함, 테스트를 직접 실행 안 함(설계만)
- **출력**: 검증 가설 표 → 참가자·회차 계획 → 세션 프로토콜 → 관찰 시트 → 설문 문항 → 텔레메트리 목록 → 결과 해석 가이드
- **구분(경계)**: "무엇을 검증할지"(코어 루프·재미 가설)는 `game-design-architect`, 손맛 장치는 `game-feel-reviewer`(이 에이전트는 "어떻게 검증할지"). 소프트웨어 자동 테스트는 `test-strategy`/`test-runner`
</details>

<details>
<summary><b>32. unity-build-auditor</b> (<code>/ubuild</code>) — 빌드/릴리스·스토어 제출 점검</summary>

- **언제**: 스토어 제출·릴리스 빌드 직전, ProjectSettings·빌드 구성 변경 시
- **점검**: Player Settings(번들 ID·버전·IL2CPP/ARM64·managed stripping), 빌드 크기(Resources 남용·압축 용량·AAB), 빌드 씬 목록, 매니페스트 권한, 스토어 요건(64bit·개인정보·데이터 안전), 서명/keystore 커밋 여부, development build 플래그 잔존, Addressables 구성
- **원칙**: 파일 판정(설정·씬·keystore·플래그)은 확정, **스토어 정책 수치는 변동이 커서 단정 금지** → 확인 목록(⚠️)으로 분리(웹 검색 도구 없음)
- **출력**: 요약 → 제출 차단·보안 Must → Should → Nit → 스토어 정책 확인 목록 → 위임, Top 3
- **구분(경계)**: 일반 CI/CD·시크릿 보관·파이프라인은 `devops-reviewer`(이 에이전트는 keystore "커밋·존재 판정"까지), 코드는 `unity-code-reviewer`, 런타임 성능은 `unity-perf-auditor`
</details>

### 🧠 인프라 (개인 메모리)

> 웹·게임·콘텐츠 리뷰와 별개로, **사용자 개인의 파일 기반 장기기억**(`E:\claude_memory\`)을 값싼 모델로 대신 읽는 인프라 에이전트. 저장소의 첫 `haiku` 에이전트다. 메모리 회상 훅(세션 시작·"예전에 뭐라고 정했더라")으로 자동 호출되며, `/recall`로 수동 호출도 된다.

<details>
<summary><b>33. memory-recaller</b> (<code>/recall</code>) — 파일 기반 장기기억 회상</summary>

- **언제**: "예전에 뭐라고 정했더라", "그 프로젝트 메모리 찾아줘", 세션 시작 시 관련 컨텍스트 회상. 수동 회상은 `/recall <주제>`
- **성격**: 리뷰/설계가 아니라 사용자 개인 메모리 저장소를 대신 읽는 인프라. 무거운 모델(Opus/Fable)이 인덱스를 통째로 읽는 토큰 낭비를 없애려 값싼 `haiku`로 회상만 수행
- **회상 절차(폴백 3단)**: 인덱스 진입점 탐색 — ① `YYYYMMDD_MEMORY.md` 최신 날짜 → ② 날짜형이 없으면 `*MEMORY*`·`*INDEX*` 등 다른 이름 인덱스 폴백(토픽 파일 오인 금지) → ③ 그래도 없으면 `Grep` 전체 검색. 최신→과거 순 회상, 관련 토픽 파일 확인, `20260624_MEMORY.md`가 하한
- **출력**: `- <사실 한 줄> (출처: <파일명>)` 형식으로 관련 사실만 압축(원문 붙여넣기 금지). 없으면 "관련 메모리 없음"으로 정직 보고, 날짜·수치·결정은 보존
- **원칙**: 읽기 전용 — 메모리를 쓰거나 고치지 않음(저장·수정은 메인 세션이 담당)
</details>

### 🛠 엔지니어링 / 문서 / 메타 (1.60 추가)

<details>
<summary><b>34. refactor-strategist</b> (<code>/refactor</code>) — 동작 보존 리팩터 계획·단계 설계 (품질)</summary>

- **언제**: "이거 정리하고 싶다", 큰 변경 전 구조 정돈 (기능 변경 없이 구조만)
- **진단**: 책임 분리(과대 함수·God object), 중복·네이밍·매직 넘버, 의존 구조(순환·잘못된 방향), 데드코드·미사용, 변경 seam(특성화 테스트 경계)
- **원칙**: 동작 보존 최우선(관찰 가능한 동작 불변), 작고 되돌릴 수 있는 단계(추출→이동→개명→정리)로 쪼개고 각 단계 검증 지점 명시, 동작 바뀌는 개선(버그·기능)은 리팩터와 분리
- **출력**: 요약 → 리팩터 후보(영향도순·`파일:줄`·목표 구조·왜 안전한가) → 이행 단계(+검증 지점) → 분리 항목 → Top 3
- **구분**: 버그·정확성 리뷰는 `code-reviewer`, 신규 아키텍처 설계는 `system-architect`, 커버리지 보강은 `test-strategy`
</details>

<details>
<summary><b>35. docs-writer</b> (<code>/docs</code>) — 개발자용 기술문서 작성·정비 (문서)</summary>

- **언제**: README·아키텍처 개요·온보딩·CONTRIBUTING·ADR을 코드·구조에서 추출해 정리
- **원칙**: 코드가 진실원천(확인한 것만, 미확인은 `확인 필요`), 독자별 깊이·용어 조정, 문서 종류별 관행(README/아키텍처/온보딩/CONTRIBUTING/ADR), 드리프트 방지(바뀌어도 유효한 구조·의도 우선)
- **출력**: 문서 계획 → 완성형 문서 초안(마크다운) → 확인 필요 목록
- **구분**: FastAPI 엔드포인트 카탈로그는 `api-doc-writer`, 디자인 시스템 문서(DESIGN.md)는 `design-system-architect`, 마케팅·강의 콘텐츠는 `content-repurposer`·`copy-reviewer`
</details>

<details>
<summary><b>36. agent-definition-reviewer</b> (<code>/agentdef</code>) — 서브에이전트 정의(.md) 점검 (메타)</summary>

- **언제**: 새 에이전트를 추가하거나 기존 정의를 개정하기 전 (이 라이브러리 자체를 점검)
- **점검**: frontmatter 스펙 정합(name/description/tools/model/effort 티어), description 라우팅 친화성(트리거·위임 절), tools 최소권한(과대·과소), 경계 중복·공백, 본문 규범 누락(인젝션 방어·읽기전용·증거 기반 보고), 배포 정합(hooks·memory·skills 조합·sync allowlist)
- **출력**: 요약 → [P1/P2/P3] 발견(`파일:줄`·근거·권장) → 경계 지도 → 개정 초안 → Top 3
- **구분**: 사용자의 범용 AI 작업환경·마케팅 프롬프트 시스템 설계는 `ai-workspace-architect`(이 에이전트는 이 라이브러리 내부 정의만), 개발 코드 품질은 `code-reviewer`
</details>

### ✍️ 창작 (스토리텔링)

> 개발 스택·마케팅 리뷰와 별개로, **프롬프트(뼈대)에 살을 붙여 이야기를 새로 짓는** 생성 에이전트. 저장소의 첫 `fable`(창작 특화 모델) 에이전트다. 기존 자산을 매체별로 각색하는 `content-repurposer`(재활용)와 달리 **없던 서사를 창작**한다.

<details>
<summary><b>37. storyteller</b> (<code>/story</code>) — 프롬프트에 살 붙여 완성형 이야기 작성 (창작)</summary>

- **언제**: 한 줄 아이디어·설정·인물·장르만 있고 완성형 이야기(단편·서사·시나리오·브랜드 스토리·에피소드)가 필요할 때. 수동 호출은 `/story <아이디어>`
- **모델**: 창작 특화 `fable`(+`effort: high`). 미가용 시 최강 모델로 폴백하되, 품질은 내장 작법 절차가 보장
- **작법(뼈대→살)**: ① 뼈대 확정(로그라인·인물 욕망/결핍·갈등·판돈·구조) → ② 살(show-don't-tell·감각 디테일·서브텍스트 대사·시점 일관성·페이싱) → ③ 자가 점검(전제 관통·동기 가시성·상투구·시점 흔들림) 후 약한 구간 재작성
- **원칙**: 표절 금지(오마주/패러디 한정), 사용자가 준 핵심 설정·결말 방향 보존(바꾸려면 대안 제안), 채운 가정 명시. 유해 실행 지침·미성년 성적 묘사·실존 인물 명예훼손은 거부
- **출력**: 로그라인 → 뼈대 요약 → 이야기 본문(제목) → 채운 가정 & 확장 포인트(더 길게/다른 결말/속편)
- **구분**: 기존 자산을 매체별로 파생하는 것은 `content-repurposer`, 카피 품질은 `copy-reviewer`, 확정 보이스 준수는 `brand-voice-guardian`, 프롬프트·지침 시스템 설계는 `ai-workspace-architect`
</details>

### 🐞 디버깅 (품질 · 1.64 추가)

> 기존 품질 에이전트가 모두 **증상이 없는 상태에서** 코드를 훑는 정적 리뷰(code-reviewer·unity-code-reviewer)이거나 **결과를 집계**하는 실행기(test-runner)인 반면, 이 에이전트는 **이미 나타난 증상에서 거꾸로** 원인을 추적한다(재현 → 가설 → 검증 → 이분 탐색). 스택 무관 — 웹(Next.js/FastAPI/MySQL)이 주력이지만 Unity C# 런타임 증상도 같은 절차로 다룬다.

<details>
<summary><b>38. debugger</b> (<code>/debug</code>) — 버그·에러·간헐 실패 근본 원인 규명</summary>

- **언제**: "왜 이 에러가 나는지 모르겠다", "가끔만 실패한다", "어제까진 됐는데", 프로덕션 장애 사후 분석. 수동 호출은 `/debug <증상>`
- **절차**: 증상 확정(기대 vs 실제·재현율·환경) → 최소 재현 → 관찰 수집(스택트레이스는 *우리 코드의 가장 깊은 프레임*부터) → 가설 3~5개(각각 반증 조건 명시) → 검증·축소(코드 경로·시간(`git log`/`blame` 회귀 시점)·입력·환경 이분) → 원인 확정 → 수정 방향·재발 방지
- **버그 클래스 렌즈**: 간헐·플레이키(경쟁 조건·순서 의존·시간/타임존), 상태·데이터(경계·부분 실패·트랜잭션), 경계 넘김(계약·직렬화·캐시 stale·하이드레이션), 동시성·자원(블로킹 I/O·풀 고갈·누수), 환경차("로컬은 되는데"), Unity 런타임(fake-null·구독 해제·프레임률 의존)
- **원칙**: 관찰이 추측을 이긴다(각 주장에 `파일:줄`·로그 근거), 첫 가설에 애착 금지, 한 번에 하나만 바꾼다, **못 밝히면 미확정으로 정직 보고**(그럴듯한 범인 창작 금지)
- **성능 축 카빙**: "무엇이 느린가"(병목 진단·측정 해석)는 `perf-auditor`·`db-optimizer`·`unity-perf-auditor`, **"언제부터·무엇이 바뀌어 느려졌나"(회귀 시점 추적)는 이 에이전트** — 성능 회귀가 무주공산이 되지 않게 축으로 나눔
- **안전장치**: 코드·데이터 수정 안 함. 워킹트리를 바꾸는 `git bisect`·`checkout`·`stash`는 **직접 실행하지 않고 절차만 제시**. Bash는 재현·조회 전용(테스트 재실행·로그·git 이력). 계측이 필요하면 코드에 심지 않고 **임시 계측 계획**만 제시
- **출력**: 증상 요약 → 관찰된 사실(해석과 분리) → 가설·검증 표(판정: 확정/반증/미검증) → 근본 원인(인과 사슬·`파일:줄`) → 수정 방향(+형제 결함) → 재발 방지 테스트 → 미해결·다음 관찰
- **구분(경계)**: 테스트 실행·집계·1차 분류는 `test-runner`(테스트를 아직 안 돌렸으면 거기부터 — 안 풀리는 실패가 이 에이전트 몫), 증상 없는 정적 리뷰는 `code-reviewer`·`unity-code-reviewer`, 추적 인프라 공백은 `observability-reviewer`, 병목 진단은 `perf-auditor`·`db-optimizer`·`unity-perf-auditor`, 취약점은 `security-reviewer`
</details>

### 역할이 겹치기 쉬운 쌍 (양방향 위임)

양쪽 description이 서로를 가리키는 대칭 위임(`↔`) — 어느 쪽으로 호출해도 인접 영역으로 안내된다. 아래는 1.56의 전수 스캔 34쌍에 **1.64에서 `debugger` 4쌍을 더한 38쌍**이며 클러스터별로 나눈다.

**웹 스택 (20쌍)**
| 쌍 | 구분 |
|---|---|
| code-reviewer ↔ security-reviewer | 일반 품질/버그 ↔ 보안 전용 |
| code-reviewer(프론트) ↔ ui-ux-reviewer | 로직·타입·구조 ↔ 시각·사용성·접근성 |
| code-reviewer ↔ api-contract-reviewer | 한쪽 "코드 품질·버그" ↔ 양쪽 "계약 일치" |
| code-reviewer ↔ observability-reviewer | 일반 "예외 처리·코드 품질" ↔ 관측성 "공백"(로깅·추적) |
| db-optimizer ↔ data-modeler | 기존 쿼리·인덱스 "튜닝" ↔ 테이블·관계 "설계" |
| migration-reviewer ↔ data-modeler | 스키마 변경 "적용 안전성" ↔ 스키마 "설계" |
| migration-reviewer ↔ db-optimizer | 마이그레이션 "락·롤백·배포 안전" ↔ 런타임 쿼리 "성능" |
| perf-auditor ↔ db-optimizer | 프론트 "성능"(번들·렌더) ↔ MySQL 쿼리·인덱스 "성능" |
| perf-auditor ↔ ui-ux-reviewer | 로드·렌더 "성능"(번들·CWV) ↔ 시각·사용성·접근성 |
| ui-ux-reviewer ↔ design-system-architect | 개별 화면 "점검" ↔ 토큰·컴포넌트 "시스템 설계" |
| dependency-auditor ↔ security-reviewer | 의존성 자체 "취약·버전·라이선스" ↔ 앱 "코드 보안 취약점" |
| dependency-auditor ↔ devops-reviewer | 의존성 "건강성"(매니페스트·lockfile) ↔ CI/공급망 "설정"(SBOM·서명) |
| devops-reviewer ↔ security-reviewer | 배포/파이프라인 설정 "운영 보안" ↔ 애플리케이션 "코드 보안" |
| devops-reviewer ↔ observability-reviewer | 로그 수집·대시보드 "인프라 설정" ↔ 앱 런타임 "로깅·트레이싱·계측" |
| devops-reviewer ↔ system-architect | 배포·인프라 설정 "점검" ↔ 시스템 구조 "설계" ⟵ 1.56에서 일방향→대칭 정정 |
| api-contract-reviewer ↔ api-doc-writer | 프론트-백 계약 "정합성 검증" ↔ 백엔드 엔드포인트 "카탈로그·문서화" |
| test-strategy ↔ test-runner | 커버리지 공백·약한 테스트 "진단·설계" ↔ 테스트 "실행·실패 분석" |
| debugger ↔ test-runner | 실패의 "근본 원인 규명"(재현·가설·이분) ↔ 테스트 "실행·집계·1차 분류" ⟵ 1.64 |
| debugger ↔ code-reviewer | 이미 난 증상에서 "역추적" ↔ 증상 없이 변경분에서 "잠재 결함" 정적 리뷰 ⟵ 1.64 |
| debugger ↔ observability-reviewer | 지금 있는 로그로 "원인 규명" ↔ 추적 "가능성" 자체의 공백 점검 ⟵ 1.64 |

**콘텐츠 / 마케팅 (3쌍)**
| 쌍 | 구분 |
|---|---|
| copy-reviewer ↔ landing-reviewer | 문장 카피 품질 ↔ 상세페이지·랜딩 전환 구조 |
| copy-reviewer ↔ seo-optimizer | 설득·문장 품질 ↔ 검색 최적화 |
| landing-reviewer ↔ seo-optimizer | 전환 구조 ↔ 검색 유입 |

**보안 (3쌍)**
| 쌍 | 구분 |
|---|---|
| security-reviewer ↔ threat-modeler | 코드 취약점(구현 후) ↔ 설계 단계 위협 모델링 |
| security-reviewer ↔ llm-ai-security-reviewer | 웹 앱 일반 보안 ↔ AI/LLM 특화 심화 |
| threat-modeler ↔ llm-ai-security-reviewer | 설계 단계 위협(LLM 포함) ↔ 구현 후 AI/LLM 심화 |

**게임 (Unity + C#, 6쌍)**
| 쌍 | 구분 |
|---|---|
| game-design-architect ↔ unity-code-reviewer | 코어 루프·시스템 "설계" ↔ C# 코드 품질·프레임 "리뷰" |
| game-design-architect ↔ playtest-designer | "무엇을 검증할지"(재미 가설) ↔ "어떻게 검증할지"(프로토콜) |
| game-feel-reviewer ↔ game-ui-reviewer | 게임플레이 동작 피드백 ↔ UI 조작 피드백 |
| game-feel-reviewer ↔ playtest-designer | 손맛 장치·프로토타입 검증 항목 ↔ 검증 프로토콜 |
| unity-code-reviewer ↔ unity-perf-auditor | GC 유발 코드 "원인" ↔ 프레임 예산 "증상·측정 해석" |
| unity-build-auditor ↔ unity-perf-auditor | 텍스처 압축 "빌드 용량" ↔ "런타임 메모리·GPU" |

**클러스터 교차 (게임 ↔ 웹, 6쌍)** — 1.52에서 양방향화
| 쌍 | 구분 |
|---|---|
| code-reviewer ↔ unity-code-reviewer | 웹(Next.js/FastAPI) 코드 ↔ Unity C# 게임 코드 |
| debugger ↔ unity-code-reviewer | 이미 난 런타임 오동작·크래시 "원인 규명"(스택 무관) ↔ 엔진 특유 코드 결함 "정적 리뷰" ⟵ 1.64 |
| perf-auditor ↔ unity-perf-auditor | 웹 프론트 성능(번들·CWV) ↔ Unity 런타임 성능·렌더링 |
| system-architect ↔ game-design-architect | 풀스택 웹 아키텍처 ↔ 2D 캐주얼 게임 디자인·시스템 |
| devops-reviewer ↔ unity-build-auditor | 일반 CI/CD·시크릿·파이프라인 ↔ Unity 빌드/릴리스·스토어 제출 |
| test-strategy ↔ playtest-designer | 소프트웨어 자동 테스트 ↔ 사람 대상 플레이테스트 |

### 일방향 위임 포인터

특화 에이전트가 **허브/일반/상위 에이전트로만** 안내하는 단방향(`→`). 역방향을 두지 않는 이유: 허브 에이전트(code-reviewer 등)가 받는 모든 특화를 역으로 나열하면 description이 비대해진다. 아래는 **의도적 단방향의 대표 예시**이며 전수 목록은 아니다 — 허브로 들어오는 inbound 포인터는 이 외에도 여럿(예: system-architect가 받는 5건, code-reviewer가 받는 다수).

| 위임 | 성격 | 역방향이 없는 이유 |
|---|---|---|
| test-strategy → code-reviewer | 특화 → 일반 폴백 | `code-reviewer`는 일반 폴백이라 개별 특화로 되돌리지 않음 |
| perf-auditor → code-reviewer | 특화 → 일반 폴백 | 동일(일반 품질·버그 폴백) |
| devops-reviewer → migration-reviewer | 운영 → DB 도메인 | 마이그레이션 리뷰는 DB 영역에 집중 |
| system-architect → api-contract-reviewer / data-modeler / security-reviewer | 최상위 설계 → 특화 검증 | 설계가 구현 후 검증을 특화로 넘김(특화는 설계를 역참조 안 함) |
| ai-workspace-architect → system-architect / design-system-architect | 메타 → 도메인 설계 | 메타가 스택 설계를 넘길 뿐, 설계 에이전트는 메타를 역참조 안 함 |
| copy-reviewer → ai-workspace-architect | 콘텐츠 → 메타 | 보이스·프롬프트 시스템 설계로 넘기는 상향 포인터 |
| content-repurposer → copy-reviewer / seo-optimizer / fact-checker | 생성 → 점검 3종 | 재활용 초안을 각 점검 에이전트로(점검 측은 생성기를 역참조 안 함) |
| storyteller → content-repurposer / copy-reviewer / brand-voice-guardian | 창작 생성 → 재활용·점검 | 새로 지은 이야기를 매체 파생·카피·보이스로(점검·재활용 측은 창작 생성기를 역참조 안 함) |
| fact-checker → copy-reviewer / seo-optimizer / landing-reviewer | 검증 → 콘텐츠 점검 | 사실 검증 후 문장·전환·검색은 각 특화로 |
| brand-voice-guardian → copy-reviewer / ai-workspace-architect | 보이스 → 카피·메타 | 일반 카피는 copy, 보이스 정의·시스템은 메타로 |
| threat-modeler → system-architect | 보안 설계 → 구조 설계 | 위협 모델이 구조 설계로 넘김 |
| llm-ai-security-reviewer → devops-reviewer | AI 보안 → 인프라 | 모델 서빙·시크릿 인프라를 devops로 |
| game-ui-reviewer → ui-ux-reviewer | 게임 UI → 웹 UI | 웹 화면·WCAG·i18n은 웹 UI로(웹 UI는 게임을 역참조 안 함) |
| unity-build-auditor → unity-code-reviewer | 빌드 → 코드 | keystore·설정 판정 후 코드 품질은 코드 리뷰로 |
| playtest-designer → test-runner | 플레이테스트 → 자동 테스트 | 사람 테스트와 별개인 자동 테스트 러너로 |
| debugger → perf-auditor / db-optimizer / unity-perf-auditor / security-reviewer | 회귀 시점 추적 → 병목 진단·보안 특화 | "무엇이 느린가"(병목)는 성능 3종, "취약점"이면 보안으로. **"언제부터 느려졌나"(회귀 시점)는 debugger가 유지** — 성능·보안 측은 디버깅을 역참조 안 함 |

> **정정(1.56)**: 이전 문서는 `system-architect`를 "다른 에이전트로 내보내는 위임이 없는 최상위 설계 에이전트"라 기술하고 `devops-reviewer → system-architect`를 일방향으로 분류했다. 그러나 현재 `system-architect` description은 5개 특화(api-contract-reviewer·data-modeler·devops-reviewer·security-reviewer·game-design-architect)로 위임을 **내보낸다**(1.52의 game-design-architect 추가가 결정타). 따라서 devops ↔ system-architect는 **대칭**(위 웹 표)으로 이동했고, system-architect도 위임을 내보내는 에이전트다.

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
저장소의 38개 에이전트 `.md`를 전역 폴더로 복사합니다. 동봉된 스크립트를 쓰면 편합니다.
```powershell
powershell -ExecutionPolicy Bypass -File sync.ps1
```
> `sync.ps1`은 38개 에이전트 파일을 `%USERPROFILE%\.claude\agents\`로, `commands/`의 38개 슬래시 명령 파일을 `%USERPROFILE%\.claude\commands\`로, `launchers/`의 런처를 `%USERPROFILE%\.claude\launchers\`로 복사합니다. 에이전트는 frontmatter `name:`이 있는 `.md`만 배포(문서는 자동 스킵)하고, 이 저장소가 이전에 배포한 에이전트가 지워지거나 이름이 바뀌면 런타임에서도 제거합니다(manifest 기반 delete-sync — 사용자 개인 에이전트는 건드리지 않음). 복사/삭제 중 오류가 나면 종료 코드 1로 알립니다.

슬래시 명령(`/review` 등)도 위 `sync.ps1` 실행으로 함께 등록됩니다(별도 복사 불필요).

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
| `/coverage` | test-strategy | 경로/모듈(선택) |
| `/perf` | perf-auditor | 경로/컴포넌트(선택) |
| `/contract` | api-contract-reviewer | 엔드포인트/경로(선택) |
| `/apidoc` | api-doc-writer | 경로 |
| `/db` | db-optimizer | 경로/쿼리 |
| `/migrate` | migration-reviewer | 마이그레이션 경로(선택) |
| `/ui` | ui-ux-reviewer | 경로 |
| `/dsystem` | design-system-architect | 경로 |
| `/datamodel` | data-modeler | 요구사항/경로 |
| `/arch` | system-architect | 기능 설명/경로 |
| `/devops` | devops-reviewer | 파일/경로(선택) |
| `/deps` | dependency-auditor | 매니페스트/경로(선택) |
| `/obs` | observability-reviewer | 기능/경로(선택) |
| `/fable` | ai-workspace-architect | 진단 대상/맥락(선택) |
| `/copy` | copy-reviewer | 파일/경로(선택) |
| `/landing` | landing-reviewer | 파일/경로(선택) |
| `/seo` | seo-optimizer | 파일/경로 또는 키워드(선택) |
| `/factcheck` | fact-checker | 파일/경로(선택) |
| `/repurpose` | content-repurposer | 소스 파일 + 목표 포맷(선택) |
| `/voice` | brand-voice-guardian | 파일/경로(선택) |
| `/threat` | threat-modeler | 기능 설명/경로 |
| `/aisec` | llm-ai-security-reviewer | 파일/경로(선택) |
| `/ureview` | unity-code-reviewer | 경로/스크립트(선택) |
| `/gdd` | game-design-architect | 게임·메카닉 설명(선택) |
| `/gui` | game-ui-reviewer | 씬/프리팹/UI 스크립트(선택) |
| `/feel` | game-feel-reviewer | 컨트롤러/카메라/이펙트(선택) |
| `/uperf` | unity-perf-auditor | 경로·설정 또는 Profiler 캡처(선택) |
| `/playtest` | playtest-designer | 검증 질문·빌드 범위(선택) |
| `/ubuild` | unity-build-auditor | ProjectSettings·플랫폼(선택) |
| `/recall` | memory-recaller | 회상할 주제/질문(선택) |
| `/refactor` | refactor-strategist | 경로/대상(선택) |
| `/docs` | docs-writer | 문서 종류/대상(선택) |
| `/agentdef` | agent-definition-reviewer | 에이전트 파일/이름(선택) |
| `/story` | storyteller | 한 줄 아이디어/설정 + 장르·분량(선택) |
| `/debug` | debugger | 증상/에러 메시지/재현 절차 |

### 한글 별칭 (1.65)

Claude Code는 슬래시 명령 이름에 **한글(비ASCII)을 허용한다**(1.65에서 `/디버그`로 검증). 자주 쓰는 20종에 한글 별칭 커맨드를 함께 배포한다 — 에이전트는 그대로고 커맨드 파일만 하나 더 있는 구조라, 별칭을 지워도 영어 명령은 그대로 동작한다.

| 한글 | 영어 | 한글 | 영어 |
|---|---|---|---|
| `/디버그` | `/debug` | `/배포` | `/devops` |
| `/리뷰` | `/review` | `/의존성` | `/deps` |
| `/보안` | `/sec` | `/관측성` | `/obs` |
| `/테스트` | `/test` | `/리팩터` | `/refactor` |
| `/커버리지` | `/coverage` | `/문서` | `/docs` |
| `/성능` | `/perf` | `/카피` | `/copy` |
| `/계약` | `/contract` | `/회상` | `/recall` |
| `/디비` | `/db` | `/이야기` | `/story` |
| `/마이그레이션` | `/migrate` | `/화면` | `/ui` |
| `/아키텍처` | `/arch` | `/데이터모델` | `/datamodel` |

> 한국어 **자연어 호출**은 별칭과 무관하게 원래부터 동작한다(38종 description이 전부 한국어라 라우터가 한국어 문장으로 매치). 별칭은 슬래시 표기 편의일 뿐이다.

> 슬래시 명령은 추가 후 다음 세션부터 목록에 나타납니다.
> `/recall`은 메모리 회상 훅으로 자동 호출되기도 하지만, 수동으로 직접 부를 수도 있습니다.

---

## 바탕화면 런처

VS Code 없이 바로 쓰고 싶을 때를 위한 런처가 `launchers/claude.bat`에 들어 있습니다.
`sync.ps1` 실행 시 `%USERPROFILE%\.claude\launchers\`로 복사되며, 그 파일의 바로가기를 바탕화면에 두고 씁니다.
더블클릭 → 프로젝트 폴더 선택(다이얼로그) → 해당 폴더에서 Claude 실행.
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
- 이 README의 [에이전트 표](#에이전트-38종) 버전 칸도 버전업 시 함께 갱신됩니다.

---

## 업데이트 워크플로우

에이전트를 수정할 때는 항상 아래 순서를 따릅니다. **원본은 이 저장소의 `*.md` 한 곳에서만** 수정합니다.

1. 원본 `*.md` 수정
2. frontmatter `version`/`updated` 갱신 (마이너/메이저 판단)
3. `CHANGELOG.md`에 변경 기록
4. **`README.md`의 버전 표 갱신** (버전업 시)
5. `sync.ps1`으로 전역(`~/.claude/agents/`·`~/.claude/commands/`·`~/.claude/launchers/`)에 반영
6. `git commit` (원격 `git push`는 **명시 요청 시에만** — public repo에서 push는 곧 공개 게시)

---

## 저장소 구조

```
claude-agents/
├─ README.md                     # 이 문서
├─ CHANGELOG.md                  # 버전별 변경 이력
├─ AGENTS.md                     # 38개 에이전트 통합 정리
├─ design-agents.md              # 디자인 에이전트 4종 상세
├─ CLAUDE.md                     # 저장소 작업 가이드(Claude Code용)
├─ sync.ps1                      # 전역 동기화 스크립트(에이전트 + 슬래시 명령)
├─ .gitignore
│
├─ commands/                     # ── 슬래시 명령 정의 (38개) ──
│  ├─ review.md  ├─ sec.md       ├─ test.md      ├─ coverage.md
│  ├─ perf.md    ├─ contract.md  ├─ apidoc.md    ├─ db.md
│  ├─ migrate.md ├─ ui.md        ├─ dsystem.md   ├─ datamodel.md
│  ├─ arch.md    ├─ devops.md    ├─ deps.md      ├─ obs.md
│  ├─ fable.md   ├─ copy.md      ├─ landing.md   ├─ seo.md
│  ├─ factcheck.md  ├─ repurpose.md   ├─ voice.md
│  ├─ threat.md   ├─ aisec.md    ├─ ureview.md   ├─ gdd.md
│  ├─ gui.md      ├─ feel.md     ├─ uperf.md     ├─ playtest.md
│  ├─ ubuild.md   ├─ recall.md   ├─ refactor.md  ├─ docs.md
│  ├─ agentdef.md ├─ story.md    └─ debug.md
│
├─ launchers/                    # ── 바탕화면 런처 ──
│  └─ claude.bat
│
├─ code-reviewer.md              # ── 에이전트 정의 (38개) ──
├─ security-reviewer.md
├─ test-runner.md
├─ test-strategy.md
├─ perf-auditor.md
├─ api-contract-reviewer.md
├─ api-doc-writer.md
├─ db-optimizer.md
├─ migration-reviewer.md
├─ ui-ux-reviewer.md
├─ design-system-architect.md
├─ data-modeler.md
├─ system-architect.md
├─ devops-reviewer.md
├─ dependency-auditor.md
├─ observability-reviewer.md
├─ ai-workspace-architect.md
├─ copy-reviewer.md
├─ landing-reviewer.md
├─ seo-optimizer.md
├─ fact-checker.md
├─ content-repurposer.md
├─ brand-voice-guardian.md
├─ threat-modeler.md
├─ llm-ai-security-reviewer.md
├─ unity-code-reviewer.md
├─ game-design-architect.md
├─ game-ui-reviewer.md
├─ game-feel-reviewer.md
├─ unity-perf-auditor.md
├─ playtest-designer.md
├─ unity-build-auditor.md
├─ memory-recaller.md            # 인프라(개인 메모리 회상, haiku)
├─ refactor-strategist.md        # 품질(동작 보존 리팩터 계획)
├─ docs-writer.md                # 문서(개발자용 기술문서)
├─ agent-definition-reviewer.md  # 메타(에이전트 정의 점검)
├─ storyteller.md                # 창작(스토리텔링, fable)
└─ debugger.md                   # 품질(버그 근본 원인 규명)
```

---

## 라이선스

개인용 프로젝트(비공개 저장소). 별도 라이선스 미지정.
