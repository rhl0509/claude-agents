// PM 오케스트레이션 워크플로 — project-manager "두뇌"의 계획을 받아, 라우팅된 전문
// 에이전트들을 실제로 실행("팔")하고 결과를 통합 보고한다.
//
// 실행: /pm-run <목표>  (커맨드가 Workflow 도구로 이 스크립트를 name="pm-orchestrate"로 호출)
// 또는 Workflow({ name: 'pm-orchestrate', args: '<목표 문자열>' })
//
// 한계(정직히): 라이브러리 전문 에이전트는 전부 읽기 전용(리뷰·설계·분석)이라 이 워크플로는
// "분석·설계 산출물"을 오케스트레이션해 통합 리포트를 낸다. 실제 코드 편집은 이 리포트를 받은
// 메인 세션/사용자의 후속 단계다(에이전트가 파일을 고치지 않는다).

export const meta = {
  name: 'pm-orchestrate',
  description: 'PM: 목표를 태스크로 분해·라우팅한 뒤 전문 에이전트를 실제로 실행해 통합 보고',
  phases: [
    { title: 'Plan', detail: 'project-manager로 WBS + 전문 에이전트 라우팅 산출' },
    { title: 'Execute', detail: '라우팅된 전문 에이전트 팬아웃 실행' },
    { title: 'Synthesize', detail: 'project-manager로 결과 통합·다음 착수 제안' },
  ],
}

const goal = (typeof args === 'string' ? args : (args && (args.goal || args.target))) || ''

// ── Phase 1: 계획 (두뇌) ──────────────────────────────────────────────
phase('Plan')

const PLAN_SCHEMA = {
  type: 'object',
  additionalProperties: false,
  properties: {
    goal: { type: 'string' },
    assumptions: { type: 'array', items: { type: 'string' } },
    tasks: {
      type: 'array',
      items: {
        type: 'object',
        additionalProperties: false,
        properties: {
          id: { type: 'string', description: '짧은 id (T1, T2 …)' },
          task: { type: 'string' },
          priority: { type: 'string', enum: ['P0', 'P1', 'P2'] },
          deps: { type: 'array', items: { type: 'string' }, description: '선행 태스크 id 목록' },
          units: {
            type: 'array',
            description: '이 태스크를 실제로 처리할 (전문 에이전트, 지시) 단위. 한 태스크가 설계→리뷰처럼 여러 단위를 가질 수 있다.',
            items: {
              type: 'object',
              additionalProperties: false,
              properties: {
                agent: { type: 'string', description: '이 라이브러리의 정확한 에이전트명 (예: security-reviewer, system-architect, db-optimizer, unity-code-reviewer …)' },
                prompt: { type: 'string', description: '그 전문 에이전트에게 줄 자기완결적 지시 — 무엇을 어느 파일/레포에서 볼지 포함' },
              },
              required: ['agent', 'prompt'],
            },
          },
        },
        required: ['id', 'task', 'priority', 'units'],
      },
    },
    risks: { type: 'array', items: { type: 'string' } },
  },
  required: ['tasks'],
}

const planPrompt = `당신은 project-manager다. 다음 목표를 실행 계획으로 옮겨라.

목표: ${goal || '(목표 미지정 — 현재 워킹 디렉터리와 project_active.md·git 이력으로 진행 현황을 파악해 다음 착수 P0들을 태스크로 잡아라)'}

요구:
- 목표를 독립적으로 착수·검증 가능한 태스크(WBS)로 분해하고, 의존성(deps)과 우선순위(P0~P2)를 매겨라.
- 각 태스크의 units에 그 일을 실제로 처리할 **이 라이브러리의 전문 에이전트명(agent)**과 **자기완결적 지시(prompt)**를 넣어라.
  - agent는 반드시 실존 에이전트명(예: code-reviewer, security-reviewer, system-architect, data-modeler, migration-reviewer, db-optimizer, api-contract-reviewer, ui-ux-reviewer, perf-auditor, test-strategy, refactor-strategist, debugger, accounting-rule-reviewer, ml-experiment-reviewer, automation-reliability-reviewer, unity-code-reviewer, multiplayer-rule-reviewer, c-code-reviewer, dotnet-code-reviewer, java-code-reviewer, swift-code-reviewer, docs-writer 등).
  - prompt는 그 에이전트가 대상 파일/레포를 스스로 읽고 일할 수 있도록 경로·범위를 담아라.
  - 코드 편집은 이 에이전트들이 하지 않는다(전부 읽기 전용). 단위는 "리뷰/설계/분석"으로 잡아라.
- 맞는 전문 에이전트가 없는 태스크면 units를 비우고 task에 "담당 없음(직접 작업)"이라고 표시하라.
가정과 리스크도 채워라.`

