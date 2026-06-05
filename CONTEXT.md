# 현재 상태 스냅샷

> 세션 시작 시 자동 로드되는 파일. 세션 종료 전 반드시 업데이트.
> Last updated: 2026-06-06

---

## ⛔ Claude 행동 규칙 (위반 시 즉시 자각할 것)

> 이 규칙들은 실수 사례에서 귀납한 것. 지식이 없어서가 아니라 습관적 패턴 답습으로 생기는 실수를 막기 위한 것.

| 규칙 | 위반 패턴 | 올바른 행동 |
|------|-----------|------------|
| **기존 코드 패턴을 맹목적으로 따르지 않는다** | 기존에 ENTRIES 배열이 있으니까 거기에 항목만 추가 | "왜 이 배열이 따로 존재하는가?" 먼저 묻고, N군데 동시 수정이 필요하면 구조부터 고친다 |
| **증상 fix 전에 근본 원인부터 파악한다** | 캘린더에 날짜가 없으니 배열에 추가 → 근본 원인(하드코딩 자체)은 그대로 | 증상이 발견되면 "왜 이 증상이 생겼는가"를 먼저 추적한다 |
| **데이터를 추가할 때 N군데 수정이 필요하면 설계 냄새다** | 엔트리 블록 추가 + ENTRIES 배열 추가 = 두 군데 | 단일 소스로 통합하거나 자동 파생되도록 먼저 리팩터 |
| **상속받은 코드도 올바르다고 가정하지 않는다** | 이전 세션에서 만든 구조니까 맞겠지 | 기존 코드도 설계 검토 대상이다. 개발 지식이 충분하면 냄새를 먼저 잡아야 한다 |
| **회고 섹션은 생략하지 않는다** | 워크로그 마지막에 회고가 없어도 그냥 저장 | 형식 규칙에 없어 보여도 템플릿에 있으면 반드시 포함 |
| **상태 확인은 CONTEXT.md만 믿지 않는다** | CONTEXT.md가 미완이라 표기됐으니 미완이겠지 | Figma MCP·git log로 실제 소스를 교차 확인한 뒤 보고. 문서는 항상 뒤처질 수 있다 |
| **워크로그 수정은 공개 URL 확인까지가 완료다** | MD만 수정하거나 worklog.html만 push하고 종료 | 원본 MD + `site/worklog.html` 동시 갱신 → 두 레포 커밋/푸시 → `https://jumijeong-design.github.io/socra-ai-workflow-wiki/site/worklog.html`에서 실제 문구 확인 |
| **공개 worklog는 월 단위 체크박스 상태까지 검증한다** | 오늘 파일만 보고 완료라고 판단 → 공개 viewer에 public-only plan/old entry 미체크가 남음 | `scripts/verify-public-worklog-month.mjs`로 공개 HTML의 해당 월 entry/plan 블록을 검사. 오늘 완료는 `[x]`, 내일 `Next`만 `[ ]`, stale `plan-*` 블록은 제거 |
| **기본은 작게 시작한다** | 분석, 수정, 배포, 위키/스킬 승격을 한 턴에 모두 수행해 토큰과 범위가 커짐 | 먼저 분석/수정 여부를 구분하고, 한 턴 한 레포를 기본값으로 둔다. 공개 검증은 public 문서 변경 시에만, 위키/스킬 승격은 하루 끝이나 명시 요청 시에만 수행한다 |

---

## 레포 구조

| 레포 | 역할 |
|------|------|
| jumi-worklog | 공동 기록 허브 — 공통 스킬 + 날짜별 워크로그 (`logs/YYYY/MM/`) |
| riiid/prism | Prism package repo — 디자인 시스템, 컴포넌트 계약, 토큰, Storybook, release workflow |
| socra-ai-workflow-wiki | 위키 채널 — AI 워크플로우·프로세스·시행착오 (구 socra-ai-workflow-guide) |

---

## 🤖 자동화 — 스킬 & 훅 (안 외워도 됨)

> 이 표는 세션 시작 시 자동 로드되니, 무슨 스킬·훅이 있는지 기억 안 나면 여기만 보면 됨.

### 스킬 (트리거 문구만 말하면 실행) — `skills/` 폴더

