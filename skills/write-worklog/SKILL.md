---
name: write-worklog
description: "오늘 작업 세션을 요약→문서화→GitHub push→CONTEXT.md 갱신→worklog.html 뷰어 등록 순서로 자동 완료한다. Jumi-Worklog 형식(미해결 항목 / 함정 모음 / 회고 및 인사이트 / 날짜별 작업 / 커밋 테이블)로 정리. '워크로그 써줘', '오늘 작업 기록해줘', '세션 정리해줘', '/write-worklog' 시 실행."
disable-model-invocation: false
---

# write-worklog

오늘 작업 세션을 **요약 → 문서화 → GitHub push → CONTEXT.md 갱신 → worklog.html 뷰어 등록** 순서로 자동 완료한다.
대화 컨텍스트에서 작업 내용을 직접 추출하므로, 사용자가 별도로 내용을 타이핑할 필요가 없다.

> **핵심:** 워크로그 본문의 정본은 `logs/YYYY/MM/YYYY-MM-DD.md` 하나다. 공개 뷰어(`site/worklog.html`)는 이 파일을 GitHub raw에서 fetch해 보여주므로, **본문을 HTML에 복사해 넣지 않는다.** 뷰어가 할 일은 그 날짜를 목록에 띄우는 것뿐이고, 그건 `ENTRY_META`에 키를 추가하면 된다(Step 4.6).
>
> HTML 안의 `entry-YYYY-MM-DD` 블록은 fetch 실패 대비 fallback이라 과거 날짜에만 남아 있다. **새로 만들지 않는다** — 만들면 원문과 두 벌이 되어 어긋난다.

---

## Mandatory prerequisites

- 로컬 레포 `~/Desktop/jumi-worklog` — 읽기·쓰기 모두 로컬 파일로 한다
- `gh` CLI 인증 (`gh auth status`) — push·원격 확인용
- 오늘 날짜 확인 필요 (`currentDate` 시스템 컨텍스트 또는 대화에서 추출)
- `logs/` 원본과 `site/worklog.html` 공개 뷰어를 같은 레포에서 관리한다

---

## Worklog 파일 형식 (엄격히 준수)

```
# YYYY-MM-DD

### 미해결 항목

- [ ] 항목 1 (미완료 작업, 다음 세션으로 이월)
- [ ] 항목 2

---

### 함정 모음

- **함정 제목** — 발견한 문제, 원인, 재발 방지 방법.
- **함정 제목2** — ...

---

### 회고 및 인사이트

#### AI 도구 활용

- 인사이트 1

#### 설계 결정

- 결정 1

---

## 작업 영역 제목 1

(작업 내용)

---

## 작업 영역 제목 2

(작업 내용)

### 커밋 (repo-name)

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
| **탭 생성 기준** | `##`는 사용자가 탭으로 전환할 만큼 큰 작업 흐름에만 사용한다 |
| 보조 기록 | 미해결 항목, 함정, 회고, 다음 액션, 커밋은 `###` 이하로 둔다 |
| 커밋 테이블 | 관련 작업 영역 안의 `### 커밋 (repo-name)`으로 둔다 |
| 섹션 구분 | `---` 로 구분 |
| 커밋 SHA | 7자리 축약형, **단 `origin/main`에 도달 가능한 SHA만 기재** (Step 2.5) |

---

## Step 1 — 컨텍스트 읽기  [Research]

**Do:**
1. 오늘 날짜를 확인한다 (`currentDate` 시스템 컨텍스트 또는 대화에서 추출).
2. `ls ~/Desktop/jumi-worklog/logs/$(date +%Y/%m)/`로 최근 날짜 파일 목록을 확인한다.
3. 최근 1~2개 worklog 파일을 읽는다 (미해결 항목 이월, 맥락 파악 목적).
4. 오늘 날짜 파일(`logs/YYYY/MM/YYYY-MM-DD.md`)이 이미 존재하는지 확인한다.
   - 존재하면: 기존 내용을 읽어 이어쓰기 준비
   - 없으면: 새 파일 생성 준비

