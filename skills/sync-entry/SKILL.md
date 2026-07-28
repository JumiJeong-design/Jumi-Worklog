---
name: sync-entry
description: "Jumi-Worklog의 마크다운 원본과 worklog.html 뷰어 엔트리 내용을 비교해 누락·불일치를 찾는다. '동기화 확인해줘', '뷰어랑 맞아?', '/sync-entry' 시 실행."
disable-model-invocation: false
---

# sync-entry

`JumiJeong-design/Jumi-Worklog` repo 안의 `logs/YYYY/MM/YYYY-MM-DD.md`(원본)과 `site/worklog.html`의 `entry-YYYY-MM-DD` 블록(뷰어 fallback)을 비교해 내용 불일치나 누락 섹션을 찾는다.

> **배경 (2026-06-04 실제 사례):** prism 작업은 worklog.html에 반영됐으나 다른 작업은 원본 md에는 있고 뷰어 fallback에는 없었다. 원본과 공개 뷰어 fallback이 함께 관리되다 보니 세션 경계에서 불일치가 쉽게 생긴다.

---

## Mandatory prerequisites

- 로컬 레포 `~/Desktop/jumi-worklog` (원격은 `JumiJeong-design/Jumi-Worklog`)
- 확인할 날짜 (기본값: 오늘)

> 읽기는 로컬 파일로 한다. 로컬이 원격과 어긋났을 수 있으니 시작 전 `git -C ~/Desktop/jumi-worklog status -sb`로
> 미푸시 커밋·미커밋 변경이 있는지 먼저 본다.

---

## Step 1 — 양쪽 내용 읽기  [Research]

1. `logs/YYYY/MM/YYYY-MM-DD.md`를 읽는다.
2. `site/worklog.html`을 읽는다.
3. worklog.html에서 `id="entry-YYYY-MM-DD"` 블록을 추출한다.

---

## Step 2 — 비교  [Research]

아래 항목을 기준으로 불일치를 찾는다:

| 확인 항목 | 방법 |
|-----------|------|
| 섹션 수 | 원본 md의 `##` 헤더 수 vs 뷰어 엔트리의 `##` 헤더 수 비교 |
| 누락 섹션 | 원본에 있는 `##` 제목이 뷰어에 없는 경우 |
| 커밋 누락 | 원본 커밋 테이블의 SHA가 뷰어에 없는 경우 |
| 회고 섹션 | 원본과 뷰어 모두에 `### 회고 및 인사이트`가 있는지 확인 |
| plan 블록 | `plan-YYYY-MM-DD` 블록이 있는지, 체크리스트가 원본과 일치하는지 |

추가로 날짜 하나만 보지 말고, 사용자가 보는 월 전체를 확인한다:

- 공개 HTML을 저장한 뒤 `node scripts/verify-public-worklog-month.mjs --html <downloaded worklog.html> --month YYYY-MM --allow-plan plan-YYYY-MM-DD --allow-unchecked plan-YYYY-MM-DD`를 실행한다.
- `--allow-unchecked`에는 내일 `Next`처럼 의도적으로 남기는 entry만 넣는다.
- 오늘 완료한 항목이 `[ ]`로 남거나, 허용하지 않은 `plan-YYYY-MM-DD` 블록이 남으면 동기화 정상으로 보고하지 않는다.

---

## Step 3 — 결과 보고 및 수정  [Confirm]

불일치가 없으면:
```
✅ YYYY-MM-DD 동기화 상태 정상 — 원본과 뷰어 내용 일치
```

불일치가 있으면 항목별로 보고한다:
```
⚠️ YYYY-MM-DD 동기화 불일치 발견

누락 섹션 (원본에 있고 뷰어에 없음):
- ## socra-ai-workflow-wiki — 사이트 구조 전면 개편
- ### 회고 및 인사이트

뷰어에만 있음:
- (없음)
```

수정 여부를 확인한 뒤, 사용자가 원하면 worklog.html 엔트리를 원본 md 기준으로 업데이트한다. 뷰어를 수정한 경우 커밋/푸시 후 공개 URL `https://jumijeong-design.github.io/Jumi-Worklog/worklog.html`에서 수정 문구가 실제로 보이는지 확인하고, 월 단위 체크박스 검증까지 통과해야 완료다.

---

## 운영 규칙

- 날짜 미지정 시 오늘 날짜로 실행
- 뷰어 수정 시 엔트리 블록(`entry-YYYY-MM-DD`)만 교체, 나머지 구조는 건드리지 않는다
- 원본 md를 뷰어에 맞춰 변경하지 않는다 — 원본이 항상 기준
- 원본 md 또는 뷰어를 수정하면 같은 repo 안의 `logs/` 원본과 `site/worklog.html` 반영 여부, 공개 URL 렌더 결과를 함께 확인한다
- 공개 viewer에만 남은 허용되지 않은 `plan-*` 블록이나 오래된 unchecked 항목은 사용자가 실제 화면에서 보는 문제이므로 반드시 월 단위로 잡는다

## Trigger phrases

`/sync-entry`, `동기화 확인해줘`, `뷰어랑 맞아?`, `워크로그 싱크 확인`
