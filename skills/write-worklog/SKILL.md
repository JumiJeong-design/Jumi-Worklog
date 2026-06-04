---
name: write-worklog
description: "오늘 작업 세션을 요약→문서화→GitHub push→CONTEXT.md 갱신→worklog.html 뷰어 동기화→Notion 업로드 순서로 자동 완료한다. jumi-worklog 형식(미해결 항목 / 함정 모음 / 회고 및 인사이트 / 날짜별 작업 / 커밋 테이블)로 정리. '워크로그 써줘', '오늘 작업 기록해줘', '세션 정리해줘', '/write-worklog' 시 실행."
disable-model-invocation: false
---

# write-worklog

오늘 작업 세션을 **요약 → 문서화 → GitHub push → CONTEXT.md 갱신 → worklog.html 뷰어 동기화 → Notion 업로드** 순서로 자동 완료한다.
대화 컨텍스트에서 작업 내용을 직접 추출하므로, 사용자가 별도로 내용을 타이핑할 필요가 없다.

> **핵심:** worklog는 두 곳에 저장된다 — ① `jumi-worklog/logs/YYYY/MM/YYYY-MM-DD.md`(원본 마크다운, private) ② `socra-ai-workflow-wiki/worklog.html`(공개 뷰어, 엔트리 하드코딩). 뷰어는 private 레포를 실시간으로 못 읽으므로, 이 스킬이 push 시점에 **둘 다** 갱신해야 한다. Step 4.6을 건너뛰면 뷰어에 오늘 날짜가 안 보인다.

---

## Mandatory prerequisites

- GitHub MCP (`mcp__github__*`) — 파일 읽기·쓰기에 사용
- Notion MCP (`mcp__a2cd6401__notion-*`) — Notion DB 업로드에 사용 (미연결 시 GitHub만 push)
- 오늘 날짜 확인 필요 (`currentDate` 시스템 컨텍스트 또는 대화에서 추출)
- 대상 레포 2개: `jumijeong-design/jumi-worklog`(원본), `jumijeong-design/socra-ai-workflow-wiki`(뷰어)

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

## 작업 영역 제목 1

(작업 내용)

---

## 작업 영역 제목 2

(작업 내용)

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
| 저장 경로 | `logs/YYYY/MM/YYYY-MM-DD.md` |
| 사용자 요청 | 코드블록으로 감싸기 (원문 그대로, 오타 수정 금지) |
| Claude 작업 | 불릿 포인트 (`-`) |
| 미해결 항목 | 이전 worklog 미완료 항목 이월 + 오늘 미완료 |
| 함정 | **굵은 제목** + em dash(—) + 설명 |
| **작업 영역 구분** | **영역마다 `## 제목` 섹션으로 나눈다 — 뷰어에서 서브탭으로 자동 생성됨** |
| 커밋 테이블 | 레포마다 별도 섹션 (`## 커밋 (repo-name)`) |
| 섹션 구분 | `---` 로 구분 |
| 커밋 SHA | 7자리 축약형, **단 main에 도달 가능한 SHA만 기재** (Step 2.5) |

---

## Step 1 — 컨텍스트 읽기  [Research]

**Do:**
1. 오늘 날짜를 확인한다 (`currentDate` 시스템 컨텍스트 또는 대화에서 추출).
2. `mcp__github__get_file_contents`로 `jumijeong-design/jumi-worklog` 레포의 `logs/YYYY/MM/` 경로를 읽어 최근 날짜 파일 목록을 확인한다. (`YYYY`와 `MM`은 오늘 날짜 기준)
3. 최근 1~2개 worklog 파일을 읽는다 (미해결 항목 이월, 맥락 파악 목적).
4. 오늘 날짜 파일(`logs/YYYY/MM/YYYY-MM-DD.md`)이 이미 존재하는지 확인한다.
   - 존재하면: SHA와 기존 내용을 읽어 이어쓰기 준비
   - 없으면: 새 파일 생성 준비

**Self-check:**
- 이전 파일에서 미완료 항목(`- [ ]`)이 있으면 이월 목록에 추가
- 이전 파일에서 완료 항목(`- [x]`)은 이월하지 않는다
- ⚠️ 이전 워크로그가 "했다"고 적은 작업이라도 **실제 main 파일에 반영돼 있는지 맹신하지 않는다.** 의심되면 해당 파일을 직접 읽어 확인한다 (orphaned 커밋으로 유실됐을 수 있음 — Step 2.5 참고).

---

## Step 2 — 오늘 작업 추출  [Research]

