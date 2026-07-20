---
description: identity-access-architect로 인증·인가·세션 구조 설계·점검
argument-hint: [기능·요구사항(선택)]
---
identity-access-architect 서브에이전트를 사용해 인증·인가·세션 구조를 설계·점검해줘 — OAuth2/OIDC 플로우 선택과 콜백 검증(state·nonce·PKCE·issuer·audience·alg 허용목록), 세션 방식 결정(불투명 서버 세션 vs 단명 JWT+회전 refresh), 토큰 수명을 폭발 반경으로 산정, 패스키/WebAuthn, SSO·SCIM, 멀티테넌트 격리(테넌트 ID는 인증된 컨텍스트에서만).

대상: $ARGUMENTS

대상이 비어 있으면 현재 프로젝트의 인증 관련 코드·설정을 읽어 점검한다. 인증 프리미티브를 발명하지 않고, 해피패스가 아니라 실패 경로(만료·폐기·리플레이·크로스테넌트·IdP 장애)부터 설계한다. 버전 민감한 라이브러리 동작은 Context7으로 확인하고 확인 못 한 것은 확인 필요로 남긴다.
