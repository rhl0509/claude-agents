---
description: unity-build-auditor로 빌드/릴리스 설정·스토어 제출 준비 점검(PlayerSettings·크기·서명·권한·디버그 잔존)
argument-hint: [ProjectSettings 경로 또는 타깃 플랫폼(선택)]
---
unity-build-auditor 서브에이전트를 사용해 Unity 빌드/릴리스 설정과 스토어 제출 준비 상태를 점검해줘.

대상: $ARGUMENTS

대상이 비어 있으면 `ProjectSettings/`(ProjectSettings.asset·EditorBuildSettings.asset·QualitySettings.asset), `Assets/Plugins/Android/`, `Assets/Resources/`, `AddressableAssetsData/`, `.gitignore`와 keystore 흔적을 찾아 점검한다. 번들 ID·버전, IL2CPP/ARM64, managed stripping, 빌드 씬 목록, 크기(Resources 남용·압축 용량), 매니페스트 권한, keystore 커밋 여부, development build 플래그 잔존을 중점 점검하고, 스토어 정책 수치는 단정하지 않고 확인 목록(⚠️)으로 분리한다. 시크릿 보관·CI 통합은 devops-reviewer, 런타임 성능·렌더링은 unity-perf-auditor 영역이다.