**Self-check:**
- 이전 파일에서 미완료 항목(`- [ ]`)이 있으면 이월 목록에 추가
- 이전 파일에서 완료 항목(`- [x]`)은 이월하지 않는다
- ⚠️ 이전 워크로그가 "했다"고 적은 작업이라도 **실제 main 파일에 반영돼 있는지 맹신하지 않는다.** 의심되면 해당 파일을 직접 읽어 확인한다 (orphaned 커밋으로 유실됐을 수 있음 — Step 2.5 참고).

---

## Step 2 — 오늘 작업 추출  [Research]

> ⚠️ **대화 컨텍스트만 보면 놓친다.** 세션이 여러 개이거나 다른 도구가 작업한 경우 컨텍스트에 안 잡힌 커밋이 있다. 반드시 **레포별 커밋을 직접 조회**한다.

**Do:**
1. 오늘 커밋을 **3개 레포 모두** 조회한다:
   ```bash
   for r in ~/Desktop/jumi-worklog "$HOME/Desktop/AI_product design_guide" "$HOME/Desktop/socraAI_product design"; do
     echo "### $(basename "$r")"
     git -C "$r" log --since=midnight --oneline
     git -C "$r" status -sb | head -1        # 미푸시/미커밋 확인
   done
   ```
   로컬 조회라 **아직 push 안 된 커밋도 잡힌다.** 그건 "완료"가 아니므로 Step 2.5에서 가른다.
2. 조회된 커밋 목록과 대화 컨텍스트를 합쳐서 아래 항목을 추출한다.

| 추출 대상 | 추출 방법 |
|-----------|----------|
| 사용자 요청 | 사용자가 직접 입력한 지시/질문 문구 (원문 그대로) |
| Claude 작업 | 실제로 수행한 작업 (파일 수정, 생성, 분석, push 등) |
| 커밋 정보 | SHA 7자리 + 커밋 메시지 (`git log` 결과 기준) |
| 함정/삽질 | 발생한 에러, 잘못된 접근, 재발 방지 포인트 |
| 인사이트 | 깨달은 것, 방향 전환, 설계 결정 |
| 미완료 항목 | 시작했지만 끝나지 않은 작업 |

작업이 없거나 대화가 짧은 경우: 사용자에게 "오늘 한 일을 간략히 말해줘"라고 요청한다.

---

## Step 2.5 — 커밋 SHA 무결성 검증  [Research]  ⭐ 필수

커밋 테이블에 넣을 SHA가 **실제로 해당 레포 main에 도달 가능한지** 검증한다. 이 단계가 없으면, 작업이 orphaned(히스토리에서 떨어져 나감)됐는데도 "완료"로 기록되어 다음 세션이 잘못된 상태를 신뢰하게 된다.

**배경 (2026-05-30 실제 사고):** 5/29 작업(커밋 `b93d8db`, rules.md 규칙 17개)이 세션 간 히스토리 충돌로 main에서 orphaned됐는데, 워크로그에는 "완료"로 적혀 있었다. 다음 세션이 그 위에 작업을 쌓다가 유실을 뒤늦게 발견했다.

**Do:**
1. 원격 상태를 먼저 받아온다: `git -C <repo> fetch origin --quiet`
2. 각 SHA가 **원격 main에 도달 가능한지** 확인한다:
   ```bash
   git -C <repo> merge-base --is-ancestor <SHA> origin/main && echo "OK" || echo "NOT ON REMOTE MAIN"
   ```
   로컬 `main`이 아니라 **`origin/main` 기준**이어야 한다. 로컬에만 있는 커밋은 아직 완료가 아니다.
3. **⚠️ squash 머지 오탐 주의.** PR을 squash로 머지하면 원본 커밋은 main의 조상이 아니게 되어
   내용이 멀쩡히 main에 있어도 위 검사가 실패한다. 실패한 SHA는 **내용 기준으로 다시 확인**한다:
   ```bash
   git -C <repo> diff --stat origin/main HEAD -- <해당 경로>   # 비어 있으면 내용은 main에 있음
   gh pr list --head <branch> --state all                      # squash 머지된 PR이 있는지
   ```
   내용이 main에 있으면 유실이 아니다. 커밋 테이블에는 **머지 커밋 SHA**를 적는다.
