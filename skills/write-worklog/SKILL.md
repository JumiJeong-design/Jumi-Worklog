---
name: write-worklog
description: "오늘 작업 세션을 요약→문서화→GitHub push→CONTEXT.md 갱신→Notion 업로드 순서로 자동 완료한다. jumi-worklog 형식(미해결 항목 / 함정 모음 / 회고 및 인사이트 / 날짜별 작업 / 커밋 테이블)으로 정리. '워크로그 써줘', '오늘 작업 기록해줘', '세션 정리해줘', '/write-worklog' 시 실행."
disable-model-invocation: false
---

# write-worklog

오늘 작업 세션을 **요약 → 문서화 → GitHub push → CONTEXT.md 갱신 → Notion 업로드** 순서로 자동 완료한다.
대화 컨텍스트에서 작업 내용을 직접 추출하므로, 사용자가 별도로 내용을 타이핑할 필요가 없다.

---

## Mandatory prerequisites

- GitHub MCP (`mcp__github__*`) — 파일 읽기·쓰기에 사용
- Notion MCP (`mcp__a2cd6401__notion-*`) — Notion DB 업로드에 사용 (미연결 시 GitHub만 push)
- 오늘 날짜 확인 필요 (`currentDate` 시스템 컨텍스트 또는 대화에서 추출)

---

## Worklog 파일 형식 (엄격히 준수)

```
# YYYY-MM-DD

## 미해결 항목

- [ ] 항목 1 (미완료 작업, 다음 세션으로 이월)
- [ ] 항목 2

---

## 함정 모음

- **함정 제목** — 발견한 문제, 원인, 재발 방지 방법.
- **함정 제목2** — ...

---

## 회고 및 인사이트

### AI 도구 활용

- 인사이트 1

### 설계 결정

- 결정 1

---

## YYYY-MM-DD

### 1. 작업 제목

```
사용자가 실제로 입력한 요청 문구를 코드블록으로
```

**Claude Code 작업:**
- 완료한 세부 작업 1
- 완료한 세부 작업 2

---

### 2. 작업 제목

...

---

## 커밋 (repo-name)

| 커밋 | 설명 |
|------|------|
| `abc1234` | commit message |
```

### 형식 규칙 요약

| 규칙 | 내용 |
|------|------|
| 파일명 | `YYYY-MM-DD.md` (오늘 날짜) |
| 사용자 요청 | 코드블록으로 감싸기 (원문 그대로, 오타 수정 금지) |
| Claude 작업 | 불릿 포인트 (`-`) |
| 미해결 항목 | 이전 worklog 미완료 항목 이월 + 오늘 미완료 |
| 함정 | **굵은 제목** + em dash(—) + 설명 |
| 커밋 테이블 | 레포마다 별도 섹션 (`## 커밋 (repo-name)`) |
| 섹션 구분 | `---` 로 구분 |
| 커밋 SHA | 7자리 축약형 |

---

## Step 1 — 컨텍스트 읽기  [Research]

**Do:**
1. 오늘 날짜를 확인한다 (`currentDate` 시스템 컨텍스트 또는 대화에서 추출).
2. `mcp__github__get_file_contents`로 `jumijeong-design/jumi-worklog` 레포 루트(`/`)를 읽어 최근 날짜 파일 목록을 확인한다.
3. 최근 1~2개 worklog 파일을 읽는다 (미해결 항목 이월, 맥락 파악 목적).
4. 오늘 날짜 파일(`YYYY-MM-DD.md`)이 이미 존재하는지 확인한다.
   - 존재하면: SHA와 기존 내용을 읽어 이어쓰기 준비
   - 없으면: 새 파일 생성 준비

**Self-check:**
- 이전 파일에서 미완료 항목(`- [ ]`)이 있으면 이월 목록에 추가
- 이전 파일에서 완료 항목(`- [x]`)은 이월하지 않는다

---

## Step 2 — 오늘 작업 추출  [Research]

대화 컨텍스트 전체를 스캔해서 아래 항목을 추출한다.

| 추출 대상 | 추출 방법 |
|-----------|-----------|
| 사용자 요청 | 사용자가 직접 입력한 지시/질문 문구 (원문 그대로) |
| Claude 작업 | 실제로 수행한 작업 (파일 수정, 생성, 분석, push 등) |
| 커밋 정보 | SHA 7자리 + 커밋 메시지 (언급된 경우) |
| 함정/삽질 | 발생한 에러, 잘못된 접근, 재발 방지 포인트 |
| 인사이트 | 깨달은 것, 방향 전환, 설계 결정 |
| 미완료 항목 | 시작했지만 끝나지 않은 작업 |

작업이 없거나 대화가 짧은 경우: 사용자에게 "오늘 한 일을 간략히 말해줘"라고 요청한다.

---

