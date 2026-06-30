# claude-agents

**Next.js + FastAPI + MySQL** 풀스택 개발을 위한 [Claude Code](https://claude.com/claude-code) 서브에이전트 모음입니다.
코드 리뷰·보안 점검·테스트·문서화·DB·디자인·아키텍처 설계를 각각 전문 에이전트가 담당합니다.

- 에이전트 수: **16종**
- 언어: 한국어 프롬프트
- 성격: **읽기 전용** — 분석·리뷰·설계·제안만 하고 코드/스키마를 직접 수정하지 않음
- 현재 버전: `security-reviewer` **v1.9**, `db-optimizer` **v1.8**, `test-runner`·`code-reviewer` **v1.7**, `devops-reviewer` **v1.6**, `data-modeler`·`ui-ux-reviewer`·`api-doc-writer` **v1.4**, `system-architect`·`design-system-architect` **v1.3**, `perf-auditor`·`test-strategy` **v1.2**, `migration-reviewer`·`observability-reviewer` **v1.1**, `api-contract-reviewer`·`dependency-auditor` **v1.0** — 상세 이력은 [CHANGELOG.md](CHANGELOG.md)

---

## 목차
- [에이전트 16종](#에이전트-16종)
- [공통 규칙](#공통-규칙)
- [설치 / 등록](#설치--등록)
- [사용 방법](#사용-방법)
- [슬래시 명령](#슬래시-명령)
- [바탕화면 런처](#바탕화면-런처)
- [버전 관리](#버전-관리)
- [업데이트 워크플로우](#업데이트-워크플로우)
- [저장소 구조](#저장소-구조)

---

## 에이전트 16종

| # | 에이전트 | 슬래시 | 분류 | 버전 | 모델 | 역할 | 도구 |
|---|---|---|---|---|---|---|---|
| 1 | `code-reviewer` | `/review` | 품질 | 1.7 | opus | 코드 품질·가독성·버그 리뷰 | Read, Grep, Glob, Bash |
| 2 | `security-reviewer` | `/sec` | 품질 | 1.9 | opus | 보안 취약점(OWASP) 점검 | Read, Grep, Glob, WebSearch, WebFetch |
| 3 | `test-runner` | `/test` | 품질 | 1.7 | haiku | 테스트 실행·실패 분석 | Bash, Read, Grep, Glob |
| 4 | `test-strategy` | `/coverage` | 품질 | 1.2 | opus | 테스트 커버리지 공백·약한 테스트 진단 | Read, Grep, Glob |
| 5 | `perf-auditor` | `/perf` | 품질 | 1.2 | opus | Next.js 프론트 성능 점검 | Read, Grep, Glob |
| 6 | `api-contract-reviewer` | `/contract` | 품질 | 1.0 | opus | 프론트-백 API 계약 정합성 점검 | Read, Grep, Glob |
| 7 | `api-doc-writer` | `/apidoc` | 문서 | 1.4 | sonnet | FastAPI 엔드포인트 카탈로그 | Read, Grep, Glob, Context7 |
| 8 | `db-optimizer` | `/db` | DB | 1.8 | opus | MySQL 쿼리·인덱스 성능 튜닝 | Read, Grep, Glob, Bash |
| 9 | `migration-reviewer` | `/migrate` | DB | 1.1 | opus | 스키마 마이그레이션 안전성 점검 | Read, Grep, Glob |
| 10 | `ui-ux-reviewer` | `/ui` | 디자인 | 1.4 | opus | UI/UX·접근성·반응형·다크패턴 점검 | Read, Grep, Glob |
| 11 | `design-system-architect` | `/dsystem` | 디자인 | 1.3 | opus | 디자인 토큰·컴포넌트 설계 (DESIGN.md) | Read, Grep, Glob, Context7 |
| 12 | `data-modeler` | `/datamodel` | 설계 | 1.4 | opus | 데이터 모델/스키마 설계 | Read, Grep, Glob |
| 13 | `system-architect` | `/arch` | 설계 | 1.3 | opus | 시스템 아키텍처 설계 | Read, Grep, Glob, Context7 |
| 14 | `devops-reviewer` | `/devops` | 운영 | 1.6 | opus | Docker·CI/CD·배포 설정 점검 | Read, Grep, Glob |
| 15 | `dependency-auditor` | `/deps` | 운영 | 1.0 | opus | 의존성 취약점·버전·라이선스 점검 | Read, Grep, Glob, Bash |
| 16 | `observability-reviewer` | `/obs` | 운영 | 1.1 | opus | 로깅·트레이싱·관측성 점검 | Read, Grep, Glob |

### 🔍 품질 / QA

<details>
<summary><b>1. code-reviewer</b> (<code>/review</code>) — 코드 품질·버그 리뷰</summary>

- **언제**: 커밋/PR 전 셀프 리뷰, 리팩터링 검토
- **범위 결정**: `git diff` / `git diff --staged`로 변경분을 파악해 그 범위에 집중 (Bash는 범위 식별 전용, 실행·수정 금지)
- **백엔드(FastAPI)**: Pydantic 스키마·타입힌트, async 일관성(블로킹 I/O), DB 세션/트랜잭션 경계, 예외 처리, 계층 분리
- **프론트(Next.js)**: 서버/클라 컴포넌트 경계, 데이터 페칭·캐싱, useEffect 의존성, 로딩/에러 처리, 타입 안전성
- **Next.js 15/16(v1.4)**: Server Actions 보안(서버 재검증·인가), `use cache`/Cache Components 오캐시, React Compiler 도입 시 중복 수동 메모 (버전 불명확하면 "확인 필요")
- **출력**: 요약 → Must fix → Should fix → Nit (분류 내 영향도순, `파일:줄` 명시)
- **구분**: 보안 전용은 `security-reviewer`, 시각·접근성·UX는 `ui-ux-reviewer`, 프론트-백 API 계약 정합은 `api-contract-reviewer`, 로깅·관측성은 `observability-reviewer`
</details>

<details>
<summary><b>2. security-reviewer</b> (<code>/sec</code>) — 보안 취약점 점검</summary>

- **언제**: PR/새 기능 머지 전, 보안 점검 필요 시
- **기준**: OWASP Top 10
- **점검**: 인증/인가(라우터 레벨 의존성까지 확인해 오탐 방지), IDOR/BOLA·BFLA·WebSocket(CSWSH), **Next.js 미들웨어 인가 우회(CVE-2025-29927)**, RBAC, 경로 탐색, JWT(알고리즘 고정·alg confusion·kid/jku 헤더 주입·exp·저장 위치), 인젝션(SQL·SSTI·OS/NoSQL), XSS, 과잉 응답(API3, response_model), CSRF/SSRF, Mass Assignment/BOPLA, CORS
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
- **구분**: 커버리지 공백·약한 테스트 진단·보강 전략은 `test-strategy`
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
- **구분**: 프론트-백 계약 정합 검증은 `api-contract-reviewer`
</details>

<details>
<summary><b>8. db-optimizer</b> (<code>/db</code>) — MySQL 성능 튜닝</summary>

- **언제**: 느린 쿼리 진단, N+1, 인덱스 설계, 마이그레이션의 성능·인덱스 영향 검토
- **점검**: N+1, 인덱스(복합 컬럼 순서·중복), SELECT */함수 래핑/OFFSET 페이지네이션, 타입 적정성, 트랜잭션·락, 커넥션 풀, 벡터 검색(MySQL 9 `VECTOR_DISTANCE` k-NN·사전필터)
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
- **AI 데이터(v1.3)**: 임베딩/시맨틱 검색을 위한 MySQL 9 `VECTOR(N)` 타입·저장 구조(MySQL 8 이하면 외부 벡터 DB 트레이드오프)
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
- **점검**: 알려진 취약점(CVE, 직접/전이 경로), 버전 신선도·방치/deprecated, lockfile 무결성·드리프트, 미사용·누락 의존성, dependencies/devDependencies 오분류, 라이선스 위험(GPL/AGPL·불명), 공급망 신호(타이포스쿼팅·postinstall·비공식 레지스트리)
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
- **구분**: 배포·인프라(로그·트레이스 수집·샘플링 파이프라인·대시보드: OTel Collector·Grafana Alloy 등) 설정은 `devops-reviewer`, 일반 예외 처리·코드 품질은 `code-reviewer`
</details>

### 역할이 겹치기 쉬운 쌍

| 쌍 | 구분 |
|---|---|
| code-reviewer ↔ security-reviewer | 일반 품질/버그 ↔ 보안 전용 |
| db-optimizer ↔ data-modeler | 기존 쿼리·인덱스 "튜닝" ↔ 테이블·관계 "설계" |
| migration-reviewer ↔ data-modeler | 스키마 변경 "적용 안전성" ↔ 스키마 "설계" |
| migration-reviewer ↔ db-optimizer | 마이그레이션 "락·롤백·배포 안전" ↔ 런타임 쿼리 "성능" |
| ui-ux-reviewer ↔ design-system-architect | 개별 화면 "점검" ↔ 토큰·컴포넌트 "시스템 설계" |
| code-reviewer(프론트) ↔ ui-ux-reviewer | 로직·타입·구조 ↔ 시각·사용성·접근성 |
| perf-auditor ↔ ui-ux-reviewer | 로드·렌더 "성능"(번들·CWV) ↔ 시각·사용성·접근성 |
| perf-auditor ↔ db-optimizer | 프론트 "성능"(번들·렌더) ↔ MySQL 쿼리·인덱스 "성능" |
| test-strategy ↔ test-runner | 커버리지 공백·약한 테스트 "진단·설계" ↔ 테스트 "실행·실패 분석" |
| devops-reviewer ↔ security-reviewer | 배포/파이프라인 설정 "운영 보안" ↔ 애플리케이션 "코드 보안" |
| api-contract-reviewer ↔ api-doc-writer | 프론트-백 계약 "정합성 검증" ↔ 백엔드 엔드포인트 "카탈로그·문서화" |
| api-contract-reviewer ↔ code-reviewer | 양쪽 "계약 일치" ↔ 한쪽 "코드 품질·버그" |
| dependency-auditor ↔ security-reviewer | 의존성 자체 "취약·버전·라이선스" ↔ 앱 "코드 보안 취약점" |
| dependency-auditor ↔ devops-reviewer | 의존성 "건강성"(매니페스트·lockfile) ↔ CI/공급망 "설정"(SBOM·서명) |
| observability-reviewer ↔ devops-reviewer | 앱 런타임 "로깅·트레이싱·계측" ↔ 로그 수집·대시보드 "인프라 설정" |
| observability-reviewer ↔ code-reviewer | 관측성 "공백"(로깅·추적) ↔ 일반 "예외 처리·코드 품질" |

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
저장소의 16개 에이전트 `.md`를 전역 폴더로 복사합니다. 동봉된 스크립트를 쓰면 편합니다.
```powershell
powershell -ExecutionPolicy Bypass -File sync.ps1
```
> `sync.ps1`은 16개 에이전트 파일을 `%USERPROFILE%\.claude\agents\`로, `commands/`의 16개 슬래시 명령 파일을 `%USERPROFILE%\.claude\commands\`로, `launchers/`의 런처를 `%USERPROFILE%\.claude\launchers\`로 복사합니다.

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

> 슬래시 명령은 추가 후 다음 세션부터 목록에 나타납니다.

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
- 이 README의 [에이전트 표](#에이전트-16종) 버전 칸도 버전업 시 함께 갱신됩니다.

---

## 업데이트 워크플로우

에이전트를 수정할 때는 항상 아래 순서를 따릅니다. **원본은 이 저장소의 `*.md` 한 곳에서만** 수정합니다.

1. 원본 `*.md` 수정
2. frontmatter `version`/`updated` 갱신 (마이너/메이저 판단)
3. `CHANGELOG.md`에 변경 기록
4. **`README.md`의 버전 표 갱신** (버전업 시)
5. `sync.ps1`으로 전역(`~/.claude/agents/`·`~/.claude/commands/`·`~/.claude/launchers/`)에 반영
6. `git commit` + `git push`

---

## 저장소 구조

```
claude-agents/
├─ README.md                     # 이 문서
├─ CHANGELOG.md                  # 버전별 변경 이력
├─ AGENTS.md                     # 16개 에이전트 통합 정리
├─ design-agents.md              # 디자인 에이전트 4종 상세
├─ CLAUDE.md                     # 저장소 작업 가이드(Claude Code용)
├─ sync.ps1                      # 전역 동기화 스크립트(에이전트 + 슬래시 명령)
├─ .gitignore
│
├─ commands/                     # ── 슬래시 명령 정의 (16개) ──
│  ├─ review.md  ├─ sec.md       ├─ test.md      ├─ coverage.md
│  ├─ perf.md    ├─ contract.md  ├─ apidoc.md    ├─ db.md
│  ├─ migrate.md ├─ ui.md        ├─ dsystem.md   ├─ datamodel.md
│  ├─ arch.md    ├─ devops.md    ├─ deps.md      └─ obs.md
│
├─ launchers/                    # ── 바탕화면 런처 ──
│  └─ claude.bat
│
├─ code-reviewer.md              # ── 에이전트 정의 (16개) ──
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
└─ observability-reviewer.md
```

---

## 라이선스

개인용 프로젝트(비공개 저장소). 별도 라이선스 미지정.
