---
description: lint-agents.ps1로 에이전트 정의 규범 검사(프론트매터·경계 위임절·끊어진 링크·라우팅 고아)
argument-hint: [파일 경로(선택)]
---
`D:\auto_agent\lint-agents.ps1`을 실행해 에이전트 정의가 저장소 규범을 지키는지 검사해줘.

대상: $ARGUMENTS

경로가 비어 있으면 전체를 검사한다(`.\lint-agents.ps1 -Quiet`). 특정 파일만이면 `-Path`로 넘긴다.

ERROR는 머지 전에 반드시 고치고, WARN은 판단이 필요한 것이므로 항목별로 실제 결함인지 의도된 예외인지 함께 판단해 보고한다. 린터가 잡은 것을 고칠 때는 해당 에이전트의 `version`/`updated`를 올리고 CHANGELOG에 남긴 뒤 `sync.ps1`을 실행하는 저장소 워크플로를 따른다.
