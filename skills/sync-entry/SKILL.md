---
name: sync-entry
description: "jumi-worklog의 마크다운 원본과 worklog.html 뷰어 엔트리 내용을 비교해 누락·불일치를 찾는다. '동기화 확인해줘', '뷰어랑 맞아?', '/sync-entry' 시 실행."
disable-model-invocation: false
---

# sync-entry

`jumi-worklog/logs/YYYY/MM/YYYY-MM-DD.md`(원본)과 `socra-ai-workflow-wiki/site/worklog.html`의 `entry-YYYY-MM-DD` 블록(뷰어)을 비교해 내용 불일치나 누락 섹션을 찾는다.

> **배경 (2026-06-04 실제 사례):** prism 작업은 worklog.html에 반영됐으나 socra-ai-workflow-wiki 구조 개편 작업은 원본 md에는 있고 뷰어에는 없었다. 두 곳이 수동으로 관리되다 보니 세션 경계에서 불일치가 쉽게 생긴다.

---

## Mandatory prerequisites

- GitHub MCP (`mcp__github__*`)
- 확인할 날짜 (기본값: 오늘)

---

## Step 1 — 양쪽 내용 읽기  [Research]

1. `mcp__github__get_file_contents`로 `jumijeong-design/jumi-worklog`의 `logs/YYYY/MM/YYYY-MM-DD.md`를 읽는다.
2. `mcp__github__get_file_contents`로 `jumijeong-design/socra-ai-workflow-wiki`의 `site/worklog.html`을 읽는다.
3. worklog.html에서 `id="entry-YYYY-MM-DD"` 블록을 추출한다.

---

## Step 2 — 비교  [Research]

아래 항목을 기준으로 불일치를 찾는다:

| 확인 항목 | 방법 |
|-----------|------|
| 섹션 수 | 원본 md의 `##` 헤더 수 vs 뷰어 엔트리의 `##` 헤더 수 비교 |
| 누락 섹션 | 원본에 있는 `##` 제목이 뷰어에 없는 경우 |
| 커밋 누락 | 원본 커밋 테이블의 SHA가 뷰어에 없는 경우 |
| 회고 섹션 | 원본과 뷰어 모두에 `## 회고 및 인사이트`가 있는지 확인 |
| plan 블록 | `plan-YYYY-MM-DD` 블록이 있는지, 체크리스트가 원본과 일치하는지 |

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
- ## 회고 및 인사이트

뷰어에만 있음:
- (없음)
```

수정 여부를 확인한 뒤, 사용자가 원하면 worklog.html 엔트리를 원본 md 기준으로 업데이트한다.

---

## 운영 규칙

- 날짜 미지정 시 오늘 날짜로 실행
- 뷰어 수정 시 엔트리 블록(`entry-YYYY-MM-DD`)만 교체, 나머지 구조는 건드리지 않는다
- 원본 md를 뷰어에 맞춰 변경하지 않는다 — 원본이 항상 기준

## Trigger phrases

`/sync-entry`, `동기화 확인해줘`, `뷰어랑 맞아?`, `워크로그 싱크 확인`
