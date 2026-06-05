#!/usr/bin/env bash
# PreToolUse 가드 — git push 사고 방지
#
# 동작: Claude Code가 Bash 도구로 git push 를 실행하기 직전 호출된다.
#   1) force push (-f / --force)         → 차단
#   2) main / master 로 직접 push        → 차단
# 그 외 push (feature 브랜치 등)는 통과.
#
# 차단 방식: exit 2 → Claude에게 차단 사유(stderr)가 전달되어 다른 방법을 찾게 한다.
# 의도된 main 푸시(GitHub Pages 배포 등)는 주미님이 터미널에서 직접 실행하면 된다.
#
# 입력: stdin 으로 PreToolUse JSON. tool_input.command 에 실행될 명령이 들어있다.

input=$(cat)

# command 추출 (jq 우선, 없으면 python3)
if command -v jq >/dev/null 2>&1; then
  cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // ""')
else
  cmd=$(printf '%s' "$input" | python3 -c 'import sys,json; print(json.load(sys.stdin).get("tool_input",{}).get("command",""))' 2>/dev/null)
fi

# 줄바꿈을 세미콜론으로 정규화 — 멀티라인 명령도 처리
normalized=$(printf '%s' "$cmd" | tr '\n' ';')

# git push 가 실제 명령으로 실행되는 경우만 탐지
# ^, ;, &&, || 바로 뒤에 오는 경우만 — 문자열·주석 안에 포함된 경우는 통과
printf '%s' "$normalized" | grep -Eq '(^|;|&&|\|\|)[[:space:]]*git[[:space:]]+push' || exit 0

# 실제 git push 구문만 추출
push_stmt=$(printf '%s' "$normalized" | grep -oE '(^|;|&&|\|\|)[[:space:]]*git[[:space:]]+push[^;&|]*' | tail -1)

# 1) force push 차단
if printf '%s' "$push_stmt" | grep -Eq '[[:space:]](-f([[:space:]]|$)|--force([[:space:]]|$))'; then
  echo "⛔ force push 감지 → 차단" >&2
  echo "히스토리 재작성은 위험합니다. 정말 필요하면 주미님이 터미널에서 직접 실행하세요." >&2
  exit 2
fi

# 2) main / master 직접 push 차단
if printf '%s' "$push_stmt" | grep -Eq '[[:space:]]+(main|master)([[:space:]]|$|:)'; then
  echo "⛔ main/master 직접 push 감지 → 차단" >&2
  echo "작업은 feature 브랜치에 올리세요. 의도된 배포(GitHub Pages 등)면 주미님이 터미널에서 직접 실행하세요." >&2
  exit 2
fi

exit 0
