---
name: record-trap
description: "실수나 함정 발견 시 design-system/rules.md와 docs/agent-rules.md를 동시에 업데이트하고, 오늘 worklog 함정 모음에도 기록한다. '이거 기억해줘', '규칙 추가해줘', '재발 방지', '/record-trap' 시 실행."
disable-model-invocation: false
---

# record-trap

실수·함정 발생 시 두 곳에 동시 기록해서 재발을 방지한다.
한 곳에만 쓰면 다음 세션에서 Claude나 Codex가 놓칠 수 있다.

---

## 기록 대상 파일

| 파일 | 역할 | 레포 |
|------|------|------|
| `design-system/rules.md` | 컴포넌트·디자인 작업 원칙 (주미님 잔소리/실수 방지 규칙) | `riiid/prism` |
| `docs/agent-rules.md` | AI 에이전트가 따라야 할 행동 규칙 | `riiid/prism` |
| 오늘 worklog `## 함정 모음` | 날짜별 함정 기록 | `jumi-worklog` |

상황에 따라 1~3개 모두 또는 일부만 업데이트한다.

---

## Step 1 — 함정 내용 정리  [Confirm]

**Do:**
1. 사용자가 말한 함정/실수를 아래 형식으로 정리한다:

```
- **[함정 제목]** — [무슨 문제가 발생했나]. [원인]. [다음엔 어떻게 해야 하나].
```

2. 채팅에 정리된 내용 출력 후 확인: "이 내용으로 기록할까요?"

**좋은 함정 제목 예시:**
- "Figma 컴포넌트 인스턴스 직접 편집"
- "버전 날짜 오타 (YYYY 확인 필수)"
- "폴더 구조 중복 분산"

---

## Step 2 — 어디에 기록할지 결정  [Confirm]

함정 성격에 따라 자동 판단한다. 사용자에게 확인.

| 함정 성격 | 기록 위치 |
|-----------|-----------|
| Figma·컴포넌트·디자인 시스템 작업 실수 | `design-system/rules.md` + worklog |
| AI에게 지시할 때의 실수·오해 | `docs/agent-rules.md` + worklog |
| 둘 다 해당 | 세 곳 모두 |
| 단순 메모만 필요 | worklog만 |

---

## Step 3 — 파일 읽기  [Research]

`mcp__github__get_file_contents`로 업데이트할 파일의 현재 내용과 SHA를 읽는다.

- `riiid/prism` → `design-system/rules.md`, `docs/agent-rules.md`
- `jumijeong-design/jumi-worklog` → 오늘 날짜 worklog 파일 (`YYYY-MM-DD.md`)

---

## Step 4 — 파일 업데이트  [Write]

**design-system/rules.md 업데이트 시:**
- 기존 Rule N+1 번호로 새 규칙 추가
- 형식: `**Rule N: [제목]** — [설명]`
- 관련 섹션이 있으면 해당 섹션 안에 삽입, 없으면 맨 아래 추가

**docs/agent-rules.md 업데이트 시:**
- "피해야 할 것" 또는 "주의사항" 섹션에 추가
- 없으면 섹션 신규 생성 후 추가

**worklog 업데이트 시:**
- 오늘 파일 `## 함정 모음` 섹션에 추가
- 파일이 없으면 `write-worklog` 스킬을 대신 실행

모두 `mcp__github__create_or_update_file`로 업데이트. SHA 필수.

완료 후 출력:
```
함정 기록 완료.
- design-system/rules.md: Rule N 추가 (또는 skip)
- docs/agent-rules.md: 항목 추가 (또는 skip)
- worklog: 함정 모음 업데이트 (또는 skip)
```

---

## 운영 규칙

- 함정 제목은 굵게 (`**제목**`) + em dash(—) + 설명 형식 통일
- 기존 규칙과 중복되면 기존 항목을 강화하고 중복 추가하지 않는다
- SHA 없이 업데이트 시도 금지 — 반드시 읽고 나서 수정

## Trigger phrases

`/record-trap`, `이거 기억해줘`, `규칙 추가해줘`, `재발 방지 기록`, `이 실수 기록해줘`, `함정 추가해줘`
