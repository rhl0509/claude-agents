---
description: llm-ai-security-reviewer로 AI/LLM 보안 심화 점검
argument-hint: [파일/경로(선택)]
---
llm-ai-security-reviewer 서브에이전트로 LLM/AI 기능(챗봇·RAG·에이전트·툴 호출)의 AI 보안을 OWASP LLM Top 10 2025 기준으로 점검해줘.

대상: $ARGUMENTS

경로가 비어 있으면 현재 폴더에서 LLM 호출·RAG·에이전트·툴 관련 코드를 찾아 점검한다. 프롬프트 인젝션(직접·간접)·출력 처리·과도한 행위성·유출·RAG 포이즈닝·무제한 소비를 심각도순으로 보고한다.
