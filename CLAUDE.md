# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

This directory is **not** an application codebase — it is a library of **Claude Code subagent definitions**. Each top-level `.md` file is one subagent: YAML frontmatter followed by the system prompt that drives that agent. There is no build, lint, or test tooling here; "developing" means authoring and editing these agent definition files.

The agents are authored in **Korean** and (with one exception) all target the same downstream stack they will be pointed at: **Next.js (frontend) + FastAPI (backend) + MySQL**. That stack lives in *other* repositories — these definitions are the reusable review/analysis tooling applied to it.

**Exceptions**: `ai-workspace-architect.md` is a **meta/workflow agent** (stack-agnostic) that redesigns the *user's own AI working environment* (prompts, custom instructions, CLAUDE.md/SKILL.md, repeat-task rules, per-model strategy). `copy-reviewer.md`, `landing-reviewer.md`, `seo-optimizer.md`, and `fact-checker.md` are **content/marketing reviewers** (copy, landing-page conversion, SEO, fact/source verification), and `content-repurposer.md` is a **content generator** that adapts one source into multiple formats. None of them review application code. All still obey the shared read-only + memory conventions below.

## The agents

| File | Purpose | Tools | Writes code? |
|---|---|---|---|
| `code-reviewer.md` | General quality/readability/bug review across Next.js + FastAPI | Read, Grep, Glob, Bash | No |
| `security-reviewer.md` | OWASP-oriented security review (authz/IDOR, Next.js middleware bypass, JWT, injection, XSS, secret leakage, OWASP LLM Top 10 2025) | Read, Grep, Glob, WebSearch, WebFetch | No |
| `db-optimizer.md` | MySQL schema/query/index analysis (N+1, indexing, pagination, locks, MySQL 9 vector search) | Read, Grep, Glob, Bash | No |
| `migration-reviewer.md` | MySQL/Alembic migration safety (locks, backfill order, rollback, deploy order) | Read, Grep, Glob | No |
| `api-doc-writer.md` | Catalog FastAPI endpoints into API docs (incl. `Annotated[...]` deps, OpenAPI 3.1 cross-check) | Read, Grep, Glob, Context7 | No |
| `test-runner.md` | Run pytest / Vitest·Jest unit / Playwright·Cypress E2E and diagnose failures (Vitest can't render async Server Components) | Bash, Read, Grep, Glob | No |
| `test-strategy.md` | Diagnose coverage gaps & weak tests, propose cases | Read, Grep, Glob | No |
| `perf-auditor.md` | Next.js perf (bundle, CWV, RSC boundary, fetching, Next 16 cache components/PPR/React Compiler) | Read, Grep, Glob | No |
| `api-contract-reviewer.md` | Front↔back API contract alignment (request/response field & type drift, optional/null/enum diffs, breaking changes, OpenAPI-generated type sync) | Read, Grep, Glob | No |
| `dependency-auditor.md` | Dependency health (CVEs, outdated/abandoned versions, lockfile integrity, unused/missing deps, license & supply-chain risk) | Read, Grep, Glob, Bash | No |
| `observability-reviewer.md` | App observability (structured logging, correlation/trace IDs, error capture/Sentry, metrics, tracing, sensitive-data log leakage) | Read, Grep, Glob | No |
| `devops-reviewer.md` | Docker / CI-CD / deploy config & secret-handling review (OIDC keyless auth, supply chain: SBOM/signing + artifact registries: immutable tags/upstream-proxy/scan, non-GHA pipelines: Harness OSS/Drone/GitLab CI, dev env: devcontainer/Gitspaces) | Read, Grep, Glob | No |
| `ui-ux-reviewer.md` | Next.js UI/UX, a11y, responsive, state-handling, forms, microcopy, i18n/RTL, dark mode, dark-pattern review | Read, Grep, Glob | No |
| `design-system-architect.md` | Design tokens, component hierarchy, theming, Tailwind config; authors a DESIGN.md single source (google-labs-code/design.md format) | Read, Grep, Glob, Context7 | No |
| `data-modeler.md` | MySQL data-model / schema design (ERD, normalization, keys, MySQL 9 VECTOR/embeddings) | Read, Grep, Glob | No |
| `system-architect.md` | System architecture design / review across the full stack (incl. LLM/RAG integration) | Read, Grep, Glob, Context7 | No |
| `ai-workspace-architect.md` | **Meta/workflow (stack-agnostic)**: redesigns the user's AI working environment — prompts, custom instructions, CLAUDE.md/SKILL.md, repeat-task rules, per-model strategy. Outputs paste-ready drafts, not code | Read, Grep, Glob, WebSearch, WebFetch | No |
| `copy-reviewer.md` | **Content/marketing**: marketing copy review (hook, single-message, reader-language, specificity, CTA, overclaim/dark-pattern ethics, tone) | Read, Grep, Glob | No |
| `landing-reviewer.md` | **Content/marketing**: landing / detail-page conversion review (value prop, problem-solution flow, social proof, objection handling, CTA strategy, offer/pricing, dark patterns) | Read, Grep, Glob | No |
| `seo-optimizer.md` | **Content/marketing**: blog/page SEO (search intent, title/meta, headings, keywords, links, structured data, E-E-A-T/snippets, cannibalization) | Read, Grep, Glob, WebSearch, WebFetch | No |
| `fact-checker.md` | **Content/marketing**: verifies factual claims / statistics / quotes / sources in content drafts; flags unverified as ⚠️/추정, never asserts unconfirmed as fact | Read, Grep, Glob, WebSearch, WebFetch | No |
| `content-repurposer.md` | **Content generator**: adapts one source (blog/script/course) into multiple formats (reels, card-news, thread, newsletter, landing sections). Outputs paste-ready drafts, not files | Read, Grep, Glob | No |

## Shared conventions (follow these when adding or editing an agent)

- **Frontmatter schema**: every agent has `name`, `description`, `tools`, `model`, `color`, `memory`, `skills`, `hooks` (plus repo-local `version`, `updated`). Official Claude Code fields: `color` (red/blue/green/yellow/purple/orange/pink/cyan — category grouping in the task list/transcript), `memory: user` (persistent per-user memory in `~/.claude/agent-memory/<name>/`, cross-project; it does **not** write into the reviewed repo), `skills: [agent-conventions]` (preloads the shared operating-norms skill), and `hooks.PreToolUse` (the read-only guard — see below). `version`/`updated` are non-standard but harmless. `name` matches the filename (kebab-case).
- **`model` tiering**: `opus` for deep-reasoning agents (code-reviewer, security-reviewer, db-optimizer, migration-reviewer, data-modeler, design-system-architect, system-architect, ui-ux-reviewer, perf-auditor, devops-reviewer, test-strategy, api-contract-reviewer, dependency-auditor, observability-reviewer, ai-workspace-architect, copy-reviewer, landing-reviewer, seo-optimizer, fact-checker, content-repurposer), `sonnet` for moderate agents (api-doc-writer, test-runner). `haiku` is reserved for purely mechanical work — no agent currently qualifies. Valid `model` values are `opus`/`sonnet`/`haiku`/`fable`/a full model ID/`inherit`; resolution precedence is `CLAUDE_CODE_SUBAGENT_MODEL` env → per-invocation `model` param → frontmatter → main conversation (the per-invocation param is the escape hatch if frontmatter `model` is ever ignored — cf. anthropics/claude-code#44385).
- **Read-only is enforced, not just promised**: reviewers get a least-privilege `tools` allowlist (`Read, Grep, Glob[, Bash]`) so Write/Edit aren't available for their own work. Because `memory: user` auto-enables Read/Write/Edit for memory upkeep, every agent also runs a `PreToolUse` guard (`hooks/agent-guard.ps1`) that **blocks Write/Edit to any path outside `*-memory`** and blocks clearly state-mutating Bash (SQL DDL/DML, `rm -rf`, git writes). The guard is **fail-open** — only a positive match blocks (exit 2); any parse error, unknown case, or missing script allows the call — so it can never break normal operation, only add a block.
- **Not used, deliberately**: `permissionMode` (its `plan` mode is read-only but would block both memory writes and diagnostic Bash — the `tools` allowlist + guard hook cover read-only better); `disallowedTools` (redundant — the allowlist already excludes Write/Edit for non-memory work).
- **`description` is a routing signal**, not a label. Write it so the orchestrator knows *when* to invoke this agent — include concrete trigger situations (e.g. "PR 머지 전", "느린 쿼리 진단") and disambiguate from neighboring agents (security-reviewer's description explicitly defers general review to code-reviewer).
- **Least-privilege tools**: grant only what the job needs. Read-only reviewers get `Read, Grep, Glob`. Add `Bash` only with a documented, narrow purpose: `test-runner` runs tests; `db-optimizer` runs read-only `EXPLAIN`/`SHOW INDEX` *only when the user explicitly asks*; `dependency-auditor` runs read-only `npm audit`/`npm outdated`/`pip-audit` *only when the user explicitly asks*, never install/upgrade; `code-reviewer` uses it solely for `git diff` to scope the review, never to run or mutate code.
- **Analysis agents do not mutate.** Reviewers state "파일을 수정하지 않는다"; `db-optimizer` proposes DDL but never runs `ALTER`/`DROP`; `test-runner` fixes production code only when explicitly told. Preserve this boundary — it's the core contract of the set.
- **Every prompt ends with an explicit output format** (severity-tagged blocks, tables grouped by resource/tag, a prioritized "Top 3" summary). Keep findings anchored to `파일경로:줄번호`.
- **Uncertainty is surfaced, not guessed**: agents mark unclear items "확인 필요" / "추정" rather than inventing facts. Keep this in new prompts.

## Locations & sync (single source of truth)

- **Source of truth**: the top-level `*.md` files in this directory (`d:\auto_agent`) for agent definitions, `commands/*.md` for slash commands, `launchers/*.bat` for the desktop launcher, `hooks/*.ps1` for the read-only guard, and `skills/<name>/SKILL.md` for preloaded skills. Edit them here only.
- **Runtime location**: Claude Code loads agents from `%USERPROFILE%\.claude\agents\`, slash commands from `%USERPROFILE%\.claude\commands\`, the launcher from `%USERPROFILE%\.claude\launchers\`, the guard hook from `%USERPROFILE%\.claude\hooks\` (agent frontmatter references it as `$env:USERPROFILE\.claude\hooks\agent-guard.ps1`), and preloaded skills from `%USERPROFILE%\.claude\skills\`. After editing, run `sync.ps1` to copy all of them there. Do not hand-edit the runtime copies — they get overwritten on sync.
- **What `sync.ps1` does**: deploys only top-level `*.md` with a frontmatter `name:` (docs auto-skipped), plus `commands/`, `launchers/`, `hooks/*.ps1`, and `skills/`. It *delete-syncs* agents: an agent renamed or removed from this repo is removed from the runtime dir too, manifest-scoped (`.claude\agents\.auto_agent_manifest.txt`) so a user's own personal agents are never touched. Any copy/remove error makes it exit 1.
- **Version/doc workflow**: when you change an agent, follow the sync workflow in `CHANGELOG.md` (작업 규칙) and `README.md` (버전 관리) — bump the agent's frontmatter `version`/`updated`, add a CHANGELOG entry, update the README version summary/table, then run `sync.ps1`.
- Do **not** keep a separate `.claude/agents/` copy inside this repo; it duplicates the global runtime set and drifts. The global set already applies to every project.

## Settings

`.claude/settings.local.json` holds local permission allowances for working in this directory. It is environment-specific, not part of the agent definitions.
