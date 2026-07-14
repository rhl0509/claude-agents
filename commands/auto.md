---
description: automation-reliability-reviewer로 데몬·스케줄 자동화 신뢰성 점검
argument-hint: [스크립트/데몬/스케줄 설정 경로(선택)]
---
automation-reliability-reviewer 서브에이전트를 사용해 백그라운드 자동화의 신뢰성을 점검해줘.

대상: $ARGUMENTS

로그가 실제로 남는가(셸 리다이렉트·상위 핸들 의존 vs 자체 기록·회전), 실패가 조용히 삼켜지는가, 중복 실행 락, 멱등성·부분 실패 복구, 하트비트·마지막 성공 시각·알림, 재부팅 후 자동 시작, 시크릿 위생을 본다. 코드를 직접 고치지 않고 사고 시나리오·신뢰성 체크리스트만 제시한다.
