---
name: handoff-check
description: "다른 AI 도구나 새 세션에서 이어받을 수 있는 상태인지 확인하고, 필요한 handoff 문서/워크로그/공개 뷰어를 갱신한다. '클로드 코드에서 이어받을 수 있어?', 'handoff 확인해줘', '/handoff-check' 시 실행."
disable-model-invocation: false
---

# handoff-check

현재 작업을 Claude Code, Codex, 또는 새 세션에서 이어받을 수 있는지 확인한다.

핵심은 채팅 기억이 아니라 repo 문서 기준이다. 다음 에이전트가 문서만 읽고 현재 상태와 다음 액션을 이해할 수 있어야 한다.

## Default Scope

토큰과 작업 범위를 줄이기 위해 기본은 작게 시작한다.

- 먼저 분석만 필요한지, 수정까지 필요한지 구분한다.
- 한 번에 한 레포를 기본으로 확인한다.
- 공개 URL 검증은 worklog 또는 public viewer를 변경했을 때만 수행한다.
- AI wiki/skill 승격 검토는 하루 끝이나 사용자가 명시적으로 요청했을 때만 수행한다.
- 새 채팅 시작 시에는 `CLAUDE.md`, `CONTEXT.md`, 오늘 worklog를 먼저 보고, 필요한 문서만 추가로 연다.

## Step 1 — Entry Documents 확인

작업 repo에서 아래 파일을 확인한다.

- `CLAUDE.md` 또는 `AGENTS.md`
- 현재 product plan / follow-up doc
- 관련 contract 또는 rules 문서

확인할 질문:

- 다음 에이전트가 처음 읽을 파일이 명확한가?
- 이미 끝난 작업과 다음 작업이 구분되는가?
- "다시 audit"처럼 완료된 일을 반복하게 만드는 문구가 남아 있지 않은가?

## Step 2 — Worklog / Context 확인

`jumi-worklog`에서 아래 파일을 확인한다.

- `CONTEXT.md`
- `logs/YYYY/MM/YYYY-MM-DD.md`
- 다음 날짜 로그가 있으면 해당 `Next` 블록

확인할 질문:

- 오늘 완료한 작업은 오늘 날짜에 `[x]`로 기록되어 있는가?
- 내일 할 일은 오늘 완료 섹션 안이 아니라 다음 날짜 `Next`에 있는가?
- Agent 작업과 Jumi review 작업이 분리되어 있는가?
- 체크리스트에 없던 일을 했다면 새 항목을 추가하고 `[x]`로 표시했는가?

## Step 3 — Public Viewer 확인

워크로그가 바뀌었으면 공개 뷰어까지 동기화한다.

- `socra-ai-workflow-wiki/site/worklog.html` 갱신
- 원본 worklog repo와 public viewer repo 모두 commit/push
- 공개 URL fetch 후 문구 확인
- 월 단위 체크박스 검증 실행

예시:

```bash
node scripts/verify-public-worklog-month.mjs --html <downloaded-worklog.html> --month YYYY-MM --allow-plan plan-YYYY-MM-DD --allow-unchecked plan-YYYY-MM-DD
```

## Step 4 — Wiki 승격 후보 확인

오늘 작업에서 아래 중 하나가 있으면 AI workflow wiki 후보로 분류한다.

- 반복될 가능성이 높은 운영 실수
- Figma / Git / Storybook / Worklog 역할 경계를 바꾼 결정
- 다른 AI 도구가 이어받기 위해 필요한 handoff 패턴
- 공개 배포/검증 절차를 더 명확히 만든 규칙

단, 하루 작업 원문은 wiki에 복사하지 않는다. 재사용 가능한 규칙이나 플레이북만 승격한다.

## Done Criteria

- 다음 에이전트 entry 문서가 최신이다.
- product plan의 `Next` 또는 handoff 섹션이 현재 상태와 맞다.
- `CONTEXT.md`가 다음 세션 기준으로 갱신되어 있다.
- worklog 체크박스가 실제 완료 상태와 맞다.
- 공개 worklog URL에서 같은 내용이 보인다.
- wiki 승격 후보가 있으면 추가하거나, 추가하지 않는 이유를 기록했다.