4. 내용까지 main에 없는 SHA만 진짜 미반영이다:
   - 커밋 테이블에 적지 않고 **함정 모음에 "미반영" 항목으로 기록**해 사용자에게 보고한다.
   - 아직 push만 안 된 것인지(`git status -sb`에 `ahead`) 정말 orphaned인지 구분한다.
   - 원격 브랜치가 `[gone]`이면 머지 후 자동 삭제된 것일 수 있다 — 그 뒤에 쌓은 커밋은
     **어디에도 없는 상태**이므로 반드시 보고한다.
   - 유실 위험 내용이 중요하면 `git show <SHA>:<path>`로 읽어 **복구**를 제안한다.
5. 문서 변경을 기록할 때 "할 예정"과 "실제 origin/main에 push 완료"를 구분한다. 추측으로 "완료"라고 쓰지 않는다.

**Self-check:** 커밋 테이블의 모든 SHA가 `merge-base` 검사를 통과했거나, 실패했더라도
Step 3의 내용 검사로 main 반영이 확인됐는가? 둘 다 실패한 게 있으면 멈추고 보고.

---

## Step 3 — 초안 작성 및 확인  [Confirm]

**Do:**
1. Step 1~2.5 결과로 worklog 초안을 작성한다.
2. 형식 규칙을 엄격히 적용한다.
3. 초안을 채팅에 마크다운으로 출력한다.
4. "이 내용으로 저장할까요? (수정 사항이 있으면 말해줘)" 라고 묻는다.

**수정 요청 시:** 반영 후 재출력, 최대 2회. 이후에는 확인 없이 저장.

**섹션 생략 규칙:**
- 함정 없음 → `### 함정 모음` 섹션 전체 생략
- 커밋 없음 → `### 커밋` 섹션 생략
- 미해결 항목 없음 → `### 미해결 항목` 섹션 생략
- ⚠️ **`### 회고 및 인사이트`는 생략 금지** — 반드시 포함한다. `#### AI 도구 활용`과 `#### 설계 결정` 중 해당하는 항목만 채우면 된다.

**Self-check (초안 출력 전 확인):**
- [ ] 3개 레포 커밋을 모두 반영했는가?
- [ ] `##` 섹션은 사용자가 탭으로 전환해 볼 가치가 있는 큰 작업 흐름에만 썼는가? 커밋, 회고, 다음 액션, 보조 기록은 `###` 이하로 둔다.
- [ ] `### 회고 및 인사이트` 섹션이 있는가?
- [ ] `#### AI 도구 활용` 또는 `#### 설계 결정` 중 최소 하나에 내용이 있는가?

---

## Step 4 — 파일 저장  [Write]

`~/Desktop/jumi-worklog/logs/YYYY/MM/YYYY-MM-DD.md`에 직접 쓴다.

**여기서 push하지 않는다.** Step 4.5(CONTEXT.md)와 4.6(worklog.html)까지 마친 뒤
**한 번에 커밋·push**한다 — 작은 변경마다 push를 반복하지 않는다.

```bash
git -C ~/Desktop/jumi-worklog add logs/ CONTEXT.md site/worklog.html
git -C ~/Desktop/jumi-worklog commit -m "log: YYYY-MM-DD 작업 기록"
git -C ~/Desktop/jumi-worklog pull --rebase && git -C ~/Desktop/jumi-worklog push
```

**에러 처리:** push가 non-fast-forward로 거부되면 다른 세션이 먼저 push한 것이다.
`git pull --rebase` 후 재시도하고, 충돌하면 멈추고 보고한다(임의 해결 금지).

---

## Step 4.5 — CONTEXT.md 갱신  [Write]

