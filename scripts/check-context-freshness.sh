#!/usr/bin/env bash
set -euo pipefail

context_file="CONTEXT.md"

if [ ! -f "$context_file" ]; then
  echo "::warning file=$context_file::CONTEXT.md not found; session snapshot freshness cannot be checked."
  exit 0
fi

context_line="$(
  sed -n 's/^> Last updated: //p' "$context_file" \
    | head -n 1
)"

context_date="$(
  printf '%s' "$context_line" \
    | grep -oE '^[0-9]{4}-[0-9]{2}-[0-9]{2}' \
    || true
)"

# Last updated 줄은 날짜 한 개가 전부여야 한다. 세션 요약이 이 줄에 쌓이면
# 스냅샷 원칙(이력은 logs/가 정본)이 깨지므로 잡아낸다.
if [ -n "$context_date" ] && [ "${#context_line}" -gt 40 ]; then
  echo "::warning file=$context_file::'Last updated' line is ${#context_line} chars — expected the date only. Session summaries belong in logs/; trim it back to 'Last updated: $context_date'."
fi

latest_log_date="$(
  find logs -type f -name '????-??-??.md' 2>/dev/null \
    | sed -E 's#^.*/([0-9]{4}-[0-9]{2}-[0-9]{2})\.md$#\1#' \
    | sort \
    | tail -n 1
)"

if [ -z "$context_date" ]; then
  echo "::warning file=$context_file::Missing 'Last updated: YYYY-MM-DD'. Read latest worklogs and git state before acting."
  exit 0
fi

if [ -z "$latest_log_date" ]; then
  echo "CONTEXT freshness check skipped: no dated worklogs found."
  exit 0
fi

if [[ "$context_date" < "$latest_log_date" ]]; then
  echo "::warning file=$context_file::CONTEXT.md is older than latest worklog ($context_date < $latest_log_date). Treat CONTEXT as a stale snapshot; read recent worklogs and repo state before acting."
else
  echo "CONTEXT freshness ok ($context_date >= $latest_log_date)."
fi
