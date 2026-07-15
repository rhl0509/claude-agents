---
description: dotnet-perf-auditor로 .NET 런타임 성능 점검(GC 압력·할당·Span·LOH·벤치마크 해석)
argument-hint: [경로 또는 측정 캡처 수치(선택)]
---
dotnet-perf-auditor 서브에이전트를 사용해 비-Unity .NET 애플리케이션의 런타임 성능을 점검해줘.

대상: $ARGUMENTS

GC 압력(할당률·세대 승격·Large Object Heap·Server 대 Workstation GC), 할당 절감(`Span<T>`/`stackalloc`/`ArrayPool`·struct 대 class·박싱·클로저 캡처), 문자열 비용(연결·보간·`StringBuilder`), async 오버헤드(상태머신 할당·`ValueTask`), LINQ 지연·중간 컬렉션, 컬렉션 선택·용량 예약, 직렬화·JIT/AOT를 점검한다. 정적으로 단정할 수 없는 것은 BenchmarkDotNet/dotnet-counters/dotnet-trace/PerfView 측정 계획으로 분리하고, 캡처 수치가 주어지면 처리량·지연·할당 병목을 해석한다. 할당 유발 코드 패턴·EF 안티패턴은 dotnet-code-reviewer, 회귀 시점은 debugger로 넘긴다.
