# 서브에이전트 전체 정리 (16종)

Next.js + FastAPI + MySQL 스택을 위한 Claude Code 서브에이전트 모음입니다.
모두 한국어로 작성되었고, **읽기 전용으로 분석·리뷰·설계·제안만** 하며 코드/스키마를 직접 수정하지 않습니다.

## 공통 규칙
- 발견/제안은 **영향도(심각도) 순으로 정렬**
- 근거에 `파일경로:줄번호` 명시
- 확신이 없으면 추측하지 않고 **"확인 필요" / "검토 필요" / "추정"** 으로 표시
- 실행·수정이 필요한 작업(테스트 실행, 진단 쿼리 등)은 명시적으로 요청받았을 때만 수행

## 등록/사용 위치
| 항목 | 경로 | 비고 |
|---|---|---|
| 전역 에이전트 | `C:\Users\PC\.claude\agents\` | 모든 프로젝트(D 파티션 포함)에서 사용 |
| 전역 슬래시 명령 | `C:\Users\PC\.claude\commands\` | `/명령`으로 호출 |
| 소스(원본) | `d:\auto_agent\*.md` | 편집용 단일 소스. 여기서만 편집 |

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

---

## 분류별 상세

### 🔍 품질 / QA

**1. code-reviewer (`/review`)**
Next.js + FastAPI 코드의 품질·가독성·버그 가능성 리뷰. `git diff`로 변경분을 파악해 그 범위에 집중(커밋/PR 전 셀프 리뷰). 백엔드(Pydantic·async·DB 세션·예외·계층 분리), 프론트(서버/클라 경계·페칭·useEffect·타입). Next.js 15/16이면 Server Actions 보안·`use cache` 오캐시·React Compiler 중복 수동 메모도 점검(버전 불명확하면 "확인 필요"). 출력: 요약 → Must fix → Should fix → Nit.
→ 보안 전용은 `security-reviewer`, 시각·접근성·UX는 `ui-ux-reviewer`, 프론트-백 API 계약 정합은 `api-contract-reviewer`, 로깅·관측성은 `observability-reviewer`.

**2. security-reviewer (`/sec`)**
OWASP 기준 보안 점검. 인증/인가(라우터 레벨 의존성까지 확인해 오탐 방지), IDOR/BOLA·BFLA, Next.js 미들웨어 인가 우회(CVE-2025-29927), RBAC, 경로 탐색, JWT(alg confusion·헤더 주입), 인젝션(SQL·SSTI·OS/NoSQL), XSS, 과잉 응답(API3), CSRF/SSRF, Mass Assignment, CORS, LLM 보안(OWASP LLM Top 10 2025: 프롬프트 인젝션·과도한 행위성·벡터/임베딩 약점 등). 출력: 심각도순 + "즉시 고쳐야 할 Top 3".
→ 일반 코드 품질·버그는 `code-reviewer`, 배포·CI 설정·시크릿 취급은 `devops-reviewer`, 의존성 취약·버전·라이선스는 `dependency-auditor`.

**3. test-runner (`/test`)**
pytest / Vitest·Jest(유닛) / Playwright·Cypress(E2E) 실행 후 실패 분석. 유닛과 E2E를 별개 러너로 인식 — E2E는 실행 비용·서버 기동 전제 때문에 요청 범위 밖이면 임의 실행 안 함. Vitest/jsdom은 async Server Component를 렌더 못 하므로 해당 실패는 프로덕션 버그로 단정하지 말고 Playwright E2E 영역임을 알림. 환경 준비(설치·venv)는 임의로 하지 않고 사전 조건으로 보고. 통과/실패 무관하게 테스트 품질 스캔(change-detector·목 그린)도 수행하며 green을 품질 증거로 칭찬하지 않음. 출력: 통과/실패/스킵 집계 → 실패별 원인 분류·제안, 플레이키·약한 테스트 표시.
→ 커버리지 공백·약한 테스트 진단·보강 전략은 `test-strategy`.

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
→ 프론트-백 계약 정합 검증은 `api-contract-reviewer`.

**8. db-optimizer (`/db`)**
MySQL 쿼리·인덱스·스키마 **성능 튜닝**. N+1, 인덱스 설계, SELECT * / 함수 래핑 / OFFSET 페이지네이션, 타입 적정성, 트랜잭션·락, 커넥션 풀, 벡터 검색(MySQL 9 `VECTOR_DISTANCE` k-NN·사전필터). `EXPLAIN`/`EXPLAIN ANALYZE`는 명시 요청 시만 실행. 출력: 영향도별 문제 + "가장 효과 큰 개선 3가지".
→ 스키마 "설계"는 `data-modeler`, 마이그레이션 안전성(락·무중단·롤백)은 `migration-reviewer`.

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
→ 배포·인프라(로그·트레이스 수집·샘플링 파이프라인·대시보드: OTel Collector·Alloy 등) 설정은 `devops-reviewer`, 일반 예외 처리·코드 품질은 `code-reviewer`.

---

## 역할이 겹치기 쉬운 쌍 (구분 기준)

| 쌍 | 구분 |
|---|---|
| code-reviewer ↔ security-reviewer | 일반 품질/버그 ↔ 보안 전용 |
| db-optimizer ↔ data-modeler | 기존 쿼리·인덱스 "튜닝" ↔ 테이블·관계 "설계" |
| migration-reviewer ↔ data-modeler | 마이그레이션 "안전성·배포 순서" ↔ 스키마 "설계" |
| migration-reviewer ↔ db-optimizer | 마이그레이션 "락·무중단·롤백" ↔ 쿼리·인덱스 "성능 튜닝" |
| ui-ux-reviewer ↔ design-system-architect | 개별 화면 "점검" ↔ 토큰·컴포넌트 "시스템 설계" |
| code-reviewer(프론트) ↔ ui-ux-reviewer | 로직·타입·구조 ↔ 시각·사용성·접근성 |
| test-strategy ↔ test-runner | 커버리지 공백·약한 테스트 "설계" ↔ 실행·실패 "진단" |
| perf-auditor ↔ ui-ux-reviewer | 성능(번들·렌더·CWV) ↔ 시각·사용성·접근성 |
| perf-auditor ↔ db-optimizer | 프론트 성능(번들·페칭) ↔ DB 쿼리·인덱스 성능 |
| devops-reviewer ↔ security-reviewer | 배포·운영 설정·시크릿 취급 ↔ 코드 보안 취약점 |
| api-contract-reviewer ↔ api-doc-writer | 프론트-백 계약 "정합성 검증" ↔ 백엔드 엔드포인트 "카탈로그·문서화" |
| api-contract-reviewer ↔ code-reviewer | 양쪽 "계약 일치" ↔ 한쪽 "코드 품질·버그" |
| dependency-auditor ↔ security-reviewer | 의존성 자체 "취약·버전·라이선스" ↔ 앱 "코드 보안 취약점" |
| dependency-auditor ↔ devops-reviewer | 의존성 "건강성"(매니페스트·lockfile) ↔ CI/공급망 "설정"(SBOM·서명) |
| observability-reviewer ↔ devops-reviewer | 앱 런타임 "로깅·트레이싱·계측" ↔ 로그 수집·대시보드 "인프라 설정" |
| observability-reviewer ↔ code-reviewer | 관측성 "공백"(로깅·추적) ↔ 일반 "예외 처리·코드 품질" |

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
```

> 슬래시 명령은 추가 후 다음 세션부터 목록에 나타납니다.
> 자동 호출: 명령 없이 "보안 점검해줘"처럼 말해도 description을 보고 알맞은 에이전트가 선택됩니다.

---

## 관련 문서
- 디자인 에이전트 4종 상세: `design-agents.md`
- 저장소 안내: `CLAUDE.md`
