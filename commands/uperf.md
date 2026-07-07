---
description: unity-perf-auditor로 Unity 런타임 성능·렌더링 점검(배칭·오버드로우·텍스처/오디오 메모리·물리 스텝·Profiler 해석)
argument-hint: [경로·설정 파일 또는 Profiler 캡처 수치(선택)]
---
unity-perf-auditor 서브에이전트를 사용해 Unity 게임의 런타임 성능·렌더링을 점검해줘.

대상: $ARGUMENTS

대상이 비어 있으면 `ProjectSettings/`(퀄리티·타임·물리 설정)와 `Assets/` 하위 텍스처·오디오 임포트 설정(`.meta`)·SpriteAtlas·파티클/카메라 구성을 찾아 점검한다. 드로우콜·배칭, 오버드로우·필레이트, 텍스처 압축(ASTC/ETC2)·메모리, Fixed Timestep·2D 충돌 비용, 오디오 Load Type을 중점 점검하고, 정적으로 단정할 수 없는 것은 Profiler/Frame Debugger 측정 계획으로 분리한다. Profiler 캡처 수치가 주어지면 프레임 예산 대비 병목을 해석한다. GC를 유발하는 코드 패턴은 unity-code-reviewer, 빌드 크기·스토어 제출은 unity-build-auditor 영역이다.
