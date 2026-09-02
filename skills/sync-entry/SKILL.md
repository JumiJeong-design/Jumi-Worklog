---
name: sync-entry
description: "Jumi-Worklog 원문이 공개 뷰어에서 실제로 보이는지 확인한다(원문 push / ENTRY_META 등록 / plan 블록). '동기화 확인해줘', '뷰어랑 맞아?', '/sync-entry' 시 실행."
disable-model-invocation: false
---

# sync-entry

`JumiJeong-design/Jumi-Worklog`의 워크로그 원문이 공개 뷰어에서 실제로 보이는지 확인한다.

> **배경 (2026-06-04 실제 사례):** prism 작업은 worklog.html에 반영됐으나 다른 작업은 원본 md에는 있고 뷰어 fallback에는 없었다. 원본과 공개 뷰어 fallback이 함께 관리되다 보니 세션 경계에서 불일치가 쉽게 생긴다.

## 먼저 — 뷰어가 무엇을 정본으로 읽는지 (2026-07-29 정정)

**로그 본문은 embed 블록이 아니라 GitHub raw에서 fetch한다.** 이걸 모르면 정상 상태를 전부 누락으로 오판한다.

`site/worklog.html`의 실제 동작:

- `ensureLog(date)` → `RAW_BASE + logs/YYYY/MM/YYYY-MM-DD.md`를 `cache: 'no-cache'`로 fetch (`origin/main` 기준)
- `getMarkdown(date)` → raw fetch가 성공하면 그 내용, **실패했을 때만** `#entry-YYYY-MM-DD` 블록으로 폴백
- 날짜가 뷰어 목록(`ENTRIES`)에 뜨려면 `ENTRY_META`에 키가 있거나 `entry-`/`plan-` 블록이 있어야 한다
- **계획 탭도 로그 MD가 정본이다(2026-08-09~).** `getPlan()`은 embed `plan-YYYY-MM-DD` 블록이 있으면 그걸 쓰고(과거 날짜 보존용), 없으면 로그 MD의 `### 미해결 항목` 절을 추출해 계획으로 보여준다. **신규 날짜엔 plan 블록을 만들지 않는다** — 로그 원문에 미해결 항목 절만 있으면 된다

따라서:

| 대상 | 정본 | 확인할 것 |
|------|------|-----------|
| 로그 본문 | `origin/main`의 `logs/*.md` | push 됐는지 (embed와 비교하지 않는다) |
| 날짜 노출 | `ENTRY_META` 키 또는 embed 블록 | 등록됐는지 (없으면 뷰어에서 접근 자체가 불가) |
| 계획 탭 | 로그 MD의 `### 미해결 항목` 절 (과거 날짜는 embed plan 블록) | 원문에 절이 있는지 (신규 날짜에 plan 블록 없음 = 정상) |

> 🚨 **`entry-YYYY-MM-DD` embed 블록이 최신 날짜에 없는 것은 정상이다.** fetch 실패 대비 fallback일 뿐이라 신규 날짜에 안 만든다. 이걸 "뷰어 누락"으로 보고하지 말 것 — 2026-07-29에 이 오탐으로 7/20\~7/28 6건이 전부 잘못 잡혔다(embed 마지막이 7/16, 그러나 ENTRY_META에는 전부 등록돼 있어 실제로는 정상).

---

## Mandatory prerequisites

- 로컬 레포 `~/Desktop/jumi-worklog` (원격은 `JumiJeong-design/Jumi-Worklog`)
- 확인할 날짜 (기본값: 오늘)

> 읽기는 로컬 파일로 한다. 로컬이 원격과 어긋났을 수 있으니 시작 전 `git -C ~/Desktop/jumi-worklog status -sb`로
> 미푸시 커밋·미커밋 변경이 있는지 먼저 본다.

---

## Step 1 — 원문과 등록 상태 읽기  [Research]

1. `logs/YYYY/MM/YYYY-MM-DD.md`(원문)를 읽는다. 없으면 그날 워크로그가 아직 안 쓰인 것이므로 여기서 멈추고 보고한다.
2. `git status -sb`와 `git log origin/main..HEAD -- logs/`로 **원문이 `origin/main`에 올라갔는지** 확인한다.
3. `site/worklog.html`에서 `ENTRY_META`에 해당 날짜 키가 있는지 확인한다.
4. 계획 탭 확인: 원문에 `### 미해결 항목` 절이 있으면 그게 계획 탭이 된다(2026-08-09 이전 날짜만 embed `plan-` 블록 확인).

