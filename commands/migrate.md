---
description: migration-reviewer로 스키마 마이그레이션 안전성 점검
argument-hint: [마이그레이션 파일/경로(선택)]
---
migration-reviewer 서브에이전트를 사용해 스키마 마이그레이션의 안전성을 점검해줘.

대상: $ARGUMENTS

대상이 비어 있으면 마이그레이션 디렉터리(alembic versions 등) 전반을 점검한다.
락 범위·무중단 가능성, NOT NULL+백필 순서, 인덱스 생성 비용, 타입 변경 재작성, FK/제약, 롤백 가능성, 대량 DML 배치, 배포 순서를 본다.