> ⚠️ **대화 컨텍스트만 보면 놓친다.** 세션이 여러 개이거나 다른 도구가 작업한 경우 컨텍스트에 안 잡힌 커밋이 있다. 반드시 **GitHub에서 레포별 커밋을 직접 조회**한다.

**Do:**
1. `mcp__github__list_commits`로 오늘 날짜 기준 커밋을 **3개 레포 모두** 조회한다 (`since: YYYY-MM-DDT00:00:00Z`):
   - `jumijeong-design/jumi-worklog`
   - `jumijeong-design/socra-ai-workflow-wiki`
   - `riiid/prism`
2. 조회된 커밋 목록과 대화 컨텍스트를 합쳐서 아래 항목을 추출한다.

| 추출 대상 | 추출 방법 |
|-----------|----------|
| 사용자 요청 | 사용자가 직접 입력한 지시/질문 문구 (원문 그대로) |
| Claude 작업 | 실제로 수행한 작업 (파일 수정, 생성, 분석, push 등) |
| 커밋 정보 | SHA 7자리 + 커밋 메시지 (GitHub 조회 결과 기준) |
| 함정/삽질 | 발생한 에러, 잘못된 접근, 재발 방지 포인트 |
| 인사이트 | 깨달은 것, 방향 전환, 설계 결정 |
| 미완료 항목 | 시작했지만 끝나지 않은 작업 |

작업이 없거나 대화가 짧은 경우: 사용자에게 "오늘 한 일을 간략히 말해줘"라고 요청한다.

---

## Step 2.5 — 커밋 SHA 무결성 검증  [Research]  ⭐ 필수

커밋 테이블에 넣을 SHA가 **실제로 해당 레포 main에 도달 가능한지** 검증한다. 이 단계가 없으면, 작업이 orphaned(히스토리에서 떨어져 나감)됐는데도 "완료"로 기록되어 다음 세션이 잘못된 상태를 신뢰하게 된다.

**배경 (2026-05-30 실제 사고):** 5/29 작업(커밋 `b93d8db`, rules.md 규칙 17개)이 세션 간 히스토리 충돌로 main에서 orphaned됐는데, 워크로그에는 "완료"로 적혀 있었다. 다음 세션이 그 위에 작업을 쌓다가 유실을 뒤늦게 발견했다.

**Do:**
1. 커밋 테이블에 기재할 각 SHA에 대해 `mcp__github__list_commits`(해당 레포, main)로 그 SHA가 목록에 나오는지 확인한다. (또는 `get_commit`으로 존재는 확인되더라도, list_commits 도달성 여부가 핵심)
2. main에서 도달 불가(orphaned)한 SHA는:
   - 커밋 테이블에 그냥 적지 않는다. 대신 **함정 모음에 "유실 위험" 항목으로 기록**하고 사용자에게 보고한다.
   - 유실된 작업 내용이 중요하면 `get_file_contents`에 `sha`(전체 커밋 SHA) 파라미터로 그 시점 파일을 읽어 **복구**를 제안한다.
3. 문서 변경을 기록할 때 "할 예정"과 "실제 main에 push 완료"를 구분한다. 추측으로 "완료"라고 쓰지 않는다.

**Self-check:** 커밋 테이블의 모든 SHA가 `list_commits` main 결과에 존재하는가? 하나라도 없으면 멈추고 보고.

---

## Step 3 — 초안 작성 및 확인  [Confirm]

**Do:**
1. Step 1~2.5 결과로 worklog 초안을 작성한다.
2. 형식 규칙을 엄격히 적용한다.
3. 초안을 채팅에 마크다운으로 출력한다.
4. "이 내용으로 저장할까요? (수정 사항이 있으면 말해줘)" 라고 묻는다.

**수정 요청 시:** 반영 후 재출력, 최대 2회. 이후에는 확인 없이 저장.

**섹션 생략 규칙:**
- 함정 없음 → `## 함정 모음` 섹션 전체 생략
- 커밋 없음 → `## 커밋` 섹션 생략
- 미해결 항목 없음 → `## 미해결 항목` 섹션 생략
- ⚠️ **`## 회고 및 인사이트`는 생략 금지** — 반드시 포함한다. `### AI 도구 활용`과 `### 설계 결정` 중 해당하는 항목만 채우면 된다.

**Self-check (초안 출력 전 확인):**
- [ ] 3개 레포 커밋을 모두 반영했는가?
- [ ] 작업 영역이 2개 이상이면 `##` 섹션으로 나눴는가? (뷰어 서브탭 자동 생성)
- [ ] `## 회고 및 인사이트` 섹션이 있는가?
- [ ] `### AI 도구 활용` 또는 `### 설계 결정` 중 최소 하나에 내용이 있는가?

