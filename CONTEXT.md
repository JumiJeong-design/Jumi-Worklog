# 현재 상태 스냅샷

> 세션 시작 시 자동 로드되는 파일. 세션 종료 전 반드시 업데이트.
> Last updated: 2026-06-05

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
> PreToolUse 훅은 아직 미설정 — 로컬에서 `/update-config` 로 추가 필요.

---

## ⭐ 주미님 액션 아이템 (블로커 — Figma에서 직접)

> Claude가 MCP로 시도했으나 **연결된 Figma가 로컬 폰트를 못 봐서** 막힌 작업. 주미님이 Figma에서 처리해야 진행됨.

### 1. 폰트 Pretendard 패밀리를 Figma에 적용
- **상태:** 결정은 5/31 완료(Pretendard 통일), Git 문서도 반영. **Figma Variables만 미적용.**
- **막힌 이유:** MCP가 연결된 Figma는 **Google Fonts(1723개)만** 보임 → 로컬 전용 폰트인 Pretendard가 안 보임.
- **주미님 할 일:**
  1. macOS `Font Book`에 **Pretendard** + **Pretendard JP**(별도 패키지) 설치 확인
  2. Figma 데스크탑 **완전 종료(Cmd+Q) 후 재실행**
  3. 뜨면 Claude에게 알리기 → 변수 4개 교체(아래) 또는 직접 교체
- **교체 대상 (컬렉션 `typography`, 모드 `5:0`):**
  | Variable ID | 이름 | 현재값 | → 바꿀 값 |
  |---|---|---|---|
  | `VariableID:5:3` | font/family/base | Noto Sans KR | **Pretendard** |
  | `VariableID:5:4` | font/family/latin | Geist | **Pretendard** |
  | `VariableID:7:2` | font/family/japanese | M PLUS 2 | **Pretendard JP** |
  | `VariableID:5:5` | font/family/mono | Noto Sans Mono | 유지 (단 Figma에 미설치 상태 — 확인 필요) |

### 2. color 컬렉션 다크 모드 모드 중복 정리
- `color` 컬렉션에 모드가 **3개**: `Light(2:0)` / `theme-dark(2:1)` / `Dark(118:0)`
- **theme-dark와 Dark가 중복** — 어느 쪽에 값이 채워져 있고 컴포넌트가 어디에 바인딩됐는지 확인 후 하나로 합쳐야 함

---

## 미해결 항목

- [ ] Figma 디자인 전체 리디자인 (주미님 직접) → 완료 후 코드 sync
- [ ] 코드 기반 컴포넌트 라이브러리 기술 스택 확정 → 확정 후 Code Connect (Codex가 Storybook 착수 — 진행 중)
- [ ] FIGMA_TOKEN 등록 완료 + 네트워크 정책 `api.figma.com` 추가 완료 → **새 세션에서 REST API 전환 테스트 필요**
- [ ] 브랜드 컬러 확정 (리디자인 전제조건)
- [ ] **폰트 Pretendard Figma 적용** (주미님, ↑ 액션 아이템 1)
- [ ] **color 다크 모드 모드 중복(theme-dark/Dark) 정리** (↑ 액션 아이템 2)
- [ ] Foundation에 Error states · Motion · Breakpoints 추가 (주미님)
- [ ] PR #3 머지 — `riiid/prism` Rule 18 + 폰트 Pretendard 통일 브랜치, CI 통과 후 머지 판단
- [ ] (구조) workflow-wiki 사이드바에 guides/·playbooks/·worklog.html 링크 연결 — Codex 영역
- [ ] **riiid/prism Button** — Figma component vs Storybook QA surface 어디를 수정할지 결정 (package 변경 금지 전제)
- [ ] `pnpm visual` Chromatic 업로드 승인 여부 결정
- [ ] **PreToolUse 훅 (main push 경고)** — 로컬 `~/.claude/settings.json`에 추가 필요

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
| ENTRIES 배열 → DOM 자동 파생으로 전환 | entry/plan 블록 추가 시 두 군데 수정 필요 = 설계 냄새. 단일 소스로 통합 |
| write-worklog Step 2에서 3개 레포 커밋 전수 조회 | 대화 컨텍스트만 보면 다른 세션 작업을 놓친다 — 2026-06-04 wiki 작업 누락 사례 |
| worklog 뷰어 H2 → 서브탭 자동 생성 | 작업 영역이 여러 개일 때 평문 나열은 읽기 불편 — `##` 섹션만 잘 나눠도 자동 적용 |
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

파일 키: `DcYgJjGAfObOIM4IyrQjgj` | MCP Plugin API는 lazy loading으로 2개만 반환 → REST API 필요

| 페이지 | node ID | 내용 |
|--------|---------|------|
| Components | `0:1` | 컴포넌트 35개 |
| Foundation | 미확인 | Color(light/dark) · Typography · Spacing · Shadow · Markdown · Error states 예정 |
| Icons | `74:10109` | Lucide 전체 + In Use 24개 |
| Pages | 미확인 | 화면 디자인 (준비 중) |
| Image reference | 미확인 | 참조 이미지 모음 |

### Figma Variable 컬렉션 (2026-05-31 조사)

| 컬렉션 | ID | 모드 | 변수 수 |
|--------|-----|------|--------|
| color | `2:2` | Light(2:0) · theme-dark(2:1) · Dark(118:0) ⚠️중복 | 52 |
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

### socra-ai-workflow-wiki
- **v0.15** — 5개 그룹 페이지 분리, scrollspy, 검색 하이라이트, wiki.html 뷰어
- worklog 뷰어: Plan/Log 탭, 캘린더 점, 인터랙티브 체크박스, **H2 → 서브탭 자동 생성**
- ENTRIES 배열 → DOM 자동 파생으로 전환 (entry/plan 블록만 추가하면 자동 반영)
- ⚠️ 사이드바에 guides/·playbooks/·worklog.html 미연결 — Codex 정리 예정

### jumi-worklog
- 스킬 6개 — write-worklog / **session-snapshot(신규)** / **sync-entry(신규)** / prep-meeting / bump-version / record-trap
- write-worklog 스킬 개선: 3개 레포 커밋 전수 조회, 회고 필수화, 서브탭 구조 안내
- **2026-06-04, 2026-06-05 워크로그 완료**

---

## 다음 작업 예정

1. **(주미님)** 폰트 Figma 적용 + theme 모드 중복 정리
2. **riiid/prism Button**: Figma component vs Storybook QA surface 결정
3. **새 세션**: REST API 전환 테스트 → 5페이지 node ID 확인 → Variables dark mode audit
4. PR #3 CI 통과 확인 → 머지 판단
5. Codex Storybook — Button 외 컴포넌트 스토리 확장 + Code Connect
6. Figma Foundation에 Error states / Motion / Breakpoints 추가 (주미님)
7. 브랜드 컬러 확정 (주미님) → 리디자인 시작
8. (wiki) 사이드바 links 연결 (Codex)
