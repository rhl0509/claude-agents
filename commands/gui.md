---
description: game-ui-reviewer로 Unity 게임 UI/UX 점검(HUD·메뉴·스케일링·세이프에어리어·내비게이션)
argument-hint: [경로 또는 씬/프리팹/UI 스크립트(선택)]
---
game-ui-reviewer 서브에이전트를 사용해 Unity 게임의 UI/UX 레이어를 점검해줘.

대상: $ARGUMENTS

대상이 비어 있으면 `Assets/` 하위 UI 관련 파일(Canvas·CanvasScaler·EventSystem이 든 씬/프리팹 YAML, UnityEngine.UI/TMPro 스크립트)을 찾아 점검한다. HUD·메뉴 레이아웃과 정보 위계, CanvasScaler 해상도·종횡비 스케일링, 세이프 에어리어, 캔버스 렌더 모드, 게임패드·터치 내비게이션과 포커스, 텍스트 가독성·색약 대비, UI 상태(로딩/빈/에러/전환), 온보딩 UI를 중점 점검한다. 게임플레이 동작의 손맛은 game-feel-reviewer 영역이다.
