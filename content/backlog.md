# 백로그 / 결정 대기

이 백로그는 “언젠가 만들 컴포넌트 목록”이 아니다. 아직 날짜에 박지 않고, 다음 루프에서 무엇을 판단해야 하는지 남기는 곳이다.

## 백로그 원칙

- 컴포넌트 이름보다 제품 질문을 먼저 적는다.
- Figma 탐색안은 승인 전까지 후보로 둔다.
- 개발자가 바로 볼 항목은 Git/Storybook으로 승격된 뒤에 정리한다.
- 페이지와 플로우에서 나온 요구를 바로 공통 컴포넌트 계약으로 올리지 않는다.
- 문서가 늘어날 때는 원문 기록, 운영판, 백로그, 위키/노트, Prism 계약 중 어디에 속하는지 먼저 분류한다.
- 낡은 절차는 삭제보다 `유지 / 병합 / 제거 / 자동화`로 먼저 판정한다.

## 결정 대기 항목

### Answer stack 내구성

- 질문: 여러 모델 답변이 쌓일 때 긴 답변, 로딩, 실패, 모바일 스크롤, 액션바, 다국어가 버티는가?
- 먼저 볼 것: Answer Card, Message Bubble, Model Profile, Bottom Bar 조합
- 완료 조건: 단일 컴포넌트 계약이 아니라 조합 상태 검증 기준 정리

### 의견 시각화 / 차트 UX 탐색

- 질문: 현재 만든 Pick Bubble, Consensus Donut, ScoreBar 탐색안 중 무엇을 계속 볼 것인가?
- 먼저 볼 것: `opinion-viz-motion.html`, Figma 내 `Page design_chart` 탐색 프레임, 실제 카피가 들어간 화면
- 완료 조건: 오늘 당장 Prism 계약으로 올릴 항목과 피그마 탐색에 남길 항목이 구분됨

### 하네스 자체 점검

- 질문: 현재 하네스가 다음 작업을 쉽게 만들고 있는가, 아니면 낡은 제약과 문서 과잉으로 작업을 느리게 만드는가?
- 먼저 볼 것: 에이전트 규칙, Worklog 운영판/백로그, Storybook QA 축, Prism 계약 문서, 최근 실패/회귀 케이스
- 완료 조건: 유지할 규칙, 병합할 문서, 제거할 절차, 자동화할 평가 케이스가 분리됨
- 상태: 🔄 착수(2026-07-13) — Codex 중단 → 단일 에이전트(Claude Code) 전환. 실행 항목은 7/13 plan "트랙 정리": 병렬 규칙 개정 · plan/parallel-codex→main 통합 · 죽은 워크트리(완료)/브랜치 정리 · validate 스크립트 pre-commit 훅. 자동화 원칙: 팬아웃은 3~4개 소규모 기본(7/10 세션 리밋 교훈), 주간 read-only 감사(token:drift+Figma 스팟체크)는 반자동 루틴

### 문서 정리 / 제거 기준

- 질문: 새로 생긴 AI 운영/디자인 문서가 실제로 읽히고 실행 기준으로 쓰이는가?
- 먼저 볼 것: 중복된 가이드, 오래된 계획, source-of-truth가 아닌 임시 메모, 같은 규칙을 반복하는 문서
- 완료 조건: 원문 기록은 Worklog, 반복 가능한 운영 지식은 wiki/notes, 제품 계약은 Prism으로 분리하고 나머지는 병합/아카이브/제거 후보로 정리

### 디자인 퀄 고도화 (현재 시각 완성도 ↑) — 6/24 주미 검토 추가

- 질문: 지금 안 이쁜 화면 요소들의 UX/UI 완성도를 어디까지·어떤 순서로 올릴 것인가?
- 포함: 차트 디자인 고도화, 차트/추가질문 등 채팅 요소, 홈·채팅뷰 디테일, 히스토리 글씨 넘침 영역 컴포넌트화, 가설 답변 카드, 모델별 한줄의견 영역 줄이기, AI 공통의견
- 먼저 볼 것: 위 "의견 시각화 / 차트 UX 탐색" · "Answer stack 내구성" 항목, 실제 화면 스크린샷
- 완료 조건: 화면/요소 1개라도 전·후 비교가 되는 퀄 기준과 우선순위

