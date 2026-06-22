---
name: session-snapshot
description: "세션 중간에 '지금까지 한 것'을 빠르게 요약해 채팅에 출력한다. write-worklog 전 누락 체크용. '지금까지 뭐했어?', '중간 정리', '/session-snapshot' 시 실행."
disable-model-invocation: false
---

# session-snapshot

세션을 종료하지 않고 **중간 시점**에 작업 현황을 빠르게 파악한다.
write-worklog 전에 "뭐가 빠졌나?" 확인하거나, 잠깐 자리를 비우기 전 현재 상태를 텍스트로 남기는 용도.

---

## Step 1 — 오늘 커밋 조회  [Research]

`mcp__github__list_commits`로 오늘 날짜 기준 3개 레포 커밋을 조회한다 (`since: YYYY-MM-DDT00:00:00Z`):
- `JumiJeong-design/Jumi-Worklog`
- `jumijeong-design/socra-ai-workflow-wiki`
- `riiid/prism`

---

## Step 2 — 대화 컨텍스트 스캔  [Research]

이번 세션에서 오간 내용을 스캔해 아래를 추출한다:
- 완료한 작업 (파일 수정, push, 결정 등)
- 진행 중인 작업 (시작했으나 끝나지 않은 것)
- 미결 질문이나 대기 중인 사용자 액션

---

## Step 3 — 스냅샷 출력  [Output]

다음 형식으로 채팅에 출력한다. **파일 저장은 하지 않는다.**

```
## 세션 스냅샷 — YYYY-MM-DD HH:MM

### 완료
- repo: 작업 내용 (커밋 `abc1234`)
- repo: 작업 내용

### 진행 중
- 작업명 — 현재 어디까지

### 미결
- 사용자 확인 필요 항목
- 블로커

### 오늘 커밋 수
- Jumi-Worklog: N개
- socra-ai-workflow-wiki: N개
- riiid/prism: N개
```

---

## 운영 규칙

- 파일 생성·push 없음 — 채팅 출력만
- write-worklog와 혼동 금지 (이건 저장 안 함)
- 세션 종료 전 write-worklog는 별도로 실행해야 함

## Trigger phrases

`/session-snapshot`, `지금까지 뭐했어?`, `중간 정리`, `지금 현황`, `뭐하고 있었지?`
