---
description: api-contract-reviewer로 프론트-백 API 계약 정합성 점검
argument-hint: [엔드포인트/경로/기능(선택)]
---
api-contract-reviewer 서브에이전트를 사용해 Next.js 프론트와 FastAPI 백엔드의 API 계약 정합성을 점검해줘.

대상: $ARGUMENTS

대상이 비어 있으면 프론트 호출부와 백엔드 라우트·스키마 전반을 점검한다.
요청/응답 필드·타입 일치, 필수/옵셔널·널·enum 차이, 타입 드리프트(단일 출처 여부), 경로·메서드·상태코드, 깨지는 변경, 페이지네이션·공통 래퍼를 본다.