const plan = await agent(planPrompt, { agentType: 'project-manager', schema: PLAN_SCHEMA, phase: 'Plan', label: 'plan:WBS' })

const tasks = (plan && plan.tasks) || []
// (태스크, 단위)를 평탄화. 전문 에이전트 단위만 실행 대상.
let units = []
for (const t of tasks) {
  for (const u of (t.units || [])) {
    if (u && u.agent && u.prompt) units.push({ taskId: t.id, task: t.task, priority: t.priority, agent: u.agent, prompt: u.prompt })
  }
}

// 폭주 방지 상한(무음 절단 금지 — 넘으면 로그로 알림).
const CAP = 24
let dropped = 0
if (units.length > CAP) { dropped = units.length - CAP; units = units.slice(0, CAP) }
log(`계획: 태스크 ${tasks.length}개 · 실행 단위 ${units.length}개${dropped ? ` (상한 ${CAP} 초과로 ${dropped}개 보류 — 나중에 재실행 필요)` : ''}`)

// ── Phase 2: 실행 (팔) — 라우팅된 전문 에이전트 병렬 팬아웃 ──────────────
// 단위들은 읽기 전용 분석이라 서로 독립 → 병렬. 태스크 간 deps는 계획에 남아
// 사람이 "코드 편집" 순서를 잡을 때 쓴다(분석 자체엔 순서 불필요).
phase('Execute')

const executed = (await parallel(units.map((u, i) => () =>
  agent(u.prompt, { agentType: u.agent, phase: 'Execute', label: `${u.taskId}:${u.agent}` })
    .then(out => ({ ...u, ok: true, output: out }))
    .catch(err => ({ ...u, ok: false, output: `실행 실패(에이전트명 오류 가능): ${String(err && err.message || err)}` }))
))).map((r, i) => r || { ...units[i], ok: false, output: '실행 실패(에이전트 종료)' })

const failed = executed.filter(r => !r.ok)
if (failed.length) log(`실행 실패 ${failed.length}개 — 라우팅한 에이전트명이 실존하는지 확인 필요: ${failed.map(f => f.agent).join(', ')}`)

// ── Phase 3: 통합 (두뇌) ──────────────────────────────────────────────
phase('Synthesize')

const digest = executed.map(r =>
  `### [${r.taskId} ${r.priority}] ${r.task} → ${r.agent} ${r.ok ? '' : '(실패)'}\n${r.output}`
).join('\n\n')

const synthPrompt = `당신은 project-manager다. 아래는 당신이 세운 계획과, 각 태스크를 라우팅한 전문 에이전트들의 실제 실행 결과다. 이것을 통합해 최종 보고를 내라.

## 원래 목표
${goal || '(진행 현황 점검)'}

## 계획(WBS)
${JSON.stringify({ assumptions: plan && plan.assumptions, tasks: tasks.map(t => ({ id: t.id, task: t.task, priority: t.priority, deps: t.deps })), risks: plan && plan.risks }, null, 2)}

## 전문 에이전트 실행 결과
${digest}

요구:
1. **통합 현황** — 무엇이 분석/설계됐고 무엇이 남았는지.
2. **핵심 발견(교차)** — 여러 에이전트 결과에서 공통·충돌하는 지점, 영향도순.
3. **실행 순서** — deps·우선순위를 반영한 사람이 할 코드 편집 순서(전문 에이전트는 읽기 전용이라 편집은 미수행 — 이 통합 리포트가 그 편집의 근거).
4. **다음 착수(P0)** — 바로 시작할 한 가지.
5. **차단·리스크·재실행 필요**(실패/보류 단위 포함).
근거는 각 에이전트 결과의 \`파일:줄\`을 인용하라. 확신 없는 건 "확인 필요"로 표시.`

const synthesis = await agent(synthPrompt, { agentType: 'project-manager', phase: 'Synthesize', label: 'synthesize:report' })

return {
  goal,
  plan,
  executedCount: executed.length,
  failedCount: failed.length,
  dropped,
  synthesis,
}
