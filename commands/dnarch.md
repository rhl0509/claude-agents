---
description: dotnet-architect로 .NET 구조 설계·점검(계층·DI 수명·미들웨어·호스팅·async 경계)
argument-hint: [설계 대상 또는 점검할 경로(선택)]
---
dotnet-architect 서브에이전트를 사용해 비-Unity .NET 애플리케이션의 구조를 설계하거나 점검해줘.

대상: $ARGUMENTS

계층 분리(엔드포인트/애플리케이션/도메인/인프라·Minimal API 대 컨트롤러), DI 컨테이너와 서비스 수명 설계(captive dependency 예방·`DbContext` 수명), 미들웨어 파이프라인 순서, 호스팅 모델(`BackgroundService`·그레이스풀 셧다운), 구성/옵션 패턴, async 경계(끝까지 async·취소 전파), 프로젝트 구조·의존성 방향(순환 차단), 복원력(재시도·서킷브레이커)을 다룬다. 버전 의존 패턴은 Context7로 확인한다. 구현 코드 결함은 dotnet-code-reviewer, 성능은 dotnet-perf-auditor, 배포·컨테이너는 devops-reviewer로 위임한다.
