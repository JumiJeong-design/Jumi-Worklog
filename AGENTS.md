# Claude 공통 지침 — 정주미

이 파일은 프로젝트에 관계없이 주미님과 일할 때 항상 적용되는 공통 룰이다.
프로젝트별 세부 규칙은 각 프로젝트의 `CLAUDE.md`를 따른다.

---

## 세션 시작 시

1. 이 레포(`JumiJeong-design/jumi-worklog`)의 최근 날짜 파일 1~2개를 읽어 맥락 파악
2. 오늘 날짜 worklog 파일이 없으면 세션 종료 시 생성
3. `skills/` 폴더에 공통 스킬 목록이 있음 — 사용자가 트리거하면 해당 SKILL.md 로드

## AI 도구별 진입점

| 도구 | 세션 시작 방식 |
|------|---------------|
| Claude Code | `CLAUDE.md` + SessionStart 훅 (`~/.claude/settings.json`) — 자동으로 이 체크리스트 실행 |
| Codex | 이 파일(`AGENTS.md`) 자동 로드 |

## 공통 스킬 목록

프로젝트에 관계없이 쓰는 스킬은 `skills/` 폴더에 있다.
어느 레포에서 작업 중이더라도 아래 스킬이 트리거되면 해당 SKILL.md를 읽어서 실행한다.

| 스킬 | 트리거 | 파일 |
|------|--------|------|
| `write-worklog` | `워크로그 써줘`, `오늘 정리해줘`, `/write-worklog` | `skills/write-worklog/SKILL.md` |
| `bump-version` | `버전 올려줘`, `배포할게`, `/bump-version` | `skills/bump-version/SKILL.md` |
| `prep-meeting` | `미팅 준비해줘`, `이번주 요약해줘`, `/prep-meeting` | `skills/prep-meeting/SKILL.md` |
| `record-trap` | `이거 기억해줘`, `규칙 추가해줘`, `/record-trap` | `skills/record-trap/SKILL.md` |

## worklog 작성 규칙

- 파일명: `YYYY-MM-DD.md`
- 사용자 요청은 코드블록으로, Claude 작업은 불릿 포인트로
- 프로젝트명을 섹션 헤더에 명시
- 커밋이 있으면 커밋 테이블 포함

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
