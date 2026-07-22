---
description: brand-voice-guardian로 브랜드 보이스 일관성 점검
argument-hint: [파일/경로(선택)]
---
brand-voice-guardian 서브에이전트로 콘텐츠 초안이 브랜드 보이스(문체·톤·어휘·거리감·시그니처)에 맞는지 점검해줘.

대상: $ARGUMENTS

기준은 프로젝트의 voice.md → 보이스 정본(`D:\auto_agent_content\voice.md`) → 확정 예시글 → 제공된 예시 추론 순으로 찾는다. 프로젝트에 voice.md가 없으면 정본을 직접 읽고, 어느 파일을 기준으로 썼는지 결과 상단에 밝힌다. 정본까지 없을 때만 보이스를 지어내지 말고 /fable로 voice.md를 먼저 만들라고 안내한다. 벗어난 구간을 원문→교정 예시로 제시한다.
