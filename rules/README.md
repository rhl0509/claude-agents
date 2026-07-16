# rules — 코딩 표준 (Claude Code 네이티브 rules)

스택별 코딩 표준의 소스다(common·python·typescript). ECC의 rules 개념을 참고하되 당신 스택(FastAPI·Next.js)과 규율에 맞춰 한국어로 작성했다.

## 로딩 메커니즘 (확인됨)

Claude Code는 `~/.claude/rules/*.md`를 **네이티브로 자동 로드한다**(claude-code-guide 확인, 공식 문서 기준):
- `paths:` 프론트매터(글롭)가 **있으면** → **조건부 로드**: Claude가 그 글롭에 매칭되는 파일을 읽을 때만 로드.
- `paths:`가 **없으면** → **무조건 로드**(세션 시작 시 항상, 일반 CLAUDE.md처럼).

그래서 이 폴더의 규칙은 `paths:`로 스코프했다 — .py 편집 시 python.md만, .ts/.tsx 편집 시 typescript.md만, 코드 파일 편집 시 common.md. **안 쓰는 스택 규칙은 컨텍스트에 안 들어온다**(비용 0). 레포별 CLAUDE.md 편집이 **필요 없다** — 전역 `paths:` 스코프가 모든 레포에서 자동 처리.

## 배포

`sync.ps1`이 이 폴더의 `*.md`(README.md 제외)를 `~/.claude/rules/`에 배포한다(agents·commands·skills와 동일 파이프라인). 소스는 여기서만 수정하고 sync로 반영한다.

## 검증 권장

전역 `~/.claude/rules/`(프로젝트 `.claude/rules/`가 아닌) + Windows 조합의 실제 로드는 다음 세션에서 확인 권장 — .py 파일을 열고 python 규칙이 적용되는지. 문서상 지원되나 Windows 명시 검증 예시는 없었다(paths 스코프는 네이티브 기능).