### 플로우/시나리오 → Storybook Flows — 6/24 주미 검토 추가

- 질문: 스플래시·온보딩·탈퇴·로그아웃 같은 "흐름"을 Storybook Flows에 어떤 단위로 올릴 것인가?
- 먼저 볼 것: 기존 Pages 스토리, Flows/Prototype 후보 구조, 로그인 플로우(Figma 완료분)
- 완료 조건: 시나리오 1개를 Flows 스토리로 올리는 방식 1개 확정

### 컴포넌트 state 제어 뷰 + Chromatic 승인 루프 — 6/24 주미 검토 추가

- 질문(state 뷰): state에 따른 디자인 변화를 Storybook Controls/args로 제어해 보는 뷰를 어디까지 만들 것인가?
- 질문(승인 루프): Chromatic 시각 승인(누가·언제·무엇 기준으로 baseline 수락)을 어떻게 운영할 것인가?
- 먼저 볼 것: 기존 stories argTypes 사용도, 6/23 "Chromatic에서 볼 항목"·locale QA 범위, Build #66 baseline 미수락 상태
- 완료 조건: 대표 컴포넌트 1~2개 state 제어 뷰 + 승인 기준 체크리스트(※ Chromatic 로그인 접근은 주미)

### 동적 인터랙션 배경/그래픽 (React 실험) — 6/24 주미 검토 추가

- 질문: 앱에 React 기반 동적 인터랙션 배경/그래픽 요소를 도입할 가치가 있는가? (정체성·완성도 vs 성능·노이즈)
- 먼저 볼 것: 홈/스플래시 후보 화면, 모션 톤(`opinion-viz-motion.html`)
- 완료 조건: 배경 실험 1안 + 도입/보류 판단 (GlassSurface 레시피와는 별개 작업)

### 로고/브랜딩 가이드 문서 — 6/24 주미 검토 추가

- 질문: 향후 로고/브랜딩 제작을 위한 최소 가이드(컬러·타입·톤)를 지금 어느 수준으로 잡을 것인가?
- 먼저 볼 것: 기존 foundation 토큰, Socra 네이밍/톤
- 완료 조건: 1페이지 브랜딩 가이드 초안

### 기획서·PoC·하네스 연동 (대기 · 주미 직접) — 6/24 주미 검토 추가

- 질문: 기획서·PoC가 공유되면 디자인-개발 루프 테스트와 Figma 추가요소 탐색을 어떻게 돌릴 것인가?
- 상태: ⏸ 기획서·PoC 공유 대기(PM 입력) · ai workflow/하네스 관점 글감 업로드는 주미 직접
- 완료 조건: 공유 시점에 루프 테스트 1회 + Figma 추가요소 목록

### Figma 디자인 다듬어서 정식으로 올릴지 결정 — 투표/추천질문 · 출처 — 6/25 주미 정리

- **둘 다 같은 일**: Figma엔 디자인을 이미 만들어 둠 → 주미가 보고 **디자인부터 다듬어 확정** → 확정되면 코드(prism 패키지)로 옮기고(포팅) Storybook에 올림. 지금은 Figma만 있고 코드엔 없음. **다듬기 전엔 포팅 안 함.**
- **투표 결과 / 추천 질문** (`VoteBar`·`VoteResult`·`QuestionItem`·`RecommendedQuestions`·`ChipGroup`)
  - 지금: Figma 마스터 + 계약 초안 있음. 실험 페이지(`🧪 Opinion Viz`)에 있음.
  - 남은 것: 디자인 다듬어 확정 → 정식 페이지(`✅ Components`)로 올릴지 결정 → 코드 포팅 + Storybook.
