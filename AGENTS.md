# Claude 공통 지침 — 정주미

이 파일은 프로젝트에 관계없이 주미님과 일할 때 항상 적용되는 공통 룰이다.
프로젝트별 세부 규칙은 각 프로젝트의 `CLAUDE.md`를 따른다.

---

## 세션 시작 시

1. 이 레포(`JumiJeong-design/jumi-worklog`)의 최근 `logs/YYYY/MM/` 날짜 파일 1~2개를 읽어 맥락 파악
2. 오늘 날짜 worklog 파일이 없으면 세션 종료 시 생성
3. `skills/` 폴더에 공통 스킬 목록이 있음 — 사용자가 트리거하면 해당 SKILL.md 로드

## AI 도구별 진입점

| 도구 | 세션 시작 방식 |
|------|---------------|
| Claude Code | `CLAUDE.md` + SessionStart 한스 (`~/.claude/settings.json`) — 자동으로 이 체크리스트 실행 |
| Codex | 이 파일(`AGENTS.md`) 자동 로드 |

## 기본 운영 방식 — 토큰/범위 절약

사용자가 모호하게 말해도 아래 방식을 기본값으로 잡는다.

- 먼저 **분석만** 할지, **수정까지** 할지 구분한다. 사용자가 "진행해", "수정해", "반영해"라고 하기 전에는 큰 수정으로 바로 확장하지 않는다.
- 한 턴에는 가능하면 **한 레포만** 처리한다. 여러 레포가 필요하면 순서를 나눠 보고한다.
- 공개 배포/공개 URL 검증은 문서나 public viewer를 실제로 변경했을 때만 수행한다.
- AI 위키/스킬 승격 검토는 하루 끝이나 사용자가 명시적으로 요청했을 때만 수행한다.
- 새 채팅 시작 시에는 우선 `CLAUDE.md`, `CONTEXT.md`, 오늘 worklog만 읽고 시작한다. 필요할 때만 추가 문서를 연다.

## 공통 스킬 목록

프로젝트에 관계없이 쓰는 스킬은 `skills/` 폴더에 있다.
어느 레포에서 작업 중이더라도 아래 스킬이 트리거되면 해당 SKILL.md를 읽어서 실행한다.

| 스킬 | 트리거 | 파일 |
|------|--------|------|
| `write-worklog` | `워크로그 써줘`, `오늘 정리해줘`, `/write-worklog` | `skills/write-worklog/SKILL.md` |
| `session-snapshot` | `지금까지 뭐했어?`, `중간 정리`, `/session-snapshot` | `skills/session-snapshot/SKILL.md` |
| `sync-entry` | `동기화 확인해줘`, `뷰어랑 맞아?`, `/sync-entry` | `skills/sync-entry/SKILL.md` |
| `handoff-check` | `handoff 확인해줘`, `클로드 코드에서 이어받을 수 있어?`, `/handoff-check` | `skills/handoff-check/SKILL.md` |
| `bump-version` | `버전 올려줘`, `배포할게`, `/bump-version` | `skills/bump-version/SKILL.md` |
| `prep-meeting` | `미팅 준비해줘`, `이번주 요약해줘`, `/prep-meeting` | `skills/prep-meeting/SKILL.md` |
| `record-trap` | `이거 기억해줘`, `규칙 추가해줘`, `/record-trap` | `skills/record-trap/SKILL.md` |

## worklog 작성 규칙

- 파일명: `YYYY-MM-DD.md`
- 저장 경로: `logs/YYYY/MM/YYYY-MM-DD.md`
- 사용자 요청은 코드블록으로, Claude 작업은 불릿 포인트로
- 프로젝트명을 섹션 헤더에 명시
- 커밋이 있으면 커밋 테이블 포함
- `##` 헤더는 worklog 뷰어에서 서브탭이 되므로 큰 작업 흐름에만 사용한다
- 커밋, 회고, 다음 액션, 보조 기록은 별도 탭으로 만들지 말고 `###` 이하에 둔다
- 새 `##`를 추가하기 전에는 "이 항목이 사용자가 독립 탭으로 전환해 볼 만큼 큰 작업 흐름인가?"를 먼저 판단한다
- 후속 체크리스트는 이전 작업 탭 안에 묻어두지 말고 해당 날짜의 `Next` 또는 다음 날짜 로그로 이월한다
- 워크로그를 수정하면 원본 MD만 고치고 끝내지 않는다. 반드시 `socra-ai-workflow-wiki/site/worklog.html`도 같은 내용으로 갱신하고, 두 레포를 커밋/푸시한 뒤 공개 URL `https://jumijeong-design.github.io/socra-ai-workflow-wiki/site/worklog.html`에서 실제 문구가 보이는지 확인한다.
- 공개 URL 확인은 문구 존재만 보면 안 된다. 사용자가 보는 월 전체를 기준으로 `scripts/verify-public-worklog-month.mjs --html <worklog.html> --month YYYY-MM --allow-plan plan-YYYY-MM-DD --allow-unchecked plan-YYYY-MM-DD`처럼 실행해 날짜별 unchecked 수와 허용되지 않은 plan 블록을 확인한다. Plan/Log 탭과 캘린더 두 색 점은 `plan-*` 블록에 의존하므로 정상 plan 블록을 삭제하지 않는다.

## 커뮤니케이션

- 짧고 직접적으로
- 설명보다 행동 우선
- 확인이 필요한 경우에만 질문

## 계정 정보

| 서비스 | 계정 |
|--------|------|
| Claude Code / Codex | candoit.j@gmail.com |
| Figma | jumi.jeong@socra.ai |
| GitHub | JumiJeong-design |
