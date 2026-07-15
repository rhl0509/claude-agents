---
description: swift-architect로 Swift 앱 구조 설계·점검(아키텍처 패턴·상태 관리·모듈·동시성 경계)
argument-hint: [무엇을 설계/점검할지 + (선택) 경로]
---
swift-architect 서브에이전트로 Swift 앱(iOS/macOS·SwiftUI/UIKit·SPM) 구조를 설계하거나 점검해줘.

대상/요구: $ARGUMENTS

아키텍처 패턴(MVVM/TCA 등) 선택·모듈 경계·의존성 주입·동시성 아키텍처(actor·@MainActor 경계)·SwiftUI 상태 관리(단일 진실 원천·프로퍼티 래퍼 소유권 배치)·내비게이션·값 타입 도메인 모델링·영속성/네트워킹 경계를 다룬다. 설계 옵션을 표로 비교해 권장안을 낸다. 코드는 작성하지 않고 설계만. 구현 결함은 swift-code-reviewer로 위임 표시한다.