- **출처 표기** (`SourceChip`·`SourceCard`·`SourcePopover`)
  - 지금: Figma 1차 생성(6/24), 신규 색 없이 기존 토큰만.
  - 디자인에서 정할 4개: 칩 글자 톤 / 다크 버전 / 출처 1개일 때 헤더 정렬 / 카드 단독·팝오버용 분리.
  - 남은 것: 위 4개 확정 → `component-contracts/citation.md` 작성 → 코드 포팅. (본문 마크다운 연결은 Codex와 미리 맞춤.)
- 완료 조건: 두 묶음 각각 디자인 확정 후 "정식으로 올릴지" Go/No-go 판단 → Go면 코드 포팅.

### neutral 색 단일화 리팩터 (코드=Figma) — 6/25 발생, Codex 트랙

- 질문: 코드 회색을 Figma처럼 `neutral` 한 줄로 통일할 것인가? 현재 코드 = `neutral`(4단계, mode-aware) + `gray`(11단계, 단일값) 두 줄 / Figma = `neutral` 한 줄.
- 근거: code=Figma 단일출처 + `neutral`은 mode-aware라 다크 자동정합(`gray` 직접 사용은 다크 부채).
- 1단계(작게·안전): 코드 `neutral`에 빠진 단계(50/100/150/300/400/600/800)를 Figma Light/Dark 값으로 추가 → 드리프트 6칸→0, `scripts/figma-token-drift.mjs`의 `KNOWN_ORPHANS` 비움.
- 2단계(큰 작업): `gray` 사용처 64곳 → `neutral` 묶음별 이관 + Chromatic 시각회귀 검증. "다크에서도 고정 의도된 gray"는 가려 남김. `gray` 폐기는 최후.
- 소유/주의: Codex 트랙(`*.tokens.json` 단일소유 — 6/25 외부 원복 충돌 1회). 값 출처 = MCP `get_variable_defs`(REST 403). 대표 기록 = prism `docs/plans/10-design-system-followup-2026-06.md` 2026-06-25 "neutral 풀 램프 아키텍처" 절.
- 완료 조건: 드리프트 "새 0" 유지 + (2단계 시) gray 사용처 이관 완료 + Chromatic 통과.

### 7/01 이월 — Overlay 정리 · PromptPill · 후속 결정 (트랙 rebase 후)

