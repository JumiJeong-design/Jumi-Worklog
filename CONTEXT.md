# 현재 상태 스냅샷

> 세션 시작 시 자동 로드되는 파일. 세션 종료 전 반드시 업데이트.
> Last updated: 2026-06-04

---

## 레포 구조

| 레포 | 역할 |
|------|------|
| jumi-worklog | 공동 기록 허브 — 공통 스킬 + 날짜별 워크로그 (`logs/YYYY/MM/`) |
| riiid/prism | Prism package repo — 디자인 시스템, 컴포넌트 계약, 토큰, Storybook, release workflow |
| socra-ai-workflow-guide | 위키 채널 — AI 워크플로우·프로세스·시행착오 |

---

## 🤖 자동화 — 스킬 & 훅 (안 외워도 됨)

> 이 표는 세션 시작 시 자동 로드되니, 무슨 스킬·훅이 있는지 기억 안 나면 여기만 보면 됨.

### 스킬 (트리거 문구만 말하면 실행) — `skills/` 폴더

| 스킬 | 트리거 문구 | 하는 일 |
|------|------------|---------|
| `write-worklog` | "워크로그 써줘", "오늘 정리해줘" | 오늘 작업 요약 → md push → CONTEXT 갱신 → 뷰어 동기화 → Notion 업로드 |
| `prep-meeting` | "미팅 준비해줘", "이번주 요약해줘" | 최근 7일 워크로그 읽어 업무 요약 + 미팅 아젠다 생성 |
| `bump-version` | "버전 올려줘", "배포할게" | socra-ai-workflow-guide 버전 4개 파일 동시 갱신 |
| `record-trap` | "이거 기억해줘", "규칙 추가해줘" | 함정/규칙을 rules.md·agent-rules.md에 기록 |

> Figma MCP 슬래시 스킬(6개)은 워크로그 뷰어 ⚡스킬 탭 참고.

### 훅 (자동 실행) — `~/.claude/settings.json` (로컬 머신, 레포엔 없음)

| 훅 | 시점 | 하는 일 |
|----|------|---------|
| SessionStart | 세션 시작 | 이 CONTEXT.md를 자동 로드 (맥락 자동 파악) |
| Stop | 세션 종료 | 오늘 워크로그가 없으면 종료 차단 (기록 누락 방지) |

> ⚠️ 훅은 로컬 `~/.claude/settings.json`에만 있어 레포·뷰어에 안 보임. 새 머신 세팅 시 재설정 필요.

---

## ⭐ 주미님 액션 아이템 (블로커 — Figma에서 직접)

> Claude가 MCP로 시도했으나 **연결된 Figma가 로컬 폰트를 못 봐서** 막힌 작업. 주미님이 Figma에서 처리해야 진행됨.

### 1. 폰트 Pretendard 패밀리를 Figma에 적용
- **상태:** 결정은 5/31 완료(Pretendard 통일), Git 문서도 반영. **Figma Variables만 미적용.**
- **막힌 이유:** MCP가 연결된 Figma는 **Google Fonts(1723개)만** 보임 → 로컬 전용 폰트인 Pretendard가 안 보임. (Geist·M PLUS 2·Noto Sans KR은 구글폰트라 보였던 것)
- **주미님 할 일:**
  1. macOS `Font Book`에 **Pretendard** + **Pretendard JP**(별도 패키지) 설치 확인
  2. Figma 데스크탑 **완전 종료(Cmd+Q) 후 재실행** — 텍스트 폰트 검색에 `Pretendard` 떠야 함
  3. 뜨면 Claude에게 알리기 → 변수 4개 교체(아래) 또는 직접 교체
- **교체 대상 (컬렉션 `typography`, 모드 `5:0`):**
  | Variable ID | 이름 | 현재값 | → 바꿀 값 |
  |---|---|---|---|
  | `VariableID:5:3` | font/family/base | Noto Sans KR | **Pretendard** |
  | `VariableID:5:4` | font/family/latin | Geist | **Pretendard** |
  | `VariableID:7:2` | font/family/japanese | M PLUS 2 | **Pretendard JP** |
  | `VariableID:5:5` | font/family/mono | Noto Sans Mono | 유지 (단 Figma에 미설치 상태 — 확인 필요) |
- 적용 후 Git 문서(typography.md·rules.md Rule 17) 상태를 ⏳ → ✅로 갱신

