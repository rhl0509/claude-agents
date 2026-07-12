---
description: agent-definition-reviewer로 서브에이전트 정의(.md) 스펙·경계 점검
argument-hint: [에이전트 파일/이름(선택)]
---
agent-definition-reviewer 서브에이전트를 사용해 Claude Code 서브에이전트 정의(.md)를 점검해줘.

대상: $ARGUMENTS

대상이 비어 있으면 `d:\auto_agent`의 에이전트 정의 전반(frontmatter 스펙 정합·description 라우팅 친화성·tools 최소권한·경계 중복/공백·본문 규범)을 점검한다. 정의 파일을 직접 고치지 않고 [P1/P2/P3] 발견 + 개정 초안만 제시한다.
