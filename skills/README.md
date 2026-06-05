# 공통 스킬 목록

어느 레포에서 작업 중이든 아래 트리거를 입력하면 실행된다.
스킬 본체는 각 폴더의 `SKILL.md`.

| 스킬 | 언제 쓰나 | 트리거 |
|------|-----------|--------|
| [`write-worklog`](write-worklog/SKILL.md) | 오늘 세션 작업 내용을 worklog 형식으로 정리하고 GitHub push | `워크로그 써줘` `오늘 정리해줘` `/write-worklog` |
| [`session-snapshot`](session-snapshot/SKILL.md) | 세션 중간 작업 현황 요약 — 파일 저장 없이 채팅 출력만 | `지금까지 뭐했어?` `중간 정리` `/session-snapshot` |
| [`sync-entry`](sync-entry/SKILL.md) | jumi-worklog md와 worklog.html 뷰어 내용 비교 → 누락·불일치 보고 | `동기화 확인해줘` `뷰어랑 맞아?` `/sync-entry` |
| [`handoff-check`](handoff-check/SKILL.md) | Claude Code/Codex/새 세션에서 이어받을 수 있는 문서 상태인지 확인 | `handoff 확인해줘` `클로드 코드에서 이어받을 수 있어?` `/handoff-check` |
| [`bump-version`](bump-version/SKILL.md) | socra-ai-workflow-wiki 버전 올릴 때 4개 파일 동시 수정 | `버전 올려줘` `배포할게` `/bump-version` |
| [`prep-meeting`](prep-meeting/SKILL.md) | worklog 읽어서 이번 주 업무 요약 + 미팅 아젠다 정리 | `미팅 준비해줘` `이번주 요약해줘` `/prep-meeting` |
| [`record-trap`](record-trap/SKILL.md) | 실수·함정 발생 시 rules.md + agent-rules.md 동시 업데이트 | `이거 기억해줘` `규칙 추가해줘` `/record-trap` |
