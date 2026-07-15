# 서브에이전트 전체 정리 (57종)

Next.js + FastAPI + MySQL 스택을 위한 Claude Code 서브에이전트 모음입니다.
모두 한국어로 작성되었고, **읽기 전용으로 분석·리뷰·설계·제안만** 하며 코드/스키마를 직접 수정하지 않습니다.

> 16종은 위 개발 스택 전용 리뷰/설계 에이전트, 1종(`ai-workspace-architect` · `/fable`)은 스택과 무관한 **AI 작업환경 재설계** 메타 에이전트, 6종(`copy-reviewer`·`landing-reviewer`·`seo-optimizer`·`fact-checker`·`content-repurposer`·`brand-voice-guardian`)은 **카피·전환·SEO·팩트체크·재활용·브랜드 보이스**를 다루는 콘텐츠 에이전트다. 2종(`threat-modeler`·`llm-ai-security-reviewer`)은 **설계 단계 위협 모델링·AI/LLM 보안 심화**를 담당한다(품질 카테고리, `security-reviewer`와 보안 방어 클러스터 형성). 7종(`unity-code-reviewer`·`game-design-architect`·`game-ui-reviewer`·`game-feel-reviewer`·`unity-perf-auditor`·`playtest-designer`·`unity-build-auditor`)은 **Unity + C# 게임 개발(싱글플레이어 2D 캐주얼)**을 위한 게임 도메인 에이전트다(🎮 게임 클러스터, 색상 `cyan` 공유). 1종(`memory-recaller` · `/recall`)은 리뷰/설계가 아니라 **사용자 개인의 파일 기반 장기기억(`E:\claude_memory\`)을 값싼 `haiku`로 대신 회상**하는 인프라 에이전트다(🧠 인프라, 저장소 첫 haiku·메모리 훅 자동 호출 + `/recall` 수동 호출·읽기 전용). 마지막으로 2026-07 추가된 3종은 엔지니어링 `refactor-strategist`(`/refactor`, 동작 보존 리팩터 계획·단계 설계), 문서 `docs-writer`(`/docs`, 개발자용 README·아키텍처·온보딩·ADR), 메타 `agent-definition-reviewer`(`/agentdef`, 이 라이브러리의 에이전트 정의 자체의 스펙·경계·규범 점검)로, 각각 품질·문서·메타 클러스터에 편입된다. 그리고 1종(`storyteller` · `/story`)은 프롬프트(뼈대)에 살을 붙여 **없던 이야기를 새로 짓는** 창작 생성 에이전트로, 저장소 첫 `fable`(창작 특화 모델) 에이전트다(✍️ 창작 클러스터, 기존 자산 재활용인 `content-repurposer`와 구분). 마지막 1종(`debugger` · `/debug`)은 **이미 발생한 증상에서 거꾸로 원인을 추적**하는 디버깅 에이전트다(🐞 품질 클러스터, 스택 무관 — 정적 리뷰인 `code-reviewer`·`unity-code-reviewer`, 결과 집계인 `test-runner`와 구분). 그리고 2026-07 추가된 6종(`c-code-reviewer`·`c-architect`·`c-perf-auditor`·`dotnet-code-reviewer`·`dotnet-architect`·`dotnet-perf-auditor`)은 **C와 비-Unity C#/.NET**을 전담하는 시스템 언어 클러스터(🧩)로, 각 언어를 리뷰·설계·성능 3역으로 나눠 웹·게임 트리오와 동형이며 리뷰↔성능은 원인/증상 대칭이다(Unity C#은 `unity-code-reviewer`가 계속 담당).

## 공통 규칙
- 발견/제안은 **영향도(심각도) 순으로 정렬**
- 근거에 `파일경로:줄번호` 명시
- 확신이 없으면 추측하지 않고 **"확인 필요" / "검토 필요" / "추정"** 으로 표시
- 실행·수정이 필요한 작업(테스트 실행, 진단 쿼리 등)은 명시적으로 요청받았을 때만 수행

