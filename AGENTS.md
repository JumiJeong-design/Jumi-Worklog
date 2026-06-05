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

## 공통 스킬 목록

프로젝트에 관계없이 쓰는 스킬은 `skills/` 폴더에 있다.
어느 레포에서 작업 중이더라도 아래 스킬이 트리거되면 해당 SKILL.md를 읽어서 실행한다.

| 스킬 | 트리거 | 파일 |
|------|--------|------|
| `write-worklog` | `워크로그 써줘`, `오늘 정리해줘`, `/write-worklog` | `skills/write-worklog/SKILL.md` |
| `session-snapshot` | `지금까지 뭐했어?`, `중간 정리`, `/session-snapshot` | `skills/session-snapshot/SKILL.md` |
| `sync-entry` | `동기화 확인해줘`, `뷰어랑 맞아?`, `/sync-entry` | `skills/sync-entry/SKILL.md` |
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
- 공개 URL 확인은 문구 존재만 보면 안 된다. 사용자가 보는 월 전체를 기준으로 `scripts/verify-public-worklog-month.mjs --html <worklog.html> --month YYYY-MM --forbid-plan --allow-unchecked entry-YYYY-MM-DD`를 실행해 날짜별 unchecked 수와 stale `plan-*` 블록을 확인한다. 오늘 처리 완료 항목은 오늘 entry에서 `[x]`여야 하고, 내일로 넘긴 항목만 내일 `Next`에서 `[ ]`로 남긴다.

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
