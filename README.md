# claude-agents

**Next.js + FastAPI + MySQL** 풀스택 개발을 위한 [Claude Code](https://claude.com/claude-code) 서브에이전트 모음입니다.
코드 리뷰·보안 점검·테스트·문서화·DB·디자인·아키텍처 설계를 각각 전문 에이전트가 담당합니다. 여기에 더해, 개발 스택과 무관하게 **AI 작업환경·프롬프트 시스템 자체**를 재설계하는 메타 에이전트 1종(`ai-workspace-architect`)과, **마케팅 카피·상세페이지·SEO·팩트체크·콘텐츠 재활용·브랜드 보이스**를 다루는 콘텐츠 에이전트 6종(`copy-reviewer`·`landing-reviewer`·`seo-optimizer`·`fact-checker`·`content-repurposer`·`brand-voice-guardian`)이 포함됩니다. 여기에 프롬프트(뼈대)에 살을 붙여 이야기를 짓는 **창작 특화(Fable) 스토리 생성 에이전트 1종**(`storyteller`)이 더해집니다. 여기에 강의·워크숍·강좌·교육 자료의 교수 설계(학습자 분석·측정 가능한 학습 목표·모듈 계열화·목표-평가-활동 정렬)를 맡는 **교육/교수설계 에이전트 1종**(`curriculum-designer`)이 더해집니다. 보안 계열은 코드 취약점(`security-reviewer`)에 더해 **설계 단계 위협 모델링(`threat-modeler`)과 AI/LLM 보안 심화(`llm-ai-security-reviewer`)**까지 다룹니다. 여기에 더해 **Unity + C# 게임 개발(싱글플레이어 2D 캐주얼)**을 위한 게임 도메인 에이전트 7종(`unity-code-reviewer`·`game-design-architect`·`game-ui-reviewer`·`game-feel-reviewer`·`unity-perf-auditor`·`playtest-designer`·`unity-build-auditor`)이 시범 추가되었습니다(🎮 게임 클러스터). 여기에 더해 **C와 비-Unity C#/.NET**을 전담하는 시스템 언어 에이전트 6종(`c-code-reviewer`·`c-architect`·`c-perf-auditor`·`dotnet-code-reviewer`·`dotnet-architect`·`dotnet-perf-auditor`)이 추가되었습니다(🧩 시스템 언어 클러스터 — 각 언어를 리뷰·설계·성능 3역으로). 이어 이 클러스터를 **Java(JVM)·Swift**로 넓혀 4종(`java-code-reviewer`·`java-architect`·`swift-code-reviewer`·`swift-architect`)을 추가했는데, C/.NET처럼 3역 트리오가 아니라 **리뷰어+아키텍트 2역씩**만 두고 **전담 perf 에이전트는 의도적으로 만들지 않았다**(프로모션 게이트 — 각 언어의 성능 점검 수요가 실제로 반복될 때까지 유보하고, 리뷰어가 그 공백을 "알려진 공백"으로 명시). 가장 최근에는 주제·문제만 있고 구체 아이디어가 없을 때 **발산(다각도 렌즈)→수렴(기준 채점)**으로 고를 수 있는 후보 목록을 만드는 **브레인스토밍 에이전트 1종**(`brainstormer`)이 더해졌습니다 — 모든 실행(오퍼·이야기·게임 설계·강의 설계) 앞단의 아이디어 단계를 전담합니다.

- 에이전트 수: **73종** (개발 스택 리뷰·엔지니어링·문서 19종 + 시스템 언어 C/.NET/Java/Swift 10종 + 도메인 3종(ML·회계·자동화) + 메타 3종 + 검증 1종 + 콘텐츠/마케팅 8종 + 교육 1종 + 창작 1종 + 발상 1종 + 커리어 1종 + 보안 심화 2종 + 게임 13종 + 인프라 3종 + AI검색·영상·이미지·제안서 4종)
- 언어: 한국어 프롬프트
- 성격: **읽기 전용** — 분석·리뷰·설계·제안만 하고 코드/스키마를 직접 수정하지 않음
- 현재 버전: `db-optimizer` **v1.10**, `security-reviewer` **v1.14**, `test-runner` **v1.11**, `code-reviewer` **v1.16**(Flask 흡수), `devops-reviewer` **v1.9**, `data-modeler` **v1.7**, `api-doc-writer` **v1.7**, `ui-ux-reviewer` **v1.6**, `system-architect` **v1.8**, `perf-auditor` **v1.5**, `design-system-architect` **v1.6**·`test-strategy` **v1.5**, `observability-reviewer` **v1.4**·`migration-reviewer` **v1.3**, `api-contract-reviewer`·`dependency-auditor` **v1.1**, 메타 3종 `ai-workspace-architect` **v1.4**·`agent-definition-reviewer` **v1.1**·`project-manager` **v1.0**, 콘텐츠/마케팅 8종 `copy-reviewer` **v1.2**·`content-repurposer` **v1.4**·`landing-reviewer` **v1.2**·`seo-optimizer` **v1.1**·`brand-voice-guardian` **v1.0**·`fact-checker` **v1.1**·`email-sequence-writer` **v1.0**·`offer-strategist` **v1.2**, 발상 `brainstormer` **v1.0**, 교육 `curriculum-designer` **v1.1**, 보안 심화 `threat-modeler`·`llm-ai-security-reviewer` **v1.2**, 조율 `project-manager` **v1.0**, 게임 9종 `unity-code-reviewer` **v1.5**·`game-design-architect` **v1.6**·`game-feel-reviewer` **v1.3**·`game-ui-reviewer` **v1.3**·`playtest-designer` **v1.2**·`unity-build-auditor`·`multiplayer-rule-reviewer`·`unity-perf-auditor` **v1.1**·`save-data-reviewer` **v1.0**, 인프라 2종 `memory-recaller` **v1.4**·`self-reflector` **v1.1**, 검증 `truth-checker` **v1.0**, 엔지니어링 `refactor-strategist` **v1.1**, 문서 `docs-writer` **v1.2**, 창작 `storyteller` **v1.1**, 커리어 `cover-letter-tailor` **v1.0**, 디버깅 `debugger` **v1.5**, 시스템 언어 C/.NET/Java/Swift 10종 `c-code-reviewer`·`c-architect`·`c-perf-auditor`·`dotnet-code-reviewer`·`dotnet-architect`·`dotnet-perf-auditor`·`java-code-reviewer`·`java-architect`·`swift-code-reviewer`·`swift-architect` **v1.0** , 1.92 신설 9종 `ai-code-auditor`·`codebase-archaeologist`·`identity-access-architect`·`video-optimizer`·`ai-search-optimizer`·`image-prompt-engineer`·`proposal-strategist`·`level-designer`·`knowledge-gardener` **v1.0** — 상세 이력은 [CHANGELOG.md](CHANGELOG.md)
- 추론 강도(`effort`): opus 심층추론 68종은 frontmatter `effort: high`로 고정해 세션 설정과 무관하게 추론 깊이를 보장하고, 그중 **`xhigh` 7종**(`security-reviewer`·`threat-modeler`·`llm-ai-security-reviewer`·`ai-workspace-architect`·`truth-checker`·`ai-code-auditor`·`identity-access-architect`)은 더 깊게 돈다. 창작 에이전트 `storyteller`는 `fable` 모델 + `effort: high`로 창작 품질 플로어를 둔다(저장소 첫 `fable` 에이전트). `sonnet`·`haiku`(api-doc-writer·test-runner·memory-recaller·self-reflector)는 세션 상속 — 상세는 [CHANGELOG.md](CHANGELOG.md) effort 튜닝 요약

---

## 목차
- [에이전트 64종](#에이전트-73종)
- [공통 규칙](#공통-규칙)
- [설치 / 등록](#설치--등록)
- [사용 방법](#사용-방법)
- [슬래시 명령](#슬래시-명령)
- [바탕화면 런처](#바탕화면-런처)
- [버전 관리](#버전-관리)
- [업데이트 워크플로우](#업데이트-워크플로우)
- [저장소 구조](#저장소-구조)

---

## 에이전트 73종

**관련된 것끼리 묶은 표**다(추가된 순서가 아니라 역할 기준). 각 표 안에서는 `#` 오름차순으로 정렬했다(예외: 📣 콘텐츠/마케팅 표는 **마케팅 → 창작 → 교육 → 커리어** 하위 묶음 순서를 번호보다 우선한다). `#`은 아래 상세 블록의 번호와 같아서 번호를 따라가면 그 에이전트의 상세를 찾을 수 있다(상세 블록 자체는 번호순이 아니라 클러스터별로 묶여 있다). 번호는 **1~73 연속이며 결번이 없다** — `#1`은 모든 에이전트 위에 앉는 진입/조율 층인 `project-manager`, `#2`부터는 대체로 추가된 순서다. 번호는 상세 블록을 찾는 **인덱스일 뿐 추가 시점을 뜻하지 않으며**, 새 에이전트는 다음 번호(`#74`…)를 이어 받는다.

#### 🔍 코드 품질 · 디버깅 · 테스트

| # | 에이전트 | 슬래시 | 버전 | 모델 | 역할 | 도구 |
|---|---|---|---|---|---|---|
| 2 | `code-reviewer` | `/review` `/리뷰` | 1.16 | opus | 코드 품질·가독성·버그 리뷰(FastAPI+**Flask** · 증상 없는 정적 탐색 · 타 스택 폴백) | Read, Grep, Glob, Bash |
| 4 | `test-runner` | `/test` `/테스트` | 1.11 | sonnet | 테스트 실행·실패 분석(1차 원인 분류) | Bash, Read, Grep, Glob |
| 5 | `test-strategy` | `/coverage` `/커버리지` | 1.5 | opus | 테스트 커버리지 공백·약한 테스트 진단(웹 스택) | Read, Grep, Glob |
| 35 | `refactor-strategist` | `/refactor` `/리팩터` | 1.1 | opus | 동작 보존 리팩터 계획·단계 설계(추출·중복·의존·seam) | Read, Grep, Glob |
| 39 | `debugger` | `/debug` `/디버그` | 1.5 | opus | 이미 난 버그·에러·간헐 실패의 근본 원인 규명(재현·가설 검증·이분 탐색) | Read, Grep, Glob, Bash |
| 43 | `ml-experiment-reviewer` | `/ml` `/머신러닝` | 1.0 | opus | **ML 실험 설계 감사**(미래 정보 누출·검증 분할·백테스트 현실성·과적합) | Read, Grep, Glob |
| 66 | `codebase-archaeologist` | `/archaeo` `/코드고고학` | 1.0 | opus | **누적 로직 드리프트 발굴**(병렬 구현·폴백 역전·상태 존재 가정·단위 불일치 · 4뷰 레지스트리) | Read, Grep, Glob, Bash |

#### 🔒 보안 (설계 단계 → 코드 → AI/LLM 3단 방어)

| # | 에이전트 | 슬래시 | 버전 | 모델 | 역할 | 도구 |
|---|---|---|---|---|---|---|
| 3 | `security-reviewer` | `/sec` `/보안` | 1.14 | opus | 코드 보안 취약점(OWASP) 점검 — 구현 **후**(+ C 메모리안전=보안 층은 c-code-reviewer로) | Read, Grep, Glob, WebSearch, WebFetch |
| 25 | `threat-modeler` | `/threat` | 1.2 | opus | 설계 단계 위협 모델링(STRIDE) — 구현 **전** | Read, Grep, Glob, WebSearch, WebFetch |
| 26 | `llm-ai-security-reviewer` | `/aisec` | 1.2 | opus | AI/LLM 보안 심화(OWASP LLM Top 10) | Read, Grep, Glob, WebSearch, WebFetch |
| 65 | `ai-code-auditor` | `/aicode` `/에이아이코드` | 1.0 | opus | **AI 생성 코드 감사**(클라 도달 시크릿·RLS 허울·프롬프트 인젝션 싱크 · CWE 매핑 · scan→fix→rescan) | Read, Grep, Glob, WebSearch, WebFetch |

#### 🗄 데이터 / DB

| # | 에이전트 | 슬래시 | 버전 | 모델 | 역할 | 도구 |
|---|---|---|---|---|---|---|
| 9 | `db-optimizer` | `/db` `/디비` | 1.10 | opus | MySQL 쿼리·인덱스 **성능 튜닝** | Read, Grep, Glob, Bash |
| 10 | `migration-reviewer` | `/migrate` `/마이그레이션` | 1.3 | opus | 스키마 마이그레이션 **안전성**(락·백필·롤백) — 서버 DB 전용 | Read, Grep, Glob |
| 13 | `data-modeler` | `/datamodel` `/데이터모델` | 1.7 | opus | 데이터 모델/스키마 **설계**(ERD·키·제약) | Read, Grep, Glob |
| 42 | `accounting-rule-reviewer` | `/acct` `/회계` | 1.0 | opus | **복식부기 규칙 감사**(차대 균형·역분개·마감 차단·금액 타입·잔액 정합) | Read, Grep, Glob |

#### 🏗 아키텍처 · API · 문서

| # | 에이전트 | 슬래시 | 버전 | 모델 | 역할 | 도구 |
|---|---|---|---|---|---|---|
| 7 | `api-contract-reviewer` | `/contract` `/계약` | 1.1 | opus | 프론트-백 API 계약 정합성 점검 | Read, Grep, Glob |
| 8 | `api-doc-writer` | `/apidoc` | 1.7 | sonnet | FastAPI 엔드포인트 카탈로그 | Read, Grep, Glob, Context7 |
| 14 | `system-architect` | `/arch` `/아키텍처` | 1.8 | opus | 시스템 아키텍처 설계(계층·경계·확장성) | Read, Grep, Glob, Context7 |
| 36 | `docs-writer` | `/docs` `/문서` | 1.2 | opus | 개발자용 기술문서(README·아키텍처·온보딩·ADR) | Read, Grep, Glob |
| 67 | `identity-access-architect` | `/autharch` `/인증설계` | 1.0 | opus | **인증·인가·세션 구조 설계**(플로우 검증·세션 결정표·패스키·SSO/SCIM·테넌트 격리) | Read, Grep, Glob, Context7 |

#### 🎨 프론트엔드 (화면 · 디자인 · 성능)

| # | 에이전트 | 슬래시 | 버전 | 모델 | 역할 | 도구 |
|---|---|---|---|---|---|---|
| 6 | `perf-auditor` | `/perf` `/성능` | 1.5 | opus | Next.js **프론트 전용** 성능(번들·CWV·캐싱 · 파이썬 백엔드 런타임 성능은 범위 밖=알려진 공백) | Read, Grep, Glob |
| 11 | `ui-ux-reviewer` | `/ui` `/화면` | 1.6 | opus | UI/UX·접근성·반응형·다크패턴 점검 | Read, Grep, Glob |
| 12 | `design-system-architect` | `/dsystem` | 1.6 | opus | 디자인 토큰·컴포넌트 설계(DESIGN.md) | Read, Grep, Glob, Context7 |

#### 🚀 운영 (배포 · 의존성 · 관측성)

| # | 에이전트 | 슬래시 | 버전 | 모델 | 역할 | 도구 |
|---|---|---|---|---|---|---|
| 15 | `devops-reviewer` | `/devops` `/배포` | 1.9 | opus | Docker·CI/CD·배포 설정 점검 | Read, Grep, Glob |
| 16 | `dependency-auditor` | `/deps` `/의존성` | 1.1 | opus | 의존성 취약점·버전·라이선스 점검 | Read, Grep, Glob, Bash |
| 17 | `observability-reviewer` | `/obs` `/관측성` | 1.4 | opus | 로깅·트레이싱·관측성 점검(웹 앱 런타임) | Read, Grep, Glob |
| 44 | `automation-reliability-reviewer` | `/auto` `/자동화` | 1.1 | opus | **데몬·크론 자동화 신뢰성**(로그 유실·중복 실행·하트비트·멱등성) | Read, Grep, Glob |

#### 🎮 게임 (Unity + C# 싱글플레이 2D 캐주얼 · MSW 멀티플레이)

| # | 에이전트 | 슬래시 | 버전 | 모델 | 역할 | 도구 |
|---|---|---|---|---|---|---|
| 27 | `unity-code-reviewer` | `/ureview` | 1.5 | opus | Unity C# 코드 리뷰(수명주기·GC·프레임/물리 · Fast Enter Play Mode · 비-Unity .NET은 dotnet-code-reviewer로) | Read, Grep, Glob, Bash |
| 28 | `game-design-architect` | `/gdd` | 1.6 | opus | 게임 디자인·시스템 설계(코어 루프·난이도·수직 슬라이스, 엔진 무관) | Read, Grep, Glob |
| 29 | `game-ui-reviewer` | `/gui` | 1.3 | opus | 게임 UI/UX(HUD·스케일링·내비·가독성, UGUI/UI Toolkit 분기) | Read, Grep, Glob |
| 30 | `game-feel-reviewer` | `/feel` | 1.3 | opus | 손맛/juice(입력 관대성·히트스톱·카메라 + 페이즈/턴 기반 피드백) | Read, Grep, Glob |
| 31 | `unity-perf-auditor` | `/uperf` | 1.1 | opus | 런타임 성능·렌더링(배칭·오버드로우·메모리·Profiler) | Read, Grep, Glob |
| 32 | `playtest-designer` | `/playtest` | 1.2 | opus | 플레이테스트 설계(가설·참가자·지표 + 다인 동시 세션) | Read, Grep, Glob |
| 33 | `unity-build-auditor` | `/ubuild` | 1.1 | opus | 빌드/릴리스·스토어 제출(+ **2026 정책: API 36·16KB·연령등급**) | Read, Grep, Glob |
| 40 | `multiplayer-rule-reviewer` | `/rule` `/룰` | 1.1 | opus | **멀티플레이 룰 정합성·서버 권위 점검**(MSW mlua — 상태머신·판정 누락·클라 입력 검증·은닉 정보) | Read, Grep, Glob |
| 41 | `save-data-reviewer` | `/save` `/세이브` | 1.0 | opus | **세이브·영속 데이터 호환성**(스키마 버전·마이그레이션·직렬화 리네이밍·손상 복구·클라우드 충돌) | Read, Grep, Glob |
| 45 | `game-localization-reviewer` | `/gloc` `/현지화` | 1.1 | opus | **현지화 준비**(하드코딩 문자열·폰트 글리프·길이 팽창·어순·폴백) | Read, Grep, Glob |
| 46 | `game-test-strategy` | `/gtest` `/게임테스트` | 1.1 | opus | **게임 자동 테스트 전략**(엔진 의존 seam·EditMode/PlayMode·결정론적 리플레이) | Read, Grep, Glob |
| 47 | `game-audio-reviewer` | `/gaudio` `/오디오` | 1.1 | opus | **오디오 구현**(믹서 버스·동시 발음·반복 피로·임포트·BGM 전환) | Read, Grep, Glob |
| 72 | `level-designer` | `/level` `/레벨` | 1.0 | opus | **레벨·스테이지 공간 설계**(흐름·불공정 사망 차단·페이싱·블록아웃 규율) | Read, Grep, Glob |

#### 🧩 시스템 언어 (C · 비-Unity .NET · Java · Swift)

C·.NET은 각 언어를 **리뷰 · 설계 · 성능** 3역으로 나눴다(웹·게임 트리오와 동형). 리뷰↔성능은 **원인/증상 대칭**. Java·Swift는 프로모션 게이트에 따라 **리뷰어+아키텍트 2역씩**만 두고 **전담 perf는 의도적 미생성**(공백은 각 리뷰어가 명시).

| # | 에이전트 | 슬래시 | 버전 | 모델 | 역할 | 도구 |
|---|---|---|---|---|---|---|
| 48 | `c-code-reviewer` | `/creview` | 1.0 | opus | **C 코드 리뷰**(메모리 안전·UB·정수 변환·에러경로 누수·포맷 취약점) | Read, Grep, Glob, Bash |
| 49 | `c-architect` | `/carch` | 1.0 | opus | **C 구조 설계**(모듈/헤더·메모리 소유권 계약·에러 규약·빌드/이식성) | Read, Grep, Glob |
| 50 | `c-perf-auditor` | `/cperf` | 1.0 | opus | **C 런타임 성능**(캐시 지역성·할당·복잡도·프로파일 해석) | Read, Grep, Glob |
| 51 | `dotnet-code-reviewer` | `/dnreview` | 1.0 | opus | **비-Unity C#/.NET 리뷰**(async 데드락·IDisposable·지연실행·DI 수명·EF Core) | Read, Grep, Glob, Bash |
| 52 | `dotnet-architect` | `/dnarch` | 1.0 | opus | **.NET 구조 설계**(계층·DI 수명·미들웨어·호스팅·async 경계) | Read, Grep, Glob, Context7 |
| 53 | `dotnet-perf-auditor` | `/dnperf` | 1.0 | opus | **.NET 런타임 성능**(GC 압력·LOH·Span/ArrayPool·박싱·벤치마크 해석) | Read, Grep, Glob |
| 55 | `java-code-reviewer` | `/jreview` | 1.0 | opus | **Java(JVM) 코드 리뷰**(NPE·Optional 오용·예외 정책·자원 누수·동시성·equals/hashCode·오토박싱 ==·Stream 부작용 · 전담 perf 없음) | Read, Grep, Glob, Bash |
| 56 | `java-architect` | `/jarch` | 1.0 | opus | **Java/Spring 구조 설계**(계층 분리·빈 수명/생성자 주입·모듈 의존 방향·에러 전략·트랜잭션 경계·영속성 OSIV) | Read, Grep, Glob, Context7 |
| 57 | `swift-code-reviewer` | `/swreview` | 1.0 | opus | **Swift 코드 리뷰**(강제 언랩 크래시·ARC retain cycle·값/참조·에러 삼킴·동시성 actor/@MainActor/Sendable·열거 망라·Codable · 전담 perf 없음) | Read, Grep, Glob, Bash |
| 58 | `swift-architect` | `/swarch` | 1.0 | opus | **Swift 앱 구조 설계**(MVVM/TCA·SPM 모듈 경계·DI·동시성 아키텍처·SwiftUI 상태 관리·내비게이션·값 타입 도메인) | Read, Grep, Glob, Context7 |

#### 📣 콘텐츠 / 마케팅

| # | 에이전트 | 슬래시 | 버전 | 모델 | 역할 | 도구 |
|---|---|---|---|---|---|---|
| 19 | `copy-reviewer` | `/copy` `/카피` | 1.2 | opus | 마케팅 카피 품질 리뷰(후킹·CTA·과장/윤리) | Read, Grep, Glob |
| 20 | `landing-reviewer` | `/landing` | 1.2 | opus | 상세페이지·랜딩 전환 구조 리뷰 | Read, Grep, Glob |
| 21 | `seo-optimizer` | `/seo` | 1.1 | opus | 블로그·페이지 SEO 점검 | Read, Grep, Glob, WebSearch, WebFetch |
| 22 | `fact-checker` | `/factcheck` | 1.1 | opus | 콘텐츠 사실·수치·출처 검증 | Read, Grep, Glob, WebSearch, WebFetch |
| 23 | `content-repurposer` | `/repurpose` | 1.4 | opus | 1소스 → 멀티 포맷 재활용(단발 뉴스레터까지) | Read, Grep, Glob |
| 24 | `brand-voice-guardian` | `/voice` | 1.0 | opus | 브랜드 보이스(문체·톤) 일관성 점검 | Read, Grep, Glob |
| 61 | `email-sequence-writer` | `/email` `/이메일` | 1.0 | opus | 이메일/라이프사이클 시퀀스 생성(웰컴·런칭·너처·재참여·콜드아웃리치, 타이밍·제목·CTA) | Read, Grep, Glob |
| 62 | `offer-strategist` | `/offer` `/오퍼` | 1.2 | opus | 카피 앞단 오퍼 설계(가치제안·가격 티어·보증·보너스·포지셔닝) | Read, Grep, Glob |
| 64 | `brainstormer` | `/brainstorm` `/발상` | 1.0 | opus | 아이디어 발산(다각도 렌즈)→수렴(기준 채점) 브레인스토밍 — 번호 표·Top 3+와일드카드, 모든 실행 앞단 | Read, Grep, Glob |
| 38 | `storyteller` | `/story` `/이야기` | 1.1 | **fable** | 프롬프트(뼈대)에 살 붙여 완성형 이야기 작성 | Read, Grep, Glob |
| 54 | `curriculum-designer` | `/curriculum` `/강의설계` | 1.1 | opus | 강의·워크숍·강좌 교수 설계(학습 목표·모듈 계열화·backward design·슬라이드 골격) | Read, Grep, Glob |
| 59 | `cover-letter-tailor` | `/cover` `/자소서` | 1.0 | opus | 채용 공고(JD)에 맞춰 자기소개서 맞춤 재작성(역량 매핑·STAR·글자수·사실만·공백 표시) | Read, Grep, Glob |
| 68 | `video-optimizer` | `/video` `/영상` | 1.0 | opus | **유튜브 최적화**(제목 3방향·썸네일·훅 초단위·챕터·숏폼) + 키즈 채널 분기 규칙 | Read, Grep, Glob, WebSearch, WebFetch |
| 69 | `ai-search-optimizer` | `/aeo` `/에이아이검색` | 1.0 | opus | **AI 검색·인용 최적화**(기반 감사 + 인용 감사) — seo-optimizer 보완층 | Read, Grep, Glob, WebSearch, WebFetch |
| 70 | `image-prompt-engineer` | `/imgprompt` `/이미지프롬프트` | 1.0 | opus | **AI 이미지 프롬프트 5계층 설계** + 권리 경계(실존 인물·브랜드 거부) | Read, Grep, Glob |
| 71 | `proposal-strategist` | `/proposal` `/제안서` | 1.0 | opus | **제안서 전략**(승리 테마·3막 서사·경영진 요약) — 1인 규모 환산 | Read, Grep, Glob |

#### 🧭 메타 / 인프라 (내 작업환경 자체)

| # | 에이전트 | 슬래시 | 버전 | 모델 | 역할 | 도구 |
|---|---|---|---|---|---|---|
| 1 | `project-manager` | `/pm` `/프로젝트관리` | 1.0 | opus | **프로젝트 조율**(태스크 분해·의존성·우선순위·전문 에이전트 라우팅 맵·순서/마일스톤·진행 현황) — 오케스트레이터 아님(계획을 텍스트로 냄) | Read, Grep, Glob, Bash |
| 18 | `ai-workspace-architect` | `/fable` | 1.4 | opus | AI 작업환경 진단·재설계(프롬프트·CLAUDE.md·SKILL.md·모델별 전략) | Read, Grep, Glob, WebSearch, WebFetch |
| 34 | `memory-recaller` | `/recall` `/회상` | 1.4 | **haiku** | 파일 기반 장기기억 회상(`E:\claude_memory`) — 값싼 Haiku 회상 | Read, Grep, Glob |
| 37 | `agent-definition-reviewer` | `/agentdef` | 1.1 | opus | 이 라이브러리의 에이전트 정의(.md) 스펙·경계·규범 점검 | Read, Grep, Glob |
| 60 | `self-reflector` | `/reflect-log` `/누적회고` | 1.1 | **haiku** | 누적 관찰 로그(`_observations`) 교차 세션 증류 → 학습 후보 제안(신뢰도·증거 기반, 자기개선 루프) | Read, Grep, Glob |
| 63 | `truth-checker` | `/truth` `/진실검증` | 1.0 | opus | **질문·주장 정확성 검증**(5분류·날조 금지·근거 기반 신뢰도 0~1·0.8 미만 재작성 · [명확한 답변]/[신뢰도]/[확인할 점]) | Read, Grep, Glob, WebSearch, WebFetch |
| 73 | `knowledge-gardener` | `/garden` `/지식정원` | 1.0 | opus | **지식베이스 구조 위생**(고립 노트·인덱스 커버리지·상록 승격) — 읽기 전용 | Read, Grep, Glob |

### 🧭 진입 / 조율 (#1 — 모든 에이전트 위에 앉는 조율 층)

<details>
<summary><b>1. project-manager</b> (<code>/pm</code>) — 프로젝트 조율 (메타/조율)</summary>

- **언제**: 여러 작업·기능·레포에 걸친 일을 실행 계획으로 옮기기 전, 스프린트·마일스톤을 짜기 전, 진행 현황을 점검할 때. "어디서부터·어떤 순서로·누구에게 시킬지 모르겠다"
- **전제**: **서브에이전트는 오케스트레이터가 아님** — 서브에이전트는 다른 서브에이전트를 호출 못 하므로(오케스트레이션은 메인 세션/Workflow 등 "위층"에 있음), 이 에이전트는 일을 굴리지 않고 계획·라우팅 맵·진행 현황을 **텍스트로 산출**한다. 코드·파일 미수정
- **두 층(두뇌+팔)**: 자동 실행이 필요하면 `/pm-run`(`/프로젝트실행`) → **`pm-orchestrate` 워크플로**가 이 에이전트를 계획 두뇌로 부른 뒤 라우팅된 전문 에이전트들을 실제로 팬아웃 실행하고 통합 보고한다. 전문 에이전트가 전부 읽기 전용이라 통합 리포트를 내며, 실제 코드 편집은 메인 세션/사람 후속 단계. `/pm`은 계획만, `/pm-run`은 계획+실행
- **조율**: 태스크 분해(WBS)·의존성(순환 의존=결함)·우선순위(P0~P2)·**라우팅 맵**(각 태스크 → 이 라이브러리의 알맞은 전문 에이전트, 없으면 "담당 없음")·실행 순서/마일스톤·리스크/차단
- **진행 현황**: `E:\claude_memory\project_active.md`·최신 날짜 인덱스·`git log`/`status`로 완료/진행 중/다음(P0)/차단을 보고(Bash는 읽기 전용 이력 파악 전용, 트리 변경 없음)
- **출력**: (계획) 목표/범위/가정 → WBS 표 → 라우팅 맵 → 실행 순서/마일스톤 → 리스크·차단·다음 착수 / (점검) 완료 → 진행 중 → 다음(P0) → 차단
- **구분**: 한 기능의 기술 구조는 `system-architect`, 게임 시스템은 `game-design-architect`, 한 작업의 구현 단계 계획은 harness `Plan` 빌트인, 리팩터 단계는 `refactor-strategist`, 원인 규명은 `debugger`, AI 작업환경 재설계는 `ai-workspace-architect`, 메모리 회상만은 `memory-recaller`
</details>

### 🔍 품질 / QA

<details>
<summary><b>2. code-reviewer</b> (<code>/review</code>) — 코드 품질·버그 리뷰</summary>

- **언제**: 커밋/PR 전 셀프 리뷰, 리팩터링 검토
- **범위 결정**: `git diff` / `git diff --staged`로 변경분을 파악해 그 범위에 집중 (Bash는 범위 식별 전용, 실행·수정 금지)
- **백엔드(FastAPI)**: Pydantic 스키마·타입힌트, async 일관성(블로킹 I/O), DB 세션/트랜잭션 경계, 예외 처리, 계층 분리
- **프론트(Next.js)**: 서버/클라 컴포넌트 경계, 데이터 페칭·캐싱, useEffect 의존성, 로딩/에러 처리, 타입 안전성
- **Next.js 15/16(v1.4)**: Server Actions 보안(서버 재검증·인가), `use cache`/Cache Components 오캐시, React Compiler 도입 시 중복 수동 메모 (버전 불명확하면 "확인 필요")
- **출력**: 요약 → Must fix → Should fix → Nit (분류 내 영향도순, `파일:줄` 명시)
- **구분**: 보안 전용은 `security-reviewer`, 시각·접근성·UX는 `ui-ux-reviewer`, 프론트-백 API 계약 정합은 `api-contract-reviewer`, 로깅·관측성은 `observability-reviewer`, 동작 보존 리팩터 계획은 `refactor-strategist`, 이미 발생한 증상의 원인 규명은 `debugger`(v1.11 — 코드리뷰는 증상 없이 변경분에서 잠재 결함을 찾음)
</details>

<details>
<summary><b>3. security-reviewer</b> (<code>/sec</code>) — 보안 취약점 점검</summary>

- **언제**: PR/새 기능 머지 전, 보안 점검 필요 시
- **기준**: OWASP Top 10 (2025) — A03 공급망·A10 예외 처리 오류(fail-open) 포함
- **점검**: 인증/인가(라우터 레벨 의존성까지 확인해 오탐 방지), IDOR/BOLA·BFLA·WebSocket(CSWSH), **Next.js 미들웨어 인가 우회(CVE-2025-29927)**, **Server Actions/Route Handler 내부 인가·입력 재검증(v1.10)**, RBAC, 경로 탐색, JWT(알고리즘 고정·alg confusion·kid/jku 헤더 주입·exp·저장 위치), 인젝션(SQL·SSTI·OS/NoSQL), XSS, 과잉 응답(API3, response_model), CSRF/SSRF, Mass Assignment/BOPLA, CORS
- **LLM 보안(v1.4, OWASP LLM Top 10 2025)**: 간접 프롬프트 인젝션(LLM01), 출력 처리(LLM05), 과도한 행위성(LLM06, 도구 권한·human-in-the-loop), 벡터/임베딩 약점(LLM08, RAG 포이즈닝·테넌트 격리), 시스템 프롬프트 유출(LLM02), 무제한 소비(LLM10)
- **출력**: 심각도(Critical~Low)순 + "즉시 고쳐야 할 Top 3"
- **구분(v1.5)**: 일반 코드 품질·버그는 `code-reviewer`, 배포·CI 설정·시크릿 취급은 `devops-reviewer`, 의존성 취약·버전·라이선스는 `dependency-auditor`
</details>

<details>
<summary><b>4. test-runner</b> (<code>/test</code>) — 테스트 실행·분석</summary>

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
<summary><b>5. test-strategy</b> (<code>/coverage</code>) — 테스트 커버리지·약한 테스트 진단</summary>

- **언제**: 테스트가 회귀를 실제로 잡는지 점검, 보강할 케이스 설계
- **점검**: 커버리지 공백(분기·경계·에러·인증 경로), 약한 단언(change-detector·목 그린·단언 약함), 테스트 구조(중복·플레이키), 스택별 핵심 경로
- **원칙**: 통과(green)가 품질의 증거가 아니다 — 통과해도 약한 테스트는 지적. 테스트 코드를 직접 작성하지 않고 케이스를 설계(요청 시 단언 골격 예시)
- **출력**: 요약 → 커버리지 공백(입력→기대결과) → 약한 테스트(왜·어떻게 바꿀지) → 제안
- **구분**: 테스트 실행·실패 진단은 `test-runner`, 일반 코드 품질은 `code-reviewer`
</details>

<details>
<summary><b>6. perf-auditor</b> (<code>/perf</code>) — Next.js 프론트 성능 점검</summary>

- **언제**: "화면이 느리다", "번들이 크다", 배포 전 성능 점검
- **점검**: 번들/코드 스플리팅, 서버/클라 경계, 데이터 페칭·캐싱(워터폴), 이미지/폰트(next/image·next/font), 렌더 비용(리렌더·가상화), Core Web Vitals(LCP/CLS/INP)
- **Next.js 15/16(v1.2)**: Cache Components/`use cache` opt-in 누락·오캐시, PPR 정적 셸+Suspense 경계, React Compiler 자동 메모와 중복되는 수동 메모 (버전 불명확하면 "확인 필요")
- **원칙**: 빌드를 실행하지 않는 정적 분석 — 측정이 필요한 항목은 "확인 필요(빌드 분석 권장)"로 표시
- **출력**: 요약 → 지표를 크게 해치는 Top 3(작용 지표 명시) → 주의 → 제안
- **구분**: 시각·접근성은 `ui-ux-reviewer`, MySQL 성능은 `db-optimizer`, 정확성·버그는 `code-reviewer`
</details>

<details>
<summary><b>7. api-contract-reviewer</b> (<code>/contract</code>) — 프론트-백 API 계약 정합성 점검</summary>

- **언제**: 프론트-백 연동 직후, API 계약 변경 머지 전
- **가정**: 프론트와 백엔드는 서로 다른 시점·다른 사람이 고친다 → 한쪽만 바뀌면 런타임에서 깨진다
- **점검**: 요청/응답 필드·타입 일치, 필수/옵셔널·널·enum 차이, 타입 드리프트(수기 중복 vs OpenAPI 생성 타입 동기화), 경로·메서드·상태코드, 깨지는 변경(필드 제거·이름·타입 축소·필수화), 페이지네이션·공통 래퍼·인증/Content-Type
- **출력**: 요약 → 불일치 Top 3(`프론트:줄` ↔ `백엔드:줄`, 어느 쪽을 맞출지) → 주의 → 제안
- **구분**: 한쪽 코드 품질·버그는 `code-reviewer`, 백엔드 엔드포인트 카탈로그·문서화는 `api-doc-writer`
</details>

### 📚 문서 / DB

<details>
<summary><b>8. api-doc-writer</b> (<code>/apidoc</code>) — API 문서화</summary>

- **언제**: 프론트 연동 전 API 명세 파악, 미문서화 엔드포인트 발견
- **수집**: 라우터/WebSocket 데코레이터, 다단계(중첩) prefix 합성, 라우터/앱 레벨 의존성까지 본 인증 판정, `tags`/`response_model`/`deprecated` 반영
- **현대 문법(v1.3)**: `Annotated[User, Depends(...)]`·`Annotated[str|None, Query()/Header()]`(FastAPI 0.95.0+ 권장) 양식을 구식 기본값 문법과 동등 인식. prefix 합성 불확실 시 OpenAPI 3.1 `/openapi.json` 교차 점검을 제안(직접 실행 불가 → "확인 필요")
- **출력**: 리소스/태그별 표 + 미인증·무응답모델·deprecated 엔드포인트 목록
- **구분**: 프론트-백 계약 정합 검증은 `api-contract-reviewer`, 일반 개발문서(README·아키텍처·온보딩·ADR)는 `docs-writer`
</details>

<details>
<summary><b>9. db-optimizer</b> (<code>/db</code>) — MySQL 성능 튜닝</summary>

- **언제**: 느린 쿼리 진단, N+1, 인덱스 설계, 마이그레이션의 성능·인덱스 영향 검토
- **점검**: N+1, 인덱스(복합 컬럼 순서·중복), SELECT */함수 래핑/OFFSET 페이지네이션, 타입 적정성, 트랜잭션·락, 커넥션 풀, 벡터 검색(MySQL 9 `VECTOR` k-NN·사전필터, 거리 함수·인덱스 지원은 엔진별 확인)
- **안전장치**: ALTER/DROP 직접 실행 안 함. `EXPLAIN`/`EXPLAIN ANALYZE`는 명시 요청 시만
- **출력**: 영향도별 문제 + "가장 효과 큰 개선 3가지"
- **구분**: 스키마 "설계"는 `data-modeler`, 마이그레이션 안전성(락·무중단·롤백)은 `migration-reviewer`, 프론트엔드 렌더·번들 등 화면 성능은 `perf-auditor`(v1.8)
</details>

<details>
<summary><b>10. migration-reviewer</b> (<code>/migrate</code>) — 마이그레이션 안전성 점검</summary>

- **언제**: 스키마 마이그레이션(Alembic 등) 머지·배포 전 안전성 리뷰
- **가정**: 운영 데이터가 많은 큰 테이블 + 마이그레이션 도중에도 트래픽이 흐른다
- **점검**: 락 범위·무중단 가능성, NOT NULL+백필 순서(expand-contract), 인덱스 생성 비용·동시성, 타입 변경 재작성, FK/유니크 제약 위반, 롤백 가능성(downgrade), 대량 DML 배치, 배포 순서(코드↔스키마 호환)
- **안전장치**: 마이그레이션을 직접 실행하지 않음. 버전·엔진 의존 동작은 "확인 필요"로 표시
- **출력**: 요약(무중단 가능 여부) → 위험 Top 3(안전한 대안 제시) → 주의 → 제안
- **구분**: 테이블·관계 "설계"는 `data-modeler`, 쿼리·인덱스 "성능 튜닝"은 `db-optimizer`
</details>

### 🎨 디자인

<details>
<summary><b>11. ui-ux-reviewer</b> (<code>/ui</code>) — UI/UX·접근성 점검</summary>

- **언제**: 화면 머지 전 디자인 품질 점검
- **점검**: 레이아웃/간격, 타이포 위계, 색 대비(WCAG AA), 반응형·터치 타깃, 접근성(시맨틱·aria·키보드·alt·label·reduced-motion), 상태 표현(로딩/빈/에러), 컴포넌트 일관성
- **확장(v1.3)**: 폼/입력(검증 시점·에러 위치), 마이크로카피/콘텐츠, 국제화(i18n/RTL·텍스트 확장), 다크모드 품질(표면 위계), **다크 패턴/윤리**, Nielsen 사용성 휴리스틱 렌즈 (실무 디자인 감사 카테고리 기반)
- **출력**: 요약 → Must/Should/Nit
- **구분**: 코드 로직·버그는 `code-reviewer`, 토큰/시스템 설계는 `design-system-architect`, 로드·렌더 성능(번들·CWV)은 `perf-auditor`
</details>

<details>
<summary><b>12. design-system-architect</b> (<code>/dsystem</code>) — 디자인 시스템 설계</summary>

- **언제**: 흩어진 스타일을 일관된 시스템으로 정비, 디자인 시스템을 `DESIGN.md` 단일 소스로 정리
- **설계**: 디자인 토큰(색/타이포/스페이싱/래디우스/섀도), 테마(다크모드), 컴포넌트 계층·variant, 네이밍, Tailwind 토큰화, 중복 통합, 문서화(Storybook)
- **DESIGN.md(v1.3)**: [google-labs-code/design.md](https://github.com/google-labs-code/design.md) 포맷(프런트매터 토큰 + 산문 근거)으로 단일 소스 초안 작성. 토큰 참조 `{colors.primary}`, WCAG 대비 명시. `@google/design.md` CLI(`lint`/`export` → Tailwind v3 JSON·v4 `@theme`·DTCG/`diff`)는 실행하지 않고 다음 단계로 안내
- **출력**: 현황 진단 → 제안 토큰 세트(DESIGN.md 형태) → DESIGN.md 초안 → 컴포넌트 구조 → 마이그레이션 단계
- **구분**: 개별 화면 UI/UX 점검은 `ui-ux-reviewer`
</details>

### 🏗 설계

<details>
<summary><b>13. data-modeler</b> (<code>/datamodel</code>) — 데이터 모델 설계</summary>

- **언제**: 새 도메인 테이블/관계 설계, 기존 모델 재설계 (ERP 등 복잡 도메인)
- **설계**: 엔터티/관계(N:M 연결 테이블), 정규화, 키 전략(대리키/자연키/FK 동작), 타입 선택, 제약·무결성, 이력/감사/soft delete/채번, 확장성
- **AI 데이터(v1.3)**: 임베딩/시맨틱 검색을 위한 MySQL 9 `VECTOR(N)` 타입·저장 구조(거리 함수·벡터 인덱스 지원은 엔진별 상이 — HeatWave vs 커뮤니티, 함수명 단정 금지·"확인 필요"; MySQL 8 이하나 미지원 시 외부 벡터 DB 트레이드오프)
- **출력**: 텍스트 ERD → 테이블별 설계(DDL) → 트레이드오프 → 가정/확인 필요
- **구분**: 기존 쿼리 성능 튜닝은 `db-optimizer`, 마이그레이션 안전성(락·백필·롤백)은 `migration-reviewer`
</details>

<details>
<summary><b>14. system-architect</b> (<code>/arch</code>) — 시스템 아키텍처 설계</summary>

- **언제**: 기능 구현 전 구조 설계, 기존 아키텍처 점검
- **설계**: 계층 분리, 모듈 경계·의존성, API 계약, 인증 구조, 비동기/작업(큐·워커), 캐싱, 폴더 구조, 확장성
- **LLM/AI 연동(v1.3)**: 스트리밍(SSE) 경로, RAG/벡터 스토어(MySQL 9 `VECTOR` vs 외부), LLM 호출 비동기·재시도·비용, MCP 등 도구 연동 경계
- **출력(설계)**: 요구사항/가정 → 옵션 비교(장단점) → 권장안(흐름도) → 단계 적용
- **출력(점검)**: 현황 진단 → 구조적 문제(영향도순) → 개선 설계 → 마이그레이션
</details>

### 🚀 운영 (DevOps)

<details>
<summary><b>15. devops-reviewer</b> (<code>/devops</code>) — Docker·CI/CD·배포 설정 점검</summary>

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
<summary><b>16. dependency-auditor</b> (<code>/deps</code>) — 의존성 취약점·버전·라이선스 점검</summary>

- **언제**: 머지·배포 전 또는 정기 의존성 점검
- **점검**: 알려진 취약점(CVE, 직접/전이 경로), 버전 신선도·방치/deprecated, lockfile 무결성·드리프트(npm/pnpm/yarn·poetry·**uv.lock·PEP 751 pylock.toml**(v1.1)), 미사용·누락 의존성, dependencies/devDependencies 오분류, 라이선스 위험(GPL/AGPL·불명), 공급망 신호(타이포스쿼팅·postinstall·비공식 레지스트리·**lockfile 포이즈닝·provenance/Trusted Publishing·릴리스 숙성**(v1.1))
- **안전장치**: 매니페스트·lockfile 정적 분석이 기본. `npm audit`·`pip-audit` 등 읽기 전용 진단은 명시 요청 시만, 설치·업그레이드는 안 함
- **출력**: 요약(취약점 개수·lockfile 상태) → 위험 Top 3(패키지·현재/권장 버전·조치) → 주의 → 제안
- **구분**: 앱 코드 보안 취약점은 `security-reviewer`, CI/공급망(SBOM·서명) 설정은 `devops-reviewer`
</details>

<details>
<summary><b>17. observability-reviewer</b> (<code>/obs</code>) — 로깅·트레이싱·관측성 점검</summary>

- **언제**: "장애가 나도 추적이 안 된다", 운영 투입·머지 전 관측성 점검
- **가정**: 새벽 3시 장애 알림 — 로그·트레이스만으로 "어떤 요청이, 누가/무엇에서, 어디서, 왜 실패했는가"를 답할 수 있는가
- **점검**: 구조적 로깅(맥락·레벨·노이즈), 상관관계 ID(request/trace) 전파, 에러 캡처·리포팅(예외 삼킴·Sentry·4xx/5xx 구분), 메트릭, 분산 트레이싱(OpenTelemetry), 민감정보 로그 노출, 프론트 에러 바운더리·웹 바이탈
- **트레이싱 경계(v1.1)**: 컨텍스트 전파 포맷 일관성(W3C `traceparent`/`tracestate` vs B3)까지 본다. 점검 범위는 **앱 측 계측**까지 — 수집·샘플링 파이프라인(OTel Collector·Grafana Alloy의 익스포터·tail sampling·배치)은 `devops-reviewer` 영역으로 구분
- **출력**: 요약(장애 추적 가능성) → 위험 Top 3(민감정보 로그·예외 삼킴·추적 불가) → 주의 → 제안
- **구분**: 배포·인프라(로그·트레이스 수집·샘플링 파이프라인·대시보드: OTel Collector·Grafana Alloy 등) 설정은 `devops-reviewer`, 일반 예외 처리·코드 품질은 `code-reviewer`, 이미 발생한 장애의 원인 규명은 `debugger`(v1.3 — 이 에이전트는 추적 "가능성" 자체의 공백을 점검)
</details>

### 🧭 메타 / 워크플로우

<details>
<summary><b>18. ai-workspace-architect</b> (<code>/fable</code>) — AI 작업환경 진단·재설계</summary>

- **언제**: 프롬프트·지침·`CLAUDE.md`·`SKILL.md`·커스텀 인스트럭션·반복 업무 규칙을 상위 수준으로 재설계할 때
- **성격**: 다른 에이전트들과 달리 특정 개발 스택이 아니라 **AI 작업환경 자체**를 다루는 메타 에이전트. 마케팅·콘텐츠 제작(릴스·카드뉴스·블로그·상세페이지·강의자료) 결과물 품질을 시스템화
- **범위**: 여러 모델(Claude/GPT/Gemini/Cursor)에서 일관되게 작동하는 범용 AI 운영체제 설계 — 바로 붙여넣을 커스텀 인스트럭션·CLAUDE.md·SKILL.md 초안 + 모델별 사용 전략
- **품질 엔진(모델 무관)**: 실행 모델과 무관하게 뼈대→초안→자가채점 루브릭(완성형·밀도·구체성·구조·근거·신뢰도)→재작성 절차를 강제. 도장찍기 금지(각 점수 근거 인용 + 진짜 약점 1개 이상 발굴·수정)
- **출력**: 총평 → 진단표 → 병목 5 → A.커스텀 인스트럭션 → B.CLAUDE.md → C.SKILL.md → D.모델별 전략 → 운영 규칙 → 자기비판 후 최종본
- **구분**: 개발 스택 아키텍처는 `system-architect`, 디자인 시스템은 `design-system-architect`, 이 라이브러리의 에이전트 정의(.md) 점검은 `agent-definition-reviewer`. 파일 직접 수정 없이 진단·초안만 제시
</details>

### 📣 콘텐츠 / 마케팅

<details>
<summary><b>19. copy-reviewer</b> (<code>/copy</code>) — 마케팅 카피 품질 리뷰</summary>

- **언제**: 릴스·카드뉴스·블로그·상세페이지·제안서·광고 문구를 발행하기 전 카피 점검
- **점검**: 후킹(첫 3초/첫 줄), 1메시지 집중, 독자 언어(vs 공급자 언어), 구체성(추상어·공허한 최상급), CTA 명확성·마찰, 신뢰도·윤리(근거 없는 보장·허위·다크패턴), 톤·문체 일관성, 포맷 적합(분량·구조). 변동 수치엔 `⚠️검증필요`
- **출력**: 요약(강점·핵심 문제) → Must fix / Should fix / Nit(위치·문제·근거·**리라이트 예시**)
- **구분**: 화면 레이아웃·시각·접근성은 `ui-ux-reviewer`, 전환 구조는 `landing-reviewer`, 검색 최적화는 `seo-optimizer`, 프롬프트·지침 시스템은 `ai-workspace-architect`
</details>

<details>
<summary><b>20. landing-reviewer</b> (<code>/landing</code>) — 상세페이지·랜딩 전환 리뷰</summary>

- **언제**: 판매·전환 페이지(상세페이지·랜딩)를 게시하기 전 전환 관점 점검
- **점검**: 히어로 가치 제안, 문제-공감-해결 흐름, 차별점의 benefit 번역, 사회적 증거, 반론 처리(FAQ·보증), CTA 전략(수·배치·마찰), 오퍼·가격 표현, 긴급성·희소성 윤리(다크패턴), 스캔 가능성·모바일 흐름
- **출력**: 요약 → 전환 저해 Top 3(위치·문제·왜 이탈·개선) → 주의·제안
- **구분**: 문장 카피 품질은 `copy-reviewer`, 시각·접근성은 `ui-ux-reviewer`, 검색 유입은 `seo-optimizer`
</details>

<details>
<summary><b>21. seo-optimizer</b> (<code>/seo</code>) — 블로그·페이지 SEO 점검</summary>

- **언제**: 블로그·랜딩을 발행하기 전 검색 최적화 점검
- **점검**: 검색 의도 매칭, 타이틀·메타, 헤딩 구조(H1 유일·계층), 키워드 배치·과최적화, 내부/외부 링크, 이미지 alt, 슬러그, 구조화 데이터(schema.org), E-E-A-T·스니펫, 카니발라이제이션. 키워드·SERP는 WebSearch로 확인(미확인은 "추정")
- **출력**: 요약(SEO 성숙도·타깃 키워드) → 개선 Top 3(위치·문제·근거·문안 예시) → 주의·제안
- **구분**: 설득·문장은 `copy-reviewer`, 전환 구조는 `landing-reviewer`, 렌더·번들 등 기술 성능(CWV)은 `perf-auditor`
</details>

<details>
<summary><b>22. fact-checker</b> (<code>/factcheck</code>) — 콘텐츠 사실·수치·출처 검증</summary>

- **언제**: 통계·수치·인용이 든 마케팅·블로그·강의자료·제안서를 발행하기 전
- **검증**: 검증 가능한 진술만 추출(의견·일반론 제외) → ✅확인 / ⚠️부분사실 / ❌틀림 / ❓출처없음 / 🔒검증불가로 판정 + 출처(발행처·URL·날짜). 통계·가격·날짜·연구 인용·비교 최상급("업계 1위")·법률/의료/금융 주장을 특히 주의. 미확인은 사실로 단정하지 않음
- **출력**: 요약(진술 수·위험 건수) → 위험 Top 3(진술·판정·출처·수정안) → 진술별 검증표
- **구분**: 문장 설득력·톤은 `copy-reviewer`, 검색 최적화는 `seo-optimizer`, 전환 구조는 `landing-reviewer`
</details>

<details>
<summary><b>23. content-repurposer</b> (<code>/repurpose</code>) — 1소스 → 멀티 포맷 재활용</summary>

- **언제**: 블로그·영상 스크립트·강의·뉴스레터 등 기존 자산을 릴스·카드뉴스·스레드·뉴스레터·상세페이지 섹션으로 재활용할 때
- **원칙**: 소스에서 핵심 추출 → 매체별 관행(릴스 훅3초·카드뉴스 1장1메시지·스레드 연쇄·뉴스레터 구조)에 맞춤. 포맷마다 다른 각도로(중복 파생 금지), 원본 수치·주장 왜곡·새 사실 창작 금지(변동 정보 `⚠️검증필요`)
- **출력**: 핵심 메시지 정리 → 포맷별 완성형 초안(+왜 이 각도로) → 재활용 맵(1소스→N파생)
- **구분**: 카피 품질은 `copy-reviewer`, 검색 최적화는 `seo-optimizer`, 사실 검증은 `fact-checker`
</details>

<details>
<summary><b>24. brand-voice-guardian</b> (<code>/voice</code>) — 브랜드 보이스 일관성 점검</summary>

- **언제**: 채널 톤을 일관되게 지키고 싶을 때, 여러 사람이 같은 채널 글을 쓸 때, 발행 전 보이스 점검
- **기준 소스**(이 순서): `voice.md` → `voice/examples/` 확정글 → 제공된 예시 추론(근거 명시) → 아무 기준도 없으면 보이스를 지어내지 않고 `/fable`로 `voice.md`부터 만들라고 안내
- **점검**: 문장 습관(길이·종결어미), 거리감·호칭, 어휘(자주 쓰는 표현·**금지 표현**), 시그니처, 톤 일관성(한 글 내 흔들림), 번역투·클리셰, 채널별 톤 변주 범위
- **출력**: 요약(기준 소스·부합도) → 벗어난 구간(위치·위반 기준·**원문→교정**) → 미세 조정·유지 → (기준 부재 시) 보이스 정의 보강 제안
- **구분**: 일반 카피 품질(후킹·CTA)은 `copy-reviewer`, 보이스 정의·시스템 설계는 `ai-workspace-architect`
</details>

<details>
<summary><b>61. email-sequence-writer</b> (<code>/email</code> <code>/이메일</code>) — 이메일/라이프사이클 시퀀스 생성</summary>

- **언제**: 웰컴·온보딩·런칭·너처·장바구니 이탈·재참여(윈백)·콜드 아웃리치 등 **여러 통이 흐름을 이루는** 이메일 시퀀스가 필요할 때(1인 브랜드·뉴스레터·제품 출시)
- **원칙**: 한 통=한 목적=한 CTA, 통 사이 발송 타이밍 설계, 제목 후보+프리헤더. 없는 실적·수치 창작 금지(미확인 `[placeholder]`/`⚠️검증필요`), 거짓 긴급성·다크패턴 금지, 수신거부 자리 유지
- **출력**: 시퀀스 개요(유형·목표·통수·흐름) → 통별 완성 초안(타이밍/제목 2~3+프리헤더/본문/CTA/역할) → A/B 포인트
- **구분**: 단발 뉴스레터 1통·1소스 멀티포맷 파생은 `content-repurposer`, 카피 품질은 `copy-reviewer`, 브랜드 보이스는 `brand-voice-guardian`, 오퍼 설계는 `offer-strategist`, 사실 검증은 `fact-checker`
</details>

<details>
<summary><b>62. offer-strategist</b> (<code>/offer</code> <code>/오퍼</code>) — 카피 앞단 오퍼 설계</summary>

- **언제**: 상세페이지·제안서·런칭·가격표를 만들기 **전에**, 무엇을·얼마에·어떤 조건으로 팔지(오퍼)를 먼저 설계할 때. 좋은 카피도 약한 오퍼는 못 구한다 — 전환 상한선은 오퍼가 정한다
- **설계**: 핵심 가치제안(결과 중심) · 가치 방정식(꿈의 결과×확률÷시간·노력) · 가격/패키지 티어·앵커링 · 보증(리스크 리버설, 지킬 수 있는 범위) · 보너스 스택(반론별) · 정직한 긴급성·희소성 · 차별 포지셔닝 · 네이밍. 시장·경쟁·실적 수치 창작 금지(`가정`/`⚠️검증필요`)
- **출력**: 오퍼 진단/가정 → 오퍼 설계(가치제안→가격→보증→보너스→긴급성→포지셔닝→이름) → 한 장 오퍼 시트 → 다음 단계 위임 안내
- **구분**: 페이지 전환 구조 리뷰는 `landing-reviewer`, 문장 카피는 `copy-reviewer`, 파는 이메일 시퀀스는 `email-sequence-writer`, 사실·시장 데이터는 `fact-checker`, 오퍼 방향·네이밍 후보의 발산·수렴(고르기 전)은 `brainstormer`
</details>

### 🔒 품질 / QA — 보안 심화

> `security-reviewer`(`/sec`, 위 품질 카테고리)와 함께 보안 방어를 이룬다: 설계 단계(threat-modeler) → 코드 취약점(security-reviewer) → AI/LLM 특화(llm-ai-security-reviewer).

<details>
<summary><b>25. threat-modeler</b> (<code>/threat</code>) — 설계 단계 위협 모델링(STRIDE)</summary>

- **언제**: 새 기능·인증/결제/파일업로드/외부연동을 **구현하기 전** 또는 큰 변경 전
- **절차**: 자산 식별 → 진입점·공격 표면 → 신뢰 경계·데이터 흐름(텍스트 DFD) → STRIDE(스푸핑·변조·부인·정보노출·DoS·권한상승) per element → 악용 시나리오 → 위험 순위 → 완화책·보안 요구사항
- **출력**: 범위·가정 → 자산 → 진입점·신뢰 경계 → STRIDE 위협 표 → 악용 시나리오 Top → 보안 요구사항 체크리스트(구현·리뷰 시 확인용)
- **구분**: 이미 있는 코드의 취약점은 `security-reviewer`, AI/LLM 특화 위협은 `llm-ai-security-reviewer`, 시스템 구조 설계는 `system-architect`
</details>

<details>
<summary><b>26. llm-ai-security-reviewer</b> (<code>/aisec</code>) — AI/LLM 보안 심화(OWASP LLM Top 10)</summary>

- **언제**: 앱이 LLM/AI 기능(챗봇·RAG·에이전트·툴 호출·파인튜닝)을 포함하고, 머지 전 AI 보안을 깊게 볼 때
- **점검**(OWASP LLM Top 10 2025): 프롬프트 인젝션(직접·**간접**: RAG·문서·외부페이지), 부적절한 출력 처리(SQL/명령/HTML/툴 전파), 과도한 행위성(도구 권한·human-in-the-loop), 민감정보·시스템 프롬프트 유출, 벡터/RAG 포이즈닝·멀티테넌시, 모델·데이터 공급망, 무제한 소비(Denial of Wallet), 가드레일·평가/레드팀
- **출력**: 심각도별(LLMxx 표기) 발견 → 즉시 고칠 Top 3
- **구분**: 웹 앱 일반 보안(인증·인젝션·XSS·IDOR)은 `security-reviewer`, 배포·시크릿·모델 서빙 인프라는 `devops-reviewer`, 설계 단계 위협은 `threat-modeler`
</details>

### 🎮 게임 (Unity + C#)

> 웹 스택과 별개인 **게임 개발 도메인**의 시작점(싱글플레이어 2D 캐주얼). 색상은 8색 소진으로 `cyan`(문서 카테고리)을 공유하되 문서에서 게임 클러스터로 묶는다. 로드맵: game-feel-reviewer·unity-perf-auditor·playtest-designer·unity-build-auditor(같은 필요 3회 반복 시 승격).

<details>
<summary><b>27. unity-code-reviewer</b> (<code>/ureview</code>) — Unity C# 게임 코드 리뷰</summary>

- **언제**: Unity + C# 코드를 커밋·머지하기 직전 셀프 리뷰 (2D 캐주얼 — 퍼즐/플랫포머)
- **범위 결정**: `git diff`로 변경분의 `Assets/` 하위 `.cs`에 집중 (Bash는 범위 식별 전용, 실행·수정 금지)
- **점검(게임 엔진 고유)**: ① MonoBehaviour 수명주기(Awake/OnEnable/Start 혼동, OnDisable 구독 해제 누락), ② 프레임 루프 비용(Update 내 GetComponent/Find/Camera.main), ③ GC 할당(매 프레임 new·박싱·문자열·LINQ·풀링 부재), ④ 코루틴/async 취소 누수, ⑤ 물리·프레임률 의존(Time.deltaTime·FixedUpdate·Rigidbody2D), ⑥ fake-null(파괴된 오브젝트 참조·`?.` 우회), ⑦ ScriptableObject 런타임 원본 오염
- **원칙**: 성능·GC는 정적 리뷰로 의심 지점만 짚고 실제 수치는 **Profiler 측정 권고**로 분리(단정 금지)
- **출력**: 요약 → Must fix → Should fix → Nit → 측정 권고 (분류 내 영향도순, `파일:줄`), 가장 먼저 고칠 Top 3
- **구분**: 일반 웹 코드 리뷰는 `code-reviewer`, 게임 설계·코어 루프·시스템 분해는 `game-design-architect`, 이미 발생한 런타임 오동작·크래시의 원인 규명은 `debugger`(v1.2 — 이 에이전트는 증상 없는 정적 리뷰)
</details>

<details>
<summary><b>28. game-design-architect</b> (<code>/gdd</code>) — 2D 캐주얼 게임 디자인·시스템 설계</summary>

- **언제**: 새 게임·메카닉·레벨 시스템을 구현하기 전 설계, 기존 설계 점검
- **설계**: 코어 게임플레이 루프(핵심 동사·재미 가설), 난이도 곡선·페이싱·진행(메카닉 도입→연습→응용→조합), 시스템 분해(GameManager 상태머신·이벤트 흐름·씬 구성·세이브), ScriptableObject 데이터 경계, 게임필 피드백 계획
- **원칙**: 솔로 개발 최대 리스크는 "미완성" — 모든 야심 기능에 **컷 후보** 강제, 재미부터(수직 슬라이스) 콘텐츠는 나중. 재미는 단정하지 않고 "가설 + 플레이테스트로 검증할 질문"으로
- **출력(설계)**: 요구/가정 → 코어 루프·재미 가설 → 시스템 분해 → 진행·난이도 → 수직 슬라이스·컷 라인 → 플레이테스트 검증 질문. (점검): 진단 → 문제 → 개선 설계 → 범위 재조정
- **구분**: Unity C# 코드 품질·프레임 리뷰는 `unity-code-reviewer`, 풀스택 웹 아키텍처는 `system-architect`, 게임 아이디어·메카닉 씨앗의 발산·수렴(고르기 전)은 `brainstormer`
</details>

<details>
<summary><b>29. game-ui-reviewer</b> (<code>/gui</code>) — 게임 UI/UX 점검</summary>

- **언제**: UI 씬·프리팹·UI 스크립트를 커밋하기 직전 (2D 캐주얼, 모바일 우선)
- **점검**: HUD·메뉴 레이아웃/정보 위계, CanvasScaler 해상도·종횡비 스케일링(Scale With Screen Size·reference resolution·match), 세이프 에어리어(노치), 캔버스 렌더 모드, 게임패드·터치 내비게이션·포커스(EventSystem·explicit navigation), 움직이는 화면 위 텍스트 가독성·색약/명도 대비, UI 상태(로딩/빈/에러/전환), 온보딩 UI, (수익화 시) F2P 다크패턴
- **원칙**: YAML 설정·코드로 확정 가능한 것만 심각도 부여, 실제 보임새는 **기기 확인 권고**로 분리(화면을 못 봄)
- **출력**: 요약 → Must/Should/Nit → 기기 확인 권고 → 위임, 가장 먼저 고칠 Top 3
- **구분(경계)**: UI 조작 피드백은 이 에이전트, 게임플레이 동작 피드백은 `game-feel-reviewer`. 코어 루프·난이도는 `game-design-architect`, 코드·프레임은 `unity-code-reviewer`, 웹 화면·WCAG 폼·i18n은 `ui-ux-reviewer`
</details>

<details>
<summary><b>30. game-feel-reviewer</b> (<code>/feel</code>) — 게임플레이 손맛/juice 점검</summary>

- **언제**: 조작이 뻣뻣·타격감 없다고 느낄 때, 플레이어 컨트롤러·카메라·이펙트 코드 커밋 직전
- **점검**: 입력 응답 관대성(코요테 타임·점프 버퍼·입력 버퍼링·가변 점프), 히트스톱/타임프리즈, 화면 흔들림·카메라 추적/룩어헤드, 스쿼시&스트레치·파티클·플래시, 사운드/햅틱 타이밍, 가감속 커브, 페이싱·리듬
- **원칙**: 장치의 유무·구조는 확정 보고, 손맛 체감·세부 튜닝값은 **프로토타입 검증 항목**으로 분리(정적 단정 금지)
- **출력**: 요약 → Must/Should/Nit → 핵심 동사 × 피드백 채널 매트릭스 → 프로토타입 검증 항목 → 위임, Top 3
- **구분(경계)**: 게임플레이 동작 피드백(HUD 표시 포함)은 이 에이전트, UI 조작·위젯 배치는 `game-ui-reviewer`. 재미 가설·난이도는 `game-design-architect`, 코드·GC는 `unity-code-reviewer`
</details>

<details>
<summary><b>31. unity-perf-auditor</b> (<code>/uperf</code>) — Unity 런타임 성능·렌더링 점검</summary>

- **언제**: "프레임이 떨어진다"·"기기가 뜨겁다", Profiler 캡처를 들고 왔을 때, 릴리스 전 성능 패스
- **점검**: 드로우콜·배칭(SpriteAtlas·머티리얼/소팅), 오버드로우·필레이트(모바일 2D GPU 병목), 텍스처 압축(ASTC/ETC2)·`.meta` 임포트·텍스처/오디오 메모리, Fixed Timestep·2D 충돌 비용, 퀄리티/프로젝트 설정, Profiler/Frame Debugger 캡처 수치 해석
- **원칙**: 정적 리뷰로 "느리다" 단정 금지 — 설정 존재/부재는 확정, 실제 비용은 **측정 계획**으로 분리(수치 제공 시 수치가 근거)
- **출력**: 요약 → Must/Should/Nit → 측정 계획 → 캡처 해석 → 위임, Top 3
- **구분(경계)**: GC 유발 코드 원인은 `unity-code-reviewer`(증상·측정 해석이 이 에이전트), 빌드 용량은 `unity-build-auditor`, 웹 성능은 `perf-auditor`, 카메라 지터의 손맛은 `game-feel-reviewer`
</details>

<details>
<summary><b>32. playtest-designer</b> (<code>/playtest</code>) — 플레이테스트 프로토콜 설계</summary>

- **언제**: 검증 질문 목록이 생겼거나 빌드를 외부인에게 처음 보여주기 직전 (수직 슬라이스/프로토타입)
- **설계**: 검증 질문→행동 지표→판정 기준, 참가자·회차(타깃·신선한 눈 배분), 세션 프로토콜(콜드 스타트·진행자 스크립트·개입 규칙), 관찰 지표(FTUE·막힘·이탈·재시도·리텐션 프록시), 설문(유도 질문 배제), 텔레메트리 이벤트, 결과 해석·우선순위화
- **원칙**: 재미의 판정자는 데이터 — 관찰이 진술을 이긴다, 소규모 n을 백분율로 포장 안 함, 테스트를 직접 실행 안 함(설계만)
- **출력**: 검증 가설 표 → 참가자·회차 계획 → 세션 프로토콜 → 관찰 시트 → 설문 문항 → 텔레메트리 목록 → 결과 해석 가이드
- **구분(경계)**: "무엇을 검증할지"(코어 루프·재미 가설)는 `game-design-architect`, 손맛 장치는 `game-feel-reviewer`(이 에이전트는 "어떻게 검증할지"). 소프트웨어 자동 테스트는 `test-strategy`/`test-runner`
</details>

<details>
<summary><b>33. unity-build-auditor</b> (<code>/ubuild</code>) — 빌드/릴리스·스토어 제출 점검</summary>

- **언제**: 스토어 제출·릴리스 빌드 직전, ProjectSettings·빌드 구성 변경 시
- **점검**: Player Settings(번들 ID·버전·IL2CPP/ARM64·managed stripping), 빌드 크기(Resources 남용·압축 용량·AAB), 빌드 씬 목록, 매니페스트 권한, 스토어 요건(64bit·개인정보·데이터 안전), 서명/keystore 커밋 여부, development build 플래그 잔존, Addressables 구성
- **원칙**: 파일 판정(설정·씬·keystore·플래그)은 확정, **스토어 정책 수치는 변동이 커서 단정 금지** → 확인 목록(⚠️)으로 분리(웹 검색 도구 없음)
- **출력**: 요약 → 제출 차단·보안 Must → Should → Nit → 스토어 정책 확인 목록 → 위임, Top 3
- **구분(경계)**: 일반 CI/CD·시크릿 보관·파이프라인은 `devops-reviewer`(이 에이전트는 keystore "커밋·존재 판정"까지), 코드는 `unity-code-reviewer`, 런타임 성능은 `unity-perf-auditor`
</details>

<details>
<summary><b>40. multiplayer-rule-reviewer</b> (<code>/rule</code> <code>/룰</code>) — 멀티플레이 룰 정합성·서버 권위 점검</summary>

- **언제**: 멀티플레이 룰·상태머신·서버 핸들러 코드를 머지하기 직전. "밤에 죽였는데 게임이 안 끝난다", "죽은 사람을 지목할 수 있다", "마피아가 누군지 보인다". 주력 대상은 **MapleStory Worlds(MSW) mlua**(마피아류 소셜 추리) — 원칙은 엔진 무관
- **전제 2가지**: ① **클라이언트는 적대적이다** — 서버가 검증하지 않으면 존재하지 않는 규칙(UI가 막는 건 방어가 아님). ② **판정은 상태 변화에 걸어야 한다** — 승패 조건을 특정 페이즈 전환에만 걸면 다른 사망 경로에서 조용히 누락
- **점검**: ① 상태머신 정합성(페이즈 × 이벤트 전이표의 구멍, 타이머·전원제출 경합, 재진입, **판정 함수 호출 지점을 전부 세어본다**) ② 서버 권위(MSW `@ExecSpace("Server")` = 클라 호출 가능 진입점을 열거해 호출자 신원·자격·생존·페이즈·대상 유효성·중복 제출 검증 여부를 표로) ③ 은닉 정보 누출(`@Sync`·브로드캐스트로 마피아 정체·밤 행동·투표 집계가 클라로 — **UI로만 가리면 결함**) ④ 로스터 생애주기(이탈·재접속·호스트·최소 인원) ⑤ 룰·밸런스 정합(시작부터 승리 조건이 성립하는 역할 구성, 자동 지목이 아군을 죽이는지, 동점·기권) ⑥ 결정성·시간(서버 시간 기준, 랜덤 시드 위치)
- **출력**: 요약 → 페이즈 전이표 → 서버 진입점 검증 표(✅/❌ + `파일:줄`) → 심각도순 발견(**악용 시나리오** 포함) → 경계 케이스 체크리스트 → 확인 필요 → Top 3
- **구분(경계)**: "무엇을 만들지"(코어 루프·재미·난이도)는 `game-design-architect`, Unity C# 엔진 코드는 `unity-code-reviewer`, **이미 난 증상**의 원인 규명은 `debugger`(이쪽은 증상 없이 선제 점검), 세이브 스키마 진화·손상 복구는 `save-data-reviewer`(이쪽은 서버 권위·멱등성), 웹 앱 인증·인가·주입은 `security-reviewer`
</details>

<details>
<summary><b>41. save-data-reviewer</b> (<code>/save</code> <code>/세이브</code>) — 세이브·영속 데이터 호환성 점검</summary>

- **언제**: 세이브 구조·저장 키·데이터 클래스를 바꾸는 변경을 배포하기 직전. "업데이트했더니 진행도가 날아갔다". 엔진 무관(Unity PlayerPrefs·JSON·바이너리, MSW 스토리지, 클라우드 세이브)
- **하나의 질문**: 이 업데이트를 내보내면 **이미 플레이 중인 유저의 진행도가 살아남는가**. 심각도 기준도 "유저 데이터가 손실되는가"
- **점검**: ① 스키마 버전 필드·v1→v2→v3 **순차** 마이그레이션(버전 건너뛴 유저가 가장 흔하다) ② 직렬화 필드 **리네이밍**(별칭 없이 바꾸면 값이 조용히 기본값으로 리셋)·enum 중간 삽입(저장된 정수가 다른 의미로 해석) ③ 손상·변조 세이브를 **크래시 대신 우아하게 거부**·백업 복구 ④ 저장의 **원자성**(임시 파일 → 교체 vs 원본 덮어쓰기)·실패의 조용한 무시·마이그레이션 직전 백업 ⑤ 삭제된 콘텐츠 ID를 참조하는 고아 데이터(레벨 인덱스 저장 vs 안정적 ID) ⑥ 매체별 함정(PlayerPrefs 남용·플랫폼 쿼터·클라우드 충돌 해소 규칙)
- **출력**: 요약(살아남는가) → 데이터 손실 위험(**손실 시나리오** 포함) → 호환성 리스크 → 스키마 변경 목록 → 마이그레이션 설계 → **구버전 세이브 회귀 시나리오** → Top 3
- **구분**: 서버 DB(MySQL·Alembic) 마이그레이션은 `migration-reviewer`(이쪽은 클라이언트·게임 세이브), 재화 지급의 서버 권위·멱등성은 `multiplayer-rule-reviewer`(이쪽은 스키마 진화·손상 복구), 데이터 구조 설계는 `game-design-architect`·`data-modeler`
</details>

<details>
<summary><b>45. game-localization-reviewer</b> (<code>/gloc</code> <code>/현지화</code>) — 게임 현지화 준비 점검</summary>

- **언제**: 영어·일본어 출시 준비, 번역을 넣기 **전** 구조 점검, UI에 텍스트가 잘려 보일 때
- **전제**: 현지화 비용의 대부분은 번역료가 아니라 **구조를 뒤늦게 고치는 비용**이다 — 그래서 번역 전에 본다
- **점검**: 하드코딩 문자열(코드·프리팹·씬 전수 조사)·키 체계, **폰트 글리프 커버리지**(CJK 미포함 시 □ 두부)·아틀라스 방식, **번역 길이 팽창**에 따른 고정 폭 컨테이너 오버플로·CJK 줄바꿈, **문자열 연결로 만든 문장**(어순 다른 언어에서 파손 → 플레이스홀더 완성 문장으로), 복수형·조사, 로케일 포맷·RTL, 이미지 속 텍스트, 로케일 전환 갱신·**미번역 키 노출 폴백**
- **출력**: 요약(지금 번역본을 받으면 넣을 수 있는가) → 구조적 차단 → 레이아웃·포맷 리스크 → **하드코딩 문자열 목록** → 현지화 체크리스트 → 기기 확인 권고 → Top 3
- **구분**: 게임 UI 레이아웃·스케일링은 `game-ui-reviewer`, 웹 i18n은 `ui-ux-reviewer`, 문구 품질은 `copy-reviewer`
</details>

<details>
<summary><b>46. game-test-strategy</b> (<code>/gtest</code> <code>/게임테스트</code>) — 게임 자동 테스트 전략·seam 설계</summary>

- **언제**: "게임 로직에 테스트를 붙이고 싶다", "리팩터가 무서워서 못 고친다"
- **전제**: 게임 로직이 테스트 불가능한 건 복잡해서가 아니라 **엔진에 붙어 있어서**다 — 그래서 절반은 "어떤 테스트를 쓸까"가 아니라 "**무엇을 떼어내면 테스트할 수 있는가**"
- **점검·설계**: 순수 로직 seam(승패 판정·상태 전이·밸런스·직렬화를 엔진 API에서 분리, 시간·난수·저장소 주입), **EditMode vs PlayMode** 분류(순수 로직을 PlayMode에서 돌리지 않기), 커버리지 공백(종료 조건 전 경로·전이표 예외 칸·경계값·저장 왕복·**속성 기반 불변식**), **결정론적 시뮬레이션**(고정 시드+고정 스텝 → 입력 시퀀스 골든 테스트, 게임에서 가성비 최고), 약한 테스트·플레이키(씬/static 잔존·코루틴 타이밍)
- **출력**: 요약 → 테스트 가능성 진단 → **seam 우선순위 Top 3** → 커버리지 공백(EditMode/PlayMode 표시) → 결정론·리플레이 계획 → Top 3
- **구분**: 웹 테스트는 `test-strategy`·`test-runner`, **사람** 플레이테스트는 `playtest-designer`, 룰 정적 감사는 `multiplayer-rule-reviewer`, 구조 리팩터는 `refactor-strategist`
</details>

<details>
<summary><b>47. game-audio-reviewer</b> (<code>/gaudio</code> <code>/오디오</code>) — 게임 오디오 구현 점검</summary>

- **언제**: "소리가 시끄럽거나 찢어진다", "BGM 루프가 튄다", 오디오를 붙이기 전 구조 설계
- **점검**: 믹서 버스 분리(BGM/SFX/UI)와 **음량 설정 저장·로그 스케일 변환**·믹서 우회 재생, **동시 발음 제한·보이스 스틸링**(같은 SFX 다량 겹침 = 찢어짐), 반복 SFX의 **피치·볼륨 랜덤화**(동일 파형 반복은 수십 번 만에 거슬린다), BGM 루프·크로스페이드·덕킹, **임포트 설정**(짧은 SFX는 메모리 적재, 긴 BGM은 스트리밍 — 반대면 메모리 폭탄/지연), 일시정지·백그라운드 처리, **음소거로도 게임이 성립하는가**
- **한계**: **들을 수 없다** — 구조·설정은 확정 판정, 음량 균형·이음새·거슬림은 **청취 확인 목록**으로 분리
- **구분**: 사운드가 동작과 **동기화되는 타이밍**은 `game-feel-reviewer`, 오디오 **메모리·CPU**는 `unity-perf-auditor`, **빌드 용량**은 `unity-build-auditor`
</details>

### 🧪 도메인 (ML · 회계 · 자동화) — 1.69 추가

> 웹·게임·콘텐츠와 별개로, **실제 운용 중인 개인 프로젝트의 도메인 규칙**을 보는 3종. 공통점은 "코드는 잘 돌지만 **결과가 조용히 틀리는**" 부류를 잡는다는 것 — 누출된 백테스트, 어긋난 장부, 죽은 줄 모르는 데몬.

<details>
<summary><b>43. ml-experiment-reviewer</b> (<code>/ml</code> <code>/머신러닝</code>) — ML 실험 설계·데이터 누출 감사</summary>

- **언제**: "백테스트는 잘 나오는데 실전은 안 된다", "검증 점수가 비현실적으로 높다", 모델 재학습·배포 전
- **전제**: **좋은 점수는 증거가 아니라 용의자다.** 누출은 에러도 경고도 없이 오직 실전에서만 드러나므로 정적으로 잡아야 한다
- **점검**: ① **미래 정보 누출**(피처 시점·`shift`/`rolling` 방향·전처리를 분할 전에 `fit_transform`·타깃 누출·레이블 off-by-one) ② 검증 설계(시계열에 shuffle/KFold = 미래로 과거 예측, walk-forward·purged/embargo CV, **as-of 재학습이 운용과 일치하는가**, point-in-time 데이터) ③ 백테스트 현실성(생존 편향·수수료/슬리피지·낙관적 체결) ④ 과적합(검증셋 재사용·홀드아웃 부재)·지표 적합성·베이스라인 ⑤ 재현성·training-serving skew
- **출력**: 요약(이 점수를 믿을 수 있는가) → 누출(Critical) → 검증 설계 결함 → 과적합·지표 → **시점 확인 질문**("이 피처는 t에 알 수 있는가") → 재검증 계획 → Top 3
- **구분**: 일반 코드 품질은 `code-reviewer`, 소프트웨어 테스트는 `test-strategy`, LLM/RAG 보안은 `llm-ai-security-reviewer`, 파이프라인 운용 신뢰성은 `automation-reliability-reviewer`
</details>

<details>
<summary><b>42. accounting-rule-reviewer</b> (<code>/acct</code> <code>/회계</code>) — 복식부기 규칙 감사</summary>

- **언제**: "잔액이 안 맞는다", "마감 후 숫자가 바뀐다", GL·전표·마감 로직 머지 전
- **불변식 3개**: ① 모든 전표는 **차변 합 = 대변 합** ② 기록은 지우지 않는다(정정은 **역분개**) ③ 마감된 과거는 바뀌지 않는다. 이걸 **코드가 강제하는가**(관행이 아니라 assert·DB 제약·트랜잭션)를 본다
- **점검**: 균형 검증의 위치(프론트 폼에만 있으면 API 직접 호출로 뚫림)·트랜잭션 원자성, 물리 삭제 경로, 마감 우회, **금액이 float이면 확정 결함**(DECIMAL·정수 최소단위), 반올림·안분 잔차, 계정 유형별 차대 방향, 잔액 캐시와 전표 합계의 정합·시산표 검증, 감사 추적
- **출력**: 요약(장부가 깨질 수 있는가) → 불변식 파손(**깨지는 시나리오**) → 정합 리스크 → 불변식 체크리스트(✅/❌) → 회계 담당 확인 필요 → Top 3
- **구분**: 스키마 설계는 `data-modeler`, 마이그레이션은 `migration-reviewer`, 쿼리 성능은 `db-optimizer`, 인가는 `security-reviewer`
</details>

<details>
<summary><b>44. automation-reliability-reviewer</b> (<code>/auto</code> <code>/자동화</code>) — 데몬·스케줄 자동화 신뢰성</summary>

- **언제**: "돌고는 있는데 로그가 없다", "언제부터 안 도는지 몰랐다", "두 번 실행돼 중복 데이터가 쌓였다", 자동화를 상시 운용에 올리기 전
- **하나의 질문**: 아무도 안 보고 있을 때 이게 조용히 죽으면 **언제 알 수 있는가**
- **점검**: ① 로그가 실제로 남는가 — **셸 리다이렉트·상위 프로세스 stdout 핸들에 의존하면 실행 방식에 따라 로그가 통째로 증발**한다(프로세스는 정상인데 로그만 사라지는 최악의 부류) ② 실패 표면화(예외 삼킴·상태 코드 무시·플레이스홀더 설정으로 조용한 실패) ③ 중복 실행 락·stale lock ④ 멱등성·체크포인트·백오프 ⑤ **하트비트·마지막 성공 시각·알림** ⑥ 재부팅 복구·자원 누수 ⑦ 시크릿 위생
- **출력**: 요약(죽으면 언제 아는가) → 침묵 실패(**사고 시나리오**) → 복구·멱등 리스크 → 신뢰성 체크리스트(✅/❌) → Top 3
- **구분**: 웹 앱 런타임 로깅·트레이싱은 `observability-reviewer`, CI/CD·컨테이너는 `devops-reviewer`, 이미 난 장애의 원인 규명은 `debugger`
</details>

### 🧠 인프라 (개인 메모리)

> 웹·게임·콘텐츠 리뷰와 별개로, **사용자 개인의 파일 기반 장기기억**(`E:\claude_memory\`)을 값싼 모델로 대신 읽는 인프라 에이전트. 저장소의 첫 `haiku` 에이전트다. 메모리 회상 훅(세션 시작·"예전에 뭐라고 정했더라")으로 자동 호출되며, `/recall`로 수동 호출도 된다.

<details>
<summary><b>34. memory-recaller</b> (<code>/recall</code>) — 파일 기반 장기기억 회상</summary>

- **언제**: "예전에 뭐라고 정했더라", "그 프로젝트 메모리 찾아줘", 세션 시작 시 관련 컨텍스트 회상. 수동 회상은 `/recall <주제>`
- **성격**: 리뷰/설계가 아니라 사용자 개인 메모리 저장소를 대신 읽는 인프라. 무거운 모델(Opus/Fable)이 인덱스를 통째로 읽는 토큰 낭비를 없애려 값싼 `haiku`로 회상만 수행
- **회상 절차(폴백 3단)**: 인덱스 진입점 탐색 — ① `YYYYMMDD_MEMORY.md` 최신 날짜 → ② 날짜형이 없으면 `*MEMORY*`·`*INDEX*` 등 다른 이름 인덱스 폴백(토픽 파일 오인 금지) → ③ 그래도 없으면 `Grep` 전체 검색. 최신→과거 순 회상, 관련 토픽 파일 확인, `20260624_MEMORY.md`가 하한
- **출력**: `- <사실 한 줄> (출처: <파일명>)` 형식으로 관련 사실만 압축(원문 붙여넣기 금지). 없으면 "관련 메모리 없음"으로 정직 보고, 날짜·수치·결정은 보존
- **원칙**: 읽기 전용 — 메모리를 쓰거나 고치지 않음(저장·수정은 메인 세션이 담당)
</details>

<details>
<summary><b>60. self-reflector</b> (<code>/reflect-log</code> <code>/누적회고</code>) — 누적 관찰 로그 교차 세션 증류 (자기개선)</summary>

- **언제**: "요즘 반복되는 내 요구/교정 패턴 뽑아줘", 주기적 자기개선 회고. 여러 세션에 걸친 관찰 로그가 소스. 수동 호출 `/reflect-log`·`/누적회고`
- **성격**: ECC continuous-learning의 **규율만** E: 단일소스로 이식한 자기개선 루프의 증류 층. `observe-capture` 훅(UserPromptSubmit)이 매 프롬프트를 `E:\claude_memory\_observations\`에 append-only로 적재하면, 이 haiku 에이전트가 그 누적 로그를 교차 세션으로 훑는다
- **증류 절차**: 반복(여러 세션·여러 날) 신호만 추출(1회성 버림) → 관찰 횟수·세션 수로 신뢰도(0.3~0.9) 산정 → 기존 메모리와 같은 취지면 갱신·신뢰도 상향, 모순이면 하향 플래그 → 이미 메모리·CLAUDE.md·git에 있는 것은 노이즈로 버림
- **출력**: 학습 후보(대상 파일·frontmatter·`confidence`·`evidence`)를 신뢰도순으로 제안. 관찰 없으면 "누적 관찰 없음"으로 정직 보고
- **원칙**: 읽기 전용 — 메모리에 직접 쓰지 않음(기록은 메인 세션이 사용자 승인 후)
- **구분**: 특정 질의 회상만은 `memory-recaller`, 지금 보이는 이번 세션 하나 증류는 `/회고` 메인 리추얼(서브에이전트 없음)
</details>

### 🛠 엔지니어링 / 문서 / 메타 (1.60 추가)

<details>
<summary><b>35. refactor-strategist</b> (<code>/refactor</code>) — 동작 보존 리팩터 계획·단계 설계 (품질)</summary>

- **언제**: "이거 정리하고 싶다", 큰 변경 전 구조 정돈 (기능 변경 없이 구조만)
- **진단**: 책임 분리(과대 함수·God object), 중복·네이밍·매직 넘버, 의존 구조(순환·잘못된 방향), 데드코드·미사용, 변경 seam(특성화 테스트 경계)
- **원칙**: 동작 보존 최우선(관찰 가능한 동작 불변), 작고 되돌릴 수 있는 단계(추출→이동→개명→정리)로 쪼개고 각 단계 검증 지점 명시, 동작 바뀌는 개선(버그·기능)은 리팩터와 분리
- **출력**: 요약 → 리팩터 후보(영향도순·`파일:줄`·목표 구조·왜 안전한가) → 이행 단계(+검증 지점) → 분리 항목 → Top 3
- **구분**: 버그·정확성 리뷰는 `code-reviewer`, 신규 아키텍처 설계는 `system-architect`, 커버리지 보강은 `test-strategy`
</details>

<details>
<summary><b>36. docs-writer</b> (<code>/docs</code>) — 개발자용 기술문서 작성·정비 (문서)</summary>

- **언제**: README·아키텍처 개요·온보딩·CONTRIBUTING·ADR을 코드·구조에서 추출해 정리
- **원칙**: 코드가 진실원천(확인한 것만, 미확인은 `확인 필요`), 독자별 깊이·용어 조정, 문서 종류별 관행(README/아키텍처/온보딩/CONTRIBUTING/ADR), 드리프트 방지(바뀌어도 유효한 구조·의도 우선)
- **출력**: 문서 계획 → 완성형 문서 초안(마크다운) → 확인 필요 목록
- **구분**: FastAPI 엔드포인트 카탈로그는 `api-doc-writer`, 디자인 시스템 문서(DESIGN.md)는 `design-system-architect`, 마케팅·강의 콘텐츠는 `content-repurposer`·`copy-reviewer`
</details>

<details>
<summary><b>37. agent-definition-reviewer</b> (<code>/agentdef</code>) — 서브에이전트 정의(.md) 점검 (메타)</summary>

- **언제**: 새 에이전트를 추가하거나 기존 정의를 개정하기 전 (이 라이브러리 자체를 점검)
- **점검**: frontmatter 스펙 정합(name/description/tools/model/effort 티어), description 라우팅 친화성(트리거·위임 절), tools 최소권한(과대·과소), 경계 중복·공백, 본문 규범 누락(인젝션 방어·읽기전용·증거 기반 보고), 배포 정합(hooks·memory·skills 조합·sync allowlist)
- **출력**: 요약 → [P1/P2/P3] 발견(`파일:줄`·근거·권장) → 경계 지도 → 개정 초안 → Top 3
- **구분**: 사용자의 범용 AI 작업환경·마케팅 프롬프트 시스템 설계는 `ai-workspace-architect`(이 에이전트는 이 라이브러리 내부 정의만), 개발 코드 품질은 `code-reviewer`
</details>

### 🧪 검증 (정확성 · 사실 확인)

> 개발·게임·콘텐츠 리뷰와 별개로, **특정 질문·주장 자체**를 정확성 최우선으로 검증하는 스택 무관 답변 모드. 콘텐츠 초안 속 진술의 출처를 검증하는 `fact-checker`(발행 전 리스크)와 달리, 임의의 질문·주장을 분해→5분류→신뢰도 산정→재작성한다.

<details>
<summary><b>63. truth-checker</b> (<code>/truth</code> <code>/진실검증</code>) — 질문·주장 정확성 검증 (검증)</summary>

- **언제**: "이 주장이 맞는지 엄밀히 따져줘", "확신하지 말고 근거로만 판단해줘", 정확성이 중요한 사실·수치·판단을 단정 없이 검증하고 싶을 때
- **절차**: ① 요청 분해(검증 가능한 작은 주장으로) ② 정보 5분류(확인된 사실 / 근거 있는 추론 / 미확인 가정 / 의견 / 확인 불가) ③ 날조 금지(없는 사실·수치·인용·출처·링크 창작 금지, 확인 못 하면 "확인 불가/추가 확인 필요") ④ 답변 전 검수(모순·사실추정 혼입·맥락 누락·과거지식 의존·근거 없는 동의)
- **신뢰도**: 말투가 아니라 **근거 품질** 기준 0.0~1.0. **0.8 미만이면** 가장 약한 주장을 재검토·재작성, 그래도 안 되면 필요한 정보·확인 방법을 사용자에게 안내
- **최신성**: 변동 큰 정보(가격·정책·모델 성능·법률/의료/금융)는 과거 지식만으로 단정하지 않고 WebSearch/WebFetch로 확인·시점 명시, 안 되면 ⚠️추가 확인 필요
- **출력**: 검증 근거·분류 → **[명확한 답변]** → **[신뢰도]**(점수+이유 한 줄) → **[확인할 점]**(가정·모르는 정보·충돌 근거·사용자 확인 사항)
- **구분**: 콘텐츠 초안 속 통계·인용·출처 검증은 `fact-checker`, 이미 난 버그 원인 규명은 `debugger`, 파일 기반 장기기억 회상은 `memory-recaller`
</details>

### 💡 발상 (브레인스토밍 · 1.91 추가)

> 모든 실행(오퍼·이야기·게임 설계·강의 설계) **앞단의 아이디어 단계**를 전담하는 생성 에이전트. 다른 생성기가 "고른 방향을 실행"한다면, 이 에이전트는 **고를 후보 자체를 만든다** — 발산(서로 다른 렌즈)과 수렴(기준 채점)을 분리해, 사용자가 번호로 고르는 후보 목록을 낸다.

<details>
<summary><b>64. brainstormer</b> (<code>/brainstorm</code> <code>/발상</code>) — 아이디어 발산→수렴 브레인스토밍</summary>

- **언제**: 주제·문제·목표만 있고 구체 아이디어가 없을 때. 콘텐츠 소재·네이밍·훅·캠페인 각도·제품/기능 아이디어·게임 메카닉 씨앗·문제 해결 접근 등 도메인 무관. 수동 호출은 `/brainstorm <주제>`
- **방법(발산→수렴)**: ① 발산 — 최소 5개 렌즈(역발상·유추 차용·결합·제약 강화·극단화·타깃 전환·빼기)를 바꿔가며 렌즈당 3~5개, 인접 중복 제거, 판단 유보 → ② 수렴 — 명시 기준(기본 3축: 목적 적합도/실행 난이도/차별성) 채점, **Top 3 + 와일드카드 1**(고위험·고보상), 탈락 후보도 전체 목록에 보존
- **정직성**: 아이디어는 자유, 딸려 붙는 시장·수치·트렌드 주장은 창작 금지(`⚠️검증필요`). 사용자 제약을 임의로 버리지 않되 제약 밖 유망 후보는 "제약 밖" 표시로 별도 제시
- **출력**: 전제 요약 → 아이디어 전체 표(번호·이름·한 줄 설명·느낌/렌즈 — 번호로 고르기) → Top 3 추천(근거+첫 걸음) → 와일드카드 → 다음 단계 라우팅 → 채운 가정
- **구분**: 고른 방향의 실행은 전문 에이전트로 — 오퍼 설계는 `offer-strategist`, 이야기 집필은 `storyteller`, 소스 파생은 `content-repurposer`, 게임 시스템 설계는 `game-design-architect`, 강의 설계는 `curriculum-designer`, 사실 검증은 `fact-checker`·`truth-checker`
</details>

### ✍️ 창작 (스토리텔링)

> 개발 스택·마케팅 리뷰와 별개로, **프롬프트(뼈대)에 살을 붙여 이야기를 새로 짓는** 생성 에이전트. 저장소의 첫 `fable`(창작 특화 모델) 에이전트다. 기존 자산을 매체별로 각색하는 `content-repurposer`(재활용)와 달리 **없던 서사를 창작**한다.

<details>
<summary><b>38. storyteller</b> (<code>/story</code>) — 프롬프트에 살 붙여 완성형 이야기 작성 (창작)</summary>

- **언제**: 한 줄 아이디어·설정·인물·장르만 있고 완성형 이야기(단편·서사·시나리오·브랜드 스토리·에피소드)가 필요할 때. 수동 호출은 `/story <아이디어>`
- **모델**: 창작 특화 `fable`(+`effort: high`). 미가용 시 최강 모델로 폴백하되, 품질은 내장 작법 절차가 보장
- **작법(뼈대→살)**: ① 뼈대 확정(로그라인·인물 욕망/결핍·갈등·판돈·구조) → ② 살(show-don't-tell·감각 디테일·서브텍스트 대사·시점 일관성·페이싱) → ③ 자가 점검(전제 관통·동기 가시성·상투구·시점 흔들림) 후 약한 구간 재작성
- **원칙**: 표절 금지(오마주/패러디 한정), 사용자가 준 핵심 설정·결말 방향 보존(바꾸려면 대안 제안), 채운 가정 명시. 유해 실행 지침·미성년 성적 묘사·실존 인물 명예훼손은 거부
- **출력**: 로그라인 → 뼈대 요약 → 이야기 본문(제목) → 채운 가정 & 확장 포인트(더 길게/다른 결말/속편)
- **구분**: 기존 자산을 매체별로 파생하는 것은 `content-repurposer`, 카피 품질은 `copy-reviewer`, 확정 보이스 준수는 `brand-voice-guardian`, 프롬프트·지침 시스템 설계는 `ai-workspace-architect`
</details>

### 🧑‍💼 커리어 / 채용 (1.85 추가)

> 채용 공고(JD)를 해부해 지원자의 **실제 경험**을 그 요구에 맞게 재구성하는 생성 에이전트. 콘텐츠 생성기 계열이지만 마케팅이 아니라 **커리어 문서**를 다루는 별도 1종이다. 핵심 가드레일은 **없는 사실을 창작하지 않는 것**(허위기재 방지) — 프레이밍은 자유롭게, 팩트는 지원자가 준 것에서만.

<details>
<summary><b>59. cover-letter-tailor</b> (<code>/cover</code> <code>/자소서</code>) — 채용 공고에 맞춰 자기소개서 맞춤 재작성</summary>

- **언제**: 기업 공고와 기존 자소서(또는 경력·경험)가 있고, 그 공고에 맞게 자소서를 수정·재작성할 때. 슬래시 `/cover`·`/자소서`는 서식 다운로드·파일 저장까지 하는 **메인 세션 워크플로**(commands/cover.md)이고, 이 `cover-letter-tailor` 서브에이전트는 순수 텍스트 초안만 빠르게 필요할 때 쓰는 **선택적 보조**다(읽기 전용이라 파일 저장은 못 함)
- **맞춤 3단계**: ① 공고 해부(주요업무·자격·우대·인재상에서 요구 역량·키워드 3~7개 추출) → ② 매핑(지원자 경험 ↔ 요구, 근거 강도 강/중/**공백** 판정) → ③ 리라이트(두괄식·STAR·직무 연결·문항별 글자수 준수·상투구 제거)
- **정직성(최우선)**: 지원자가 준 사실만 사용 — 없는 경력·수상·자격·정량 수치 창작 금지. 근거 공백은 숨기지 않고 "이런 경험이 있으면 알려달라"로 되묻는다. 위조·과장 요청은 거부하고 위험(합격/채용 취소·법적 책임)을 밝힌 뒤 "가진 사실을 더 강하게" 대안으로 전환
- **출력**: 공고 요구역량 요약 → 매핑 표(공백 포함) → 문항별 완성본(글자수 표기) → 보강 제안(공백 메우기 질문) → 채운 가정
- **구분**: 마케팅 카피 품질은 `copy-reviewer`, 확정 브랜드 보이스 정합은 `brand-voice-guardian`, 1소스 멀티포맷 파생은 `content-repurposer`, 창작 서사는 `storyteller`, 외부 사실·수치 검증은 `fact-checker`
</details>

### 🐞 디버깅 (품질 · 1.64 추가)

> 기존 품질 에이전트가 모두 **증상이 없는 상태에서** 코드를 훑는 정적 리뷰(code-reviewer·unity-code-reviewer)이거나 **결과를 집계**하는 실행기(test-runner)인 반면, 이 에이전트는 **이미 나타난 증상에서 거꾸로** 원인을 추적한다(재현 → 가설 → 검증 → 이분 탐색). 스택 무관 — 웹(Next.js/FastAPI/MySQL)이 주력이지만 Unity C# 런타임 증상도 같은 절차로 다룬다.

<details>
<summary><b>39. debugger</b> (<code>/debug</code>) — 버그·에러·간헐 실패 근본 원인 규명</summary>

- **언제**: "왜 이 에러가 나는지 모르겠다", "가끔만 실패한다", "어제까진 됐는데", 프로덕션 장애 사후 분석. 수동 호출은 `/debug <증상>`
- **절차**: 증상 확정(기대 vs 실제·재현율·환경) → 최소 재현 → 관찰 수집(스택트레이스는 *우리 코드의 가장 깊은 프레임*부터) → 가설 3~5개(각각 반증 조건 명시) → 검증·축소(코드 경로·시간(`git log`/`blame` 회귀 시점)·입력·환경 이분) → 원인 확정 → 수정 방향·재발 방지
- **버그 클래스 렌즈**: 간헐·플레이키(경쟁 조건·순서 의존·시간/타임존), 상태·데이터(경계·부분 실패·트랜잭션), 경계 넘김(계약·직렬화·캐시 stale·하이드레이션), 동시성·자원(블로킹 I/O·풀 고갈·누수), 환경차("로컬은 되는데"), Unity 런타임(fake-null·구독 해제·프레임률 의존)
- **원칙**: 관찰이 추측을 이긴다(각 주장에 `파일:줄`·로그 근거), 첫 가설에 애착 금지, 한 번에 하나만 바꾼다, **못 밝히면 미확정으로 정직 보고**(그럴듯한 범인 창작 금지)
- **성능 축 카빙**: "무엇이 느린가"(병목 진단·측정 해석)는 `perf-auditor`·`db-optimizer`·`unity-perf-auditor`·`c-perf-auditor`·`dotnet-perf-auditor`, **"언제부터·무엇이 바뀌어 느려졌나"(회귀 시점 추적)는 이 에이전트** — 성능 회귀가 무주공산이 되지 않게 축으로 나눔
- **안전장치**: 코드·데이터 수정 안 함. 워킹트리를 바꾸는 `git bisect`·`checkout`·`stash`는 **직접 실행하지 않고 절차만 제시**. Bash는 재현·조회 전용(테스트 재실행·로그·git 이력). 계측이 필요하면 코드에 심지 않고 **임시 계측 계획**만 제시
- **출력**: 증상 요약 → 관찰된 사실(해석과 분리) → 가설·검증 표(판정: 확정/반증/미검증) → 근본 원인(인과 사슬·`파일:줄`) → 수정 방향(+형제 결함) → 재발 방지 테스트 → 미해결·다음 관찰
- **구분(경계)**: 테스트 실행·집계·1차 분류는 `test-runner`(테스트를 아직 안 돌렸으면 거기부터 — 안 풀리는 실패가 이 에이전트 몫), 증상 없는 정적 리뷰는 `code-reviewer`·`unity-code-reviewer`, 추적 인프라 공백은 `observability-reviewer`, 병목 진단은 `perf-auditor`·`db-optimizer`·`unity-perf-auditor`·`c-perf-auditor`·`dotnet-perf-auditor`, 취약점은 `security-reviewer`
</details>

### 🧩 시스템 언어 (C · 비-Unity .NET) — 1.72 추가

> 웹(code-reviewer)·게임(unity-code-reviewer)이 폴백으로만 훑던 **C와 비-Unity C#/.NET**을 전담하는 6종. 두 언어는 code-reviewer가 못 잡는 **고유 결함 표면**(C: 메모리 안전·UB·정수 변환 / .NET: async 계약·자원 수명·DI 수명·EF Core)이 프로젝트와 무관하게 참이라, 각 언어를 **리뷰·설계·성능** 3역으로 나눴다(웹·게임 트리오와 동형). 리뷰↔성능은 unity 쌍과 같은 **원인/증상 대칭**. Unity C#은 `unity-code-reviewer`가 계속 맡고, 이 클러스터는 비-Unity만 본다.

<details>
<summary><b>48. c-code-reviewer</b> (<code>/creview</code>) — C 코드 리뷰(메모리 안전·UB) (품질)</summary>

- **언제**: C 코드 커밋/머지 전 셀프 리뷰. `git diff`로 변경분 파악(Bash는 범위 식별 + **명시 요청 시** 읽기전용 정적분석 `-fsyntax-only`·cppcheck·clang --analyze, 빌드·실행 금지)
- **점검**: ① 공간 안전(버퍼 오버플로·off-by-one·널 종결자) ② 시간 안전/소유권(UAF·double-free·dangling·미초기화 읽기) ③ 널·반환값·`errno` 미검사(`p=realloc(p,...)` 함정) ④ 정수(시그니처드 오버플로·부호/폭 변환·크기 계산 오버플로→힙 오버플로) ⑤ UB(엄격 앨리어싱·시퀀스 포인트·널 산술) ⑥ 에러 경로 자원 누수(`goto cleanup` 일관성) ⑦ 포맷 스트링 ⑧ 동시성·시그널 안전성 ⑨ 매크로 함정
- **전제**: C의 메모리 안전 결함 = 보안 결함(RCE·정보 노출) — 웹 OWASP `security-reviewer`가 안 보는 층을 여기서 맡는다. "지금은 도는 UB"도 결함으로 보고
- **출력**: 요약 → Must fix(메모리·UB·정수·누수·포맷) → Should fix(소유권 계약·이식성·const) → Nit → 위임
- **구분**: 일반 품질·타 스택 폴백은 `code-reviewer`, 구조는 `c-architect`, 성능은 `c-perf-auditor`, 이미 난 크래시 원인은 `debugger`
</details>

<details>
<summary><b>49. c-architect</b> (<code>/carch</code>) — C 구조 설계 (설계)</summary>

- **언제**: 새 C 모듈·라이브러리·서브시스템을 만들기 전, 기존 구조 점검
- **전제**: C는 캡슐화·수명 관리를 언어가 강제하지 않는다 — **규율을 구조와 계약으로 만든다**
- **설계**: 모듈/헤더 경계(불투명 포인터·최소 공개 표면·순환 포함 차단), **메모리 소유권 모델**(누가 할당·해제하는지를 API 계약으로·이전 vs 대여), 에러 처리 전략(반환코드/errno/out-param 일관·단일 출구 정리), API/ABI 안정성(레이아웃·버저닝·심볼 가시성), 빌드 의존성 방향, 이식성 계층(플랫폼 추상화·`#ifdef` 격리), 동시성·할당 전략(아레나/풀 vs 개별 malloc)
- **출력**: (신규) 요구사항/가정 → 옵션 비교 표 → 권장안(모듈/소유권 다이어그램·API 스케치) → 단계 적용 / (점검) 진단 → 구조적 문제 → 개선 → 마이그레이션
- **구분**: 구현 코드 결함은 `c-code-reviewer`, 성능은 `c-perf-auditor`, 웹 아키텍처는 `system-architect`, .NET 구조는 `dotnet-architect`
</details>

<details>
<summary><b>50. c-perf-auditor</b> (<code>/cperf</code>) — C 런타임 성능 (성능)</summary>

- **언제**: 릴리스 전 성능 패스, "느리다" 보고, 프로파일러 캡처 해석
- **모드**: (1) 정적 감사 — 접근 패턴·할당·복사·복잡도 (2) 캡처 해석 — perf/gprof/cachegrind/callgrind/Massif
- **점검**: 캐시 지역성(AoS/SoA·스트라이드·**거짓 공유**·정렬), 할당 전략(핫 경로 개별 malloc→아레나/풀), 불필요 복사·루프 불변식, 알고리즘·자료구조 복잡도, 분기·핫/콜드 분리, 벡터화 저해 요인(`restrict`—정확성은 c-code-reviewer로), I/O 버퍼링
- **원칙**: 정적으로 "느리다"를 단정하지 않는다 — 성능 깎는 구성은 보고하되 실제 비용은 **측정 계획**으로 분리, 조기 최적화 경계. `c-code-reviewer`와 **원인/증상 대칭**
- **구분**: 코드 원인·UB는 `c-code-reviewer`, 회귀 시점은 `debugger`, 구조 재설계는 `c-architect`, 웹/.NET 성능은 `perf-auditor`·`dotnet-perf-auditor`
</details>

<details>
<summary><b>51. dotnet-code-reviewer</b> (<code>/dnreview</code>) — 비-Unity C#/.NET 코드 리뷰 (품질)</summary>

- **언제**: 비-Unity C# 코드 커밋/머지 전(ASP.NET Core·워커·콘솔·WPF·라이브러리). `git diff`로 범위 파악(Bash는 범위 식별만)
- **점검**: ① async(`.Result`/`.Wait()` 데드락·`async void`·미대기 Task·취소 미전파·`ConfigureAwait`) ② 자원 수명(IDisposable/`using` 누락·`HttpClient` 소켓 고갈·이벤트 미해제) ③ 지연 실행(IEnumerable 다중 열거·열거 중 변경) ④ nullable(`!` 남용·NRE) ⑤ **DI 수명**(captive dependency·`DbContext` 공유) ⑥ EF Core(N+1·클라 평가·추적 낭비·`SaveChanges` 누락) ⑦ 예외(삼킴·`throw ex` 스택 소실) ⑧ 값/참조 의미·문화권 파싱
- **출력**: 요약 → Must fix(데드락·누수·captive dependency·다중 열거) → Should fix(nullable·EF·문화권) → Nit → 위임
- **구분**: Unity C#은 `unity-code-reviewer`, 웹 JS/파이썬 폴백은 `code-reviewer`, 구조는 `dotnet-architect`, 성능은 `dotnet-perf-auditor`, 보안은 `security-reviewer`
</details>

<details>
<summary><b>52. dotnet-architect</b> (<code>/dnarch</code>) — .NET 구조 설계 (설계)</summary>

- **언제**: 새 .NET 서비스·모듈을 만들기 전, 기존 구조 점검. 버전 의존 패턴은 Context7로 확인
- **설계**: 계층 분리(엔드포인트/앱/도메인/인프라·Minimal API vs 컨트롤러), **DI 서비스 수명 설계**(싱글턴/스코프드/트랜지언트·captive dependency 예방·`DbContext` 수명), 미들웨어 파이프라인 순서, 호스팅(`BackgroundService`·그레이스풀 셧다운·큐 소비), 옵션 패턴(`IOptions`·시크릿), async 경계(끝까지 async·취소 전파), 프로젝트 의존성 방향(순환 차단), 복원력(재시도·서킷브레이커)
- **출력**: (신규) 요구사항/가정 → 옵션 비교 → 권장안(계층·DI 수명·파이프라인 다이어그램) → 단계 적용 / (점검) 진단 → 구조적 문제 → 개선 → 마이그레이션
- **구분**: 구현 코드 결함은 `dotnet-code-reviewer`, 성능은 `dotnet-perf-auditor`, 웹 풀스택은 `system-architect`, C 구조는 `c-architect`, 배포·컨테이너는 `devops-reviewer`
</details>

<details>
<summary><b>53. dotnet-perf-auditor</b> (<code>/dnperf</code>) — .NET 런타임 성능 (성능)</summary>

- **언제**: 릴리스 전 성능 패스, "느리다·GC가 튄다" 보고, 측정 캡처 해석
- **모드**: (1) 정적 감사 — 할당·GC 압력·비싼 경로 (2) 캡처 해석 — BenchmarkDotNet/dotnet-counters/dotnet-trace/PerfView
- **점검**: **GC 압력**(할당률·세대 0/1/2 승격·**LOH 단편화**·Server vs Workstation GC), 할당 절감(`Span<T>`/`stackalloc`/`ArrayPool`·struct vs class·박싱·클로저 캡처), 문자열(연결·보간→`StringBuilder`/`ReadOnlySpan<char>`), async 오버헤드(상태머신 할당·`ValueTask`), LINQ 중간 컬렉션, 컬렉션 선택·용량 예약, 직렬화, JIT/AOT·티어드
- **원칙**: 정적으로 "느리다" 단정 금지 — 할당 유발 구성은 보고하되 실제 비용은 **측정 계획**으로. `dotnet-code-reviewer`와 **증상/원인 대칭**
- **구분**: 할당 유발 코드·EF 안티패턴은 `dotnet-code-reviewer`, 회귀 시점은 `debugger`, 구조는 `dotnet-architect`, Unity 성능은 `unity-perf-auditor`, MySQL 튜닝은 `db-optimizer`
</details>

### 🎓 교육 / 교수설계 (콘텐츠 · 2026-07-15 추가)

> 콘텐츠 계열의 **교육/교수설계 생성기**. 기존 콘텐츠/마케팅 6종·창작 1종과 별개인 "교육 1종"으로, 강의·워크숍·강좌·교육 자료를 사람이 배우도록 설계한다(읽기 전용 — 파일 미수정, 완성형 커리큘럼 맵+모듈 초안을 텍스트로 낸다).

<details>
<summary><b>54. curriculum-designer</b> (<code>/curriculum</code> <code>/강의설계</code>) — 강의·워크숍 교수 설계</summary>

- **언제**: 강의·워크숍·강좌·교육 자료(온·오프라인)를 만들기 전 교수 설계가 필요할 때. 수동 호출은 `/curriculum <주제·대상·시간>`
- **절차(backward design)**: ① 학습자·맥락 분석(선수지식·동기·제약·시간 예산) → ② 측정 가능한 학습 목표(Bloom's 동사) → ③ 목표에 정렬된 형성·총괄 평가 → ④ 목표·평가에 맞춘 활동·콘텐츠(목표-평가-활동 정렬, constructive alignment)
- **설계**: 모듈 분해·선수관계 계열화, 난이도 곡선·페이싱, 학습 경험 흐름(도입·동기→설명→시연→실습→피드백→정리), 인지부하 청킹, 슬라이드·핸드아웃·강사 노트 골격, 시간 배분
- **출력**: 커리큘럼 맵(목표·모듈·평가 정렬표) → 모듈별 초안(학습 목표·활동·시간 배분·평가) → 슬라이드/핸드아웃/강사 노트 골격 → 채운 가정 & 확장 포인트
- **구분**: 강의 홍보 카피는 `copy-reviewer`, 완성된 강의를 다른 포맷으로 파생하는 것은 `content-repurposer`, 개발자 문서·튜토리얼은 `docs-writer`, 사실 검증은 `fact-checker`, AI 작업환경 설계는 `ai-workspace-architect`
</details>

### 🧩 시스템 언어 — Java · Swift (2026-07-15 추가)

> 시스템 언어 클러스터를 **Java(JVM)·Swift**로 확장한 4종. C/.NET 트리오와 달리 **리뷰어+아키텍트 2역씩**만 두고 **전담 perf 에이전트는 의도적으로 만들지 않았다**(프로모션 게이트 — 각 언어의 성능 점검 수요가 실제 작업에서 반복될 때까지 유보). 두 리뷰어는 이 공백을 **"전담 perf 에이전트 없음(알려진 공백)"**으로 정직하게 명시한다. 리뷰어는 `Bash`(git diff 범위 식별 + 명시 요청 시 읽기전용 정적분석, 빌드·실행 금지), 아키텍트는 `Context7`(Spring/`jakarta.*`·`@Observable`/NavigationStack 등 버전 의존 패턴 확인)을 갖는다.

<details>
<summary><b>55. java-code-reviewer</b> (<code>/jreview</code>) — Java(JVM) 코드 리뷰 (품질)</summary>

- **언제**: 서버/JVM Java 코드 커밋/머지 전 셀프 리뷰. `git diff`로 변경분 파악(Bash는 범위 식별 + **명시 요청 시** 읽기전용 정적분석, 빌드·실행 금지)
- **점검(Java 고유)**: ① NPE·널 처리(필드/파라미터 `Optional` 오용·미검사 `get()`) ② 예외 정책(빈 `catch`·`catch(Exception)` 삼킴·원인 체이닝 소실·try-with-resources 미사용) ③ 자원 수명(AutoCloseable/스트림/커넥션 누수) ④ JVM 동시성(volatile을 원자성으로 오해·비스레드안전 `SimpleDateFormat`·`ConcurrentModificationException`·데드락) ⑤ `equals`/`hashCode`/`compareTo` 계약(HashMap 키·가변 키) ⑥ 제네릭(로 타입·미검사 캐스트·소거) ⑦ 오토박싱(`Integer` 캐시 `==`·언박싱 NPE·`double`로 금액) ⑧ String/로케일 ⑨ Stream 부작용
- **범위**: 서버·JVM Java 전담 — **Android/Kotlin 프레임워크는 대상 밖(인접 공백으로 명시)**. **전담 perf 에이전트 없음(알려진 공백)** — 성능 의심은 측정 권고로만 분리
- **출력**: 요약 → Must fix → Should fix → Nit → 위임
- **구분**: 일반 품질·타 스택 폴백은 `code-reviewer`, 구조는 `java-architect`, 이미 난 크래시 원인은 `debugger`, 보안은 `security-reviewer`
</details>

<details>
<summary><b>56. java-architect</b> (<code>/jarch</code>) — Java/Spring 구조 설계 (설계)</summary>

- **언제**: 새 Java/Spring 서비스·모듈을 만들기 전, 기존 구조 점검. 버전 의존 패턴(Spring·`jakarta.*`)은 Context7로 확인
- **설계**: 계층 분리(controller/service/repository/domain·헥사고날·의존성 안쪽 방향), **빈 수명**(생성자 주입·빈 스코프·싱글턴 빈의 가변 상태 스레드 안전·순환 의존), 모듈/패키지 의존 방향, 에러 전략(checked/unchecked 정책·경계 변환 `@ControllerAdvice`), 동시성(executor 소유권·불변성·`@Async` 경계), 영속성 경계(엔티티 vs DTO·`@Transactional` 전파·OSIV)
- **출력**: (신규) 요구사항/가정 → 옵션 비교 → 권장안(계층·빈 수명 다이어그램) → 단계 적용 / (점검) 진단 → 구조적 문제 → 개선 → 마이그레이션
- **구분**: 구현 코드 결함은 `java-code-reviewer`, 웹 풀스택은 `system-architect`, .NET 구조는 `dotnet-architect`, C 구조는 `c-architect`, 배포·컨테이너는 `devops-reviewer`
</details>

<details>
<summary><b>57. swift-code-reviewer</b> (<code>/swreview</code>) — Swift 코드 리뷰 (품질)</summary>

- **언제**: Swift 코드 커밋/머지 전 셀프 리뷰. `git diff`로 변경분 파악(Bash는 범위 식별 + **명시 요청 시** 읽기전용 정적분석, 빌드·실행 금지)
- **점검(Swift 고유)**: ① 옵셔널 안전(강제 언랩 `!`/`try!`/`as!` 크래시·IUO) ② **ARC retain cycle**(클로저 `[weak self]` 누락·강한 delegate 참조·`unowned` 오용) ③ 값/참조 의미(struct vs class·COW) ④ 에러 삼킴(`try?`·force-try) ⑤ 동시성(async/await·actor 격리·`@MainActor` UI 스레드·Sendable 데이터 레이스·`DispatchQueue.main.sync` 데드락·continuation 이중 재개) ⑥ 프로토콜/제네릭 existential 비용·클로저 캡처 ⑦ 열거 망라성 ⑧ force-cast ⑨ Codable
- **범위**: **전담 perf 에이전트 없음(알려진 공백)** — 성능 의심은 측정 권고로만 분리
- **출력**: 요약 → Must fix → Should fix → Nit → 위임
- **구분**: 일반 품질·타 스택 폴백은 `code-reviewer`, 구조는 `swift-architect`, 이미 난 크래시 원인은 `debugger`, 보안은 `security-reviewer`
</details>

<details>
<summary><b>58. swift-architect</b> (<code>/swarch</code>) — Swift 앱 구조 설계 (설계)</summary>

- **언제**: 새 Swift 앱·모듈을 만들기 전, 기존 구조 점검. 버전 의존 패턴(`@Observable`·NavigationStack)은 Context7로 확인
- **설계**: 아키텍처 패턴 선택(MVVM/TCA/VIPER/Clean, 규모별), 모듈 경계(SPM/프레임워크 타깃·비순환 의존), DI(이니셜라이저/Environment 주입·싱글턴 남용 회피·프로토콜 seam), 동시성 아키텍처(actor 격리·`@MainActor` 경계·구조적 동시성·Sendable), **SwiftUI 상태 관리**(단일 진실 원천·`@State`/`@StateObject`/`@ObservedObject`/`@Binding`/`@Environment` 소유권 배치·`@Observable`), 내비게이션, 값 타입 우선 도메인 모델링, 영속성·네트워킹 경계
- **출력**: (신규) 요구사항/가정 → 옵션 비교 → 권장안(아키텍처·상태 소유권 다이어그램) → 단계 적용 / (점검) 진단 → 구조적 문제 → 개선 → 마이그레이션
- **구분**: 구현 코드 결함은 `swift-code-reviewer`, 웹 풀스택은 `system-architect`, .NET 구조는 `dotnet-architect`, C 구조는 `c-architect`
</details>

### 🆕 1.92 신설 — 외부 라이브러리 대조로 채운 공백 9종

공개 모음집 [msitarzewski/agency-agents](https://github.com/msitarzewski/agency-agents)(MIT, 308종)의 프론트매터를 전수 대조해 이 라이브러리에 **없던 각도만** 추린 결과다. 내용만 취하고 형식은 저장소 규범으로 다시 썼다. 소속 클러스터는 각 항목에 표시한다.

**65. ai-code-auditor (`/aicode`, `/에이아이코드`)** — 🔒 보안 심화 · opus · **effort xhigh**
AI 코딩 도구가 **기본값으로** 남기는 결함만 본다. ① 클라이언트 도달 시크릿(`NEXT_PUBLIC_`/`VITE_`/`PUBLIC_`/`EXPO_PUBLIC_` 접두사 뒤·`service_role` 키·빌드 산출물) ② 행 수준 보안 허울(`USING (true)` 블랭킷·RLS on + 정책 0개·world-readable storage·클라이언트가 수정 가능한 `user_metadata`로 권한 판정) ③ 요청 입력→LLM 싱크 taint 추적, 심각도는 **도달 위치**로 결정(자기 user-role 메시지면 침묵 / 시스템 프롬프트면 medium / 툴 호출이 붙으면 high). 최우선 규율은 **오탐보다 미탐** — 늑대를 외치는 도구는 음소거되고 음소거된 도구는 아무것도 지키지 않으므로, 공개 설계 키(anon·publishable·Firebase 웹 config)는 영구 침묵 목록이다. 발견마다 CWE + fingerprint를 달아 scan→fix→rescan에서 해결/잔존/신규를 구분하고, 시크릿은 **회전 절차까지** 제시하되 원문 값은 보고에 되찍지 않는다. "몇 % 안전" 같은 보증 숫자 대신 **가시 범위**를 밝힌다.
→ 스택 전반 OWASP는 `security-reviewer`, LLM 기능 심화는 `llm-ai-security-reviewer`, 설계 단계 위협 모델링은 `threat-modeler`, 인증 구조 설계는 `identity-access-architect`, 누적 드리프트는 `codebase-archaeologist`.

**66. codebase-archaeologist (`/archaeo`, `/코드고고학`)** — 🛠 엔지니어링 · opus · effort high
코드베이스를 파일이 아니라 **지층**으로 읽는다. 드리프트는 절대 공표되지 않으므로("3월에 쓴 것과 모순된다"는 커밋 메시지는 없다) 일은 발견이 아니라 역사 재구성이다. 유사 파일 비교로 **절대 안 잡히는 두 클래스를 독립 패스로 강제**한다 — ④ 이벤트·웹훅 핸들러의 상태 존재 가정(명시적 존재 체크·upsert·큐 순서 계약·트랜잭션만 보장으로 인정하고 주석·이벤트 이름 뉘앙스는 불인정) ⑤ 금액·단위·표현 추적(변수명이 완전히 달라도 하류 전수 추적, 에러가 안 나도 flag). 그 밖에 같은 책임의 병렬 구현·폴백 순서 역전·이중 변환·유사 이름 혼동·문서와 동작 괴리·반쪽 수정. 규율: **사람이나 도구를 지목하지 않고**, 최신 코드가 옳다고 가정하지 않으며, 안전하려고 Critical을 주지 않고, 검증해서 안전한 것도 "확인함"으로 남긴다. 산출은 4뷰 레지스트리(발견별·시대별·책임별·위험별)이며 **발견을 삭제하지 않는다**("Won't Fix"로 보존해 재발견을 막는다). `Bash`는 `git log` 이력 조회 전용.
→ 증상이 있는 버그는 `debugger`, 변경분 한 건 리뷰는 `code-reviewer`, 정리 단계 설계는 `refactor-strategist`, 보안 기본값은 `ai-code-auditor`.

**67. identity-access-architect (`/autharch`, `/인증설계`)** — 🏗 설계 · opus · **effort xhigh**
신원 표면 전담 아키텍트. 판단 기준은 늘 같다 — **지루하고 표준화되고 검증 가능한 것이 영리한 것을 이긴다**. 절대 규칙 4개: 인증 프리미티브를 발명하지 않는다 / 클라이언트는 권위가 아니다 / **테넌트 격리는 데이터 계층의 성질이다**(개발자가 WHERE 절을 잊지 않는 것에 의존하면 실패한 설계) / JWT는 서명됐을 뿐 비밀이 아니다. 다루는 축: OAuth2/OIDC 콜백 검증 전량(`state`·`nonce`·PKCE를 짧은 TTL로 저장하고 콜백 후 즉시 폐기, `redirect_uri` 정확 일치, issuer·audience·`alg` 허용목록), 세션 결정 표(불투명 서버 세션 vs 단명 JWT+회전 refresh — refresh 재사용 감지 시 토큰 패밀리 전체 폐기), 토큰 수명을 **폭발 반경**으로 산정, 패스키(`rpID` 결박이 피싱 저항의 실체, signCount 감소 = 복제 신호), SSO/SCIM(assertion 서명·audience·`InResponseTo`·replay 캐시·인증서 회전·디프로비저닝 지연·감사되는 break-glass), RBAC→ABAC/ReBAC 승격 게이트. **해피패스는 쉬운 20%**이므로 실패 경로부터 설계한다. xhigh 근거: 인증 설계 결함은 배포 후 되돌리기가 가장 비싸다.
→ 구현된 코드 취약점은 `security-reviewer`, STRIDE 전반은 `threat-modeler`, 스택 구조는 `system-architect`, AI 스캐폴딩 기본값은 `ai-code-auditor`.

**68. video-optimizer (`/video`, `/영상`)** — 📣 콘텐츠 · opus · effort high
"패키징이 클릭 → 훅·페이싱이 리텐션 → 세션 설계가 추천"의 3단 모델. 제목은 항상 3방향(호기심·검색·베네핏)을 동시에 내고, 썸네일은 3요소(비주얼·텍스트 3단어 이내·컬러)로 명세하되 **모바일 크기로 판정**한다. 제목-썸네일은 합쳐 하나의 마이크로 스토리여야 하며 같은 정보를 두 번 말하면 절반을 버린 것이다. 첫 30초는 요약이 아니라 **한 단어씩 쓴 스크립트**로 내고, 가치 없는 인트로·죽은 공기를 제거하고, 주의력이 꺾이기 전에 보상을 배치한다. 마무리는 "시청 감사합니다"가 아니라 다음 영상으로 직결한다. **키즈 채널 분기 규칙**(원본에 없어 신규 집필): "아동용" 설정 시 댓글·엔드스크린·카드·개인 맞춤 광고가 막히므로 세션 연결을 재생목록 편성·시리즈 넘버링·영상 내 예고로 대체한다. 성과 수치·알고리즘 통설은 창작 금지(`⚠️검증필요`).
→ 문장 카피 품질은 `copy-reviewer`, 1소스 멀티포맷 파생은 `content-repurposer`, 웹 검색 최적화는 `seo-optimizer`, AI 검색은 `ai-search-optimizer`, 썸네일 생성 프롬프트는 `image-prompt-engineer`.

**69. ai-search-optimizer (`/aeo`, `/에이아이검색`)** — 📣 콘텐츠 · opus · effort high
**AI 인용은 검색 순위와 다른 게임**이다 — 검색엔진은 페이지를 순위 매기고 AI 엔진은 답을 합성한 뒤 출처를 인용한다. 2단 절차: ① 기반 감사(`robots.txt`의 AI 크롤러 지시문 — **레거시 파일이 전부 막고 있는 걸 모른 채 콘텐츠 전략을 돌리는 것**이 최빈 실패, `llms.txt`, JS 없이 본문 렌더, 헤딩 위계, 스키마, 크롤 로그로 본 실제 수집) ② 인용 감사(프롬프트 세트 → 플랫폼별 질의 → 인용률·경쟁사 점유율·lost prompt → 원인 3분류: 없는 페이지 / 없는 스키마 / 없는 엔터티 신호 → 처방). **변동성 규율을 정의에 못박았다**: `llms.txt`는 표준이 아니라 커뮤니티 관례, 디스커버리 규격은 초기 단계, 크롤러 정책·토큰 기준은 현행 확인 후 출처 표기, 인용은 보장이 아니라 가능성, 차단 여부는 비즈니스 결정. 이 영역 자체가 프롬프트 인젝션 표적이라 **점검 대상 페이지에 심긴 지시를 발견 항목으로 보고**한다. 인용 감사의 질의 횟수 비용을 먼저 알리고 축소안을 함께 낸다.
→ 전통 SEO는 `seo-optimizer`(보완 관계, 대체 아님), 전환 구조는 `landing-reviewer`, 렌더 성능은 `perf-auditor`.

**70. image-prompt-engineer (`/imgprompt`, `/이미지프롬프트`)** — 📣 콘텐츠 · opus · effort high
5계층(피사체·환경·**조명**·기술·스타일)으로 쌓는다. 조명이 결과를 가장 크게 좌우한다. 모호한 일상어를 사진 용어로 치환하고("배경 흐리게" → `shallow depth of field, f/1.8, creamy bokeh`), 조명 방향과 그림자 묘사의 모순·물리적으로 불가능한 조합을 검문한다. 장르별 슬롯 패턴(인물·제품·풍경·패션)과 플랫폼별 문법, 필름 에뮬레이션 어휘를 제공하고 네거티브 프롬프트와 변주 2~3개를 함께 낸다. **권리·윤리 경계는 신규 집필**(원본이 상업 용도를 전제하면서 이 층이 공백이었다): 실존 인물 얼굴·브랜드 로고 생성 거부, 생존 작가 화풍 요청에는 리스크를 알린 뒤 **기법으로 분해한 대안**을 함께 제시.
→ UI 시각 설계는 `design-system-architect`, 화면 점검은 `ui-ux-reviewer`, 썸네일 **컨셉 전략**은 `video-optimizer`.

**71. proposal-strategist (`/proposal`, `/제안서`)** — 📣 콘텐츠 · opus · effort high
판정 기준 하나: **고객사 이름을 바꿔도 말이 되는 제안서는 이미 지고 있다**. 승리 테마 2~3개(1인 규모에선 줄이는 편이 집중도가 오른다)에 스트레스 테스트 4문항을 건다 — 특히 4번 "경쟁사가 똑같이 주장하기 어려운가"에서 걸리면 테마가 아니라 업계 상식이다. 3막 서사(과제 이해로 신뢰 확보 → 역량을 과제에 매핑한 여정 → 정량화된 변화 후 상태)와 경영진 요약 5단을 낸다. **경영진 요약은 요약이 아니라 맨 앞에 놓인 최종 변론**이며 작성 순서상 이것을 먼저 쓴다(디테일이 번식하기 전에 논증을 강제). 빈 형용사 제거·모든 주장에 증거·경쟁사 직접 비판 금지·가격은 가치 뒤에. 원본이 대기업/정부 조달(Shipley·color team·capture) 전제라 **1인 규모 체크포인트 환산표를 신규 집필**했다(black hat → 스스로 쓰는 1페이지 반박문, 검토위원회 → 업계 밖 지인 5분 스캔, 콘텐츠 라이브러리 → 섹션이 아니라 **테마별**). `cover-letter-tailor`와 동일한 창작 금지 규율.
→ 오퍼 자체 설계는 `offer-strategist`, 페이지 전환은 `landing-reviewer`, 문장 품질은 `copy-reviewer`, 자소서는 `cover-letter-tailor`.

**72. level-designer (`/level`, `/레벨`)** — 🎮 게임 · opus · effort high
게임 9종에 통째로 비어 있던 **공간 설계** 층. `game-design-architect`가 시스템을 설계한다면 이쪽은 그 시스템이 놓일 공간을 설계한다 — 통로는 문장, 방은 문단, 레벨은 하나의 주장. 원본이 3D·FPS·오픈월드 전제라 **2D 어휘로 번역**했다(치수→타일/유닛, 3층 조명→명도·채도 대비와 실루엣, 엄폐물→발판·안전 지대, 인카운터→장애물 구간·퍼즐 방). 절대 규칙 4개: **불공정 사망 금지**(화면 밖 투사체·예고 없는 낙사) / **아트가 레이아웃을 구제하지 못한다**(그레이박스 플레이테스트 통과 전 드레싱 금지, 예외 없음) / 난이도는 공간 먼저 수치는 나중 / **설계자의 의도는 증거가 아니다**(테스트에서 실제 관찰된 해법 2개 이상이어야 유효). 절차적 생성의 도달 가능성·해결 가능성 자동 검증은 2D 타일 퍼즐에 이식 가치가 높아 유지했고, 멀티플레이 맵 설계는 범위 밖으로 제외했다. 페이싱 차트는 예측이지 사실이 아니라고 명시한다.
→ 코어 루프·시스템은 `game-design-architect`, 손맛은 `game-feel-reviewer`, HUD·메뉴는 `game-ui-reviewer`, 사람 플레이테스트는 `playtest-designer`.

**73. knowledge-gardener (`/garden`, `/지식정원`)** — 🧠 인프라 · **opus**(기존 인프라 2종은 haiku) · effort high
지식은 폴더 계층이 아니라 **링크와 인덱스 항목으로 자란다**는 전제. 원자성·고립 노트·끊어진 링크·인덱스 커버리지·중복 분산·사건 대 상록 분리·썩은 노트·명명 일관성을 점검하고, 깊이 읽은 자료의 구조 노트 설계와 각 제안에 대한 반론 질문(Gegenrede)을 낸다. **rho 환경의 고정 사실을 절대 규칙으로 못박았다**: `E:\claude_memory`가 단일 소스이고 C드라이브 `MEMORY.md`는 포인터이므로 **그쪽에 쓰자는 제안 금지**(원본의 "루트 MEMORY.md에 복사" 단계를 그대로 옮기면 규칙 위반), `_observations`는 원자료라 점검·정리 대상 제외, `project_active.md`와 중복되는 open-loops 파일 신설 금지, 삭제 후보는 경로·크기·수정일·근거를 붙여 개별 확인이 가능하게. 옵시디언 볼트와 `E:` 두 체계에 어느 점검 축이 적용되는지 표로 분리한다. 원본의 페르소나 전환 기능(Feynman·Munger 등)은 저장소 규범과 충돌해 폐기했다. **읽기 전용** — 기록·이동·삭제는 메인 세션이 승인 후 수행.
→ 질의 기반 회상은 `memory-recaller`, 관찰 로그 증류는 `self-reflector`, 코드 문서화는 `docs-writer`.

### 역할이 겹치기 쉬운 쌍 (양방향 위임)

양쪽 description이 서로를 가리키는 대칭 위임(`↔`) — 어느 쪽으로 호출해도 인접 영역으로 안내된다. 1.56의 전수 스캔 34쌍에서 1.64·1.67~1.72·1.89·1.91을 거치며 늘어 **현재 63쌍**이며 클러스터별로 나눈다.

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

**콘텐츠 / 마케팅 (5쌍)**
| 쌍 | 구분 |
|---|---|
| copy-reviewer ↔ landing-reviewer | 문장 카피 품질 ↔ 상세페이지·랜딩 전환 구조 |
| copy-reviewer ↔ seo-optimizer | 설득·문장 품질 ↔ 검색 최적화 |
| landing-reviewer ↔ seo-optimizer | 전환 구조 ↔ 검색 유입 |
| truth-checker ↔ fact-checker | 질문·주장 자체 "정확성 검증"(신뢰도 산정) ↔ 콘텐츠 초안 속 진술 "출처 검증" ⟵ 1.89 |
| brainstormer ↔ offer-strategist | 오퍼 방향·네이밍 후보 "발산·수렴"(고르기 전) ↔ 고른 방향의 오퍼 "설계" ⟵ 1.91 |

**보안 (3쌍)**
| 쌍 | 구분 |
|---|---|
| security-reviewer ↔ threat-modeler | 코드 취약점(구현 후) ↔ 설계 단계 위협 모델링 |
| security-reviewer ↔ llm-ai-security-reviewer | 웹 앱 일반 보안 ↔ AI/LLM 특화 심화 |
| threat-modeler ↔ llm-ai-security-reviewer | 설계 단계 위협(LLM 포함) ↔ 구현 후 AI/LLM 심화 |

**게임 (Unity + C# · MSW, 17쌍)**
| 쌍 | 구분 |
|---|---|
| game-design-architect ↔ unity-code-reviewer | 코어 루프·시스템 "설계" ↔ C# 코드 품질·프레임 "리뷰" |
| game-design-architect ↔ multiplayer-rule-reviewer | 룰을 "설계" ↔ 그 룰이 서버에서 실제로 "강제되는지" 검증 ⟵ 1.67 |
| unity-code-reviewer ↔ multiplayer-rule-reviewer | Unity C# "엔진 코드" ↔ 엔진 무관 "룰·서버 권위" 층(MSW mlua) ⟵ 1.67 |
| debugger ↔ multiplayer-rule-reviewer | 이미 난 증상의 "원인 규명" ↔ 증상 없이 룰·권위 결함 "선제 점검" ⟵ 1.67 |
| save-data-reviewer ↔ migration-reviewer | 클라이언트·게임 "세이브"(스키마 진화·손상 복구) ↔ 서버 DB "마이그레이션"(락·백필·롤백) ⟵ 1.68 |
| save-data-reviewer ↔ multiplayer-rule-reviewer | 데이터가 "살아남는가"(스키마·손상) ↔ 값을 "누가 정하는가"(서버 권위·멱등성) ⟵ 1.68 |
| game-localization-reviewer ↔ game-ui-reviewer | "문자열·폰트·번역 파이프라인" ↔ "레이아웃·스케일링·내비게이션" ⟵ 1.69 |
| game-test-strategy ↔ playtest-designer | **기계** 테스트(자동) ↔ **사람** 플레이테스트 ⟵ 1.69 |
| game-audio-reviewer ↔ game-feel-reviewer | 오디오 "믹싱·재생 구조" ↔ 사운드가 동작과 "동기화되는 타이밍" ⟵ 1.69 |
| game-audio-reviewer ↔ game-ui-reviewer | "그 소리가 어떻게 재생되는가"(믹서·중복·비용) ↔ "어떤 소리가 나야 하는가"(UI 조작음 일관성·무음 대체) ⟵ 1.71 |
| game-audio-reviewer ↔ unity-perf-auditor | 오디오 "구조·청감 품질" ↔ 오디오 "메모리·CPU 프레임 예산" ⟵ 1.69 |
| game-design-architect ↔ playtest-designer | "무엇을 검증할지"(재미 가설) ↔ "어떻게 검증할지"(프로토콜) |
| game-feel-reviewer ↔ game-ui-reviewer | 게임플레이 동작 피드백 ↔ UI 조작 피드백 |
| game-feel-reviewer ↔ playtest-designer | 손맛 장치·프로토타입 검증 항목 ↔ 검증 프로토콜 |
| unity-code-reviewer ↔ unity-perf-auditor | GC 유발 코드 "원인" ↔ 프레임 예산 "증상·측정 해석" |
| unity-build-auditor ↔ unity-perf-auditor | 텍스처 압축 "빌드 용량" ↔ "런타임 메모리·GPU" |
| brainstormer ↔ game-design-architect | 게임 아이디어·메카닉 씨앗 "발산·수렴"(고르기 전) ↔ 고른 방향의 시스템 "설계" ⟵ 1.91 |

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
| debugger ↔ unity-code-reviewer | 이미 난 런타임 오동작·크래시 "원인 규명"(스택 무관) ↔ 엔진 특유 코드 결함 "정적 리뷰" ⟵ 1.64 |
| perf-auditor ↔ unity-perf-auditor | 웹 프론트 성능(번들·CWV) ↔ Unity 런타임 성능·렌더링 |
| system-architect ↔ game-design-architect | 풀스택 웹 아키텍처 ↔ 2D 캐주얼 게임 디자인·시스템 |
| devops-reviewer ↔ unity-build-auditor | 일반 CI/CD·시크릿·파이프라인 ↔ Unity 빌드/릴리스·스토어 제출 |
| test-strategy ↔ playtest-designer | 소프트웨어 자동 테스트 ↔ 사람 대상 플레이테스트 |
| game-test-strategy ↔ test-strategy | 게임(엔진 seam·EditMode/PlayMode·결정론) ↔ 웹(pytest·Vitest·Playwright) ⟵ 1.69 |

**시스템 언어 (C · 비-Unity .NET · Java · Swift, 7쌍)** — 1.72 신설, 2026-07-15 Java·Swift 확장
| 쌍 | 구분 |
|---|---|
| c-code-reviewer ↔ c-perf-auditor | C 성능 깎는 코드 "원인·UB" ↔ 캐시·할당 "증상·측정 해석" (원인/증상 대칭) |
| dotnet-code-reviewer ↔ dotnet-perf-auditor | .NET 할당 유발 "코드 원인·EF 안티패턴" ↔ GC "증상·측정 해석" (원인/증상 대칭) |
| dotnet-code-reviewer ↔ unity-code-reviewer | **비-Unity** C#/.NET(async·DI·EF Core) ↔ **Unity** C#(수명주기·GC·프레임) |
| c-architect ↔ system-architect | 시스템 언어 C 모듈·소유권 "설계" ↔ 웹 풀스택 "아키텍처" |
| dotnet-architect ↔ system-architect | .NET 계층·DI 수명 "설계" ↔ 웹 풀스택 "아키텍처" |
| java-architect ↔ system-architect | Java/Spring 계층·빈 수명 "설계" ↔ 웹 풀스택 "아키텍처" |
| swift-architect ↔ system-architect | Swift 앱 아키텍처·SwiftUI 상태 "설계" ↔ 웹 풀스택 "아키텍처" |

### 일방향 위임 포인터

특화 에이전트가 **허브/일반/상위 에이전트로만** 안내하는 단방향(`→`). 역방향을 두지 않는 이유: 허브 에이전트(code-reviewer 등)가 받는 모든 특화를 역으로 나열하면 description이 비대해진다. 아래는 **의도적 단방향의 대표 예시**이며 전수 목록은 아니다 — 허브로 들어오는 inbound 포인터는 이 외에도 여럿(예: system-architect가 받는 5건, code-reviewer가 받는 다수).

| 위임 | 성격 | 역방향이 없는 이유 |
|---|---|---|
| test-strategy → code-reviewer | 특화 → 일반 폴백 | `code-reviewer`는 일반 폴백이라 개별 특화로 되돌리지 않음 |
| perf-auditor → code-reviewer | 특화 → 일반 폴백 | 동일(일반 품질·버그 폴백) |
| code-reviewer → c-code-reviewer / dotnet-code-reviewer / java-code-reviewer / swift-code-reviewer | 일반 폴백 → 언어 전담 | 폴백이 C·비-Unity C#·Java·Swift를 전담으로 넘김(1.70 도메인 카브아웃과 동일 — 흡수 방지). 전담도 일반 품질을 code-reviewer로 되넘기지만, 허브가 특화를 전부 나열하지 않는 관행상 일방향 표에 둔다 ⟵ 1.72, Java·Swift 2026-07-15 |
| devops-reviewer → migration-reviewer | 운영 → DB 도메인 | 마이그레이션 리뷰는 DB 영역에 집중 |
| system-architect → api-contract-reviewer / data-modeler / security-reviewer | 최상위 설계 → 특화 검증 | 설계가 구현 후 검증을 특화로 넘김(특화는 설계를 역참조 안 함) |
| ai-workspace-architect → system-architect / design-system-architect | 메타 → 도메인 설계 | 메타가 스택 설계를 넘길 뿐, 설계 에이전트는 메타를 역참조 안 함 |
| copy-reviewer → ai-workspace-architect | 콘텐츠 → 메타 | 보이스·프롬프트 시스템 설계로 넘기는 상향 포인터 |
| content-repurposer → copy-reviewer / seo-optimizer / fact-checker | 생성 → 점검 3종 | 재활용 초안을 각 점검 에이전트로(점검 측은 생성기를 역참조 안 함) |
| storyteller → content-repurposer / copy-reviewer / brand-voice-guardian | 창작 생성 → 재활용·점검 | 새로 지은 이야기를 매체 파생·카피·보이스로(점검·재활용 측은 창작 생성기를 역참조 안 함) |
| cover-letter-tailor → copy-reviewer / brand-voice-guardian / fact-checker | 커리어 생성 → 점검 | 맞춤 자소서를 카피·보이스·사실검증으로(점검 측은 커리어 생성기를 역참조 안 함) |
| fact-checker → copy-reviewer / seo-optimizer / landing-reviewer | 검증 → 콘텐츠 점검 | 사실 검증 후 문장·전환·검색은 각 특화로 |
| brand-voice-guardian → copy-reviewer / ai-workspace-architect | 보이스 → 카피·메타 | 일반 카피는 copy, 보이스 정의·시스템은 메타로 |
| threat-modeler → system-architect | 보안 설계 → 구조 설계 | 위협 모델이 구조 설계로 넘김 |
| llm-ai-security-reviewer → devops-reviewer | AI 보안 → 인프라 | 모델 서빙·시크릿 인프라를 devops로 |
| game-ui-reviewer → ui-ux-reviewer | 게임 UI → 웹 UI | 웹 화면·WCAG·i18n은 웹 UI로(웹 UI는 게임을 역참조 안 함) |
| unity-build-auditor → unity-code-reviewer | 빌드 → 코드 | keystore·설정 판정 후 코드 품질은 코드 리뷰로 |
| playtest-designer → test-runner | 플레이테스트 → 자동 테스트 | 사람 테스트와 별개인 자동 테스트 러너로 |
| debugger → perf-auditor / db-optimizer / unity-perf-auditor / security-reviewer | 회귀 시점 추적 → 병목 진단·보안 특화 | "무엇이 느린가"(병목)는 성능 3종, "취약점"이면 보안으로. **"언제부터 느려졌나"(회귀 시점)는 debugger가 유지** — 성능·보안 측은 디버깅을 역참조 안 함 |
| project-manager → 전 특화 에이전트(라우팅 맵) | 조율 → 실무 특화 | 조율 층이 각 태스크를 알맞은 특화로 보낼 뿐, 특화는 조율을 역참조 안 함(진입/조율은 위층) ⟵ 1.83 |
| email-sequence-writer → copy-reviewer / brand-voice-guardian / offer-strategist / fact-checker | 생성 → 점검·앞단 설계 | 생성기가 점검·오퍼 설계로 넘김(점검 측은 생성기를 역참조 안 함) ⟵ 1.87 |
| offer-strategist → landing-reviewer / copy-reviewer / email-sequence-writer / fact-checker | 앞단 설계 → 하류 표현·검증 | 카피 앞단이 페이지·문장·이메일로 넘김(하류는 앞단을 역참조 안 함) ⟵ 1.87 |
| self-reflector → memory-recaller | 누적 증류 → 질의 회상 | 교차 세션 증류가 특정 질의 회상으로 넘김(회상은 증류를 역참조 안 함) ⟵ 1.86 |

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
저장소의 73개 에이전트 `.md`를 전역 폴더로 복사합니다. 동봉된 스크립트를 쓰면 편합니다.
```powershell
powershell -ExecutionPolicy Bypass -File sync.ps1
```
> `sync.ps1`은 73개 에이전트 파일을 `%USERPROFILE%\.claude\agents\`로, `commands/`의 76개 슬래시 명령(+ 한글 별칭 48개) 파일을 `%USERPROFILE%\.claude\commands\`로, `launchers/`의 런처를 `%USERPROFILE%\.claude\launchers\`로 복사하고, `workflows/`·`hooks/`·`skills/`·`rules/`도 각각 `%USERPROFILE%\.claude\`의 대응 폴더로 배포합니다(배포 대상 7종). 에이전트는 frontmatter `name:`이 있는 `.md`만 배포(문서는 자동 스킵)하고, 이 저장소가 이전에 배포한 에이전트가 지워지거나 이름이 바뀌면 런타임에서도 제거합니다(manifest 기반 delete-sync — 사용자 개인 에이전트는 건드리지 않음). 복사/삭제 중 오류가 나면 종료 코드 1로 알립니다.

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
| `/email` | email-sequence-writer | 제품·시퀀스 종류·타깃(선택) |
| `/offer` | offer-strategist | 제품·타깃·가격여건(선택) |
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
| `/reflect-log` | self-reflector | 범위/주제 힌트(선택) — 누적 로그 교차 세션 증류 |
| `/reflect` | (메인 세션 리추얼) | 이번 세션 회고 범위 힌트(선택) — 서브에이전트 없음 |
| `/refactor` | refactor-strategist | 경로/대상(선택) |
| `/docs` | docs-writer | 문서 종류/대상(선택) |
| `/agentdef` | agent-definition-reviewer | 에이전트 파일/이름(선택) |
| `/story` | storyteller | 한 줄 아이디어/설정 + 장르·분량(선택) |
| `/brainstorm` | brainstormer | 주제/문제 + 목적·타깃·제약·수량·기준(선택) |
| `/debug` | debugger | 증상/에러 메시지/재현 절차 |
| `/rule` | multiplayer-rule-reviewer | 룰·상태머신·서버 핸들러 경로(선택) |
| `/save` | save-data-reviewer | 세이브·직렬화 코드 경로(선택) |
| `/ml` | ml-experiment-reviewer | 학습·피처·백테스트 코드 경로(선택) |
| `/acct` | accounting-rule-reviewer | GL·전표·마감 코드 경로(선택) |
| `/auto` | automation-reliability-reviewer | 스크립트·데몬·스케줄 설정 경로(선택) |
| `/gloc` | game-localization-reviewer | 문자열·UI·폰트 경로(선택) |
| `/gtest` | game-test-strategy | 게임 로직 경로(선택) |
| `/gaudio` | game-audio-reviewer | 오디오 코드·믹서·클립 경로(선택) |
| `/creview` | c-code-reviewer | C 소스 경로(선택) |
| `/carch` | c-architect | 설계 대상/경로(선택) |
| `/cperf` | c-perf-auditor | 경로 또는 프로파일러 캡처(선택) |
| `/dnreview` | dotnet-code-reviewer | C# 소스 경로(선택) |
| `/dnarch` | dotnet-architect | 설계 대상/경로(선택) |
| `/dnperf` | dotnet-perf-auditor | 경로 또는 측정 캡처(선택) |
| `/jreview` | java-code-reviewer | Java 소스 경로(선택) |
| `/jarch` | java-architect | 설계 대상/경로(선택) |
| `/swreview` | swift-code-reviewer | Swift 소스 경로(선택) |
| `/swarch` | swift-architect | 설계 대상/경로(선택) |
| `/curriculum` | curriculum-designer | 주제·대상·시간(선택) |
| `/cover` | (메인 세션 워크플로 · 보조 cover-letter-tailor) | 채용 공고 + 기존 자소서/경력(선택) |
| `/truth` | truth-checker | 질문·주장 또는 파일/경로(선택) |
| `/aicode` | ai-code-auditor | 경로(선택) |
| `/archaeo` | codebase-archaeologist | 경로·범위(선택) |
| `/autharch` | identity-access-architect | 기능·요구사항(선택) |
| `/video` | video-optimizer | 영상 주제·스크립트(선택) |
| `/aeo` | ai-search-optimizer | 사이트·경로(선택) |
| `/imgprompt` | image-prompt-engineer | 이미지 용도·컨셉(선택) |
| `/proposal` | proposal-strategist | 공고·기회 설명(선택) |
| `/level` | level-designer | 레벨·스테이지 설명(선택) |
| `/garden` | knowledge-gardener | 경로·범위(선택) |
| `/lint` | (스크립트) lint-agents.ps1 — 정의 규범 검사 | 파일 경로(선택) |

### 한글 별칭 (1.65)

Claude Code는 슬래시 명령 이름에 **한글(비ASCII)을 허용한다**(1.65에서 `/디버그`로 검증). 자주 쓰는 47종에 한글 별칭 커맨드를 함께 배포한다 — 에이전트는 그대로고 커맨드 파일만 하나 더 있는 구조라, 별칭을 지워도 영어 명령은 그대로 동작한다.

| 한글 | 영어 | 한글 | 영어 |
|---|---|---|---|
| `/디버그` | `/debug` | `/배포` | `/devops` |
| `/룰` | `/rule` | `/세이브` | `/save` |
| `/머신러닝` | `/ml` | `/회계` | `/acct` |
| `/자동화` | `/auto` | `/현지화` | `/gloc` |
| `/게임테스트` | `/gtest` | `/오디오` | `/gaudio` |
| `/리뷰` | `/review` | `/의존성` | `/deps` |
| `/보안` | `/sec` | `/관측성` | `/obs` |
| `/테스트` | `/test` | `/리팩터` | `/refactor` |
| `/커버리지` | `/coverage` | `/문서` | `/docs` |
| `/성능` | `/perf` | `/카피` | `/copy` |
| `/계약` | `/contract` | `/회상` | `/recall` |
| `/디비` | `/db` | `/이야기` | `/story` |
| `/마이그레이션` | `/migrate` | `/화면` | `/ui` |
| `/아키텍처` | `/arch` | `/데이터모델` | `/datamodel` |
| `/강의설계` | `/curriculum` | `/자소서` | `/cover` |
| `/회고` | `/reflect` | `/누적회고` | `/reflect-log` |
| `/이메일` | `/email` | `/오퍼` | `/offer` |
| `/진실검증` | `/truth` | `/프로젝트관리` | `/pm` |
| `/프로젝트실행` | `/pm-run` | `/발상` | `/brainstorm` |
| `/에이아이코드` | `/aicode` | `/코드고고학` | `/archaeo` |
| `/인증설계` | `/autharch` | `/영상` | `/video` |
| `/에이아이검색` | `/aeo` | `/이미지프롬프트` | `/imgprompt` |
| `/제안서` | `/proposal` | `/레벨` | `/level` |
| `/지식정원` | `/garden` | `/린트` | `/lint` |

> 한국어 **자연어 호출**은 별칭과 무관하게 원래부터 동작한다(64종 description이 전부 한국어라 라우터가 한국어 문장으로 매치). 별칭은 슬래시 표기 편의일 뿐이다.

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
- 이 README의 [에이전트 표](#에이전트-73종) 버전 칸도 버전업 시 함께 갱신됩니다.

---

## 업데이트 워크플로우

에이전트를 수정할 때는 항상 아래 순서를 따릅니다. **원본은 이 저장소의 `*.md` 한 곳에서만** 수정합니다.

1. 원본 `*.md` 수정
2. frontmatter `version`/`updated` 갱신 (마이너/메이저 판단)
3. `CHANGELOG.md`에 변경 기록
4. **`README.md`의 버전 표 갱신** (버전업 시)
5. `sync.ps1`으로 전역(`~/.claude/`의 `agents/`·`commands/`·`workflows/`·`launchers/`·`hooks/`·`skills/`·`rules/` 7종)에 반영
6. `git commit` (원격 `git push`는 **명시 요청 시에만** — public repo에서 push는 곧 공개 게시)

---

> 에이전트를 추가·삭제·개명했다면 **먼저 `registry.json`을 고치고 `.uild-registry.ps1`을 돌려** PM 라우팅 블록을 재생성한다. 그다음 `sync.ps1` 실행 **전에** `.\lint-agents.ps1`을 돌린다. 프론트매터 필수 필드·읽기 전용 계약·경계 위임절·끊어진 위임 링크·라우팅 고아를 기계가 잡는다(ERROR면 종료 코드 1). 새 에이전트를 추가했다면 특히 **역방향 경계절**(이웃이 새 에이전트를 가리키는 절)이 빠지지 않았는지 이 검사로 확인한다.

## 저장소 구조

```
claude-agents/
├─ README.md                     # 이 문서
├─ CHANGELOG.md                  # 버전별 변경 이력
├─ AGENTS.md                     # 73개 에이전트 통합 정리
├─ lint-agents.ps1               # 정의 규범 검사(프론트매터·경계 위임절·끊어진 링크·라우팅 고아)
├─ registry.json                 # 에이전트 명단 단일 소스(group·note만 — 나머지는 프론트매터가 정본)
├─ build-registry.ps1            # registry.json → project-manager.md 라우팅 블록 생성
├─ design-agents.md              # 디자인 에이전트 4종 상세
├─ CLAUDE.md                     # 저장소 작업 가이드(Claude Code용)
├─ sync.ps1                      # 전역 동기화 스크립트(에이전트 + 슬래시 명령)
├─ .gitignore
│
├─ commands/                     # ── 슬래시 명령 정의 (66개, +한글 별칭 38개) ──
│  ├─ review.md  ├─ sec.md       ├─ test.md      ├─ coverage.md
│  ├─ perf.md    ├─ contract.md  ├─ apidoc.md    ├─ db.md
│  ├─ migrate.md ├─ ui.md        ├─ dsystem.md   ├─ datamodel.md
│  ├─ arch.md    ├─ devops.md    ├─ deps.md      ├─ obs.md
│  ├─ fable.md   ├─ copy.md      ├─ landing.md   ├─ seo.md
│  ├─ factcheck.md  ├─ repurpose.md   ├─ voice.md
│  ├─ threat.md   ├─ aisec.md    ├─ ureview.md   ├─ gdd.md
│  ├─ gui.md      ├─ feel.md     ├─ uperf.md     ├─ playtest.md
│  ├─ ubuild.md   ├─ recall.md   ├─ refactor.md  ├─ docs.md
│  ├─ agentdef.md ├─ story.md    ├─ debug.md
│  ├─ email.md    ├─ offer.md
│  ├─ creview.md  ├─ carch.md    ├─ cperf.md
│  ├─ dnreview.md ├─ dnarch.md   ├─ dnperf.md
│  ├─ curriculum.md ├─ jreview.md ├─ jarch.md
│  ├─ swreview.md └─ swarch.md
│
├─ launchers/                    # ── 바탕화면 런처 ──
│  └─ claude.bat
│
├─ workflows/                    # ── 워크플로 (pm-orchestrate) ──
│  └─ pm-orchestrate.js
│
├─ hooks/                        # ── 읽기 전용 가드 훅 ──
│  └─ agent-guard.ps1
│
├─ skills/                       # ── 프리로드 스킬 ──
│  ├─ agent-conventions/         └─ design-reference/
│
├─ rules/                        # ── 경로 스코프 규칙(common·python·typescript) ──
│  ├─ README.md  ├─ common.md    ├─ python.md    └─ typescript.md
│
├─ _drafts/                      # ── 미편입 초안(sync 배포 안 함) ──
│
├─ code-reviewer.md              # ── 에이전트 정의 (64개) ──
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
├─ self-reflector.md             # 인프라(자기개선 회고·누적 관찰 증류, haiku)
├─ refactor-strategist.md        # 품질(동작 보존 리팩터 계획)
├─ docs-writer.md                # 문서(개발자용 기술문서)
├─ agent-definition-reviewer.md  # 메타(에이전트 정의 점검)
├─ storyteller.md                # 창작(스토리텔링, fable)
├─ brainstormer.md               # 발상(브레인스토밍 발산→수렴)
├─ debugger.md                   # 품질(버그 근본 원인 규명)
├─ multiplayer-rule-reviewer.md  # 게임(멀티플레이 룰 정합성·서버 권위, MSW mlua)
├─ save-data-reviewer.md         # 게임(세이브·영속 데이터 호환성)
├─ ml-experiment-reviewer.md     # 도메인(ML 실험 설계·데이터 누출)
├─ accounting-rule-reviewer.md   # 도메인(복식부기 규칙 감사)
├─ automation-reliability-reviewer.md  # 도메인(데몬·크론 신뢰성)
├─ game-localization-reviewer.md # 게임(현지화 준비)
├─ game-test-strategy.md         # 게임(자동 테스트 전략·seam)
├─ game-audio-reviewer.md        # 게임(오디오 구현)
├─ c-code-reviewer.md            # 시스템 언어(C 리뷰·메모리 안전·UB)
├─ c-architect.md                # 시스템 언어(C 구조 설계)
├─ c-perf-auditor.md             # 시스템 언어(C 런타임 성능)
├─ dotnet-code-reviewer.md       # 시스템 언어(비-Unity C#/.NET 리뷰)
├─ dotnet-architect.md           # 시스템 언어(.NET 구조 설계)
├─ dotnet-perf-auditor.md        # 시스템 언어(.NET 런타임 성능)
├─ curriculum-designer.md        # 콘텐츠(교육/교수설계, backward design)
├─ cover-letter-tailor.md        # 커리어(자소서 맞춤 재작성, 사실만)
├─ java-code-reviewer.md         # 시스템 언어(Java/JVM 리뷰)
├─ java-architect.md             # 시스템 언어(Java/JVM 구조 설계)
├─ swift-code-reviewer.md        # 시스템 언어(Swift 리뷰)
├─ swift-architect.md            # 시스템 언어(Swift 구조 설계)
├─ email-sequence-writer.md      # 콘텐츠/마케팅(이메일·라이프사이클 시퀀스 생성)
├─ offer-strategist.md           # 콘텐츠/마케팅(카피 앞단 오퍼 설계)
└─ truth-checker.md              # 검증(질문·주장 정확성·근거 기반 신뢰도)
```

> 프리로드 스킬은 `skills/`에 있다: `agent-conventions`(전 에이전트 공용 규범) · `design-reference`(ui-ux-reviewer·design-system-architect에 주입되는 구체 디자인 레퍼런스 — 업계 매핑·클리셰·팔레트·폰트·체크리스트).

---

## 라이선스

개인용 프로젝트(비공개 저장소). 별도 라이선스 미지정.
