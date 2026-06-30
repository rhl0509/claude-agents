---
description: devops-reviewer로 Docker·CI/CD·배포 설정 점검
argument-hint: [파일/경로(선택)]
---
devops-reviewer 서브에이전트를 사용해 배포/운영 설정을 점검해줘.

대상: $ARGUMENTS

대상이 비어 있으면 Dockerfile·docker-compose·CI 워크플로·배포 설정 전반을 점검한다. 대상 파일이 없으면 그 사실을 보고한다.
