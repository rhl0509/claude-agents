---
description: swift-code-reviewer로 Swift 코드 리뷰(강제 언랩·ARC 참조 순환·값/참조·동시성·에러 삼킴)
argument-hint: [파일/경로(선택)]
---
swift-code-reviewer 서브에이전트로 Swift 코드의 고유 결함(강제 언랩 `!`/`try!`/`as!` 크래시·ARC retain cycle·[weak self] 누락·값/참조 의미·actor/@MainActor 경계·Sendable 데이터 레이스·continuation 이중 재개·try? 에러 삼킴)을 리뷰해줘.

대상: $ARGUMENTS

경로가 비어 있으면 `git diff`로 변경분을 대상으로 한다. 코드를 직접 고치지 않고 Must/Should/Nit로 분류해 근거(`파일:줄`)와 수정 방향을 제시한다. 앱 구조·상태관리 설계는 swift-architect, 이미 난 크래시는 debugger로 위임 표시한다.
