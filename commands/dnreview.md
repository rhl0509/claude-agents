---
description: dotnet-code-reviewer로 비-Unity C#/.NET 코드 리뷰(async·IDisposable·지연실행·DI 수명·EF Core)
argument-hint: [경로 또는 소스(선택)]
---
dotnet-code-reviewer 서브에이전트를 사용해 비-Unity C#/.NET 코드를 리뷰해줘.

대상: $ARGUMENTS

경로가 비어 있으면 현재 git 변경분(`git diff` / `git diff --staged`) 중 `.cs`를 리뷰한다. async/await 오용(`.Result`/`.Wait()` 데드락·`async void`·미대기 Task·취소 미전파), IDisposable/`using` 누락과 자원 누수, IEnumerable 지연 실행·다중 열거, nullable(NRE·`!` 남용), DI 수명 오류(captive dependency·`DbContext` 공유), EF Core 안티패턴(N+1·추적 낭비), 예외 삼킴·`throw ex` 스택 소실, 문화권 의존 파싱을 중점 점검한다. Unity C#은 unity-code-reviewer, 구조는 dotnet-architect, 성능은 dotnet-perf-auditor로 넘긴다.
