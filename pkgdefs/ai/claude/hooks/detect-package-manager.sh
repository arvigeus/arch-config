#!/usr/bin/env bash
# PreToolUse hook: detect the project's JS package manager from its lockfile
# and block Bash commands that invoke a different manager.
#
# Reads Claude Code hook JSON from stdin (fields: .cwd, .tool_input.command).
# Exit 2 + stderr = block the tool call; Claude sees stderr and adjusts.

set -euo pipefail

input=$(cat)
cwd=$(printf '%s' "$input" | jq -r '.cwd // empty')
cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // empty')

# Nothing to inspect
[[ -z "$cwd" || -z "$cmd" ]] && exit 0

# Only care about commands that start with a JS package manager.
# Tolerates leading whitespace and env assignments like `FOO=bar pnpm ...`.
stripped=$(printf '%s' "$cmd" | sed -E 's/^[[:space:]]*([A-Za-z_][A-Za-z0-9_]*=[^[:space:]]+[[:space:]]+)*//')
case "$stripped" in
npm | npm\ * | yarn | yarn\ * | pnpm | pnpm\ * | bun | bun\ *) ;;
*) exit 0 ;;
esac

used=${stripped%% *}

# Walk upward from cwd looking for the nearest lockfile (monorepo-safe).
dir="$cwd"
mgr=""
while [[ -n "$dir" && "$dir" != "/" ]]; do
	if [[ -f "$dir/pnpm-lock.yaml" ]]; then
		mgr=pnpm
		break
	elif [[ -f "$dir/yarn.lock" ]]; then
		mgr=yarn
		break
	elif [[ -f "$dir/bun.lockb" || -f "$dir/bun.lock" ]]; then
		mgr=bun
		break
	elif [[ -f "$dir/package-lock.json" ]]; then
		mgr=npm
		break
	fi
	dir=$(dirname "$dir")
done

# No lockfile anywhere above cwd - let it pass.
[[ -z "$mgr" ]] && exit 0

# Correct manager - allow.
[[ "$used" == "$mgr" ]] && exit 0

# Mismatch - block with a message Claude will see on stderr.
printf 'This project uses %s (detected from lockfile in %s). Use %s instead of %s.\n' \
	"$mgr" "$dir" "$mgr" "$used" >&2
exit 2