### 2. color 컬렉션 다크 모드 모드 중복 정리
- `color` 컬렉션에 모드가 **3개**: `Light(2:0)` / `theme-dark(2:1)` / `Dark(118:0)`
- **theme-dark와 Dark가 중복** — 어느 쪽에 값이 채워져 있고 컴포넌트가 어디에 바인딩됐는지 확인 후 하나로 합쳐야 함 (조사·정리 미완)

---

## 미해결 항목

- [ ] Figma 디자인 전체 리디자인 (주미님 직접) → 완료 후 코드 sync
- [ ] 코드 기반 컴포넌트 라이브러리 기술 스택 확정 → 확정 후 Code Connect (Codex가 Storybook 착수 — 진행 중)
- [ ] FIGMA_TOKEN 등록 완료 + 네트워크 정책 `api.figma.com` 추가 완료 → **새 세션에서 REST API 전환 테스트 필요**
- [ ] 브랜드 컬러 확정 (리디자인 전제조건)
- [ ] **폰트 Pretendard Figma 적용** (주미님, ↑ 액션 아이템 1) — 결정·문서 완료, Figma Variables만 대기
- [ ] **color 다크 모드 모드 중복(theme-dark/Dark) 정리** (↑ 액션 아이템 2)
- [ ] Foundation에 Error states · Motion · Breakpoints 추가 (주미님)
- [ ] PR #3 머지 — `riiid/prism` Rule 18 + 폰트 Pretendard 통일 브랜치, CI 통과 후 머지 판단
- [ ] (구조) workflow-guide 사이드바에 guides/·playbooks/·worklog.html 링크 연결 — Codex 영역
- [ ] **riiid/prism Button** — Figma component vs Storybook QA surface 어디를 수정할지 결정 (package 변경 금지 전제)
- [ ] `pnpm visual` Chromatic 업로드 승인 여부 결정

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
| 에이전트 분담은 맥락 소유권 기준 | Claude/Codex 능력차 아님 — 충돌 회피 + Figma MCP 연결만 실질 차이. 코드=Codex, Figma·워크로그=Claude |
| **폰트 Pretendard 패밀리로 통일** (KR·EN=Pretendard, JP=Pretendard JP, 코드=Noto Sans Mono) | 5/29 Geist+M PLUS 2 혼용은 패밀리가 갈려 한·일·영 톤이 분리됨. orioncactus/pretendard 한 패밀리로 일관성↑·관리 단순. Geist 제거 |
| `riiid/prism` package contract가 현재 SOT | Figma는 visual evidence와 적용 상태 확인에 사용한다. package/component/token/Storybook 계약은 `riiid/prism`의 README, AGENTS, contract 문서를 우선한다 |
| 워크로그 경로 `logs/YYYY/MM/`로 통일 | write-worklog는 루트, CI는 logs/만 검증 → 6일치가 검증 사각지대에 쌓임. 스킬·AGENTS 경로 수정으로 재발 차단 |
| Package-first + Storybook 검증 모델 채택 | `riiid/prism` package contract를 우선하고, Figma evidence는 보조 근거로 사용. Storybook shell은 컴포넌트 CSS와 분리해 격리 렌더 |
| rules.md Rule 18 Auto Layout 필수 | 다국어 텍스트 길이(KR/JA/EN) 변화에 레이아웃이 깨지지 않게 |
| write-worklog에 SHA 무결성 검증(Step 2.5) 추가 | 세션 간 히스토리 충돌로 5/29 rules.md 17규칙이 고아 커밋으로 유실됐다가 복구된 사고 재방지 |
| write-worklog에 worklog.html 자동 동기화(Step 4.6) 추가 | jumi-worklog private이라 GitHub Pages 뷰어와 수동 동기화 필요 → 자동화 |
| ops-plan.md 전면 재작성 | 빌드 트랙만 있고 검증 루프·일본 설계 원칙·품질 게이트가 누락됐었음 |
| Figma REST API 전환 추진 | Plugin API가 5페이지 중 2개만 반환하는 lazy loading 버그 |
| Japan-First 설계 원칙 채택 | 일본을 "조정 대상"이 아닌 "설계 기준"으로 삼아야 나중 현지화 비용 최소화 |
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

