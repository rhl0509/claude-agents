---
description: unity-code-reviewer로 Unity C# 게임 코드 리뷰(수명주기·GC·프레임/물리 의존)
argument-hint: [경로 또는 스크립트(선택)]
---
unity-code-reviewer 서브에이전트를 사용해 Unity + C# 게임 코드를 리뷰해줘.

대상: $ARGUMENTS

경로가 비어 있으면 현재 git 변경분(`git diff` / `git diff --staged`) 중 `Assets/` 하위 `.cs`를 리뷰한다. MonoBehaviour 수명주기, Update/FixedUpdate 루프 비용, GC 유발 할당, 코루틴·async 취소, 물리·프레임률 의존, fake-null, ScriptableObject 패턴을 중점 점검한다.
