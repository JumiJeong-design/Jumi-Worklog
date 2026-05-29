---
name: bump-version
description: "socra-ai-workflow-guide 버전을 올릴 때 4개 파일(sidebar.html, ai-workflow-guide.html, changelog.html, index.html)을 동시에 수정한다. '버전 올려줘', 'v0.X 배포해줘', '/bump-version' 시 실행."
disable-model-invocation: false
---

# bump-version

`socra-ai-workflow-guide` 버전을 올릴 때 반드시 수정해야 하는 4개 파일을 순서대로 처리한다.
누락이나 날짜 오타를 방지하기 위해 스킬로 관리한다.

---

## 수정 대상 파일 (4개 전부 필수)

| 파일 | 수정 내용 |
|------|-----------|
| `sidebar.html` | 버전 텍스트 (`v0.X`) |
| `ai-workflow-guide.html` | 상단 버전 배지 + 인라인 changelog 항목 추가 |
| `changelog.html` | 신규 버전 섹션 추가 (최신순 — 맨 위에 삽입) |
| `index.html` | 신규 기능 카드 추가 (변경 사항이 사용자에게 보일 때만) |

---

## Step 1 — 버전 정보 수집  [Confirm]

**Do:**
1. 사용자에게 확인한다:
   - 새 버전 번호 (예: `v0.5`)
   - 오늘 날짜 (`currentDate` 컨텍스트에서 자동 추출 — `YYYY.MM` 형식)
   - 이번 버전에서 변경된 내용 (없으면 대화 컨텍스트에서 추출)
2. `mcp__github__get_file_contents`로 현재 버전을 확인한다 (`sidebar.html` 기준).
3. 이전 버전 번호와 새 버전 번호를 확정한다.

**Self-check:**
- 날짜가 올해(`2026`)로 정확한가? (2025 오타 주의)
- 변경 내용이 1줄 이상 있는가?

---

## Step 2 — 4개 파일 읽기  [Research]

`mcp__github__get_file_contents`로 아래 파일의 현재 내용과 SHA를 읽는다.

- `sidebar.html`
- `ai-workflow-guide.html`
- `changelog.html`
- `index.html`

모두 `jumijeong-design/socra-ai-workflow-guide` 레포, `main` 브랜치에서 읽는다.

---

## Step 3 — 수정 내용 확인  [Confirm]

각 파일에서 수정할 부분을 찾아 before/after를 채팅에 출력한다.

**sidebar.html 수정 위치:**
- 버전 텍스트가 있는 `v0.X` 문자열을 새 버전으로 교체

**ai-workflow-guide.html 수정 위치:**
- 상단 버전 배지: `v0.X` → 새 버전
- changelog 인라인 항목: 최신순으로 새 항목 추가

**changelog.html 수정 위치:**
- 기존 최신 버전 섹션 위에 새 버전 섹션 삽입
- 형식: `## v0.X — YYYY.MM` + 변경 내용 불릿

**index.html 수정 위치:**
- 이번 변경이 사용자에게 노출되는 신규 기능인 경우만 카드 추가
- 단순 수정/버그픽스면 생략

"이 내용으로 진행할까요? [진행 / 수정]" 확인.

---

## Step 4 — 4개 파일 업데이트  [Write]

`mcp__github__create_or_update_file`로 순서대로 업데이트한다.

| 파라미터 | 값 |
|---------|-----|
| owner | `jumijeong-design` |
| repo | `socra-ai-workflow-guide` |
| branch | `main` |
| sha | Step 2에서 읽은 각 파일의 SHA (필수) |

커밋 메시지 형식: `feat: v0.X 배포 — <한 줄 요약>`

완료 후 출력:
```
버전 업데이트 완료.
v0.(이전) → v0.(새) — YYYY.MM
수정 파일: sidebar.html, ai-workflow-guide.html, changelog.html, index.html
```

---

## 운영 규칙

- 날짜는 항상 `currentDate`에서 추출 (`YYYY.MM` 형식), 직접 입력하지 않는다
- 4개 파일 중 하나라도 실패하면 나머지도 중단하고 에러 보고
- changelog는 최신순 (새 항목이 맨 위)
- index.html 카드 추가는 선택적 — 사용자가 결정

## Trigger phrases

`/bump-version`, `버전 올려줘`, `v0.X 배포해줘`, `버전 업데이트`, `배포할게`
