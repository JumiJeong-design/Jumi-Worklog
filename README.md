# jumi-worklog

주미님과 AI 도구(Claude Code, Codex)의 **공동 기록 허브**입니다. 이 repo는 날짜별 작업 기록, 세션 맥락, 결정 전 고민, 시행착오를 보존하는 공동 채널입니다.

## What Belongs Here

- 날짜별 worklog (`logs/YYYY/MM/YYYY-MM-DD.md`)
- AI 세션에서 나온 맥락, 시도, 막힌 지점, 다음 행동
- 다른 repo에서 진행한 작업의 하루 단위 요약
- 나중에 `socra-ai-workflow-wiki`로 승격할 후보 메모
- 공통 스킬 관리 (`skills/`)
- 세션 간 컨텍스트 스냅샷 (`CONTEXT.md`)

## What Does Not Belong Here

- 정제된 가이드/플레이북: `socra-ai-workflow-wiki`로 승격
- 제품 디자인 시스템 원본 스펙: `riiid/prism`에 기록
- Figma의 시각적 원본: Figma `Socra Design system test`에서 관리

## 레포 구조

| 레포 | 역할 |
|------|------|
| **jumi-worklog** (this) | 공동 기록 허브, 날짜별 작업 로그 |
| riiid/prism | Prism package repo — 디자인 시스템, 컴포넌트 계약, 토큰, Storybook, release workflow |
| socra-ai-workflow-wiki | 위키 채널 — AI 워크플로우·프로세스·시행착오 |

## 기본 폴더

```text
/logs/
  YYYY/
    MM/
      YYYY-MM-DD.md
/templates/
  daily-worklog-template.md
  ai-session-template.md
```

## Worklog Rule

- 하루의 날것 기록은 여기에 남긴다.
- 반복 가능한 패턴이 보이면 `socra-ai-workflow-wiki` 문서 후보로 표시한다.
- 제품/컴포넌트 스펙이 필요하면 `riiid/prism` 문서로 연결한다.
- worklog를 지식화했으면 양쪽에 역링크를 남긴다.

## 공통 스킬

| 스킬 | 트리거 |
|------|--------|
| `write-worklog` | `워크로그 써줘`, `/write-worklog` |
| `session-snapshot` | `지금까지 뭐했어?`, `/session-snapshot` |
| `sync-entry` | `동기화 확인해줘`, `/sync-entry` |
| `bump-version` | `버전 올려줘`, `/bump-version` |
| `prep-meeting` | `미팅 준비해줘`, `/prep-meeting` |
| `record-trap` | `이거 기억해줘`, `/record-trap` |
