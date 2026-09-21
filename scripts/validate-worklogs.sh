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

# 날짜가 공개 뷰어 목록에 등록됐는지 본다.
# 뷰어(site/worklog.html)는 logs/를 훑지 않는다 — 날짜 목록의 정본은 ENTRY_META다.
# 로그 파일만 올리면 그 날짜가 뷰어에 아예 안 뜨고, 조용히 며칠씩 묻힌다.
# 2026-09-08 · 09-12 · 09-18 · 09-21에 났다. 절차 메모로는 안 막혀서 검사로 옮겼다.
viewer="site/worklog.html"
if [ -f "$viewer" ]; then
  unregistered=0
  while IFS= read -r file; do
    date="$(basename "$file" .md)"
    # ENTRY_META 키로 등록된 경우
    if grep -qE "^[[:space:]]*'${date}':[[:space:]]*\{" "$viewer"; then
      continue
    fi
    # 2026-08-09 이전 날짜는 embed 블록 id로 산다
    if grep -qE "id=[\"']((plan|entry)-)${date}[\"']" "$viewer"; then
      continue
    fi
    echo "::error file=$file::${date} is not registered in ${viewer}. Add \"  '${date}': { tags: [...] },\" to ENTRY_META, or the day will not appear in the public viewer at all."
    unregistered=$((unregistered + 1))
  done < <(find logs -type f -name '????-??-??.md' 2>/dev/null | sort)

  if [ "$unregistered" -ne 0 ]; then
    echo "로그 파일만 올리면 그 날짜가 공개 뷰어 목록에 안 뜹니다. site/worklog.html의 ENTRY_META에 키를 추가한 뒤 같은 PR에 담으세요."
    exit 1
  fi

  echo "Viewer entry registration validated."
fi

if [ -x scripts/check-context-freshness.sh ]; then
  scripts/check-context-freshness.sh
fi