---

## Step 4 — GitHub에 push  [Write]

`mcp__github__create_or_update_file`로 파일을 저장한다.

| 파라미터 | 값 |
|---------|-----|
| owner | `jumijeong-design` |
| repo | `jumi-worklog` |
| path | `logs/YYYY/MM/YYYY-MM-DD.md` |
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

## Step 4.6 — worklog.html 뷰어 동기화  [Write]

공개 뷰어 `socra-ai-workflow-wiki/site/worklog.html`에 오늘 엔트리를 추가한다.
**이 단계를 건너뛰면 뷰어 페이지에 오늘 날짜가 안 보인다.** (private 레포라 실시간 fetch 불가 → 수동 동기화 필수)

worklog.html은 엔트리를 **`<script>` 블록**으로만 관리한다. ENTRIES 목록은 DOM에서 자동 파생되므로 별도로 건드리지 않는다.

**Do:**
1. `mcp__github__get_file_contents`로 `socra-ai-workflow-wiki/site/worklog.html`의 현재 내용과 SHA를 읽는다.
2. 오늘 엔트리가 이미 있는지(`id="entry-YYYY-MM-DD"`) 확인. 있으면 해당 블록 교체, 없으면 신규 추가.
3. **엔트리 블록 삽입:** 가장 최신 엔트리 블록 **바로 위**에 새 블록을 넣는다.
   ```
   <script type="text/plain" id="entry-YYYY-MM-DD">
   (worklog 마크다운 본문)
   </script>
   ```
   - 작업 영역이 2개 이상이면 `##` 섹션으로 나눈다 — 뷰어가 자동으로 서브탭을 생성한다.
   - `</script>` 문자열이 본문에 들어가면 블록이 깨지므로 피한다.
4. **ENTRY_META 갱신 (선택):** tags나 notion 링크가 있으면 `ENTRY_META` 객체에만 추가한다.
   ```js
   'YYYY-MM-DD': { tags: ['태그1', '태그2'] },
   // notion 링크가 있는 경우: 'YYYY-MM-DD': { tags: [...], notion: 'https://...' },
   ```
   - tags나 notion이 없으면 이 단계는 생략해도 된다.
   - **ENTRIES 배열은 건드리지 않는다** — `entry-YYYY-MM-DD` 블록 추가만으로 캘린더·목록에 자동 반영된다.
5. `mcp__github__create_or_update_file`로 저장한다.

| 파라미터 | 값 |
|---------|-----|
| owner | `jumijeong-design` |
| repo | `socra-ai-workflow-wiki` |
| path | `site/worklog.html` |
| branch | `main` |
| message | `feat: YYYY-MM-DD worklog 엔트리 추가` |
| sha | 반드시 포함 (읽은 SHA 사용) |

**주의:** `<style>`, 사이드바, 스킬 패널, JS 함수 등 **엔트리 외 구조는 절대 건드리지 않는다.** 오직 엔트리 블록(`entry-/plan-`) + ENTRY_META(선택)만 추가.

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
├── GitHub: logs/YYYY/MM/YYYY-MM-DD.md → JumiJeong-design/jumi-worklog
├── CONTEXT.md 갱신 완료
├── worklog.html 뷰어 동기화 완료 → socra-ai-workflow-wiki
└── Notion: YYYY-MM-DD 업무 로그 업데이트
```

**에러 처리:** Notion MCP 미연결 시 → GitHub push + CONTEXT.md + worklog.html 까지 완료하고 "Notion MCP가 연결되지 않아 GitHub에만 저장했어요." 출력.

---

## 운영 규칙

- 미완료 항목(`- [ ]`)만 이월, 완료 항목(`- [x]`)은 이월 금지
- 빈 섹션 작성 금지 (내용 없으면 섹션 자체 생략) — 단 **회고는 예외, 항상 포함**
- 사용자 요청 코드블록: 원문 그대로 (오타·수정 금지)
- 작업 번호는 1부터 순서대로
- **worklog.html 동기화(Step 4.6)는 빠뜨리지 않는다**
- **커밋 SHA는 main 도달 가능성을 검증하고 기재한다(Step 2.5)**
- **Step 2에서 3개 레포 커밋을 GitHub에서 직접 조회한다** — 대화 컨텍스트만 보면 다른 세션 작업을 놓친다
- 레포 정비·대량 수정 시 반드시 origin/main 최신 상태를 먼저 읽고 작업한다

## Trigger phrases

`/write-worklog`, `워크로그 써줘`, `오늘 작업 기록해줘`, `세션 정리해줘`, `worklog 작성`, `오늘 정리해줘`, `작업 기록해줘`