> node ID 미확인 항목은 REST API 전환 후 다음 세션에서 확인 예정

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
- docs/ux-principles.md 완료 + a11y 체크리스트 (WCAG 2.1 AA, 터치타겟, 스크린리더)
- design-system/components.md — 35개 컴포넌트 전면 싱크 완료
- design-system/decisions.md — 5/29 폰트 결정 + 5/31 Pretendard 통일 결정 추가
- **design-system/foundation/typography.md — 폰트 Pretendard 패밀리 통일** (KR·EN=Pretendard, JP=Pretendard JP, Geist 제거) [PR #3 브랜치, Figma 반영 대기]
- **design-system/rules.md — 18규칙** (Rule 17 폰트=Pretendard 통일로 갱신, Rule 18 Auto Layout 필수, **PR #3 브랜치, main 미머지**)
- design-system/screens.md — 5개 화면 스캐폴딩
- docs/product-context.md · model-registry.md · agent-rules.md 완료
- Model Profile: 브랜드 아이콘 이미지 fill 완료 (5모델 × 3사이즈)
- **Storybook 착수 (Codex, main)** — Storybook 전용 shell 스타일을 앱/컴포넌트 CSS에서 분리, Button 스토리 + token fallback로 격리 렌더. `.md` 문서만 있던 레포에 실제 코드 시작
- **Button Figma/Storybook 루프 검증 완료** (2026-06-04) — package 변경 금지 원칙 확인, Figma component와 package contract 일치 확인, stale evidence 문서 정리
- Figma 리디자인 대기 중

### socra-ai-workflow-wiki (구 socra-ai-workflow-guide)
- **v0.15** (2026-06-04) — 사이트 구조 전면 개편
  - `ai-workflow-guide.html` → 5개 그룹 페이지로 분리 (guide-basics/setup/build/ops/extensions)
  - wiki 문서 → guide-wiki.html, guide-playbooks.html
  - 빌드 스크립트: scripts/build-guide.py, scripts/build-wiki.py
  - 페이지 간 prev/next 네비게이션
  - wiki 문서 전체 한국어 번역 (영어 섹션 제거)
- scrollspy (현재 섹션 사이드바 하이라이트) + 검색 하이라이트 + 페이지 내 결과 이동 네비게이터
- wiki.html 뷰어 — 마크다운 문서를 사이트 디자인으로 렌더링
- 디자이너-개발자 용어 가이드 추가
- worklog 뷰어 개선: Plan/Log 탭, 캘린더 점, 인터랙티브 체크박스(localStorage)
- figma-mcp-traps.html — 함정 9개 (T8 폰트, T9 Variables 포함)
- 각 worklog 엔트리에 Notion 페이지 링크 연동
- ⚠️ guides/·playbooks/·worklog.html이 사이드바 네비에 미연결 (도달 불가) — Codex 정리 예정

### jumi-worklog
- SessionStart hook (CONTEXT.md 자동 로드) + Stop hook (워크로그 없으면 차단) 완료
- 스킬 4개 — write-worklog / prep-meeting / bump-version / record-trap (↑ 자동화 표 참고)
- write-worklog 스킬 — Step 2.5 SHA 무결성 + Step 4.6 뷰어 동기화
- 워크로그 계층 `logs/YYYY/MM/`로 통일 — 루트 6개 이전 + 5/29 복원 + 스킬/AGENTS 경로 수정
- **Notion 동기화 — 작업 로그 DB(DAX 로그)에 5/31·5/30 페이지 업로드 + 뷰어 Notion 링크 연동** (5/21~5/29 기존 페이지 전부 링크됨)
- ops-plan.md 전면 재작성 완료 (글로벌 서비스 아키텍처)
- **2026-06-04 워크로그 완료** — prism Button 루프 + wiki 구조 개편 + 현황 점검 세션

---

## 다음 작업 예정

1. **(주미님)** 폰트 Figma 적용 + theme 모드 중복 정리 → ↑ 주미님 액션 아이템 참고
2. **riiid/prism Button**: Figma component vs Storybook QA surface 결정 → package 변경 없이 처리할 범위 확정
3. **새 세션**: REST API 전환 테스트 → 5페이지 node ID 전체 확인 → Variables dark mode audit → SessionStart hook 업그레이드
4. PR #3 CI 통과 확인 → 머지 판단 (Rule 18 + 폰트 Pretendard 통일)
5. Codex Storybook 진행 — Button 외 컴포넌트 스토리 확장 + 기술 스택 확정 → Code Connect
6. Figma Foundation에 Error states / Motion / Breakpoints 추가 (주미님)
7. 브랜드 컬러 확정 (주미님) → 리디자인 시작
8. (wiki) 사이드바에 guides/·playbooks/·worklog.html 링크 연결 (Codex)
