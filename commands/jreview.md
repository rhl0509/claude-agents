---
description: java-code-reviewer로 Java(JVM) 코드 리뷰(null·예외·자원 수명·동시성·equals/hashCode·박싱)
argument-hint: [파일/경로(선택)]
---
java-code-reviewer 서브에이전트로 Java 코드의 고유 결함(NPE·Optional 오용·예외 정책·try-with-resources 자원 누수·동시성/비스레드안전·equals·hashCode 계약·오토박싱 ==·로케일)을 리뷰해줘.

대상: $ARGUMENTS

경로가 비어 있으면 `git diff`로 변경분을 대상으로 한다. 코드를 직접 고치지 않고 Must/Should/Nit로 분류해 근거(`파일:줄`)와 수정 방향을 제시한다. 구조·DI 설계는 java-architect, 이미 난 증상은 debugger로 위임 표시한다.