| 스킬 | 트리거 문구 | 하는 일 |
|------|------------|---------|
| `write-worklog` | "워크로그 써줘", "오늘 정리해줘" | 오늘 작업 요약 → md push → CONTEXT 갱신 → 뷰어 동기화 → Notion 업로드 |
| `session-snapshot` | "지금까지 뭐했어?", "중간 정리" | 세션 중간 작업 현황 요약 — 파일 저장 없이 채팅 출력만 |
| `sync-entry` | "동기화 확인해줘", "뷰어랑 맞아?" | jumi-worklog md와 worklog.html 뷰어 내용 비교 → 누락·불일치 보고 |
| `handoff-check` | "handoff 확인해줘", "클로드 코드에서 이어받을 수 있어?" | 다른 AI 도구나 새 세션에서 이어받을 수 있는 문서 상태인지 확인 → 필요 시 handoff 문서·워크로그·공개 뷰어 갱신 |
| `prep-meeting` | "미팅 준비해줘", "이번주 요약해줘" | 최근 7일 워크로그 읽어 업무 요약 + 미팅 아젠다 생성 |
| `bump-version` | "버전 올려줘", "배포할게" | socra-ai-workflow-wiki 버전 4개 파일 동시 갱신 |
| `record-trap` | "이거 기억해줘", "규칙 추가해줘" | 함정/규칙을 rules.md·agent-rules.md에 기록 |

> Figma MCP 슬래시 스킬(6개)은 워크로그 뷰어 ⚡스킬 탭 참고.

### 훅 (자동 실행) — `~/.claude/settings.json` (로컬 머신, 레포엔 없음)

| 훅 | 시점 | 하는 일 |
|----|------|---------|
| SessionStart | 세션 시작 | 이 CONTEXT.md를 자동 로드 (맥락 자동 파악) |
| Stop | 세션 종료 | 오늘 워크로그가 없으면 종료 차단 (기록 누락 방지) |
| PreToolUse (Bash) | git push 실행 전 | main으로 직접 push 시 경고 출력 |

> ⚠️ 훅은 로컬 `~/.claude/settings.json`에만 있어 레포·뷰어에 안 보임. 새 머신 세팅 시 재설정 필요.
> PreToolUse 훅: 스크립트·설정·가이드 준비 완료 → `hooks/` (pre-push-guard.sh). **로컬 설치만 남음** (`hooks/README.md` 참고).

---

## ⭐ 주미님 액션 아이템

### ✅ 완료 (2026-06-05, Figma MCP 교차검증)
1. **폰트 Pretendard Figma 적용** — `var(--font-family-base)` = **Pretendard** 확인 (텍스트 노드 `575:875` get_variable_defs). heading/body 모두 base family 적용됨.
2. **color 다크 모드 중복(theme-dark/Dark) 정리** — `color` 컬렉션 **2개 모드**(`Light(2:0)` / `Dark(728:0)`)만 잔존, metadata에 `theme-dark` 0회. 중복 해소 확인.
3. **브랜드 컬러 방향 확정** — B&W 기반 + 카테고리별 컬러 포인트 확장. 모델 컬러는 SVG 로고 내장값 사용(별도 토큰 X).

---

## 작업 보드

- [ ] Figma 디자인 전체 리디자인 (주미님 직접) → 완료 후 코드 sync
- [ ] 코드 기반 컴포넌트 라이브러리 기술 스택 확정 → 확정 후 Code Connect (Codex가 Storybook 착수 — 진행 중)
- [ ] FIGMA_TOKEN 등록 완료 + 네트워크 정책 `api.figma.com` 추가 완료 → **새 세션에서 REST API 전환 테스트 필요**
- [ ] 브랜드 컬러 구체값 확정 (방향은 B&W+카테고리 포인트로 확정, 구체 hex·카테고리 매핑 미정)
- [x] **폰트 Pretendard Figma 적용** — `var(--font-family-base)` = Pretendard 확인 (MCP 교차검증)
- [x] **color 다크 모드 모드 중복(theme-dark/Dark) 정리** — 현재 Figma `color` collection은 Light/Dark 2 modes로 확인됨
- [x] Socra Design system test — opacity/alpha semantic token audit 및 layer opacity cleanup
- [ ] Socra Design system test — Foundation/Icons/Components/Pages 전체 token/style sync audit
- [ ] Socra Design system test — component guide wrapper 구조 시범 적용
- [ ] Socra Design system test — Markdown table head/column/cell 구조 점검
- [ ] Foundation에 Error states · Motion · Breakpoints 추가 (주미님)
- [x] PR #3 — `riiid/prism` CLOSED (머지 없이 종료 판단. Rule 18·Pretendard 내용은 직접 커밋으로 반영됨)
- [ ] (구조) workflow-wiki 사이드바에 guides/·playbooks/·worklog.html 링크 연결 — Codex 영역
- [x] **riiid/prism Button** — QA surface 결정 완료: package contract 기준 유지, Figma evidence를 package에 맞게 정렬 (`8b83f66` revert + `4096d75`)
- [ ] `pnpm visual` Chromatic 업로드 승인 여부 결정
- [x] **PreToolUse 훅 (main push·force push 차단)** — 설치 완료 (`hooks/pre-push-guard.sh` + `~/.claude/settings.json` 등록)

