# Read-only guard for the auto_agent review/analysis subagents.
# Wired as a PreToolUse hook (matcher "Write|Edit|Bash") in every agent's frontmatter.
#
# FAIL-OPEN by design: only a POSITIVE match returns exit code 2 (block). Any
# missing input, parse error, unknown tool, or unmatched command returns 0
# (allow). Claude Code treats a non-zero exit other than 2 as a non-blocking
# error, so even if this script itself fails to run (e.g. execution policy, file
# missing before sync), the tool call still proceeds — the guard can only ever
# ADD a block on a clear match, never break existing behavior.
#
# Purpose:
#   - Write/Edit: memory (memory: user) enables Write/Edit for the agent's own
#     memory dir. Confine those writes to *-memory paths; block edits to the
#     reviewed codebase. Keeps the "never modify the target repo" contract.
#   - Bash: block clearly state-mutating commands (SQL DDL/DML, destructive rm,
#     git write ops). Diagnostics (git diff/log, EXPLAIN, tests) pass through.

try {
    $raw = [Console]::In.ReadToEnd()
    if (-not $raw) { exit 0 }
    $j = $raw | ConvertFrom-Json -ErrorAction Stop
} catch {
    exit 0   # unparseable input -> allow (fail-open)
}

$tool = [string]$j.tool_name
$in   = $j.tool_input

if ($tool -eq 'Write' -or $tool -eq 'Edit') {
    $p = [string]$in.file_path
    if ($p -and ($p -notmatch 'agent-memory')) {
        [Console]::Error.WriteLine('Blocked: read-only analysis agent. File writes are confined to its agent-memory directory; it must not modify the reviewed codebase.')
        exit 2
    }
    exit 0
}

if ($tool -eq 'Bash') {
    $c = [string]$in.command
    if ($c) {
        # NOTE: these patterns match the keyword anywhere in the command string, so a
        #   read-only diagnostic that merely CONTAINS a keyword (e.g. `grep "CREATE TABLE"
        #   schema.sql`, `git log --grep=DELETE`) can be false-blocked. Accepted on purpose:
        #   the guard only ever ADDS a block, agents normally use the Grep tool (not shell
        #   grep), and narrowing to SQL context would open a real gap. If a legitimate
        #   read-only command is blocked, run it yourself.
        $sqlMutate = '(?i)\b(INSERT|UPDATE|DELETE|DROP|CREATE|ALTER|TRUNCATE|GRANT|REVOKE)\b'
        $fsDestroy = '(?i)\brm\s+-[rf]'
        $gitWrite  = '(?i)\bgit\s+(push|commit|reset|checkout|clean|merge|rebase|apply|restore|stash)\b'
        if ($c -match $sqlMutate -or $c -match $fsDestroy -or $c -match $gitWrite) {
            [Console]::Error.WriteLine('Blocked: command appears to mutate state. Read-only agents run diagnostics only; run mutating commands yourself if intended.')
            exit 2
        }
    }
    exit 0
}

exit 0
