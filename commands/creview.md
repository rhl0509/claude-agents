---
description: c-code-reviewer로 C 코드 리뷰(메모리 안전·UB·정수 변환·자원 누수·포맷 취약점)
argument-hint: [경로 또는 소스(선택)]
---
c-code-reviewer 서브에이전트를 사용해 C 언어 코드를 리뷰해줘.

대상: $ARGUMENTS

경로가 비어 있으면 현재 git 변경분(`git diff` / `git diff --staged`) 중 `.c`/`.h`를 리뷰한다. 버퍼 경계·use-after-free·double-free·미초기화 읽기·널 역참조, 정수 오버플로·부호/폭 변환, 정의되지 않은 동작(UB), malloc/free·fd 등 자원 누수(특히 에러 경로), 포맷 스트링 취약점, 반환값·errno 미검사를 중점 점검한다. 정확성·안전을 우선하고, 구조 설계는 c-architect, 성능은 c-perf-auditor, 이미 난 크래시 원인은 debugger로 넘긴다.