- 상태: 트랙 rebase 완료로 아래가 활성 plan에서 백로그로 내려옴. 대부분 "결정 → 실행" 대기. **(7/01) 한동안 코드 파킹 · 탐색 위주 모드 — `plan/parallel-codex` 트랙은 의도적 미merge(feature 브랜치, origin + 3중 백업), "까먹은 일감" 아님. main 반영은 나중에 Overlay 정리 묶음과 함께.**
- **홈 배경 Aurora vs Ripple 채택** → 채택 후 Overlay 정리 묶음(미채택 탐색물 제거 · Home Prism Hero WebGL 롤백 · 발행 PR #22 닫기). 둘 다 탐색 완료, 지금 트랙에 "미확정" 라벨로 실림. (위 "동적 인터랙션 배경/그래픽" 항목의 구체화)
- **PromptPill 후속** — engaged 대비(`neutral/150`) OK 확인 · `TabItem` radius 24→16 동기화(컴포넌트) · Figma 프리뷰 프레임 정리 · 패키지 포팅(위 "투표/추천질문" 승격에 합류). Figma `Prompt Pill` `3190:1395`, prism plan-11 §9-1.
- **입력바 progressive blur 채택** — 탐색·보존(`533445f`), 적용 시 `BottomBar`+`ChatPage` 2곳.
- **Announcement Popover · 알림 Badge dot 채택** — 기획(promo 필요성) 선행, prism `plan-13`.
- **ChatInputBar 미결 디테일** — 툴팁 단축키 표시 · mic 버튼 · focused 글로우 색.
- **계약초안 5개** — 위 "Figma 디자인 다듬어서 정식으로 올릴지 — 투표/추천질문 · 출처" 항목과 동일(중복 안 만듦).
- **Chromatic 88 accept/flag** — 위 "컴포넌트 state 제어 뷰 + Chromatic 승인 루프" 항목. 리뷰는 스냅샷 0=무료라 지금 가능(TurboSnap은 7/01 적용 완료).
- 완료 조건: 각 항목 Go/No-go → Go면 실행.

### Quick/Deep 결과 화면 확정 — 라벨·리포트·후킹 (7/8 아이데이션 승격)

- 질문: 결과 화면에서 ① 정량 vs 정성 라벨을 병기할지 택일할지(퀵은 3모델이라 정량 기준 모호), ② 퀵 세 답변의 공통점·차이점을 한 줄 요약으로 충분한지, ③ 딥 후킹 클릭 시 내용 수정 후 딥 전환 경로, ④ 전문가 매칭 실패 케이스에서 딥 강조 방향을 어떻게 구분할지?
- 먼저 볼 것: 7/8 log 5단계 아이데이션(§5 "2차 요약본-7/9 미팅 피드백"), Figma `2211:9469`, plan-16 §3, 기존 "의견 시각화/차트 UX 탐색"·"디자인 퀄 고도화" 카드
- 완료 조건: 위 4개 각각 방향 확정 → Quick/Deep 결과 화면 컴포넌트 계약에 반영
- 상태: ⏸ 보류(2026-07-13 주미 — 방향 픽스 아직). 아이데이션은 2차 요약본(7/9 미팅 피드백 반영)까지 진행됨. 갭 감사 P0 선설계(가중치 막대·리포트 카드·스텝퍼)도 방향 확정 후 착수

### Quick/Deep MVP 기획 Open Issues (착수 전 확정) — 7/8 아이데이션 승격

- 질문: 디자인·개발 착수 전 확정 필요 — 모드명 JP 보조라벨(かんたん/じっくり) 병기 여부, 답변 생성시간/타임아웃 정책, 시각화 그래프 형태(막대/도넛), RAG 1차 지원 도메인, 에이전트 초기 구성(MVP=롤 에이전트), 온보딩·비로그인 전환 장치는 어디까지?
- 먼저 볼 것: 7/8 log §2 "기획서 아이데이션/질문"(화면·상태 인벤토리 + Open Issues), Figma `5211:3276`
- 완료 조건: 각 이슈 결정 → 화면/상태 사양 반영
- 상태: ⏸ 일부 PM 입력 대기 (계정·인증·법무(APPI)·BM·MVP 일정(2026-09)은 주미/PM 직접)

## 잔여 (결정 완료·마무리만)

### Storybook 정보구조 재정리

- 상태: 잔여 (본체 6/26 완료)
- 본체 완료(2026-06-26): `Components/*`를 `Base UI`+`Chat`/`History`/`Navigation`/`Settings`(+예약 Citation/Decision)로 분할, Storybook title·Figma 섹션 정합. top-level은 이미 소비면(Foundations/Components) vs 검토면(Pages/Flows/Patterns) 분리됨. 근거 `riiid/prism` `storybook-map.md`, 상세 worklog 2026-06-26.
- 잔여(슬림): ① "개발자가 자주 보는 API/Docs 위치"를 명시 감사해 소비면/검토면 분리에 반영(현 구조상 충돌은 없음), ② `Flows/Prototype` 세부 명명 적용 여부.

### GlassSurface 커서 추적 sheen — 6/26 테스트 후 보류

- 상태: 잔여 (테스트 완료 · 미채택)
- 결과(2026-06-26): Explorations 데모 완성(의존성0 — pointermove + rAF lerp "출렁" + CSS 변수, 데스크톱 한정, reduced-motion 스냅, GlassSurface 본체 미변경). 기술 검증 OK.
- 보류 이유: Socra 모바일 퍼스트. 커서(hover) 전제 효과라 모바일에선 가치 0(터치=추적 포인터 없음→기본 글래스 폴백). 재고 조건 = 데스크톱/웹 표면 비중↑. 재구현 비용 낮음(의존성0), 코드는 `riiid/prism` Explorations 스토리로 박제.
