---
description: c-perf-auditor로 C 런타임 성능 점검(캐시 지역성·할당·복사·복잡도·프로파일 해석)
argument-hint: [경로 또는 프로파일러 캡처 수치(선택)]
---
c-perf-auditor 서브에이전트를 사용해 C 프로그램의 런타임 성능을 점검해줘.

대상: $ARGUMENTS

메모리 접근 패턴·캐시 지역성(AoS/SoA·거짓 공유), 할당 전략(핫 경로의 개별 malloc 대 아레나/풀), 불필요한 복사, 알고리즘·자료구조 복잡도, 분기·핫/콜드 분리, 컴파일 최적화·벡터화 여지, I/O 버퍼링을 점검한다. 정적으로 단정할 수 없는 것은 perf/cachegrind/callgrind/Massif 측정 계획으로 분리하고, 캡처 수치가 주어지면 병목을 해석한다. 성능을 깎는 코드의 정확성·UB는 c-code-reviewer, 회귀 시점은 debugger, 구조 재설계는 c-architect 영역이다.