## Step 3 — 초안 작성 및 확인  [Confirm]

**Do:**
1. Step 1~2 결과로 worklog 초안을 작성한다.
2. 형식 규칙을 엄격히 적용한다.
3. 초안을 채팅에 마크다운으로 출력한다.
4. "이 내용으로 저장할까요? (수정 사항이 있으면 말해줘)" 라고 묻는다.

**수정 요청 시:** 반영 후 재출력, 최대 2회. 이후엔 확인 없이 저장.

**섹션 생략 규칙:**
- 함정 없음 → `## 함정 모음` 섹션 전체 생략
- 인사이트 없음 → `## 회고 및 인사이트` 섹션 전체 생략
- 커밋 없음 → `## 커밋` 섹션 생략
- 미완료 항목 없음 → `## 미해결 항목` 섹션 생략

---

## Step 4 — GitHub에 push  [Write]

`mcp__github__create_or_update_file`로 파일을 저장한다.

| 파라미터 | 값 |
|---------|-----|
| owner | `jumijeong-design` |
| repo | `jumi-worklog` |
| path | `YYYY-MM-DD.md` |
| branch | `main` |
| message | `feat: YYYY-MM-DD worklog 추가` |
| sha | 기존 파일이 있는 경우 반드시 포함 |

**에러 처리:** SHA 없이 기존 파일 업데이트 → SHA 먼저 읽고 재시도. 네트워크 에러 → 3회 재시도 (2s → 4s → 8s).

---

## Step 4.5 — CONTEXT.md 갱신  [Write]

워크로그 push 직후 `jumi-worklog/CONTEXT.md`를 업데이트한다. 다음 세션 자동 로드 시 항상 최신 상태가 반영되도록 한다.

**Do:**
1. `mcp__github__get_file_contents`로 `CONTEXT.md`의 현재 내용과 SHA를 읽는다.
2. 오늘 worklog에서 다음을 추출한다:
   - 완료된 항목 → `## 미해결 항목`에서 제거
   - 새로 생긴 미완료 항목 → `## 미해결 항목`에 추가
   - 오늘 완료한 주요 작업 → `## 현재 진행 상황` 해당 레포 섹션 갱신
   - 새로 결정된 사항 → `## 최근 주요 결정` 추가 (중요한 경우만)
   - 다음 세션 할 일 → `## 다음 작업 예정` 업데이트
3. `Last updated: YYYY-MM-DD` 날짜를 오늘로 갱신한다.
4. `mcp__github__create_or_update_file`로 저장한다.

| 파라미터 | 값 |
|---------|-----|
| owner | `jumijeong-design` |
| repo | `jumi-worklog` |
| path | `CONTEXT.md` |
| branch | `main` |
| message | `chore: CONTEXT.md 업데이트 — YYYY-MM-DD 세션 반영` |
| sha | 반드시 포함 (읽은 SHA 사용) |

**주의:** `##` 헤더와 테이블 구조는 유지하고 내용만 수정한다.

---

## Step 5 — Notion 동기화  [Write]

Notion MCP(`mcp__a2cd6401__notion-*`)로 디자인팀 DB에 오늘 작업 로그를 업로드한다.

**Do:**
1. `mcp__a2cd6401__notion-search`로 오늘 날짜 페이지가 이미 존재하는지 확인한다.
2. 존재하면: `mcp__a2cd6401__notion-update-page`로 내용 업데이트
3. 없으면: `mcp__a2cd6401__notion-create-pages`로 신규 페이지 생성

**페이지 구조:**
| 속성 | 값 |
|------|-----|
| Title | `YYYY-MM-DD 업무 로그` |
| Date | 오늘 날짜 |

**본문:** worklog 마크다운 내용 그대로 (미해결 항목 → 함정 → 회고 → 작업 목록 → 커밋)

성공 시 출력:
```
worklog 저장 완료.
├── GitHub: YYYY-MM-DD.md → JumiJeong-design/jumi-worklog
├── CONTEXT.md 갱신 완료
└── Notion: YYYY-MM-DD 업무 로그 업데이트
```

**에러 처리:** Notion MCP 미연결 시 → GitHub push + CONTEXT.md 갱신만 완료하고 "Notion MCP가 연결되지 않아 GitHub에만 저장했어요." 출력.

---

## 운영 규칙

- 미완료 항목(`- [ ]`)만 이월, 완료 항목(`- [x]`)은 이월 금지
- 빈 섹션 작성 금지 (내용 없으면 섹션 자체 생략)
- 사용자 요청 코드블록: 원문 그대로 (오타·수정 금지)
- 작업 번호는 1부터 순서대로

## Trigger phrases

`/write-worklog`, `워크로그 써줘`, `오늘 작업 기록해줘`, `세션 정리해줘`, `worklog 작성`, `오늘 정리해줘`, `작업 기록해줘`