---

## Step 2 — 비교  [Research]

| 확인 항목 | 방법 | 실패하면 |
|-----------|------|----------|
| 원문 존재 | `logs/YYYY/MM/YYYY-MM-DD.md` | 워크로그 미작성 |
| 원문 push | `git merge-base --is-ancestor HEAD origin/main` 또는 `git log origin/main..HEAD -- logs/`가 비어 있는지 | 로컬에만 있어 뷰어에 안 뜸 |
| 날짜 등록 | `ENTRY_META`에 키가 있거나 `entry-`/`plan-` 블록 존재 | 뷰어 목록에서 그 날짜 자체가 안 보임 |
| 계획 탭 | 원문 `### 미해결 항목` 절 존재(신규) / embed plan 블록(과거) | plan 패널이 빈 상태 |
| plan 체크박스 | 오늘 완료 항목이 `[x]`인지 (신규 날짜는 원문 MD에서) | 완료가 미완료로 보임 |

**하지 말 것:** 원문 `##` 헤더 수와 `entry-` embed 블록의 헤더 수를 비교하지 않는다. embed는 fallback이라 최신 날짜엔 아예 없는 게 정상이고, 비교하면 전부 누락으로 잡힌다.

추가로 날짜 하나만 보지 말고, 사용자가 보는 월 전체를 확인한다:

- 공개 HTML을 저장한 뒤 **그 달의 날짜가 목록·캘린더에 다 뜨는지** 본다. 안 보이면 코드를 고치기 전에 캐시부터 의심한다(`?v=$(date +%s)`).
- **`verify-public-worklog-month.mjs`는 쓰지 않는다(2026-09-02 확정).** 뷰어 HTML 안에 본문이 복사돼 있던 시절의 검사이고, 2026-08-09에 그 방식을 접어 지금은 어느 달을 넣어도 실패한다. 근거는 `AGENTS.md` 워크로그 절.

---

## Step 3 — 결과 보고 및 수정  [Confirm]

정상이면:
```
✅ YYYY-MM-DD 뷰어 노출 정상
   원문 push 완료 / ENTRY_META 등록됨 / plan 블록 OK
```

문제가 있으면 원인별로 보고한다. 각 원인마다 고치는 곳이 다르다:
```
⚠️ YYYY-MM-DD 뷰어에 안 보임

원인: 원문이 origin/main에 없음 (로컬 커밋 2개 미푸시)
→ 고칠 곳: git push

원인: ENTRY_META에 날짜 미등록
→ 고칠 곳: site/worklog.html의 ENTRY_META에 키 추가
```

수정 여부를 확인한 뒤 고친다. 뷰어를 수정한 경우 커밋/푸시 후 공개 URL `https://jumijeong-design.github.io/Jumi-Worklog/worklog.html`에서 실제로 보이는지 확인하고, 월 단위 체크박스 검증까지 통과해야 완료다. raw는 캐시가 있어(~5분) 바로 안 바뀔 수 있으므로, 안 보이면 코드를 또 고치기 전에 캐시부터 의심한다.

---

## 운영 규칙

- 날짜 미지정 시 오늘 날짜로 실행. 오늘 원문이 없으면 최신 날짜로 안내하고 멈춘다
- **`entry-` embed 블록을 새로 만들지 않는다.** 신규 날짜는 `ENTRY_META` 등록으로 노출시킨다
- 원본 md를 뷰어에 맞춰 변경하지 않는다 — 원본이 항상 기준
- 원본 md 또는 뷰어를 수정하면 같은 repo 안의 `logs/` 원본과 `site/worklog.html` 반영 여부, 공개 URL 렌더 결과를 함께 확인한다
- 공개 viewer에만 남은 허용되지 않은 `plan-*` 블록이나 오래된 unchecked 항목은 사용자가 실제 화면에서 보는 문제이므로 반드시 월 단위로 잡는다

## Trigger phrases

`/sync-entry`, `동기화 확인해줘`, `뷰어랑 맞아?`, `워크로그 싱크 확인`
