# 디자인 에이전트 5종 정리

Next.js + FastAPI + MySQL 스택을 위해 추가한 **설계/디자인 전용 서브에이전트** 모음입니다.
모두 읽기 전용으로 분석·설계·제안만 하며, 코드/스키마를 직접 수정하지 않습니다.

- 등록 위치(전역): `%USERPROFILE%\.claude\agents\`
- 사용 범위: 모든 프로젝트(D 파티션 포함)
- 공통 규칙: 영향도순 정렬 · 근거에 `파일:줄` · 불확실하면 "검토 필요" 표시

## 한눈에 보기

| 에이전트 | 슬래시 명령 | 모델 | 역할 |
|---|---|---|---|
| `ui-ux-reviewer` | `/ui` | opus | 화면 UI/UX·접근성·반응형 점검 |
| `motion-reviewer` | `/motion` `/모션` | opus | 모션·애니메이션 품질 점검 + 기회 탐색 |
| `design-system-architect` | `/dsystem` | opus | 디자인 토큰·컴포넌트·테마·**모션 토큰** 설계 |
| `data-modeler` | `/datamodel` | opus | 엔터티·관계·키·제약 설계 |
| `system-architect` | `/arch` | opus | 계층·모듈·API·확장성 설계 |

---

## 1. ui-ux-reviewer (`/ui`)

**언제 쓰나**: 화면을 머지하기 전 디자인 품질 점검이 필요할 때.

**점검 항목**
- 레이아웃/간격 일관성, 시각적 위계
- 타이포그래피 위계·가독성
- 색 대비(WCAG AA), 색에만 의존하지 않는 정보 전달
- 반응형(브레이크포인트, 터치 타깃 크기)
- 접근성(시맨틱 태그, `aria-*`, 키보드·포커스, `alt`, `label`, `prefers-reduced-motion`)
- 상태 표현(로딩/빈/에러/비활성/성공 피드백)
- **폼/입력**(라벨·검증 시점·에러 위치·중복 제출 방지) *(v1.3)*
- **마이크로카피/콘텐츠**(행동 기반 라벨·에러 메시지·말투 일관성) *(v1.3)*
- **국제화(i18n/RTL)**(텍스트 확장·RTL 미러링·로케일 포맷) *(v1.3)*
- **다크모드 품질**(단순 반전 넘어 표면 위계·채도·대비) *(v1.3)*
- **다크 패턴/윤리**(거짓 긴급성·함정 동의·강제 행동) *(v1.3)*
- 컴포넌트 일관성(중복·불일치, 아이콘·래디우스·인터랙션 상태·내비 활성)

> 점검 렌즈: 실무 디자인 감사 카테고리 + Nielsen 사용성 휴리스틱 10 (참고: GitHub Claude Design 생태계의 디자인 감사 룰셋).

**구분**: 코드 로직 버그는 `code-reviewer`, 토큰/시스템 설계는 `design-system-architect`, 로드·렌더 성능(번들·CWV)은 `perf-auditor`, 모션 품질(이징·지속시간·인터럽트·GPU 속성)은 `motion-reviewer` — 이 에이전트는 `prefers-reduced-motion` 대응 유무까지만 본다 *(v1.8)*.

---

## 1-B. motion-reviewer (`/motion` `/모션`)

**언제 쓰나**: 모션·트랜지션·제스처 코드를 머지하기 전, "애니메이션이 굼뜨다·겉돈다"고 느낄 때, 또는 "여기 뭘 애니메이션할까".

**두 모드**
- **점검(기본)** — 이미 있는 모션의 결함.
- **기회 탐색** — 빠진 모션 찾기. **절제가 기본값**이라 제안 5~7개 상한 + **기각 후보 필수**.

**점검 항목**
- 정당성(피드백·공간 일관성·상태 표시·급변 완충·설명 중 하나로 부를 수 있는가)
- **빈도 게이트** — 하루 100회 이상·키보드로 시작되는 동작의 애니메이션은 실격
- 이징(등장·퇴장 `ease-out`, **UI의 `ease-in`은 결함**, 내장 커브 대신 커스텀 cubic-bezier)
- 지속시간 예산(UI 300ms 미만 / 버튼 100~160 · 툴팁 125~200 · 드롭다운 150~250 · 모달 200~500ms)
- 물리성·원점(`scale(0)` 금지, 팝오버는 트리거에서 자람 · **모달은 예외**, 들어온 경로로 나가기)
- **인터럽트 가능성**(토스트·토글의 keyframes는 재시작 → transition/스프링, 현재 화면값에서 이어받기)
- GPU 속성(`transform`·`opacity`만 / `transition: all`·레이아웃 속성·Framer Motion `x`/`y` 축약형은 결함)
- 비대칭 타이밍, 제스처 물리(속도 핸드오프·모멘텀 투영·러버밴딩), 모션 접근성, 응집·스태거(30~80ms)

**근거**: 프리로드 스킬 `motion-reference`(구체 값 정본 — 값을 인용하고 근사하지 않는다).
출처는 [emilkowalski/skills](https://github.com/emilkowalski/skills)(MIT © 2026 Emil Kowalski) 방법론 + Apple WWDC *Designing Fluid Interfaces*의 모션·제스처 부분.

**출력**: 모드·범위 → 발견 표(위치/Before/After/왜) → 영향도 6등급 → (기회 모드면) 제안·기각 표 → **보류/통과** 판정 → 확인 필요.

**구분**: 화면 전반은 `ui-ux-reviewer`, 모션 **토큰 체계 설계**는 `design-system-architect`, 번들·CWV는 `perf-auditor`, Unity 게임플레이 손맛은 `game-feel-reviewer`.

---

## 2. design-system-architect (`/dsystem`)

**언제 쓰나**: 흩어진 스타일을 일관된 디자인 시스템으로 정비할 때, 디자인 시스템을 `DESIGN.md` 단일 소스로 정리할 때.

**분석/설계 항목**
- 디자인 토큰(색/타이포/스페이싱/래디우스/섀도/z-index/**모션** — 이징 3종·듀레이션 스케일·스프링 프리셋, *v1.7*)
- 테마(다크모드 등 CSS 변수 기반 전환 구조)
- 컴포넌트 계층(원자 → 조합 → 패턴), variant/size/state 설계
- 네이밍·규칙 일관성(의미 기반 vs 값 기반)
- Tailwind 설정 토큰화, 임의값 남용 점검
- 중복 컴포넌트/스타일 통합
- 문서화(Storybook 등) / **단일 소스 `DESIGN.md`**

**DESIGN.md 포맷 (v1.3)**: [google-labs-code/design.md](https://github.com/google-labs-code/design.md) 포맷으로 토큰을 한 파일에 모은다 — 프런트매터(기계가 읽는 토큰: `colors`/`typography`/`rounded`/`spacing`/`components`, 참조 `{colors.primary}`) + 산문(사람이 읽는 근거: Overview→Colors→Typography→Layout & Spacing→Elevation & Depth→Shapes→Components→Do's and Don'ts). 색 토큰은 WCAG 대비 명시. `@google/design.md` CLI(`lint`/`export`→Tailwind v3 JSON·v4 `@theme`·DTCG/`diff`)는 **실행하지 않고** 다음 단계로 안내(읽기 전용). Tailwind 프로젝트는 DESIGN.md를 단일 소스로 두고 export 권장.

**출력**: 현황 진단 → 제안 토큰 세트(DESIGN.md 형태) → DESIGN.md 초안 → 컴포넌트 구조 → 마이그레이션 단계.

**구분**: 개별 화면 점검은 `ui-ux-reviewer`, 구현된 애니메이션의 품질 점검은 `motion-reviewer`(이 에이전트는 그 판정 기준이 될 토큰을 세운다).

---

## 3. data-modeler (`/datamodel`)

**언제 쓰나**: 새 도메인의 테이블/관계를 설계하거나 기존 모델을 재설계할 때(ERP 등 복잡 도메인).

**설계 항목**
- 엔터티/관계(1:1, 1:N, N:M → 연결 테이블)
- 정규화(3NF 기준, 의도적 비정규화는 사유 명시)
- 키 전략(대리키 vs 자연키, 복합키, FK 동작)
- 타입 선택(금액=DECIMAL, 시간=DATETIME/TIMESTAMP, 상태=ENUM vs 참조 테이블)
- 제약/무결성(UNIQUE·NOT NULL·CHECK·기본값)
- 이력/운영(감사 컬럼, soft delete, 채번/시퀀스)
- 확장성(다국어·멀티테넌시)

**출력**: 텍스트 ERD → 테이블별 설계(DDL 예시) → 트레이드오프 → 가정/확인 필요.

**구분**: 기존 쿼리/인덱스 성능 튜닝은 `db-optimizer`, 마이그레이션 안전성(락·백필·롤백)은 `migration-reviewer`. 이 에이전트는 "어떻게 설계할지"를 다룸.

---

## 4. system-architect (`/arch`)

**언제 쓰나**: 기능 구현 전 구조 설계, 또는 기존 아키텍처 점검 시.

**점검/설계 항목**
- 계층 분리(라우터/서비스/레포지토리, 서버/클라이언트 컴포넌트 경계)
- 모듈 경계·의존성 방향(순환 의존, 결합도/응집도)
- API 계약(스키마·버저닝·에러 규약·타입 공유)
- 인증/인가 구조(토큰 흐름, 권한 검사 위치)
- 비동기/작업 처리(큐·워커, 타임아웃·재시도)
- 캐싱/성능 구조, N+1 구조적 방지
- 폴더/프로젝트 구조, 확장성·운영

**출력(새 설계)**: 요구사항/가정 → 설계 옵션 비교(장단점) → 권장안(흐름 다이어그램) → 단계적 적용.
**출력(점검)**: 현황 진단 → 구조적 문제(영향도순) → 개선 설계 → 마이그레이션 단계.

---

## 사용 예

```
/ui src/components            # 컴포넌트 UI/UX·접근성 점검
/motion src/components        # 모션·애니메이션 품질 점검
/모션 기회 탐색                # 빠진 모션 찾기(절제·기각 후보 포함)
/dsystem                      # 디자인 시스템 진단·설계
/datamodel 주문/결제 ERP 모델 설계해줘
/arch 실시간 알림 기능 구조 설계해줘
```

> 슬래시 명령은 추가 후 다음 세션부터 목록에 나타납니다.