워크로그 push 직후 `Jumi-Worklog/CONTEXT.md`를 업데이트한다. 다음 세션 자동 로드 시 항상 최신 상태가 반영되도록 한다.

**Do:**
1. 로컬 `~/Desktop/jumi-worklog/CONTEXT.md`를 읽는다.
2. 오늘 worklog에서 다음을 추출한다:
   - 완료된 항목 → `### 미해결 항목`에서 제거
   - 새로 생긴 미완료 항목 → `### 미해결 항목`에 추가
   - 오늘 완료한 주요 작업 → `## 현재 진행 상황` 해당 레포 섹션 갱신
   - 새로 결정된 사항 → `## 최근 주요 결정` 추가 (중요한 경우만)
   - 다음 세션 할 일 → `## 다음 작업 예정` 업데이트
3. `Last updated: YYYY-MM-DD` 날짜를 오늘로 갱신한다.
4. 로컬 파일에 저장한다. 커밋은 Step 4.6까지 마친 뒤 한 번에 한다.

**주의:** `##` 헤더와 테이블 구조는 유지하고 내용만 수정한다.

---

## Step 4.6 — worklog.html 뷰어 동기화  [Write]

오늘 날짜를 공개 뷰어 목록에 띄운다. **본문은 복사하지 않는다** — 뷰어가 `logs/*.md`를 raw로 fetch하므로, 여기서 할 일은 날짜 등록뿐이다.

날짜가 뷰어(`ENTRIES`)에 뜨는 조건은 `ENTRY_META`에 키가 있거나 `entry-`/`plan-` 블록이 있는 것 둘 중 하나다. **신규 날짜는 `ENTRY_META` 등록으로 처리한다.**

**Do:**
1. 로컬 `~/Desktop/jumi-worklog/site/worklog.html`을 읽는다.
2. `ENTRY_META`에 오늘 날짜 키를 **최상단**(가장 최신 날짜 위)에 추가한다.
   ```js
   const ENTRY_META = {
     'YYYY-MM-DD': { tags: ['태그1', '태그2'] },
     ...
   ```
   - tags는 그날 작업의 검색 키워드. 커밋이 있으면 `'commit'`도 넣는다.
   - **ENTRIES 배열은 건드리지 않는다** — `ENTRY_META` 키 추가만으로 캘린더·목록에 자동 반영된다.
3. **`entry-YYYY-MM-DD` 블록을 새로 만들지 않는다.** 그건 fetch 실패 대비 fallback이고 과거 날짜에만 남아 있다. 새로 만들면 원문과 두 벌이 되어 어긋난다. (2026-07-29 정정 — 이전 판이 블록 생성을 지시하고 있었다)
4. **`plan-YYYY-MM-DD` 블록도 새로 만들지 않는다.** (2026-08-09 정정 — 이전 판이 "plan 블록은 예외"라며 생성을 지시했다) 뷰어의 `getPlan()`이 로그 MD의 `### 미해결 항목` 절을 추출해 계획 탭으로 보여주므로, **계획의 정본도 `logs/*.md` 하나다.** 새 날짜의 계획/이월 항목은 로그 파일 상단 `### 미해결 항목` 절에 쓰면 끝. embed plan 블록은 과거 날짜(2026-08-09 이전) fallback으로만 남아 있다.
5. 로컬 파일에 저장한 뒤, **여기서 Step 4의 커밋·push를 한 번에 실행한다**
   (`logs/` + `CONTEXT.md` + `site/worklog.html`을 한 커밋으로).
6. push 후 `git -C ~/Desktop/jumi-worklog status -sb`가 `ahead` 없이 깨끗한지 확인한다.
7. 공개 URL `https://jumijeong-design.github.io/Jumi-Worklog/worklog.html`을 직접 받아 새 날짜가 실제로 보이는지 확인한다. **안 보이면 코드를 또 고치기 전에 캐시부터 의심한다** — `?v=$(date +%s)`를 붙여 cache-bust로 재확인한다. GitHub Pages/CDN 반영이 늦으면 20~30초 간격으로 재시도.
8. 원문이 raw로 실제 받아지는지도 확인한다:
   `curl -s -o /dev/null -w '%{http_code}' https://raw.githubusercontent.com/JumiJeong-design/Jumi-Worklog/main/logs/YYYY/MM/YYYY-MM-DD.md`
