---
description: dependency-auditor로 의존성 취약점·버전·라이선스 점검
argument-hint: [매니페스트/경로(선택)]
---
dependency-auditor 서브에이전트를 사용해 프로젝트 의존성의 건강성을 점검해줘.

대상: $ARGUMENTS

대상이 비어 있으면 package.json·lockfile·requirements·pyproject 전반을 점검한다.
알려진 취약점(CVE), 오래된/방치된 버전, lockfile 무결성·드리프트, 미사용·누락 의존성, dev/runtime 오분류, 라이선스·공급망 위험을 본다.
`npm audit`·`pip-audit` 같은 읽기 전용 진단 명령은 내가 명시적으로 요청할 때만 실행하고, 설치·업그레이드는 하지 않는다.
