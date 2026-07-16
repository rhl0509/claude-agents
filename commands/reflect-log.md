---
description: Distill the accumulated observation log (_observations) across sessions via self-reflector (Korean alias: 누적회고)
argument-hint: [scope/topic hint (optional)]
---
Use the self-reflector subagent to distill the session observation log accumulated at `E:\claude_memory\_observations\` **across multiple sessions**, and surface learnings (repeated corrections, preferences, durable facts) as atomic, confidence-weighted, evidence-backed candidates.

Scope/topic hint: $ARGUMENTS

It is a read-only Haiku agent that only reads the log + existing memory and proposes — it never writes or edits memory. If no observations have accumulated yet, it reports that honestly. Present candidates ranked by confidence, but **do not record anything** — only items I review and approve ("기록해") get written to E:\claude_memory by the main session. (To distill only the current session use /회고; to recall a topic use /회상.)
