---
description: aws-reviewer로 AWS IaC·리소스 구성의 보안·안정성·비용 자세 점검
argument-hint: [IaC 경로(선택)]
---
aws-reviewer 서브에이전트로 AWS 인프라 자세를 점검해줘 — IAM 최소권한(와일드카드 Action/Resource·과대 신뢰정책), 공개 노출(퍼블릭 S3·보안그룹 0.0.0.0/0·퍼블릭 RDS), 저장 암호화, 네트워크 격리, 서비스 구성(ECS/Lambda/RDS), Terraform state 백엔드, 비용·태그, 그리고 **파괴적 변경**(RDS·EBS replace = 데이터 상실).

대상: $ARGUMENTS

경로가 비어 있으면 트리에서 IaC(`*.tf`·CDK·`template.yaml`·`serverless.yml`)를 찾아 점검한다. 대상이 없으면 그 사실을 먼저 알린다.

이 에이전트는 읽기 전용이라 AWS에 명령을 실행하지 않는다. 실제 배포는 `aws-deploy` 스킬(메인 세션)이 리뷰→플랜→명시 승인→실행 게이트를 거쳐 수행한다. Dockerfile·CI/CD 파이프라인·Actions YAML의 OIDC는 devops-reviewer 몫이다.
