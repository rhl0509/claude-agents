---
description: java-architect로 Java(JVM/Spring) 구조 설계·점검(계층·빈 수명·트랜잭션·모듈 경계)
argument-hint: [무엇을 설계/점검할지 + (선택) 경로]
---
java-architect 서브에이전트로 Java(Spring Boot·서버·배치) 구조를 설계하거나 점검해줘.

대상/요구: $ARGUMENTS

계층 분리·의존성 주입과 빈 수명(생성자 주입·스코프·싱글턴 상태)·모듈/패키지 의존 방향·에러 처리 전략·트랜잭션 경계·동시성·구성/시크릿을 다룬다. 설계 옵션을 장단점 표로 비교해 권장안을 낸다. 코드는 작성하지 않고 설계만. 구현 결함은 java-code-reviewer로 위임 표시한다.
