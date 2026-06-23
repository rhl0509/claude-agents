# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

This directory is **not** an application codebase — it is a library of **Claude Code subagent definitions**. Each top-level `.md` file is one subagent: YAML frontmatter followed by the system prompt that drives that agent. There is no build, lint, or test tooling here; "developing" means authoring and editing these agent definition files.

The agents are authored in **Korean** and all target the same downstream stack they will be pointed at: **Next.js (frontend) + FastAPI (backend) + MySQL**. That stack lives in *other* repositories — these definitions are the reusable review/analysis tooling applied to it.

## The agents

| File | Purpose | Tools | Writes code? |
|---|---|---|---|
| `code-reviewer.md` | General quality/readability/bug review across Next.js + FastAPI | Read, Grep, Glob, Bash | No |
| `security-reviewer.md` | OWASP-oriented security review (authz/IDOR, JWT, injection, XSS, secret leakage) | Read, Grep, Glob | No |
| `db-optimizer.md` | MySQL schema/query/index analysis (N+1, indexing, pagination, locks) | Read, Grep, Glob, Bash | No |
| `api-doc-writer.md` | Catalog FastAPI endpoints into API docs | Read, Grep, Glob | No |
| `test-runner.md` | Run pytest / Jest / Vitest and diagnose failures | Bash, Read, Grep, Glob | No |

## Shared conventions (follow these when adding or editing an agent)

- **Frontmatter schema**: every agent has `name`, `description`, `tools`, `model`. `name` matches the filename (kebab-case). `model` is `sonnet` across all current agents.
- **`description` is a routing signal**, not a label. Write it so the orchestrator knows *when* to invoke this agent — include concrete trigger situations (e.g. "PR 머지 전", "느린 쿼리 진단") and disambiguate from neighboring agents (security-reviewer's description explicitly defers general review to code-reviewer).
- **Least-privilege tools**: grant only what the job needs. Read-only reviewers get `Read, Grep, Glob`. Add `Bash` only with a documented, narrow purpose: `test-runner` runs tests; `db-optimizer` runs read-only `EXPLAIN`/`SHOW INDEX` *only when the user explicitly asks*; `code-reviewer` uses it solely for `git diff` to scope the review, never to run or mutate code.
- **Analysis agents do not mutate.** Reviewers state "파일을 수정하지 않는다"; `db-optimizer` proposes DDL but never runs `ALTER`/`DROP`; `test-runner` fixes production code only when explicitly told. Preserve this boundary — it's the core contract of the set.
- **Every prompt ends with an explicit output format** (severity-tagged blocks, tables grouped by resource/tag, a prioritized "Top 3" summary). Keep findings anchored to `파일경로:줄번호`.
- **Uncertainty is surfaced, not guessed**: agents mark unclear items "확인 필요" / "추정" rather than inventing facts. Keep this in new prompts.

## Settings

`.claude/settings.local.json` holds local permission allowances for working in this directory. It is environment-specific, not part of the agent definitions.