## 등록/사용 위치
| 항목 | 경로 | 비고 |
|---|---|---|
| 전역 에이전트 | `%USERPROFILE%\.claude\agents\` | 모든 프로젝트(D 파티션 포함)에서 사용 |
| 전역 슬래시 명령 | `%USERPROFILE%\.claude\commands\` | `/명령`으로 호출 |
| 전역 런처 | `%USERPROFILE%\.claude\launchers\` | 데스크톱 실행용 `claude.bat` |
| 소스(원본) | `d:\auto_agent`의 `*.md`·`commands/*.md`·`launchers/*.bat` | 편집용 단일 소스. 여기서만 편집 |

---

## 전체 한눈에 보기

| # | 에이전트 | 슬래시 | 분류 | 역할 | 도구 |
|---|---|---|---|---|---|
| 1 | `code-reviewer` | `/review` | 품질 | 코드 품질·가독성·버그 리뷰 | Read, Grep, Glob, Bash |
| 2 | `security-reviewer` | `/sec` | 품질 | 보안 취약점(OWASP) 점검 | Read, Grep, Glob, WebSearch, WebFetch |
| 3 | `test-runner` | `/test` | 품질 | 테스트 실행·실패 분석 | Bash, Read, Grep, Glob |
| 4 | `test-strategy` | `/coverage` | 품질 | 커버리지 공백·약한 테스트 진단 | Read, Grep, Glob |
| 5 | `perf-auditor` | `/perf` | 품질 | Next.js 프론트 성능 점검 | Read, Grep, Glob |
| 6 | `api-contract-reviewer` | `/contract` | 품질 | 프론트-백 API 계약 정합성 점검 | Read, Grep, Glob |
| 7 | `api-doc-writer` | `/apidoc` | 문서 | FastAPI 엔드포인트 카탈로그 | Read, Grep, Glob, Context7 |
| 8 | `db-optimizer` | `/db` | DB | MySQL 쿼리·인덱스 성능 튜닝 | Read, Grep, Glob, Bash |
| 9 | `migration-reviewer` | `/migrate` | DB | 스키마 마이그레이션 안전성 점검 | Read, Grep, Glob |
| 10 | `ui-ux-reviewer` | `/ui` | 디자인 | UI/UX·접근성·반응형 점검 | Read, Grep, Glob |
| 11 | `design-system-architect` | `/dsystem` | 디자인 | 디자인 토큰·컴포넌트 설계 | Read, Grep, Glob, Context7 |
| 12 | `data-modeler` | `/datamodel` | 설계 | 데이터 모델/스키마 설계 | Read, Grep, Glob |
| 13 | `system-architect` | `/arch` | 설계 | 시스템 아키텍처 설계 | Read, Grep, Glob, Context7 |
| 14 | `devops-reviewer` | `/devops` | 운영 | Docker·CI/CD·배포 설정 점검 | Read, Grep, Glob |
| 15 | `dependency-auditor` | `/deps` | 운영 | 의존성 취약점·버전·라이선스 점검 | Read, Grep, Glob, Bash |
| 16 | `observability-reviewer` | `/obs` | 운영 | 로깅·트레이싱·관측성 점검 | Read, Grep, Glob |
| 17 | `ai-workspace-architect` | `/fable` | 메타 | AI 작업환경 진단·재설계 | Read, Grep, Glob, WebSearch, WebFetch |
| 18 | `copy-reviewer` | `/copy` | 콘텐츠 | 마케팅 카피 품질 리뷰 | Read, Grep, Glob |
| 19 | `landing-reviewer` | `/landing` | 콘텐츠 | 상세페이지·랜딩 전환 리뷰 | Read, Grep, Glob |
| 20 | `seo-optimizer` | `/seo` | 콘텐츠 | 블로그·페이지 SEO 점검 | Read, Grep, Glob, WebSearch, WebFetch |
| 21 | `fact-checker` | `/factcheck` | 콘텐츠 | 콘텐츠 사실·수치·출처 검증 | Read, Grep, Glob, WebSearch, WebFetch |
| 22 | `content-repurposer` | `/repurpose` | 콘텐츠 | 1소스 → 멀티 포맷 재활용 | Read, Grep, Glob |
| 23 | `brand-voice-guardian` | `/voice` | 콘텐츠 | 브랜드 보이스 일관성 점검 | Read, Grep, Glob |
| 24 | `threat-modeler` | `/threat` | 품질 | 설계 단계 위협 모델링(STRIDE) | Read, Grep, Glob, WebSearch, WebFetch |
| 25 | `llm-ai-security-reviewer` | `/aisec` | 품질 | AI/LLM 보안 심화(OWASP LLM Top 10) | Read, Grep, Glob, WebSearch, WebFetch |
| 26 | `unity-code-reviewer` | `/ureview` | 게임 | Unity C# 게임 코드 리뷰(수명주기·GC·프레임/물리) | Read, Grep, Glob, Bash |
| 27 | `game-design-architect` | `/gdd` | 게임 | 2D 캐주얼 게임 디자인·시스템 설계 | Read, Grep, Glob |
| 28 | `game-ui-reviewer` | `/gui` | 게임 | 게임 UI/UX(HUD·메뉴·스케일링·내비·가독성) 점검 | Read, Grep, Glob |
| 29 | `game-feel-reviewer` | `/feel` | 게임 | 게임플레이 손맛/juice(입력 관대성·히트스톱·피드백) 점검 | Read, Grep, Glob |
| 30 | `unity-perf-auditor` | `/uperf` | 게임 | Unity 런타임 성능·렌더링(배칭·오버드로우·메모리·Profiler 해석) | Read, Grep, Glob |
| 31 | `playtest-designer` | `/playtest` | 게임 | 플레이테스트 프로토콜 설계(가설·참가자·지표·설문·텔레메트리) | Read, Grep, Glob |
| 32 | `unity-build-auditor` | `/ubuild` | 게임 | 빌드/릴리스·스토어 제출 점검(PlayerSettings·크기·서명·권한) | Read, Grep, Glob |
| 33 | `memory-recaller` | `/recall` | 인프라 | 파일 기반 장기기억 회상(E:\claude_memory 인덱스·토픽, haiku) | Read, Grep, Glob |
| 34 | `refactor-strategist` | `/refactor` | 품질 | 동작 보존 리팩터 계획·단계 설계(추출·중복·의존·seam) | Read, Grep, Glob |
| 35 | `docs-writer` | `/docs` | 문서 | 개발자용 기술문서(README·아키텍처·온보딩·ADR) 작성·정비 | Read, Grep, Glob |
| 36 | `agent-definition-reviewer` | `/agentdef` | 메타 | 서브에이전트 정의(.md) 스펙·라우팅·경계·규범 점검 | Read, Grep, Glob |
| 37 | `storyteller` | `/story` | 창작 | 프롬프트(뼈대)에 살 붙여 완성형 이야기 작성(fable) | Read, Grep, Glob |
| 38 | `debugger` | `/debug` | 품질 | 버그·에러·간헐 실패의 근본 원인 규명(재현·가설 검증·이분 탐색) | Read, Grep, Glob, Bash |
| 39 | `multiplayer-rule-reviewer` | `/rule` | 게임 | 멀티플레이 룰 정합성·서버 권위 점검(MSW mlua — 상태머신·판정 누락·클라 입력 검증·은닉 정보) | Read, Grep, Glob |
| 40 | `save-data-reviewer` | `/save` | 게임 | 세이브·영속 데이터 호환성(스키마 버전·마이그레이션·직렬화 리네이밍·손상 복구·클라우드 충돌) | Read, Grep, Glob |
| 41 | `accounting-rule-reviewer` | `/acct` | 도메인 | 복식부기 규칙 감사(차대 균형·역분개·마감 차단·금액 타입·잔액 정합·감사 추적) | Read, Grep, Glob |
| 42 | `ml-experiment-reviewer` | `/ml` | 도메인 | ML 실험 설계 감사(미래 정보 누출·검증 분할·as-of 재학습·백테스트 현실성·과적합) | Read, Grep, Glob |
| 43 | `automation-reliability-reviewer` | `/auto` | 도메인 | 데몬·크론 신뢰성(로그 유실·침묵 실패·중복 실행·멱등성·하트비트·복구) | Read, Grep, Glob |
| 44 | `game-localization-reviewer` | `/gloc` | 게임 | 현지화 준비(하드코딩 문자열·폰트 글리프·길이 팽창·어순·복수형·폴백) | Read, Grep, Glob |
| 45 | `game-test-strategy` | `/gtest` | 게임 | 게임 자동 테스트 전략(엔진 의존 seam·EditMode/PlayMode·결정론적 리플레이) | Read, Grep, Glob |
| 46 | `game-audio-reviewer` | `/gaudio` | 게임 | 오디오 구현(믹서 버스·동시 발음·반복 피로·임포트 설정·BGM 전환) | Read, Grep, Glob |
| 47 | `c-code-reviewer` | `/creview` | 시스템 | C 코드 리뷰(메모리 안전·UB·정수 변환·에러경로 누수·포맷 취약점) | Read, Grep, Glob, Bash |
| 48 | `c-architect` | `/carch` | 시스템 | C 구조 설계(모듈/헤더·메모리 소유권 계약·에러 규약·빌드/이식성) | Read, Grep, Glob |
| 49 | `c-perf-auditor` | `/cperf` | 시스템 | C 런타임 성능(캐시 지역성·할당·복잡도·프로파일 해석) | Read, Grep, Glob |
| 50 | `dotnet-code-reviewer` | `/dnreview` | 시스템 | 비-Unity C#/.NET 리뷰(async 데드락·IDisposable·지연실행·DI 수명·EF Core) | Read, Grep, Glob, Bash |
| 51 | `dotnet-architect` | `/dnarch` | 시스템 | .NET 구조 설계(계층·DI 수명·미들웨어·호스팅·async 경계) | Read, Grep, Glob, Context7 |
| 52 | `dotnet-perf-auditor` | `/dnperf` | 시스템 | .NET 런타임 성능(GC 압력·LOH·Span/ArrayPool·박싱·벤치마크 해석) | Read, Grep, Glob |
| 53 | `curriculum-designer` | `/curriculum` | 교육 | 강의·워크숍·강좌 교수 설계(학습자 분석·측정 가능한 학습 목표·모듈 계열화·backward design·슬라이드/핸드아웃 골격) | Read, Grep, Glob |
| 54 | `java-code-reviewer` | `/jreview` | 시스템 | Java(JVM) 코드 리뷰(NPE·Optional 오용·예외 정책·try-with-resources 자원 누수·동시성·equals/hashCode·오토박싱 ==·Stream 부작용) | Read, Grep, Glob, Bash |
| 55 | `java-architect` | `/jarch` | 시스템 | Java/Spring 구조 설계(계층 분리·빈 수명/생성자 주입·모듈 의존 방향·에러 전략 @ControllerAdvice·트랜잭션 경계·영속성 OSIV) | Read, Grep, Glob, Context7 |
| 56 | `swift-code-reviewer` | `/swreview` | 시스템 | Swift 코드 리뷰(강제 언랩 크래시·ARC retain cycle·값/참조 의미·에러 삼킴·동시성 actor/@MainActor/Sendable·열거 망라·Codable) | Read, Grep, Glob, Bash |
| 57 | `swift-architect` | `/swarch` | 시스템 | Swift 앱 구조 설계(MVVM/TCA·SPM 모듈 경계·DI·동시성 아키텍처·SwiftUI 상태 관리·내비게이션·값 타입 도메인) | Read, Grep, Glob, Context7 |

---

## 분류별 상세

### 🔍 품질 / QA

**1. code-reviewer (`/review`)**
Next.js + FastAPI 코드의 품질·가독성·버그 가능성 리뷰. `git diff`로 변경분을 파악해 그 범위에 집중(커밋/PR 전 셀프 리뷰). 백엔드(Pydantic·async·DB 세션·예외·계층 분리), 프론트(서버/클라 경계·페칭·useEffect·타입). Next.js 15/16이면 Server Actions 보안·`use cache` 오캐시·React Compiler 중복 수동 메모도 점검(버전 불명확하면 "확인 필요"). 출력: 요약 → Must fix → Should fix → Nit.
→ 보안 전용은 `security-reviewer`, 시각·접근성·UX는 `ui-ux-reviewer`, 프론트-백 API 계약 정합은 `api-contract-reviewer`, 로깅·관측성은 `observability-reviewer`, 동작 보존 리팩터 계획은 `refactor-strategist`, 이미 발생한 증상의 원인 규명은 `debugger`(코드리뷰는 증상 없는 정적 탐색).

**2. security-reviewer (`/sec`)**
OWASP 기준 보안 점검. 인증/인가(라우터 레벨 의존성까지 확인해 오탐 방지), IDOR/BOLA·BFLA, Next.js 미들웨어 인가 우회(CVE-2025-29927), RBAC, 경로 탐색, JWT(alg confusion·헤더 주입), 인젝션(SQL·SSTI·OS/NoSQL), XSS, 과잉 응답(API3), CSRF/SSRF, Mass Assignment, CORS, LLM 보안(OWASP LLM Top 10 2025: 프롬프트 인젝션·과도한 행위성·벡터/임베딩 약점 등). 출력: 심각도순 + "즉시 고쳐야 할 Top 3".
→ 일반 코드 품질·버그는 `code-reviewer`, 배포·CI 설정·시크릿 취급은 `devops-reviewer`, 의존성 취약·버전·라이선스는 `dependency-auditor`, LLM/AI 심화는 `llm-ai-security-reviewer`, 설계 단계 위협은 `threat-modeler`.

**3. test-runner (`/test`)**
pytest / Vitest·Jest(유닛) / Playwright·Cypress(E2E) 실행 후 실패 분석. 유닛과 E2E를 별개 러너로 인식 — E2E는 실행 비용·서버 기동 전제 때문에 요청 범위 밖이면 임의 실행 안 함. Vitest/jsdom은 async Server Component를 렌더 못 하므로 해당 실패는 프로덕션 버그로 단정하지 말고 Playwright E2E 영역임을 알림. 환경 준비(설치·venv)는 임의로 하지 않고 사전 조건으로 보고. 통과/실패 무관하게 테스트 품질 스캔(change-detector·목 그린)도 수행하며 green을 품질 증거로 칭찬하지 않음. 출력: 통과/실패/스킵 집계 → 실패별 원인 분류·제안, 플레이키·약한 테스트 표시.
→ 커버리지 공백·약한 테스트 진단·보강 전략은 `test-strategy`. 1차 원인 분류로 안 풀리는 실패(간헐·환경 의존·회귀 시점 추적)는 `debugger`로 넘긴다.

**4. test-strategy (`/coverage`)**
테스트 커버리지 공백·약한 테스트 **진단 및 케이스 설계**(테스트 코드는 직접 작성 안 함). 안 짠 경로, 약한 단언(change-detector·목 그린·단언 약함), 테스트 구조, 스택별 핵심 경로 누락, 보강 우선순위. 출력: 요약 → 커버리지 공백(입력→기대결과) → 약한 테스트 → 제안.
→ 실행·실패 진단은 `test-runner`, 일반 코드 품질은 `code-reviewer`.

**5. perf-auditor (`/perf`)**
Next.js 프론트 **성능** 정적 분석(빌드 실행 안 함). 번들/코드 스플리팅, 서버/클라 경계(RSC), 데이터 페칭·캐싱, 이미지/폰트, 렌더 비용, Core Web Vitals(LCP/CLS/INP), 서드파티. Next.js 15/16이면 Cache Components/`use cache` opt-in·PPR 경계·React Compiler 중복 메모도 점검. 측정 필요 항목은 "확인 필요"로 표시. 출력: 요약 → 위험 Top 3(작용 지표) → 주의 → 제안.
→ 시각·접근성은 `ui-ux-reviewer`, DB 성능은 `db-optimizer`, 정확성은 `code-reviewer`.

**6. api-contract-reviewer (`/contract`)**
Next.js 프론트와 FastAPI 백엔드의 **API 계약 정합성** 점검(프론트/백을 서로 다른 시점에 고치면 런타임에서 깨진다는 가정). 요청/응답 필드·타입 일치, 필수/옵셔널·널·enum 차이, 타입 드리프트(수기 중복 vs OpenAPI 생성 타입 동기화), 경로·메서드·상태코드, 깨지는 변경(필드 제거·이름·타입 축소·필수화), 페이지네이션·공통 래퍼·인증/Content-Type. 출력: 요약 → 불일치 Top 3(`프론트:줄`↔`백엔드:줄`, 어느 쪽을 맞출지) → 주의 → 제안.
→ 한쪽 코드 품질·버그는 `code-reviewer`, 백엔드 엔드포인트 카탈로그·문서화는 `api-doc-writer`.

### 📚 문서 / DB

**7. api-doc-writer (`/apidoc`)**
FastAPI 엔드포인트를 빠짐없이 카탈로그화. 라우터/WebSocket 데코레이터 수집, 다단계 prefix 합성, 라우터 레벨 의존성까지 본 인증 판정, `tags`/`response_model`/`deprecated` 반영. `Annotated[User, Depends(...)]`·`Annotated[..., Query()/Header()]`(0.95.0+ 권장) 양식을 구식 기본값 문법과 동등 인식. prefix 불확실 시 OpenAPI 3.1 `/openapi.json` 교차 점검 제안("확인 필요"). 출력: 리소스/태그별 표 + 미인증·무응답모델·deprecated 목록.
→ 프론트-백 계약 정합 검증은 `api-contract-reviewer`, 일반 개발문서(README·아키텍처·온보딩·ADR)는 `docs-writer`.

**8. db-optimizer (`/db`)**
MySQL 쿼리·인덱스·스키마 **성능 튜닝**. N+1, 인덱스 설계, SELECT * / 함수 래핑 / OFFSET 페이지네이션, 타입 적정성, 트랜잭션·락, 커넥션 풀, 벡터 검색(MySQL 9 `VECTOR` k-NN·사전필터, 거리 함수·인덱스 지원은 엔진별 확인). `EXPLAIN`/`EXPLAIN ANALYZE`는 명시 요청 시만 실행. 출력: 영향도별 문제 + "가장 효과 큰 개선 3가지".
→ 스키마 "설계"는 `data-modeler`, 마이그레이션 안전성(락·무중단·롤백)은 `migration-reviewer`, 프론트엔드 렌더·번들 등 화면 성능은 `perf-auditor`.

**9. migration-reviewer (`/migrate`)**
MySQL/Alembic 스키마 마이그레이션 **안전성** 점검(대형 테이블·운영 트래픽 가정). 락 범위·무중단 가능성, NOT NULL+백필 순서(expand-contract), 인덱스 생성 비용, 타입 변경 재작성, FK/유니크 제약, 롤백 가능성, 대량 DML 배치, 배포 순서(코드↔스키마 호환). 출력: 요약 → 위험 Top 3 → 주의 → 제안.
→ 스키마 "설계"는 `data-modeler`, 쿼리 "성능 튜닝"은 `db-optimizer`.

### 🎨 디자인

**10. ui-ux-reviewer (`/ui`)**
화면 UI/UX·접근성 점검. 레이아웃/간격, 타이포 위계, 색 대비(WCAG AA), 반응형·터치 타깃, 접근성(시맨틱·aria·키보드·alt·label·reduced-motion), 상태 표현(로딩/빈/에러), **폼/입력(검증 시점·에러 위치), 마이크로카피, 국제화(i18n/RTL), 다크모드 품질, 다크 패턴/윤리**, 컴포넌트 일관성. 실무 디자인 감사 카테고리 + Nielsen 휴리스틱 렌즈. 출력: 요약 → Must/Should/Nit.
→ 코드 로직 버그는 `code-reviewer`, 토큰/시스템 설계는 `design-system-architect`, 로드·렌더 성능(번들·CWV)은 `perf-auditor`.

**11. design-system-architect (`/dsystem`)**
디자인 시스템 설계. 디자인 토큰(색/타이포/스페이싱/래디우스/섀도), 테마(다크모드), 컴포넌트 계층·variant, 네이밍, Tailwind 설정 토큰화, 중복 통합, 문서화. 디자인 시스템을 **`DESIGN.md`**([google-labs-code/design.md](https://github.com/google-labs-code/design.md) 포맷: 프런트매터 토큰 + 산문 근거) 단일 소스로 정리·작성. 토큰 참조 `{colors.primary}`, WCAG 대비 명시. `@google/design.md` CLI(`lint`/`export`→Tailwind v3·v4·DTCG/`diff`)는 실행 안 하고 안내만. 출력: 현황 진단 → 제안 토큰 세트(DESIGN.md 형태) → DESIGN.md 초안 → 컴포넌트 구조 → 마이그레이션 단계.
→ 개별 화면 UI/UX 점검은 `ui-ux-reviewer`.

### 🏗 설계

**12. data-modeler (`/datamodel`)**
MySQL 데이터 모델 **설계**. 엔터티·관계(N:M 연결 테이블), 정규화, 키 전략(대리키/자연키/FK 동작), 타입 선택(임베딩=MySQL 9 `VECTOR(N)` 포함), 제약·무결성, 이력/감사/soft delete/채번, 확장성. 출력: 텍스트 ERD → 테이블별 설계(DDL) → 트레이드오프 → 가정.
→ 기존 쿼리 성능 튜닝은 `db-optimizer`, 마이그레이션 안전성(락·백필·롤백)은 `migration-reviewer`.

**13. system-architect (`/arch`)**
시스템 아키텍처 설계·점검. 계층 분리, 모듈 경계·의존성, API 계약, 인증 구조, 비동기/작업, 캐싱, 폴더 구조, 확장성, LLM/AI 연동(스트리밍 SSE·RAG/벡터 스토어·MCP 도구 경계). 출력(설계): 요구사항 → 옵션 비교 → 권장안(흐름도) → 단계 적용. 출력(점검): 진단 → 문제 → 개선 설계 → 마이그레이션.

### 🚀 운영 (DevOps)

**14. devops-reviewer (`/devops`)**
배포/운영 설정 점검. Dockerfile(레이어·캐시·이미지 크기·비루트·멀티스테이지), 시크릿/환경변수 취급, docker-compose(헬스체크·의존 순서·볼륨), CI/CD(GitHub Actions 권한·캐시·시크릿 노출·OIDC 키리스 인증), GHA 외 파이프라인(Harness Open Source/Drone `kind: pipeline`·GitLab CI·CircleCI도 같은 렌즈: 스텝 이미지 핀·`secrets.get`/`from_secret` 시크릿 참조·`privileged`/docker.sock DinD 격리·트리거 범위), 공급망 보안(SBOM·이미지 서명/cosign·provenance·digest 핀; 아티팩트 레지스트리 Harness OSS·GHCR·ECR·Nexus 불변 태그·업스트림 프록시·레지스트리단 스캔·풀/푸시 최소 권한), 개발 환경 설정(devcontainer/Gitspaces `.devcontainer/devcontainer.json` 베이스 이미지·`features` 핀·`postCreateCommand` 신뢰성·docker.sock/`privileged`·시크릿 하드코딩), 관측성 수집 파이프라인(OTel Collector·Grafana Alloy 설정 `config.alloy`·`*.river`·`config.yaml`·Helm `values`: 익스포터 인증 시크릿 하드코딩 vs `sys.env`·엔드포인트 TLS·수집기 이미지 핀·batch/큐/리소스 limits·tail sampling 토폴로지 headless Service/`routing_key="traceID"`/spanmetrics 위치·컴포넌트 `stabilityLevel` 게이팅 — 앱 측 계측은 `observability-reviewer` 영역), 배포 안전성, 빌드 재현성. 대상 파일이 없으면 그 사실을 보고. 출력: 요약 → 위험 Top 3 → 주의 → 제안.
→ 코드 보안은 `security-reviewer`, 마이그레이션은 `migration-reviewer`, 구조 설계는 `system-architect`, 의존성 자체의 취약·버전·라이선스는 `dependency-auditor`, 앱 런타임 로깅·트레이싱은 `observability-reviewer`.

**15. dependency-auditor (`/deps`)**
프로젝트 **의존성 건강성** 감사. package.json·lockfile·requirements·pyproject 정적 분석: 알려진 취약점(CVE, 직접/전이 경로), 버전 신선도·방치/deprecated, lockfile 무결성·드리프트, 미사용·누락 의존성, dependencies/devDependencies 오분류, 라이선스 위험(GPL/AGPL·불명), 공급망 신호(타이포스쿼팅·postinstall·비공식 레지스트리). `npm audit`·`pip-audit` 등 읽기 전용 진단은 명시 요청 시만, 설치·업그레이드는 안 함. 출력: 요약 → 위험 Top 3(패키지·현재/권장 버전·조치) → 주의 → 제안.
→ 앱 코드 보안 취약점은 `security-reviewer`, CI/공급망(SBOM·서명) 설정은 `devops-reviewer`.

**16. observability-reviewer (`/obs`)**
애플리케이션 **관측성** 점검("장애 시 추적 가능한가"가 기준). 구조적 로깅(맥락·레벨·노이즈), 상관관계 ID(request/trace) 전파(W3C `traceparent`/B3 포맷 일관성 포함), 에러 캡처·리포팅(예외 삼킴·Sentry·4xx/5xx 구분), 메트릭, 분산 트레이싱(OpenTelemetry **앱 측 계측**까지), 민감정보 로그 노출, 프론트 에러 바운더리·웹 바이탈. 수집·샘플링 파이프라인(OTel Collector·Alloy의 익스포터·tail sampling·배치)은 범위 밖. 출력: 요약(장애 추적 가능성) → 위험 Top 3(민감정보 로그·예외 삼킴·추적 불가) → 주의 → 제안.
→ 배포·인프라(로그·트레이스 수집·샘플링 파이프라인·대시보드: OTel Collector·Alloy 등) 설정은 `devops-reviewer`, 일반 예외 처리·코드 품질은 `code-reviewer`, 이미 발생한 장애의 원인 규명은 `debugger`(이 에이전트는 추적 "가능성"의 공백을 점검).

### 🧭 메타 / 워크플로우

**17. ai-workspace-architect (`/fable`)**
프롬프트·지침·`CLAUDE.md`·`SKILL.md`·커스텀 인스트럭션·반복 업무 규칙을 진단·재설계하는 **메타 에이전트**. 다른 16종과 달리 특정 개발 스택이 아니라 AI 작업환경 자체를 다루며, 마케팅·콘텐츠 제작(릴스·카드뉴스·블로그·상세페이지·강의자료) 결과물 품질을 시스템화. 여러 모델(Claude/GPT/Gemini/Cursor)에서 일관되게 작동하는 범용 AI 운영체제 설계 — 바로 붙여넣을 커스텀 인스트럭션·CLAUDE.md·SKILL.md 초안 + 모델별 전략. 실행 모델과 무관하게 뼈대→초안→자가채점→재작성 품질 엔진을 강제(도장찍기 금지: 근거 인용 + 약점 1개 이상 발굴·수정). 출력: 총평 → 진단표 → 병목 5 → A·B·C·D → 운영 규칙 → 자기비판 후 최종본.
→ 개발 스택 아키텍처는 `system-architect`, 디자인 시스템은 `design-system-architect`, 이 라이브러리의 에이전트 정의(.md) 점검은 `agent-definition-reviewer`.

### 📣 콘텐츠 / 마케팅

**18. copy-reviewer (`/copy`)**
마케팅 카피 품질 리뷰. 후킹(첫 3초/첫 줄), 1메시지 집중, 독자 언어, 구체성(추상어·공허한 최상급), CTA 명확성·마찰, 신뢰도·윤리(근거 없는 보장·허위·다크패턴), 톤 일관성, 포맷 적합. 변동 수치엔 `⚠️검증필요`. 출력: 요약 → Must/Should/Nit(위치·문제·근거·리라이트 예시).
→ 화면 시각·접근성은 `ui-ux-reviewer`, 전환 구조는 `landing-reviewer`, 검색 최적화는 `seo-optimizer`.

**19. landing-reviewer (`/landing`)**
상세페이지·랜딩 **전환** 리뷰. 히어로 가치 제안, 문제-공감-해결, 차별점 benefit 번역, 사회적 증거, 반론 처리, CTA 전략, 오퍼·가격 표현, 긴급성·희소성 윤리(다크패턴), 스캔 가능성. 출력: 요약 → 전환 저해 Top 3 → 주의·제안.
→ 문장 카피는 `copy-reviewer`, 시각·접근성은 `ui-ux-reviewer`, 검색 유입은 `seo-optimizer`.

**20. seo-optimizer (`/seo`)**
블로그·페이지 SEO 점검. 검색 의도, 타이틀·메타, 헤딩 구조, 키워드 배치·과최적화, 링크, 이미지 alt, 슬러그, 구조화 데이터, E-E-A-T·스니펫, 카니발라이제이션. 키워드·SERP는 WebSearch로 확인(미확인 "추정"). 출력: 요약 → 개선 Top 3(문안 예시) → 주의·제안.
→ 설득·문장은 `copy-reviewer`, 전환은 `landing-reviewer`, 기술 성능(CWV)은 `perf-auditor`.

**21. fact-checker (`/factcheck`)**
콘텐츠 사실·수치·출처 검증. 검증 가능한 진술만 추출(의견·일반론 제외) → ✅확인/⚠️부분사실/❌틀림/❓출처없음/🔒검증불가로 판정 + 출처. 통계·가격·날짜·연구 인용·비교 최상급·법률/의료/금융 주장 주의. 미확인은 사실로 단정 안 함. 출력: 요약 → 위험 Top 3 → 진술별 검증표.
→ 문장 설득력·톤은 `copy-reviewer`, 검색 최적화는 `seo-optimizer`, 전환은 `landing-reviewer`.

**22. content-repurposer (`/repurpose`)**
1소스(블로그·영상 스크립트·강의·뉴스레터) → 멀티 포맷(릴스·카드뉴스·스레드·뉴스레터·상세페이지 섹션) 재활용. 소스에서 핵심 추출 → 매체별 관행에 맞춤, 포맷마다 다른 각도, 원본 사실 왜곡·새 사실 창작 금지. 출력: 핵심 메시지 → 포맷별 완성형 초안 → 재활용 맵.
→ 카피 품질은 `copy-reviewer`, 검색 최적화는 `seo-optimizer`, 사실 검증은 `fact-checker`.

**23. brand-voice-guardian (`/voice`)**
콘텐츠가 브랜드 보이스(문체·톤·어휘·거리감·시그니처)에 맞는지 점검. 기준 소스: voice.md → 확정 예시글 → 제공 예시 추론 → 부재 시 `/fable`로 voice.md부터 만들라고 안내(보이스 지어내지 않음). 문장 습관·호칭·금지 표현·시그니처·톤 일관성·번역투 점검. 출력: 요약(기준·부합도) → 벗어난 구간(원문→교정) → 보강 제안.
→ 일반 카피 품질은 `copy-reviewer`, 보이스 정의·시스템 설계는 `ai-workspace-architect`.

### 🎓 교육 / 교수설계

**53. curriculum-designer (`/curriculum`)**
강의·워크숍·강좌·교육 자료의 **교수 설계(instructional design)**. backward design으로 학습자·맥락 분석 → 측정 가능한 학습 목표(Bloom's 동사) → 목표에 정렬된 형성·총괄 평가 → 목표·평가에 맞춘 활동·콘텐츠 순서로 설계한다. 모듈 분해·선수관계 계열화, 난이도 곡선·페이싱, 학습 경험 흐름(도입·동기→설명→시연→실습→피드백→정리), 인지부하 청킹, 슬라이드·핸드아웃·강사 노트 골격, 시간 배분을 다뤄 완성형 커리큘럼 맵+모듈 초안을 낸다(읽기 전용 — 파일 미수정). 콘텐츠 계열의 "교육 1종"으로 콘텐츠/마케팅 6종·창작 1종과 별개. 출력: 커리큘럼 맵(목표·모듈·평가 정렬표) → 모듈별 초안 → 슬라이드/핸드아웃/강사 노트 골격 → 채운 가정 & 확장 포인트.
→ 강의 홍보 카피는 `copy-reviewer`, 완성된 강의를 다른 포맷으로 파생은 `content-repurposer`, 개발자 문서·튜토리얼은 `docs-writer`, 사실 검증은 `fact-checker`, AI 작업환경 설계는 `ai-workspace-architect`.

### 🔒 품질 / QA — 보안 심화

**24. threat-modeler (`/threat`)**
설계 단계 위협 모델링. 자산 → 진입점·공격 표면 → 신뢰 경계·데이터 흐름(텍스트 DFD) → STRIDE per element → 악용 시나리오 → 위험 순위 → 완화책·보안 요구사항. 구현 전 선제 방어. 출력: 범위·가정 → 자산 → 진입점·신뢰경계 → STRIDE 위협 표 → 악용 시나리오 → 보안 요구사항 체크리스트.
→ 이미 있는 코드의 취약점은 `security-reviewer`, AI/LLM 특화 위협은 `llm-ai-security-reviewer`, 구조 설계는 `system-architect`.

**25. llm-ai-security-reviewer (`/aisec`)**
AI/LLM 보안 심화(OWASP LLM Top 10 2025). 프롬프트 인젝션(직접·간접: RAG·문서·외부페이지), 부적절한 출력 처리, 과도한 행위성(도구 권한·human-in-the-loop), 민감정보·시스템 프롬프트 유출, 벡터/RAG 포이즈닝·멀티테넌시, 공급망, 무제한 소비(Denial of Wallet), 가드레일·레드팀. 출력: 심각도별(LLMxx) → Top 3.
→ 웹 앱 일반 보안은 `security-reviewer`, 배포·시크릿·모델 서빙은 `devops-reviewer`, 설계 단계 위협은 `threat-modeler`.

### 🎮 게임 (Unity + C#)

**26. unity-code-reviewer (`/ureview`)**
Unity + C# 게임 코드(싱글플레이어 2D 캐주얼)의 게임 엔진 고유 결함 리뷰. `git diff`로 `Assets/` 하위 `.cs` 변경분에 집중(Bash는 범위 식별 전용). MonoBehaviour 수명주기(OnDisable 구독 해제 누락), 프레임 루프 비용(Update 내 GetComponent/Find), GC 할당(매 프레임 new·박싱·LINQ·풀링 부재), 코루틴/async 취소 누수, 물리·프레임률 의존(Time.deltaTime·Rigidbody2D), fake-null(파괴된 오브젝트 참조), ScriptableObject 원본 오염. 성능·GC는 정적 리뷰로 의심 지점만, 실제 수치는 Profiler 측정 권고로 분리. 출력: 요약 → Must/Should/Nit → 측정 권고 → Top 3.
→ 일반 웹 코드 리뷰는 `code-reviewer`, 게임 설계·코어 루프는 `game-design-architect`, 이미 발생한 런타임 오동작·크래시의 원인 규명은 `debugger`(이 에이전트는 증상 없는 정적 리뷰).

**27. game-design-architect (`/gdd`)**
구현 전 2D 캐주얼 게임 디자인·시스템 구조 설계. 코어 게임플레이 루프·재미 가설, 난이도 곡선·페이싱, 시스템 분해(상태머신·이벤트·SO 데이터 경계·세이브), 수직 슬라이스·MVP·컷 후보. 솔로 개발 최대 리스크 "미완성"을 겨냥해 야심 기능마다 컷 후보 강제, 재미는 단정 않고 "가설 + 플레이테스트 검증 질문"으로. 출력(설계): 요구/가정 → 코어 루프·재미 가설 → 시스템 분해 → 진행·난이도 → 수직 슬라이스·컷 라인 → 검증 질문.
→ Unity C# 코드 품질·프레임 리뷰는 `unity-code-reviewer`, 풀스택 웹 아키텍처는 `system-architect`.

**28. game-ui-reviewer (`/gui`)**
Unity 게임 **UI/UX 레이어**(HUD·메뉴·팝업·튜토리얼 화면) 점검. HUD/메뉴 레이아웃·정보 위계, CanvasScaler 해상도·종횡비 스케일링, 세이프 에어리어(노치), 캔버스 렌더 모드, 게임패드·터치 내비게이션·포커스(EventSystem·explicit navigation), 움직이는 화면 위 텍스트 가독성·색약/명도 대비, UI 상태(로딩/빈/에러/전환), 온보딩 UI, (수익화 시) F2P 다크패턴. YAML 설정·코드로 확정 가능한 것만 심각도, 실제 보임새는 기기 확인 권고로 분리(화면 못 봄). 출력: 요약 → Must/Should/Nit → 기기 확인 권고 → 위임 → Top 3.
→ UI 조작 피드백은 이 에이전트, 게임플레이 동작 피드백은 `game-feel-reviewer`. 코어 루프·난이도는 `game-design-architect`, 코드·프레임은 `unity-code-reviewer`, 웹 화면·WCAG 폼·i18n은 `ui-ux-reviewer`.

**29. game-feel-reviewer (`/feel`)**
게임플레이 동작의 **손맛(game feel·juice)** 점검. 입력 응답 관대성(코요테 타임·점프 버퍼·입력 버퍼링·가변 점프), 히트스톱/타임프리즈, 화면 흔들림·카메라 추적/룩어헤드, 스쿼시&스트레치·파티클·플래시, 사운드/햅틱 타이밍, 가감속 커브, 페이싱. 장치의 유무·구조는 확정 보고, 손맛 체감·세부 튜닝값은 프로토타입 검증 항목으로 분리(정적 단정 금지). 출력: 요약 → Must/Should/Nit → 핵심 동사×피드백 채널 매트릭스 → 프로토타입 검증 항목 → 위임 → Top 3.
→ 게임플레이 동작 피드백(HUD 표시 포함)은 이 에이전트, UI 조작·위젯 배치는 `game-ui-reviewer`. 재미 가설·난이도는 `game-design-architect`, 코드·GC는 `unity-code-reviewer`.

**30. unity-perf-auditor (`/uperf`)**
Unity 게임 런타임 성능·렌더링 감사(모바일 2D 타깃). 드로우콜·배칭(SpriteAtlas), 오버드로우·필레이트, 텍스처 압축(ASTC/ETC2)·`.meta` 임포트·메모리, Fixed Timestep·2D 충돌 비용, 퀄리티/프로젝트 설정, Profiler/Frame Debugger 캡처 수치 해석. 정적 리뷰로 "느리다" 단정 않고 측정 계획으로 분리(수치 제공 시 수치가 근거). 출력: 요약 → Must/Should/Nit → 측정 계획 → 캡처 해석 → 위임 → Top 3.
→ GC 유발 코드 원인은 `unity-code-reviewer`(증상·측정 해석이 이 에이전트), 빌드 용량은 `unity-build-auditor`, 웹 성능은 `perf-auditor`, 카메라 지터 손맛은 `game-feel-reviewer`.

**31. playtest-designer (`/playtest`)**
플레이테스트 프로토콜 설계(실행 아님). game-design-architect의 검증 질문·game-feel-reviewer의 프로토타입 검증 항목을 실행 가능한 프로토콜로: 가설→행동 지표→판정 기준, 참가자·회차(신선한 눈 배분), 세션(콜드 스타트·진행자 스크립트·개입 규칙), 관찰 지표(FTUE·막힘·이탈·재시도·리텐션 프록시), 설문(유도 질문 배제), 텔레메트리 이벤트, 결과 해석. 재미의 판정자는 데이터 — 관찰이 진술을 이기고 소규모 n을 백분율로 포장 안 함. 출력: 검증 가설 표 → 참가자·회차 → 세션 프로토콜 → 관찰 시트 → 설문 → 텔레메트리 → 해석 가이드.
→ "무엇을 검증할지"는 `game-design-architect`·`game-feel-reviewer`(이 에이전트는 "어떻게 검증할지"). 소프트웨어 자동 테스트는 `test-strategy`/`test-runner`.

**32. unity-build-auditor (`/ubuild`)**
Unity 빌드·릴리스 설정·스토어 제출 준비 감사(모바일). Player Settings(번들 ID·버전·IL2CPP/ARM64·managed stripping), 빌드 크기(Resources 남용·압축 용량·AAB), 빌드 씬 목록, 매니페스트 권한, 스토어 요건(64bit·개인정보), 서명/keystore 커밋 여부, development build 플래그 잔존, Addressables. 파일 판정은 확정, 스토어 정책 수치는 변동이 커 확인 목록(⚠️)으로 분리(웹 검색 도구 없음). 출력: 요약 → 제출 차단·보안 Must → Should → Nit → 스토어 정책 확인 목록 → 위임 → Top 3.
→ 일반 CI/CD·시크릿 보관·파이프라인은 `devops-reviewer`(이 에이전트는 keystore 커밋·존재 판정까지), 코드는 `unity-code-reviewer`, 런타임 성능은 `unity-perf-auditor`.

### 🛠 엔지니어링 / 문서 / 메타 (1.60 추가)

**34. refactor-strategist (`/refactor`)** — 품질
기능 변경 없이 코드 구조를 개선하는 계획 설계. 책임 분리(과대 함수·God object), 중복·네이밍·매직 넘버, 의존 구조(순환·잘못된 방향), 데드코드·미사용, 변경 seam(특성화 테스트 경계)을 진단하고, 동작 보존을 최우선으로 작고 되돌릴 수 있는 이행 단계(추출→이동→개명→정리)와 각 단계 검증 지점을 낸다. 동작 바뀌는 개선(버그·기능)은 리팩터와 분리. 출력: 요약 → 리팩터 후보(영향도순) → 이행 단계(+검증) → 분리 항목 → Top 3.
→ 버그·정확성 리뷰는 `code-reviewer`, 신규 아키텍처 설계는 `system-architect`, 커버리지 보강은 `test-strategy`.

**35. docs-writer (`/docs`)** — 문서
코드·구조에서 사실을 추출해 개발자용 기술문서(README·아키텍처 개요·온보딩·CONTRIBUTING·ADR)를 작성·정비. 코드가 진실원천(미확인은 `확인 필요`), 독자별 깊이 조정, 문서 종류별 관행 준수, 드리프트 방지(바뀌어도 유효한 구조·의도 우선). 출력: 문서 계획 → 완성형 문서 초안 → 확인 필요 목록.
→ FastAPI 엔드포인트 카탈로그는 `api-doc-writer`, 디자인 시스템 문서(DESIGN.md)는 `design-system-architect`, 마케팅·강의 콘텐츠는 `content-repurposer`·`copy-reviewer`.

**36. agent-definition-reviewer (`/agentdef`)** — 메타
이 라이브러리의 서브에이전트 정의(.md) 자체를 점검. frontmatter 스펙 정합(name/description/tools/model/effort 티어), description 라우팅 친화성(트리거·위임 절), tools 최소권한(과대·과소), 에이전트 간 경계 중복·공백, 본문 규범 누락(인젝션 방어·읽기전용·증거 기반 보고), 배포 정합(hooks·memory·skills 조합·sync allowlist). 새 에이전트 추가·정의 개정 전 점검. 출력: 요약 → [P1/P2/P3] 발견 → 경계 지도 → 개정 초안 → Top 3.
→ 사용자의 범용 AI 작업환경·마케팅 프롬프트 시스템 설계는 `ai-workspace-architect`(이 에이전트는 라이브러리 내부 정의만), 개발 코드 품질은 `code-reviewer`.

### ✍️ 창작 (스토리텔링)

**37. storyteller (`/story`)** — 창작
프롬프트(뼈대: 한 줄 아이디어·설정·인물·장르·분량)에 살을 붙여 완성형 이야기(단편·서사·시나리오·브랜드 스토리·에피소드)를 짓는다. 저장소 첫 `fable`(창작 특화 모델, +`effort: high`) 에이전트. 작법: ① 뼈대 확정(로그라인·인물 욕망/결핍·갈등·판돈·구조) → ② 살(show-don't-tell·감각 디테일·서브텍스트 대사·시점 일관성·페이싱) → ③ 자가 점검 후 약한 구간 재작성. 표절 금지·사용자 핵심 설정/결말 보존·채운 가정 명시, 유해 실행 지침·미성년 성적 묘사·실존 인물 명예훼손 거부. 출력: 로그라인 → 뼈대 요약 → 이야기 본문(제목) → 채운 가정 & 확장 포인트.
→ 기존 자산을 매체별로 파생하는 것은 `content-repurposer`, 카피 품질은 `copy-reviewer`, 확정 보이스 준수는 `brand-voice-guardian`, 프롬프트·지침 시스템 설계는 `ai-workspace-architect`.

### 🎮 게임 — 멀티플레이 (MSW)

**39. multiplayer-rule-reviewer (`/rule`, `/룰`)** — 게임
멀티플레이 게임의 **룰이 서버에서 실제로 강제되는가**를 점검한다(주력: MapleStory Worlds `.mlua` 소셜 추리/마피아류, 원칙은 엔진 무관). 두 전제: ①클라이언트는 적대적이다(서버가 검증 안 하면 규칙이 아니다 — UI 차단은 방어가 아님) ②판정은 상태 변화에 걸어야 한다(승패를 특정 페이즈 전환에만 걸면 다른 사망 경로에서 누락). 점검: 상태머신 정합성(페이즈×이벤트 전이표 구멍·타이머 경합·재진입, 판정 함수 호출 지점 전수 카운트), 서버 권위(`@ExecSpace("Server")` = 클라 호출 가능 진입점의 호출자 신원·자격·생존·페이즈·대상 유효성·중복 제출 검증), 은닉 정보 누출(`@Sync`·브로드캐스트로 마피아 정체·밤 행동·투표 집계 유출 — 클라 UI로만 가리면 결함), 로스터 생애주기(이탈·재접속·호스트·최소 인원), 룰·밸런스 정합(시작부터 승리 조건이 성립하는 역할 구성, 자동 지목의 아군 살해, 동점·기권), 결정성·시간. 출력: 요약 → 페이즈 전이표 → 서버 진입점 검증 표 → 심각도순 발견(악용 시나리오 포함) → 경계 케이스 체크리스트 → 확인 필요 → Top 3.
→ "무엇을 만들지"(코어 루프·재미·난이도)는 `game-design-architect`, Unity C# 엔진 코드는 `unity-code-reviewer`, 이미 난 증상의 원인 규명은 `debugger`(이쪽은 증상 없는 선제 점검), 세이브 스키마 진화·손상 복구는 `save-data-reviewer`, 웹 앱 인증·인가·주입은 `security-reviewer`.

**40. save-data-reviewer (`/save`, `/세이브`)** — 게임
**이 업데이트를 내보내면 이미 플레이 중인 유저의 진행도가 살아남는가**만 본다(엔진 무관 — Unity PlayerPrefs/JSON/바이너리, MSW 스토리지, 클라우드 세이브). 점검: 스키마 버전 필드와 v1→v2→v3 **순차** 마이그레이션(버전 건너뛴 유저가 가장 흔하다), 직렬화 필드 리네이밍(별칭 없이 바꾸면 값이 조용히 기본값으로 리셋)·enum 중간 삽입(저장된 정수가 다른 의미로 해석)·타입 변경, 손상·변조 세이브의 우아한 거부·백업 복구(시작 즉시 크래시 = 게임 못 켬), 저장의 원자성(임시 파일 → 교체)과 실패의 조용한 무시·마이그레이션 직전 백업, 삭제된 콘텐츠 ID를 참조하는 고아 데이터(인덱스 저장 vs 안정적 ID), 매체별 함정(PlayerPrefs 남용·플랫폼 쿼터·클라우드 충돌 해소 규칙). 출력: 요약(살아남는가) → 데이터 손실 위험(손실 시나리오) → 호환성 리스크 → 스키마 변경 목록 → 마이그레이션 설계 → 구버전 세이브 회귀 시나리오 → Top 3.
→ 서버 DB(MySQL·Alembic) 마이그레이션은 `migration-reviewer`, 재화 지급의 서버 권위·멱등성은 `multiplayer-rule-reviewer`, 데이터 구조 설계는 `game-design-architect`·`data-modeler`.

### 🐞 디버깅 (품질)

**38. debugger (`/debug`)** — 품질
**이미 발생한 증상**에서 거꾸로 근본 원인을 추적한다(스택 무관 — 웹이 주력, Unity C# 런타임 증상도 동일 절차). 증상 확정(기대 vs 실제·재현율·환경) → 최소 재현 → 관찰 수집(스택트레이스는 *우리 코드의 가장 깊은 프레임*부터) → 가설 3~5개(각각 반증 조건) → 검증·축소(코드 경로·시간(`git log`/`blame`)·입력·환경 이분) → 원인 확정 → 수정 방향·재발 방지 테스트. 버그 클래스 렌즈: 간헐·플레이키(경쟁 조건·순서 의존), 상태·데이터, 경계 넘김(계약·캐시 stale·하이드레이션), 동시성·자원, 환경차, Unity 런타임(fake-null·구독 해제). 관찰이 추측을 이긴다 — 못 밝히면 **미확정으로 정직 보고**(범인 창작 금지). 코드 수정 안 함, `git bisect`·`checkout` 등 워킹트리 변경은 절차만 제시, Bash는 재현·조회 전용, 계측은 코드에 심지 않고 계획만. 출력: 증상 요약 → 관찰된 사실 → 가설·검증 표 → 근본 원인(인과 사슬) → 수정 방향 → 재발 방지 → 미해결·다음 관찰.
→ 테스트 실행·집계·1차 분류는 `test-runner`(테스트를 아직 안 돌렸으면 거기부터 — 안 풀리는 실패가 이 에이전트 몫), 증상 없는 정적 리뷰는 `code-reviewer`·`unity-code-reviewer`, 추적 인프라 공백은 `observability-reviewer`, 취약점은 `security-reviewer`. **성능은 축으로 가른다** — "무엇이 느린가"(병목 진단)는 `perf-auditor`·`db-optimizer`·`unity-perf-auditor`, "언제부터·무엇이 바뀌어 느려졌나"(회귀 시점 추적)는 이 에이전트.

### 🧩 시스템 언어 (C · 비-Unity .NET · Java · Swift) — 1.72 추가, 2026-07-15 Java·Swift 확장

웹(code-reviewer)·게임(unity-code-reviewer)이 폴백으로만 훑던 C와 비-Unity C#/.NET을 전담. C·.NET은 각 언어를 리뷰·설계·성능 3역으로 나눴고, 리뷰↔성능은 unity 쌍과 같은 원인/증상 대칭. 2026-07-15 이 클러스터를 **Java(JVM)·Swift**로 확장했는데, 3역 트리오가 아니라 **리뷰어+아키텍트 2역씩**만 두고 **전담 perf 에이전트는 프로모션 게이트에 따라 의도적으로 미생성**(두 리뷰어가 "전담 perf 없음"을 알려진 공백으로 명시). 리뷰어는 Bash(git diff 범위 식별 + 명시 요청 시 읽기전용 정적분석), 아키텍트는 Context7(Spring·SwiftUI 등 버전 의존 패턴)을 갖는다.

**47. c-code-reviewer (`/creview`)** — 시스템
C 고유 결함의 정적 리뷰. 공간 안전(버퍼 오버플로·off-by-one), 시간 안전/소유권(UAF·double-free·dangling·미초기화), 널·반환값·`errno` 미검사, 정수(시그니처드 오버플로·부호/폭 변환·크기 계산 오버플로→힙 오버플로), UB(엄격 앨리어싱·시퀀스 포인트·널 산술), 에러 경로 자원 누수(`goto cleanup` 일관성), 포맷 스트링, 동시성·시그널 안전성, 매크로 함정. C의 메모리 안전 결함 = 보안 결함이라 웹 OWASP `security-reviewer`가 안 보는 층을 맡는다. Bash는 변경 범위 식별 + **명시 요청 시** 읽기전용 정적분석(빌드·실행 금지). 출력: 요약 → Must fix → Should fix → Nit → 위임.
→ 일반 품질·타 스택 폴백은 `code-reviewer`, 구조는 `c-architect`, 성능은 `c-perf-auditor`, 이미 난 크래시 원인은 `debugger`.

**48. c-architect (`/carch`)** — 시스템
C 구조 설계(언어가 규율을 강제 안 하니 구조·계약으로 만든다). 모듈/헤더 경계(불투명 포인터·최소 공개 표면·순환 포함 차단), **메모리 소유권 모델**(할당·해제를 API 계약으로·이전 vs 대여), 에러 처리 전략(반환코드/errno/out-param 일관·단일 출구 정리), API/ABI 안정성, 빌드 의존성 방향, 이식성 계층(`#ifdef` 격리), 동시성·할당 전략(아레나/풀 vs 개별 malloc). 출력: (신규) 가정 → 옵션 비교 → 권장안(다이어그램·API 스케치) → 단계 / (점검) 진단 → 문제 → 개선 → 마이그레이션.
→ 구현 코드 결함은 `c-code-reviewer`, 성능은 `c-perf-auditor`, 웹 아키텍처는 `system-architect`, .NET 구조는 `dotnet-architect`.

**49. c-perf-auditor (`/cperf`)** — 시스템
C 런타임 성능. (1) 정적 감사 — 캐시 지역성(AoS/SoA·거짓 공유·정렬)·할당 전략(핫 경로 malloc→아레나/풀)·불필요 복사·알고리즘 복잡도·분기·벡터화 저해 요인(`restrict`은 정확성이라 c-code-reviewer로)·I/O 버퍼링, (2) 캡처 해석 — perf/gprof/cachegrind/callgrind/Massif. 정적으로 "느리다" 단정 금지 → 측정 계획으로 분리(조기 최적화 경계). `c-code-reviewer`와 원인/증상 대칭.
→ 코드 원인·UB는 `c-code-reviewer`, 회귀 시점은 `debugger`, 구조는 `c-architect`, 웹/.NET 성능은 `perf-auditor`·`dotnet-perf-auditor`.

**50. dotnet-code-reviewer (`/dnreview`)** — 시스템
비-Unity C#/.NET 고유 결함 리뷰(ASP.NET Core·워커·콘솔·WPF·라이브러리). async(`.Result`/`.Wait()` 데드락·`async void`·미대기·취소 미전파·`ConfigureAwait`), 자원 수명(IDisposable/`using`·`HttpClient` 소켓 고갈·이벤트 미해제), 지연 실행(IEnumerable 다중 열거), nullable, **DI 수명**(captive dependency·`DbContext` 공유), EF Core(N+1·클라 평가·추적 낭비·`SaveChanges` 누락), 예외(삼킴·`throw ex` 스택 소실), 값/참조 의미·문화권 파싱. Bash는 변경 범위 식별만. 출력: 요약 → Must fix → Should fix → Nit → 위임.
→ Unity C#은 `unity-code-reviewer`, 웹 JS/파이썬 폴백은 `code-reviewer`, 구조는 `dotnet-architect`, 성능은 `dotnet-perf-auditor`, 보안은 `security-reviewer`.

**51. dotnet-architect (`/dnarch`)** — 시스템
.NET 구조 설계. 계층 분리(엔드포인트/앱/도메인/인프라·Minimal API vs 컨트롤러), **DI 서비스 수명 설계**(captive dependency 예방·`DbContext` 수명), 미들웨어 파이프라인 순서, 호스팅(`BackgroundService`·그레이스풀 셧다운·큐 소비), 옵션 패턴(`IOptions`·시크릿), async 경계(끝까지 async·취소 전파), 프로젝트 의존성 방향(순환 차단), 복원력(재시도·서킷브레이커). 버전 의존 패턴은 Context7로 확인. 출력: (신규) 가정 → 옵션 비교 → 권장안 → 단계 / (점검) 진단 → 문제 → 개선 → 마이그레이션.
→ 구현 코드 결함은 `dotnet-code-reviewer`, 성능은 `dotnet-perf-auditor`, 웹 풀스택은 `system-architect`, C 구조는 `c-architect`, 배포·컨테이너는 `devops-reviewer`.

**52. dotnet-perf-auditor (`/dnperf`)** — 시스템
.NET 런타임 성능. (1) 정적 감사 — **GC 압력**(할당률·세대 승격·LOH 단편화·Server vs Workstation GC)·할당 절감(`Span`/`stackalloc`/`ArrayPool`·struct vs class·박싱·클로저 캡처)·문자열·async 오버헤드(`ValueTask`)·LINQ 중간 컬렉션·컬렉션 선택·직렬화·JIT/AOT, (2) 캡처 해석 — BenchmarkDotNet/dotnet-counters/dotnet-trace/PerfView. 정적으로 "느리다" 단정 금지 → 측정 계획으로. `dotnet-code-reviewer`와 증상/원인 대칭.
→ 할당 유발 코드·EF 안티패턴은 `dotnet-code-reviewer`, 회귀 시점은 `debugger`, 구조는 `dotnet-architect`, Unity 성능은 `unity-perf-auditor`, MySQL 튜닝은 `db-optimizer`.

**54. java-code-reviewer (`/jreview`)** — 시스템
서버/JVM Java 고유 결함 리뷰. NPE·널 처리(필드/파라미터 `Optional` 오용·미검사 `get()`), 예외 정책(빈·`catch(Exception)` 삼킴·원인 체이닝 소실·try-with-resources 미사용), 자원 수명(AutoCloseable/스트림/커넥션 누수), JVM 동시성(volatile을 원자성으로 오해·비스레드안전 `SimpleDateFormat`·`ConcurrentModificationException`·데드락), `equals`/`hashCode`/`compareTo` 계약(HashMap 키·가변 키), 제네릭(로 타입·미검사 캐스트·소거), 오토박싱(`Integer` 캐시 `==`·언박싱 NPE·`double`로 금액), String/로케일, Stream 부작용. Bash는 변경 범위 식별 + 명시 요청 시 읽기전용 정적분석. **Android/Kotlin 프레임워크는 대상 밖(인접 공백 명시)**, **전담 perf 에이전트 없음(알려진 공백)**. 출력: 요약 → Must fix → Should fix → Nit → 위임.
→ 일반 품질·타 스택 폴백은 `code-reviewer`, 구조는 `java-architect`, 이미 난 크래시 원인은 `debugger`, 보안은 `security-reviewer`.

**55. java-architect (`/jarch`)** — 시스템
Java/Spring 구조 설계. 계층 분리(controller/service/repository/domain·헥사고날·의존성 안쪽 방향), **빈 수명**(생성자 주입·빈 스코프·싱글턴 빈의 가변 상태 스레드 안전·순환 의존), 모듈/패키지 의존 방향, 에러 전략(checked/unchecked 정책·경계 변환 `@ControllerAdvice`), 동시성(executor 소유권·불변성·`@Async` 경계), 영속성 경계(엔티티 vs DTO·`@Transactional` 전파·OSIV). 버전 의존 패턴(Spring·`jakarta.*`)은 Context7로 확인. 출력: (신규) 가정 → 옵션 비교 → 권장안 → 단계 / (점검) 진단 → 문제 → 개선 → 마이그레이션.
→ 구현 코드 결함은 `java-code-reviewer`, 웹 풀스택은 `system-architect`, .NET 구조는 `dotnet-architect`, C 구조는 `c-architect`, 배포·컨테이너는 `devops-reviewer`.

**56. swift-code-reviewer (`/swreview`)** — 시스템
Swift 고유 결함 리뷰. 옵셔널 안전(강제 언랩 `!`/`try!`/`as!` 크래시·IUO), **ARC retain cycle**(클로저 `[weak self]` 누락·강한 delegate 참조·`unowned` 오용), 값/참조 의미(struct vs class·COW), 에러 삼킴(`try?`·force-try), 동시성(async/await·actor 격리·`@MainActor` UI 스레드·Sendable 데이터 레이스·`DispatchQueue.main.sync` 데드락·continuation 이중 재개), 프로토콜/제네릭 existential 비용·클로저 캡처, 열거 망라성, force-cast, Codable. Bash는 변경 범위 식별 + 명시 요청 시 읽기전용 정적분석. **전담 perf 에이전트 없음(알려진 공백)**. 출력: 요약 → Must fix → Should fix → Nit → 위임.
→ 일반 품질·타 스택 폴백은 `code-reviewer`, 구조는 `swift-architect`, 이미 난 크래시 원인은 `debugger`, 보안은 `security-reviewer`.

**57. swift-architect (`/swarch`)** — 시스템
Swift 앱 구조 설계. 아키텍처 패턴 선택(MVVM/TCA/VIPER/Clean, 규모별), 모듈 경계(SPM/프레임워크 타깃·비순환 의존), DI(이니셜라이저/Environment 주입·싱글턴 남용 회피·프로토콜 seam), 동시성 아키텍처(actor 격리·`@MainActor` 경계·구조적 동시성·Sendable), **SwiftUI 상태 관리**(단일 진실 원천·`@State`/`@StateObject`/`@ObservedObject`/`@Binding`/`@Environment` 소유권 배치·`@Observable`), 내비게이션, 값 타입 우선 도메인 모델링, 영속성·네트워킹 경계. 버전 의존 패턴(`@Observable`·NavigationStack)은 Context7로 확인. 출력: (신규) 가정 → 옵션 비교 → 권장안 → 단계 / (점검) 진단 → 문제 → 개선 → 마이그레이션.
→ 구현 코드 결함은 `swift-code-reviewer`, 웹 풀스택은 `system-architect`, .NET 구조는 `dotnet-architect`, C 구조는 `c-architect`.

---

## 역할이 겹치기 쉬운 쌍 (양방향 위임)

양쪽 description이 서로를 가리키는 대칭 위임(`↔`) — 어느 쪽으로 호출해도 인접 영역으로 안내된다. 1.56의 전수 스캔 34쌍에서 1.64·1.67~1.72를 거치며 늘어 **현재 60쌍**이며 클러스터별로 나눈다.

**웹 스택 (20쌍)**
| 쌍 | 구분 |
|---|---|
| code-reviewer ↔ security-reviewer | 일반 품질/버그 ↔ 보안 전용 |
| code-reviewer(프론트) ↔ ui-ux-reviewer | 로직·타입·구조 ↔ 시각·사용성·접근성 |
| code-reviewer ↔ api-contract-reviewer | 한쪽 "코드 품질·버그" ↔ 양쪽 "계약 일치" |
| code-reviewer ↔ observability-reviewer | 일반 "예외 처리·코드 품질" ↔ 관측성 "공백"(로깅·추적) |
| db-optimizer ↔ data-modeler | 기존 쿼리·인덱스 "튜닝" ↔ 테이블·관계 "설계" |
| migration-reviewer ↔ data-modeler | 마이그레이션 "안전성·배포 순서" ↔ 스키마 "설계" |
| migration-reviewer ↔ db-optimizer | 마이그레이션 "락·무중단·롤백" ↔ 쿼리·인덱스 "성능 튜닝" |
| perf-auditor ↔ db-optimizer | 프론트 성능(번들·페칭) ↔ DB 쿼리·인덱스 성능 |
| perf-auditor ↔ ui-ux-reviewer | 성능(번들·렌더·CWV) ↔ 시각·사용성·접근성 |
| ui-ux-reviewer ↔ design-system-architect | 개별 화면 "점검" ↔ 토큰·컴포넌트 "시스템 설계" |
| dependency-auditor ↔ security-reviewer | 의존성 자체 "취약·버전·라이선스" ↔ 앱 "코드 보안 취약점" |
| dependency-auditor ↔ devops-reviewer | 의존성 "건강성"(매니페스트·lockfile) ↔ CI/공급망 "설정"(SBOM·서명) |
| devops-reviewer ↔ security-reviewer | 배포·운영 설정·시크릿 취급 ↔ 코드 보안 취약점 |
| devops-reviewer ↔ observability-reviewer | 로그 수집·대시보드 "인프라 설정" ↔ 앱 런타임 "로깅·트레이싱·계측" |
| devops-reviewer ↔ system-architect | 배포·인프라 설정 "점검" ↔ 시스템 구조 "설계" ⟵ 1.56에서 일방향→대칭 정정 |
| api-contract-reviewer ↔ api-doc-writer | 프론트-백 계약 "정합성 검증" ↔ 백엔드 엔드포인트 "카탈로그·문서화" |
| test-strategy ↔ test-runner | 커버리지 공백·약한 테스트 "설계" ↔ 실행·실패 "진단" |
| debugger ↔ test-runner | 실패의 "근본 원인 규명"(재현·가설·이분) ↔ 테스트 "실행·집계·1차 분류" |
| debugger ↔ code-reviewer | 이미 난 증상에서 "역추적" ↔ 증상 없이 변경분에서 "잠재 결함" 정적 리뷰 |
| debugger ↔ observability-reviewer | 지금 있는 로그로 "원인 규명" ↔ 추적 "가능성" 자체의 공백 점검 |

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

**게임 (Unity + C# · MSW, 16쌍)**
| 쌍 | 구분 |
|---|---|
| game-design-architect ↔ unity-code-reviewer | 코어 루프·시스템 "설계" ↔ C# 코드 품질·프레임 "리뷰" |
| game-design-architect ↔ multiplayer-rule-reviewer | 룰을 "설계" ↔ 그 룰이 서버에서 "강제되는지" 검증 |
| unity-code-reviewer ↔ multiplayer-rule-reviewer | Unity C# "엔진 코드" ↔ 엔진 무관 "룰·서버 권위"(MSW mlua) |
| debugger ↔ multiplayer-rule-reviewer | 이미 난 증상 "원인 규명" ↔ 증상 없이 룰·권위 "선제 점검" |
| save-data-reviewer ↔ migration-reviewer | 클라이언트·게임 "세이브" ↔ 서버 DB "마이그레이션" |
| save-data-reviewer ↔ multiplayer-rule-reviewer | 데이터가 "살아남는가" ↔ 값을 "누가 정하는가" |
| game-design-architect ↔ playtest-designer | "무엇을 검증할지"(재미 가설) ↔ "어떻게 검증할지"(프로토콜) |
| game-feel-reviewer ↔ game-ui-reviewer | 게임플레이 동작 피드백 ↔ UI 조작 피드백 |
| game-feel-reviewer ↔ playtest-designer | 손맛 장치·프로토타입 검증 항목 ↔ 검증 프로토콜 |
| unity-code-reviewer ↔ unity-perf-auditor | GC 유발 코드 "원인" ↔ 프레임 예산 "증상·측정 해석" |
| unity-build-auditor ↔ unity-perf-auditor | 텍스처 압축 "빌드 용량" ↔ "런타임 메모리·GPU" |
| game-localization-reviewer ↔ game-ui-reviewer | "문자열·폰트·번역 파이프라인" ↔ "레이아웃·스케일링·내비게이션" ⟵ 1.69 |
| game-test-strategy ↔ playtest-designer | **기계** 테스트(자동) ↔ **사람** 플레이테스트 ⟵ 1.69 |
| game-audio-reviewer ↔ game-feel-reviewer | 오디오 "믹싱·재생 구조" ↔ 사운드가 동작과 "동기화되는 타이밍" ⟵ 1.69 |
| game-audio-reviewer ↔ game-ui-reviewer | "그 소리가 어떻게 재생되는가"(믹서·중복·비용) ↔ "어떤 소리가 나야 하는가"(UI 조작음 일관성·무음 대체) ⟵ 1.71 |
| game-audio-reviewer ↔ unity-perf-auditor | 오디오 "구조·청감 품질" ↔ 오디오 "메모리·CPU 프레임 예산" ⟵ 1.69 |

**도메인 (ML · 회계 · 자동화, 4쌍)** — 1.69 신설
| 쌍 | 구분 |
|---|---|
| ml-experiment-reviewer ↔ test-strategy | ML "실험 설계"의 타당성(누출·검증 분할) ↔ "소프트웨어 테스트" 커버리지 |
| accounting-rule-reviewer ↔ data-modeler | 회계 "규칙이 코드로 강제되는가" ↔ 테이블·관계 "설계" |
| automation-reliability-reviewer ↔ observability-reviewer | 로컬 데몬·크론의 "운용 신뢰성" ↔ 웹 앱 런타임의 "추적 가능성" |
| automation-reliability-reviewer ↔ devops-reviewer | 상시 실행 자동화의 "생존·복구" ↔ CI/CD·컨테이너 "파이프라인 설정" |

**클러스터 교차 (게임 ↔ 웹, 7쌍)** — 1.52에서 양방향화
| 쌍 | 구분 |
|---|---|
| code-reviewer ↔ unity-code-reviewer | 웹(Next.js/FastAPI) 코드 ↔ Unity C# 게임 코드 |
| debugger ↔ unity-code-reviewer | 이미 난 런타임 오동작·크래시 "원인 규명"(스택 무관) ↔ 엔진 특유 결함 "정적 리뷰" |
| perf-auditor ↔ unity-perf-auditor | 웹 프론트 성능(번들·CWV) ↔ Unity 런타임 성능·렌더링 |
| system-architect ↔ game-design-architect | 풀스택 웹 아키텍처 ↔ 2D 캐주얼 게임 디자인·시스템 |
| devops-reviewer ↔ unity-build-auditor | 일반 CI/CD·시크릿·파이프라인 ↔ Unity 빌드/릴리스·스토어 제출 |
| test-strategy ↔ playtest-designer | 소프트웨어 자동 테스트 ↔ 사람 대상 플레이테스트 |
| game-test-strategy ↔ test-strategy | 게임(엔진 seam·EditMode/PlayMode·결정론) ↔ 웹(pytest·Vitest·Playwright) ⟵ 1.69 |

**시스템 언어 (C · 비-Unity .NET · Java · Swift, 7쌍)** — 1.72 신설, 2026-07-15 Java·Swift 확장
| 쌍 | 구분 |
|---|---|
| c-code-reviewer ↔ c-perf-auditor | C 성능 깎는 "코드 원인·UB" ↔ 캐시·할당 "증상·측정 해석" |
| dotnet-code-reviewer ↔ dotnet-perf-auditor | .NET 할당 유발 "코드 원인·EF 안티패턴" ↔ GC "증상·측정 해석" |
| dotnet-code-reviewer ↔ unity-code-reviewer | **비-Unity** C#(async·DI·EF Core) ↔ **Unity** C#(수명주기·GC·프레임) |
| c-architect ↔ system-architect | C 모듈·소유권 "설계" ↔ 웹 풀스택 "아키텍처" |
| dotnet-architect ↔ system-architect | .NET 계층·DI 수명 "설계" ↔ 웹 풀스택 "아키텍처" |
| java-architect ↔ system-architect | Java/Spring 계층·빈 수명 "설계" ↔ 웹 풀스택 "아키텍처" |
| swift-architect ↔ system-architect | Swift 앱 아키텍처·SwiftUI 상태 "설계" ↔ 웹 풀스택 "아키텍처" |

## 일방향 위임 포인터

특화 → 허브/일반/상위로만 가리키는 단방향(`→`). 허브 에이전트(code-reviewer 등)가 받는 모든 특화를 역으로 나열하면 description이 비대해지므로 역방향을 두지 않는다. 아래는 **대표 예시**이며 전수 목록은 아니다(허브로 들어오는 inbound 포인터는 이 외에도 여럿 — 예: system-architect가 받는 5건, code-reviewer가 받는 다수).

| 위임 | 역방향이 없는 이유 |
|---|---|
| test-strategy → code-reviewer | `code-reviewer`는 일반 폴백, 개별 특화로 되돌리지 않음 |
| perf-auditor → code-reviewer | 동일(일반 품질·버그 폴백) |
| code-reviewer → c-code-reviewer / dotnet-code-reviewer / java-code-reviewer / swift-code-reviewer | C·비-Unity C#·Java·Swift의 고유 결함은 전담이 폴백보다 우선(전담은 폴백을 역참조 안 함) ⟵ 1.72, Java·Swift 2026-07-15 |
| devops-reviewer → migration-reviewer | 마이그레이션 리뷰는 DB 영역 집중 |
| system-architect → api-contract-reviewer / data-modeler / security-reviewer | 설계가 구현 후 검증을 특화로 넘김(특화는 설계를 역참조 안 함) |
| ai-workspace-architect → system-architect / design-system-architect | 메타가 스택 설계를 넘길 뿐, 설계 에이전트는 메타를 역참조 안 함 |
| copy-reviewer → ai-workspace-architect | 보이스·프롬프트 시스템 설계로 넘기는 상향 포인터 |
| content-repurposer → copy-reviewer / seo-optimizer / fact-checker | 재활용 초안을 각 점검 에이전트로(점검 측은 생성기를 역참조 안 함) |
| storyteller → content-repurposer / copy-reviewer / brand-voice-guardian | 새로 지은 이야기를 매체 파생·카피·보이스로(점검·재활용 측은 창작 생성기를 역참조 안 함) |
| fact-checker → copy-reviewer / seo-optimizer / landing-reviewer | 사실 검증 후 문장·전환·검색은 각 특화로 |
| brand-voice-guardian → copy-reviewer / ai-workspace-architect | 일반 카피는 copy, 보이스 정의·시스템은 메타로 |
| threat-modeler → system-architect | 위협 모델이 구조 설계로 넘김 |
| llm-ai-security-reviewer → devops-reviewer | 모델 서빙·시크릿 인프라를 devops로 |
| game-ui-reviewer → ui-ux-reviewer | 웹 화면·WCAG·i18n은 웹 UI로(웹 UI는 게임을 역참조 안 함) |
| unity-build-auditor → unity-code-reviewer | keystore·설정 판정 후 코드 품질은 코드 리뷰로 |
| playtest-designer → test-runner | 사람 테스트와 별개인 자동 테스트 러너로 |
| debugger → perf-auditor / db-optimizer / unity-perf-auditor / security-reviewer | "무엇이 느린가"(병목)는 성능 3종, "취약점"은 보안으로. "언제부터 느려졌나"(회귀 시점)는 debugger 유지(역참조 없음) |

> **정정(1.56)**: 이전 문서는 `system-architect`를 "내보내는 위임이 없는 최상위 설계 에이전트"라 기술하고 `devops-reviewer → system-architect`를 일방향으로 분류했으나, 현재 `system-architect` description은 5개 특화(api-contract-reviewer·data-modeler·devops-reviewer·security-reviewer·game-design-architect)로 위임을 **내보낸다**. devops ↔ system-architect는 **대칭**(위 웹 표)으로 이동했다.

---

## 사용 예

```
/review                       # 현재 git 변경분 코드 리뷰
/sec src/auth                 # auth 폴더 보안 점검
/test tests/test_user.py      # 특정 테스트만 실행
/coverage src/services        # 커버리지 공백·약한 테스트 진단
/perf src/app                 # Next.js 프론트 성능 점검
/contract                     # 프론트-백 API 계약 정합성 점검
/apidoc                       # API 엔드포인트 문서화
/db                           # 쿼리/인덱스 성능 점검
/migrate                      # 스키마 마이그레이션 안전성 점검
/ui src/components            # 컴포넌트 UI/UX 점검
/dsystem                      # 디자인 시스템 설계
/datamodel 주문/결제 ERP 모델 설계해줘
/arch 실시간 알림 기능 구조 설계해줘
/devops                       # Docker·CI/CD·배포 설정 점검
/deps                         # 의존성 취약점·버전·라이선스 점검
/obs                          # 로깅·트레이싱·관측성 점검
/fable                        # AI 작업환경 진단·재설계(프롬프트·지침·모델별 전략)
/copy src/content             # 마케팅 카피 품질 리뷰
/landing                      # 상세페이지·랜딩 전환 구조 리뷰
/seo                          # 블로그·페이지 SEO 점검
/factcheck                    # 콘텐츠 사실·수치·출처 검증
/repurpose blog/post.md 릴스,카드뉴스   # 1소스 → 멀티 포맷 재활용
/voice                        # 브랜드 보이스(문체·톤) 일관성 점검
/threat 결제 연동 기능        # 설계 단계 위협 모델링(STRIDE)
/aisec                        # AI/LLM 보안 심화(OWASP LLM Top 10)
/ureview src/Player.cs        # Unity C# 게임 코드 리뷰
/gdd 원터치 점프 퍼즐 설계해줘   # 2D 캐주얼 게임 디자인·시스템 설계
/gui Assets/UI               # 게임 UI/UX(HUD·스케일링·내비) 점검
/feel Assets/Player          # 게임플레이 손맛(코요테·점프버퍼·피드백) 점검
/uperf ProjectSettings       # Unity 런타임 성능·렌더링 점검
/playtest 튜토리얼 없이 규칙 이해되나   # 플레이테스트 프로토콜 설계
/ubuild                      # 빌드/릴리스·스토어 제출 준비 점검
```

> 슬래시 명령은 추가 후 다음 세션부터 목록에 나타납니다.
> 자동 호출: 명령 없이 "보안 점검해줘"처럼 말해도 description을 보고 알맞은 에이전트가 선택됩니다.

---

## 관련 문서
- 디자인 에이전트 4종 상세: `design-agents.md`
- 저장소 안내: `CLAUDE.md`