---

## 현재 검증 중인 가설

| 가설 | 현황 |
|------|------|
| 일본 유저는 멀티 AI 비교에서 신뢰를 더 높게 느낀다 | 🔄 검증 전 |
| 고민 도메인이 명확할수록 재방문률이 높다 | 🔄 검증 전 |
| 일본 유저는 UI 완성도에서 신뢰를 먼저 형성한다 | 🔄 검증 전 |

---

## 주요 결정 + 이유 (최근순)

| 결정 | 이유 한 줄 |
|------|------------|
| Component state는 layer opacity가 아니라 semantic token으로 표현 | 다크모드 전환에서 disabled/pressed/scrim 의도를 각각 제어해야 함 |
| Socra category color set을 active Foundation에서 제거 | 고민 taxonomy와 화면 사용처가 확정되기 전까지 semantic처럼 노출하면 판단 노이즈가 커짐 |
| dark mode opacity는 role semantic token으로 운영 | black/white alpha 1:1 반전은 surface·state·overlay 의도를 망가뜨릴 수 있음 |
| Markdown table은 head/column/body cell 구조를 분리 | markdown table을 실제 읽을 수 있게 만들려면 header와 column/cell 역할이 시각적으로 달라야 함 |
| component guide wrapper는 한 component에 먼저 시범 적용 | 흩어진 guide card는 다시 혼란을 만들 수 있으므로 작은 단위로 검증해야 함 |
| component guide는 wrapper docs 구조로 작성 | 흩어진 guide card는 원본 컴포넌트 주변을 어지럽히고 실제 preview와 설명의 관계를 흐림 |
| ENTRIES 배열 → DOM 자동 파생으로 전환 | entry/plan 블록 추가 시 두 군데 수정 필요 = 설계 냄새. 단일 소스로 통합 |
| write-worklog Step 2에서 3개 레포 커밋 전수 조회 | 대화 컨텍스트만 보면 다른 세션 작업을 놓친다 — 2026-06-04 wiki 작업 누락 사례 |
| worklog 뷰어 H2 → 서브탭 자동 생성 | `##`는 탭으로 전환할 만큼 큰 작업 흐름에만 사용. 커밋·회고·다음 액션은 `###` 이하로 둬 탭 과밀을 피함 |
| 에이전트 분담은 맥락 소유권 기준 | Claude/Codex 능력차 아님 — 충돌 회피 + Figma MCP 연결만 실질 차이. 코드=Codex, Figma·워크로그=Claude |
| **폰트 Pretendard 패밀리로 통일** | orioncactus/pretendard 한 패밀리로 일관성↑·관리 단순. Geist 제거 |
| `riiid/prism` package contract가 현재 SOT | Figma는 visual evidence와 적용 상태 확인에 사용. package/component/token/Storybook 계약 우선 |
| 워크로그 경로 `logs/YYYY/MM/`로 통일 | 스킬·CI 경로 불일치로 6일치 사각지대 발생 → 경로 통일로 재발 차단 |
| Package-first + Storybook 검증 모델 채택 | package contract 우선, Figma evidence는 보조 근거 |
| rules.md Rule 18 Auto Layout 필수 | 다국어 텍스트 길이 변화에 레이아웃 깨지지 않게 |
| write-worklog SHA 무결성 검증(Step 2.5) 추가 | 5/29 rules.md 17규칙 고아 커밋 유실 사고 재방지 |
| Figma REST API 전환 추진 | Plugin API lazy loading 버그 — 5페이지 중 2개만 반환 |
| Japan-First 설계 원칙 채택 | 일본을 "조정 대상"이 아닌 "설계 기준"으로 삼아야 현지화 비용 최소화 |
| 블랙앤화이트 플랫폼 톤 | 브랜드 컬러 미확정 상태에서 컴포넌트 작업 진행 가능하게 |

---

## Figma 파일 페이지 구조

파일 키: `DcYgJjGAfObOIM4IyrQjgj`

| 페이지 | node ID | 내용 |
|--------|---------|------|
| Components | `0:1` | 컴포넌트 35개 |
| Foundation | `70:218` | Color(light/dark) · Typography · Spacing · Shadow/Elevation · Markdown · Error states 예정 |
| Icons | `74:10109` | Lucide 전체 + In Use 24개 |
| Page design test | `76:10172` | 화면 디자인 테스트 |
| Image reference | `76:10169` | 참조 이미지 모음 |

