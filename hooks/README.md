# Claude Code 훅 — 로컬 설치 가이드

> 웹 세션의 Claude는 **클라우드 컨테이너**에서 돌아서 주미님 맥북의 `~/.claude/settings.json`을 못 건드린다.
> 그래서 훅 스크립트와 설정만 레포에 준비해두고, **설치는 로컬 터미널에서 한 번** 한다.

## 들어있는 것

| 파일 | 역할 |
|------|------|
| `pre-push-guard.sh` | git push 사고 방지 — ① force push ② main/master 직접 push 차단 |
| `settings-snippet.json` | `~/.claude/settings.json` 에 병합할 hooks 조각 |

> **설치 상태(2026-07-14 확인):** 주미님 맥북에는 이미 설치돼 있다(`~/.claude/settings.json`의 PreToolUse → `/Users/jeongjumi/Desktop/jumi-worklog/hooks/pre-push-guard.sh`).
> `settings-snippet.json`의 `/ABSOLUTE/PATH/...`는 **의도된 템플릿 placeholder**이지 미설치 표시가 아니다. 새 머신에서만 아래 설치 절차를 따른다.

## 설치 (로컬 터미널, 1회)

```bash
# 1) 이 레포 경로 확인 (예시)
cd ~/jumi-worklog
HOOK="$(pwd)/hooks/pre-push-guard.sh"
chmod +x "$HOOK"
echo "$HOOK"   # 이 절대경로를 복사

# 2) ~/.claude/settings.json 의 "hooks" 안에 아래를 추가
#    (settings-snippet.json 참고, command 를 위 절대경로로 교체)
```

`~/.claude/settings.json` 예시:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          { "type": "command", "command": "/Users/jumi/jumi-worklog/hooks/pre-push-guard.sh" }
        ]
      }
    ]
  }
}
```

> 로컬에서 Claude Code를 직접 쓰는 경우 `/update-config` 스킬로 위 설정을 바로 넣을 수도 있다.

## 동작

- `git push -f` / `git push --force` → **차단**
- `git push origin main` / `master` → **차단**
- feature 브랜치 push (`git push -u origin claude/...`) → 통과
- push 가 아닌 명령 → 통과

차단되면 Claude에게 사유가 전달되어 다른 방법(feature 브랜치)을 찾는다.
의도된 main 푸시(GitHub Pages 배포 등)는 주미님이 터미널에서 직접 실행하면 된다.

## 검증

설치 후 아무 디렉토리에서:

```bash
echo '{"tool_input":{"command":"git push origin main"}}' | ~/jumi-worklog/hooks/pre-push-guard.sh; echo "exit=$?"
# → ⛔ ... 메시지 + exit=2 면 정상
```
