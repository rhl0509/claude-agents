# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

This directory is **not** an application codebase — it is a library of **Claude Code subagent definitions**. Each top-level `.md` file is one subagent: YAML frontmatter followed by the system prompt that drives that agent. There is no build, lint, or test tooling here; "developing" means authoring and editing these agent definition files.

The agents are authored in **Korean** and all target the same downstream stack they will be pointed at: **Next.js (frontend) + FastAPI (backend) + MySQL**. That stack lives in *other* repositories — these definitions are the reusable review/analysis tooling applied to it.

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
| `devops-reviewer.md` | Docker / CI-CD / deploy config & secret-handling review (OIDC keyless auth, supply chain: SBOM/signing + artifact registries: immutable tags/upstream-proxy/scan, non-GHA pipelines: Harness OSS/Drone/GitLab CI, dev env: devcontainer/Gitspaces) | Read, Grep, Glob | No |
| `ui-ux-reviewer.md` | Next.js UI/UX, a11y, responsive, state-handling, forms, microcopy, i18n/RTL, dark mode, dark-pattern review | Read, Grep, Glob | No |
| `design-system-architect.md` | Design tokens, component hierarchy, theming, Tailwind config; authors a DESIGN.md single source (google-labs-code/design.md format) | Read, Grep, Glob, Context7 | No |
| `data-modeler.md` | MySQL data-model / schema design (ERD, normalization, keys, MySQL 9 VECTOR/embeddings) | Read, Grep, Glob | No |
| `system-architect.md` | System architecture design / review across the full stack (incl. LLM/RAG integration) | Read, Grep, Glob, Context7 | No |

## Shared conventions (follow these when adding or editing an agent)

- **Frontmatter schema**: every agent has `name`, `description`, `tools`, `model` (plus `version`, `updated`). `name` matches the filename (kebab-case). `model` is tiered by task difficulty: `opus` for deep-reasoning agents (code-reviewer, security-reviewer, db-optimizer, migration-reviewer, data-modeler, design-system-architect, system-architect, ui-ux-reviewer, perf-auditor, devops-reviewer, test-strategy), `haiku` for mechanical ones (test-runner), `sonnet` for the rest (api-doc-writer).
- **`description` is a routing signal**, not a label. Write it so the orchestrator knows *when* to invoke this agent — include concrete trigger situations (e.g. "PR 머지 전", "느린 쿼리 진단") and disambiguate from neighboring agents (security-reviewer's description explicitly defers general review to code-reviewer).
- **Least-privilege tools**: grant only what the job needs. Read-only reviewers get `Read, Grep, Glob`. Add `Bash` only with a documented, narrow purpose: `test-runner` runs tests; `db-optimizer` runs read-only `EXPLAIN`/`SHOW INDEX` *only when the user explicitly asks*; `code-reviewer` uses it solely for `git diff` to scope the review, never to run or mutate code.
- **Analysis agents do not mutate.** Reviewers state "파일을 수정하지 않는다"; `db-optimizer` proposes DDL but never runs `ALTER`/`DROP`; `test-runner` fixes production code only when explicitly told. Preserve this boundary — it's the core contract of the set.
- **Every prompt ends with an explicit output format** (severity-tagged blocks, tables grouped by resource/tag, a prioritized "Top 3" summary). Keep findings anchored to `파일경로:줄번호`.
- **Uncertainty is surfaced, not guessed**: agents mark unclear items "확인 필요" / "추정" rather than inventing facts. Keep this in new prompts.

## Locations & sync (single source of truth)

- **Source of truth**: the top-level `*.md` files in this directory (`d:\auto_agent`) for agent definitions, and `commands/*.md` for the slash commands that invoke them. Edit both here only.
- **Runtime location**: Claude Code loads agents from `%USERPROFILE%\.claude\agents\` and slash commands from `%USERPROFILE%\.claude\commands\`. After editing, run `sync.ps1` to copy both there. Do not hand-edit the runtime copies — they get overwritten on sync.
- Do **not** keep a separate `.claude/agents/` copy inside this repo; it duplicates the global runtime set and drifts. The global set already applies to every project.

## Settings

`.claude/settings.local.json` holds local permission allowances for working in this directory. It is environment-specific, not part of the agent definitions.
