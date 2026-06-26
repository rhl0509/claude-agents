# 서브에이전트 전체 정리 (10종)

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
| 소스 사본 | `d:\auto_agent\*.md` | 편집용 원본 보관 |
| 프로젝트 사본 | `d:\auto_agent\.claude\agents\` | 이 프로젝트 한정(전역과 중복) |

---

## 전체 한눈에 보기

| # | 에이전트 | 슬래시 | 분류 | 역할 | 도구 |
|---|---|---|---|---|---|
| 1 | `code-reviewer` | `/review` | 품질 | 코드 품질·가독성·버그 리뷰 | Read, Grep, Glob, Bash |
| 2 | `security-reviewer` | `/sec` | 품질 | 보안 취약점(OWASP) 점검 | Read, Grep, Glob, WebSearch, WebFetch |
| 3 | `test-runner` | `/test` | 품질 | 테스트 실행·실패 분석 | Bash, Read, Grep, Glob |
| 4 | `api-doc-writer` | `/apidoc` | 문서 | FastAPI 엔드포인트 카탈로그 | Read, Grep, Glob, Context7 |
| 5 | `db-optimizer` | `/db` | DB | MySQL 쿼리·인덱스 성능 튜닝 | Read, Grep, Glob, Bash |
| 6 | `migration-reviewer` | `/migrate` | DB | 스키마 마이그레이션 안전성 점검 | Read, Grep, Glob |
| 7 | `ui-ux-reviewer` | `/ui` | 디자인 | UI/UX·접근성·반응형 점검 | Read, Grep, Glob |
| 8 | `design-system-architect` | `/dsystem` | 디자인 | 디자인 토큰·컴포넌트 설계 | Read, Grep, Glob, Context7 |
| 9 | `data-modeler` | `/datamodel` | 설계 | 데이터 모델/스키마 설계 | Read, Grep, Glob |
| 10 | `system-architect` | `/arch` | 설계 | 시스템 아키텍처 설계 | Read, Grep, Glob, Context7 |

---

## 분류별 상세

### 🔍 품질 / QA

**1. code-reviewer (`/review`)**
Next.js + FastAPI 코드의 품질·가독성·버그 가능성 리뷰. `git diff`로 변경분을 파악해 그 범위에 집중(커밋/PR 전 셀프 리뷰). 백엔드(Pydantic·async·DB 세션·예외·계층 분리), 프론트(서버/클라 경계·페칭·useEffect·타입). 출력: 요약 → Must fix → Should fix → Nit.
→ 보안 전용은 `security-reviewer`.

**2. security-reviewer (`/sec`)**
OWASP 기준 보안 점검. 인증/인가(라우터 레벨 의존성까지 확인해 오탐 방지), IDOR, RBAC, 경로 탐색, JWT, 인젝션, XSS, 민감정보 노출, CSRF/SSRF, Pydantic 과잉 수용(Mass Assignment), CORS. 출력: 심각도순 + "즉시 고쳐야 할 Top 3".

**3. test-runner (`/test`)**
pytest / Jest / Vitest 실행 후 실패 분석. 환경 준비(설치·venv)는 임의로 하지 않고 사전 조건으로 보고. 출력: 통과/실패/스킵 집계 → 실패별 원인 분류·제안, 플레이키 표시.

### 📚 문서 / DB

**4. api-doc-writer (`/apidoc`)**
FastAPI 엔드포인트를 빠짐없이 카탈로그화. 라우터/WebSocket 데코레이터 수집, 다단계 prefix 합성, 라우터 레벨 의존성까지 본 인증 판정, `tags`/`response_model`/`deprecated` 반영. 출력: 리소스/태그별 표 + 미인증·무응답모델·deprecated 목록.

**5. db-optimizer (`/db`)**
MySQL 쿼리·인덱스·스키마 **성능 튜닝**. N+1, 인덱스 설계, SELECT * / 함수 래핑 / OFFSET 페이지네이션, 타입 적정성, 트랜잭션·락, 커넥션 풀. `EXPLAIN`/`EXPLAIN ANALYZE`는 명시 요청 시만 실행. 출력: 영향도별 문제 + "가장 효과 큰 개선 3가지".
→ 스키마 "설계"는 `data-modeler`.

**6. migration-reviewer (`/migrate`)**
MySQL/Alembic 스키마 마이그레이션 **안전성** 점검(대형 테이블·운영 트래픽 가정). 락 범위·무중단 가능성, NOT NULL+백필 순서(expand-contract), 인덱스 생성 비용, 타입 변경 재작성, FK/유니크 제약, 롤백 가능성, 대량 DML 배치, 배포 순서(코드↔스키마 호환). 출력: 요약 → 위험 Top 3 → 주의 → 제안.
→ 스키마 "설계"는 `data-modeler`, 쿼리 "성능 튜닝"은 `db-optimizer`.

### 🎨 디자인

**7. ui-ux-reviewer (`/ui`)**
화면 UI/UX·접근성 점검. 레이아웃/간격, 타이포 위계, 색 대비(WCAG AA), 반응형·터치 타깃, 접근성(시맨틱·aria·키보드·alt·label), 상태 표현(로딩/빈/에러), 컴포넌트 일관성. 출력: 요약 → Must/Should/Nit.
→ 토큰/시스템 설계는 `design-system-architect`.

**8. design-system-architect (`/dsystem`)**
디자인 시스템 설계. 디자인 토큰(색/타이포/스페이싱/래디우스/섀도), 테마(다크모드), 컴포넌트 계층·variant, 네이밍, Tailwind 설정 토큰화, 중복 통합, 문서화. 출력: 현황 진단 → 제안 토큰 세트 → 컴포넌트 구조 → 마이그레이션 단계.

### 🏗 설계

**9. data-modeler (`/datamodel`)**
MySQL 데이터 모델 **설계**. 엔터티·관계(N:M 연결 테이블), 정규화, 키 전략(대리키/자연키/FK 동작), 타입 선택, 제약·무결성, 이력/감사/soft delete/채번, 확장성. 출력: 텍스트 ERD → 테이블별 설계(DDL) → 트레이드오프 → 가정.
→ 기존 쿼리 성능 튜닝은 `db-optimizer`.

**10. system-architect (`/arch`)**
시스템 아키텍처 설계·점검. 계층 분리, 모듈 경계·의존성, API 계약, 인증 구조, 비동기/작업, 캐싱, 폴더 구조, 확장성. 출력(설계): 요구사항 → 옵션 비교 → 권장안(흐름도) → 단계 적용. 출력(점검): 진단 → 문제 → 개선 설계 → 마이그레이션.

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

---

## 사용 예

```
/review                       # 현재 git 변경분 코드 리뷰
/sec src/auth                 # auth 폴더 보안 점검
/test tests/test_user.py      # 특정 테스트만 실행
/apidoc                       # API 엔드포인트 문서화
/db                           # 쿼리/인덱스 성능 점검
/migrate                      # 스키마 마이그레이션 안전성 점검
/ui src/components            # 컴포넌트 UI/UX 점검
/dsystem                      # 디자인 시스템 설계
/datamodel 주문/결제 ERP 모델 설계해줘
/arch 실시간 알림 기능 구조 설계해줘
```

> 슬래시 명령은 추가 후 다음 세션부터 목록에 나타납니다.
> 자동 호출: 명령 없이 "보안 점검해줘"처럼 말해도 description을 보고 알맞은 에이전트가 선택됩니다.

---

## 관련 문서
- 디자인 에이전트 4종 상세: `design-agents.md`
- 저장소 안내: `CLAUDE.md`
