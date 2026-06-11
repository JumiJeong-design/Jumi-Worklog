#!/usr/bin/env bash
set -euo pipefail

bad=0

while IFS= read -r file; do
  if [[ ! "$file" =~ ^logs/[0-9]{4}/[0-9]{2}/[0-9]{4}-[0-9]{2}-[0-9]{2}\.md$ ]]; then
    echo "::error file=$file::Worklog files must use logs/YYYY/MM/YYYY-MM-DD.md"
    bad=1
  fi

done < <(find logs -type f -name '*.md' 2>/dev/null || true)

if [ "$bad" -ne 0 ]; then
  exit 1
fi

echo "Worklog filenames validated."

if [ -x scripts/check-context-freshness.sh ]; then
  scripts/check-context-freshness.sh
fi