9. 월 단위 체크박스 검증을 실행한다.
   - 예: `node scripts/verify-public-worklog-month.mjs --html /tmp/worklog-public.html --month YYYY-MM --allow-plan plan-YYYY-MM-DD --allow-unchecked plan-YYYY-MM-DD`
   - `--allow-unchecked`에는 내일 `Next`처럼 의도적으로 남기는 entry만 넣는다.
   - **오늘 만든 것과 과거 누적분을 구분해 보고한다.** 과거 plan 블록의 미체크가 쌓여 있으면 검증은 항상 실패로 나온다. 오늘 기여분이 0이면 그렇게 명시하고, 누적분을 오늘 작업의 실패로 보고하지 않는다.

커밋 메시지: `log: YYYY-MM-DD 작업 기록`

**주의:** `<style>`, 사이드바, 스킬 패널, JS 함수 등 **다른 구조는 절대 건드리지 않는다.** 오직 `ENTRY_META` 키만 추가(entry/plan 블록 생성 금지).

---

## Notion 업로드 — 하지 않는다 (2026-07-29 확정)

일일 워크로그는 **Notion에 올리지 않는다.** 공개 뷰어가 그 역할을 한다.

이전 판에는 Notion 동기화 단계가 있었으나 실제로는 2026-06-08을 마지막으로 안 하고 있었고(7월 워크로그는 Notion에 한 건도 없다), 2026-07-29에 안 하는 것으로 확정했다. 스킬이 지시하는데 실무는 안 하는 상태를 없애기 위해 단계를 지운다.

> AX 실험 기록처럼 **별도 사례글**을 Notion에 올리는 건 이 스킬 범위가 아니다. 그건 `ax-log` 스킬이 다룬다.

성공 시 출력:
```
worklog 저장 완료.
├── GitHub: logs/YYYY/MM/YYYY-MM-DD.md → JumiJeong-design/Jumi-Worklog
├── CONTEXT.md 갱신 완료
├── worklog.html ENTRY_META 등록 완료
├── 공개 URL 확인 완료 → https://jumijeong-design.github.io/Jumi-Worklog/worklog.html
└── 월별 체크박스 검증 → 오늘 기여분 N건 / 과거 누적 M건
```

---

## 운영 규칙

- 미완료 항목(`- [ ]`)만 이월, 완료 항목(`- [x]`)은 이월 금지
- 빈 섹션 작성 금지 (내용 없으면 섹션 자체 생략) — 단 **회고는 예외, 항상 포함**
- 사용자 요청 코드블록: 원문 그대로 (오타·수정 금지)
- 작업 번호는 1부터 순서대로
- **뷰어 등록(Step 4.6)은 빠뜨리지 않는다.** 단 등록은 `ENTRY_META` 키 추가이지 본문 복사가 아니다
- **`entry-YYYY-MM-DD` 블록을 새로 만들지 않는다** — 본문 정본은 `logs/*.md` 하나다
- **워크로그 수정은 공개 URL 확인까지가 완료다** — MD/GitHub push만으로 완료 처리하지 않는다. 안 보이면 캐시부터 의심한다
- **커밋 SHA는 main 도달 가능성을 검증하고 기재한다(Step 2.5)**
- **Step 2에서 3개 레포 커밋을 GitHub에서 직접 조회한다** — 대화 컨텍스트만 보면 다른 세션 작업을 놓친다
- 레포 정비·대량 수정 시 반드시 origin/main 최신 상태를 먼저 읽고 작업한다

## Trigger phrases

`/write-worklog`, `워크로그 써줘`, `오늘 작업 기록해줘`, `세션 정리해줘`, `worklog 작성`, `오늘 정리해줘`, `작업 기록해줘`