### Figma Variable 컬렉션 (2026-05-31 조사)

| 컬렉션 | ID | 모드 | 변수 수 |
|--------|-----|------|--------|
| color | `2:2` | Light(2:0) · Dark(728:0) | 108 |
| typography | `5:2` | default(5:0) | 26 |
| spacing | `8:2` | default(8:0) | 20 |
| radius | `9:2` | default(9:0) | 9 |

---

## AI 모델 현황

`docs/model-registry.md` 참고. 현재 5개 활성 (Claude/GPT/Gemini/Grok/Perplexity), 6번째 TBD.

---

## 현재 진행 상황

### riiid/prism
- 파운데이션 문서 4종 완료 (color, typography, spacing, shadow)
- design-system/components.md — 35개 컴포넌트 전면 싱크 완료
- **design-system/rules.md — 18규칙** [PR #3 브랜치, main 미머지]
- Storybook 착수 (Codex, main) — Button 스토리 + token fallback 격리 렌더
- **Button Figma/Storybook 루프 검증 완료** (2026-06-04)
- **Socra Foundation cleanup 완료** (2026-06-05): category colors 제거, `Shadow / Elevation` 병합, Markdown Rendering/Table 정리, semantic alpha/state token 반영, 후속 계획 push (`6ee8c65`, `b69a034`, `8f3a427`)
- **Foundation/Components sync audit 표 작성 완료** (2026-06-05): `docs/plans/2026-06-06-socra-design-system-followup.md`의 `### 2026-06-05 Foundation / Components Sync Audit Table` 기준으로 6월 6일 수정 작업을 이어간다. 같은 표를 다시 만들지 않고, false positive 제거 후 source-of-truth가 명확한 항목만 수정한다.

### socra-ai-workflow-wiki
- **v0.15** — 5개 그룹 페이지 분리, scrollspy, 검색 하이라이트, wiki.html 뷰어
- worklog 뷰어: Plan/Log 탭, 캘린더 점, 인터랙티브 체크박스, **큰 작업 흐름 H2 → 서브탭 자동 생성**
- ENTRIES 배열 → DOM 자동 파생으로 전환 (entry/plan 블록만 추가하면 자동 반영)
- ⚠️ 사이드바에 guides/·playbooks/·worklog.html 미연결 — Codex 정리 예정

### jumi-worklog
- 스킬 6개 — write-worklog / **session-snapshot(신규)** / **sync-entry(신규)** / prep-meeting / bump-version / record-trap
- write-worklog 스킬 개선: 3개 레포 커밋 전수 조회, 회고 필수화, H2 탭 과밀 방지 기준 추가
- **2026-06-04, 2026-06-05 워크로그 완료**

---

## 다음 작업 예정

6월 6일 다음 작업은 역할을 분리해서 진행한다.

### Codex/Claude Code가 이어서 할 작업

1. **Socra DS**: 6월 5일 sync audit 표 기준으로 Foundation/Components 수정. source-of-truth가 명확한 항목만 반영하고, count 기반 bulk edit은 금지.
2. **Socra DS**: Markdown table head/column/body cell 구조를 현재 Figma component 구조와 대조해 수정 가능 항목과 사용자 판단 항목을 분리.
3. **Socra DS**: Button/icon stroke/Text Field처럼 package-sensitive 항목은 package contract와 승인 범위를 먼저 확인한 뒤 수정 여부 결정.
4. **워크로그**: 작업을 하면 즉시 해당 체크리스트를 `[x]`로 갱신하고, 공개 `worklog.html` 배포 후 월 단위 검증까지 완료.

### 주미님 확인

1. **Chromatic Storybook matrix 육안 QA**: 사용자 Chromatic 세션에서 Button `InteractiveAction`, matrix stories, light/dark 상태 확인.
2. **Component guide wrapper 구조**: 실제 component 1개에만 wrapper를 시범 적용할 대상과 배치 결정.
3. **Pretendard JP Figma runtime availability**: Figma font picker/runtime에서 실제 노출 여부 확인.
4. **Markdown Table 2-column / 4-column 방향**: 현재 3-column preview와 Header/Body primitive 이후 variant 또는 instance 방향 결정.
5. **기존 모바일 source frame 확인**: source frame을 정한 뒤 web responsive 확장 판단.
6. **next-batch component 후보 최종 결정**: `ActionBar`, `Chat History Panel`, `ThumbnailItem`, `GNB` 등 승인 범위 결정.
