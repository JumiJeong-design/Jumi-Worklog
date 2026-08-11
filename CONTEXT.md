# 현재 상태 스냅샷

> 새 세션이 현재 기준과 위험 게이트만 빠르게 잡도록 돕는 파일.
> 상세 이력은 `logs/YYYY/MM/YYYY-MM-DD.md`와 각 repo git history를 본다.
> Last updated: 2026-08-11
>
> 이 파일은 **누적 이력이 아니라 스냅샷**이다. 날짜별 경과는 `logs/`가 정본이므로 여기에 날짜 섹션을 쌓지 않고, 현재 상태 한 벌만 덮어쓴다(2026-07-14 정리 — 6/12~6/23 날짜 섹션 6개가 누적돼 worklog와 중복되고 갱신이 밀리던 것을 접음. 2026-08-10 정리 — `Last updated` 줄에 세션 요약이 괄호로 6천 자까지 쌓여 날짜만 남김. **이 줄에는 날짜만 쓴다** — 세션 요약은 worklog로, 상태 변화는 아래 본문 섹션 덮어쓰기로 간다. 2026-08-11 전면 갱신 — 해소된 취소선 항목과 배포 초기 서사를 걷어내고 현행만 남김).

---

## 시작 루틴

1. `scripts/check-context-freshness.sh`를 실행한다.
2. 최신 worklog 1-2개와 필요한 public viewer plan을 확인한다.
3. 작업 대상 repo에서 `git status -sb`와 최근 커밋을 확인한다.
4. 피그마나 코드 write 전에 해당 repo의 최신 규칙 문서를 먼저 읽는다.
5. 문서 구조 변경은 `docs/00-document-role-map.md` 기준으로 진행한다.

`CONTEXT.md`가 최신 worklog보다 오래됐다는 경고가 나오면 이 파일은 stale snapshot으로 취급한다.

---

## 하드 룰

| 규칙 | 올바른 행동 |
| --- | --- |
| 계획은 실행 승인과 다르다 | plan/worklog/backlog 항목만 보고 피그마나 코드에 write하지 않는다. |
| 피그마 시각 변경은 승인 게이트를 거친다 | read-only 감사 → 변경안/영향 범위/rollback 범위 보고 → 주미님 명시 승인 뒤 write. |
| CONTEXT만 믿지 않는다 | 최신 worklog, public viewer, git 상태, 필요 시 Figma 실제 상태를 교차 확인한다. |
| N군데 동시 수정은 설계 냄새다 | 같은 데이터를 여러 곳에 추가해야 하면 구조 개선이나 단일 출처를 먼저 검토한다. |
| worklog 수정은 public viewer까지가 완료다 | 원본 MD, `site/worklog.html`, commit/push, 공개 URL, 월 단위 검증까지 확인한다. |
| 넓은 요청은 먼저 범위를 나눈다 | 분석/계획/수정/배포/승격을 한 번에 섞지 않고, write가 필요한 지점을 분리한다. |

---

## repo 역할

| repo | 역할 | 현재 기준 |
| --- | --- | --- |
| `jumi-worklog` | 날짜별 raw worklog, 세션 스냅샷, 공통 스킬 | 원본 기록. 중복 초안은 커밋하지 않는다. |
| `riiid/prism` / `socraAI_product design` | Prism package, 디자인 시스템 계약, token, Storybook, release | 최종 반영 대상은 `https://github.com/riiid/prism`. 로컬 `socraAI_product design` 원격 상태는 작업 전 재확인한다. |
| `socra-ai-workflow-wiki` | 반복 가능한 AI workflow 지식과 public viewer | 운영 교훈만 승격. 제품/컴포넌트 계약을 중복하지 않는다. |

---

## 현재 상태 (2026-08-11 기준)

### 운영 모드

- **Claude Code 단일 에이전트** 체제다(2026-07-13~, Codex 병행 중단). 브랜치 전략은 main-first: 짧은 feature 브랜치 → PR → main. 장수 병렬 트랙(`plan/parallel-codex`류)은 새로 만들지 않는다.
- 같은 세션에서 병렬이 필요하면 서브에이전트 + `git worktree` 격리를 쓰되 팬아웃은 3~4개 소규모가 기본이다. **감사·리서치류는 인라인이 기본**(7/10·7/13 대규모 팬아웃이 두 번 다 세션리밋에 걸렸다).
- 2-에이전트 병렬 규칙은 휴면 상태로 보존돼 있다(정본: `riiid/prism`의 `AGENTS.md`). `socra-ai-workflow-wiki`의 핸드오프/컴포넌트 플레이북과 `AGENTS.md`도 2026-07-16에 같은 (휴면) 패턴으로 맞췄다.

### `riiid/prism`

- **최신 배포는 `@riiid/prism@0.10.0`(2026-08-11).** 배포 금지 방침은 07-30에 해제됐고 08-10~11에 0.7.0→0.10.0 네 번 연속 발행됐다. 미배포 changeset 2건(text-* 토큰 매핑·Comment chevron)이 다음 버전 PR로 대기 중.
- 배포 경로는 **GitHub Actions + npm Trusted Publishing(OIDC)**이다. latest = Version PR을 `main`에 머지 / canary = `canary/**` 브랜치 push + changeset. 정본은 `docs/release.md`.
  - 패키지는 `--access restricted`라 **미인증 `npm view`가 E404를 내는 게 정상**이다 — 발행 실패로 오진하지 않는다. 확인은 워크플로 로그로 한다.
  - **빌드 산출물을 저장소에 커밋하지 않는다**(산출물 브랜치 `prism-dist`는 07-31 은퇴).
- **Tailwind `text-*` 크기 유틸리티가 08-11부터 `--font-size-*` 토큰값으로 렌더된다(#123).** 그전엔 `@theme` 미등재로 Tailwind 내장 기본값이 나가고 있었다(`lg` 18≠17, `2xl` 24≠22, markdown h1 36≠28, `text-13`류는 규칙 미생성 — 패키지 42곳). `build.ts` `publicThemeTokens`에 별칭 16종 등재로 일괄 교정. **새 크기 토큰을 추가하면 `--text-*` 별칭도 같이 등재해야 유틸리티가 생긴다.** 정본 plan-23 「text-* 전수 실측」 절.
- **화면 가장자리 페이드 = `EdgeBand`(08-11 신설, PR #143 대기).** 스크롤 콘텐츠가 위/아래 끝에서 표면색으로 잦아든다. 색은 `color.bg.surface-fade-{10,50,90}`(→ `--color-surface-fade-*`), 피그마 `Edge Band`(`4432:2063`) + 변수 `semantic/surface/fade-*`(게시 완료). 등장 판정은 **소비처가 `scrollTop > 0`으로** 넘긴다. **progressive blur는 탈락**(부분 블러가 한글에서 렌더 결함으로 읽히고, 색의 무게를 안 없앤다) — 코드는 탈락 기록으로 남아 있으니 되살리지 말 것. 모바일 하단은 `BottomBar`가 같은 램프를 이미 깔아 쓰지 않는다.
  - 이름이 `scrim`이 아닌 이유: `color.overlay.scrim`은 **모달 뒤 검정 dim**이다. 가장자리는 dim이 아니라 페이드다.
- **Chromatic은 월 스냅샷 쿼터 소진 상태다(08-10).** 머지분이 전부 UI Review pending — 주미님 "당장은 눈으로 QA하니 비블로커". 쿼터 해제 시 main 전체 비교 1회, 육안 우선순위는 `ModelProfile`을 쓰는 5곳(MessageBubble·ProfileGroup·SheetProfile·Comment·ReportParticipants). CI 자동 업로드는 없고 필요할 때 `pnpm visual` 수동 실행이 기준.
- 문서 형식 게이트는 `.githooks/pre-commit`(→ `scripts/validate-design-system.sh`)으로 커밋 전 자동 실행된다. 새 클론은 `git config core.hooksPath .githooks` 필요.
- 뱃지·칩 기준선: **눌러서 상태가 바뀌면 `Chip`, 그냥 읽는 라벨이면 `BadgeLabel`**(정본 `docs/plans/20` §5-1~5-3). 패키지엔 `Badge`·`BadgeLabel` 포팅 완료, `Button/DeepCTA`는 Figma만.
- `chart/*` semantic은 **종결됐다(08-09)** — 코드 `color.band.*`+`color.badge.{band}.*`, 피그마 `chart/band·badge` 모두 main/DS에 있다. 다만 `apps/storybook/src/stories/chartPalette.ts`의 5색은 **폐기된 시리즈 팔레트**라 교체 대상이다.
- **반응형 레이아웃 기준(2026-08-06~).** DS `Layout` 페이지(`4054:1848`)가 정본, 코드 계약은 `packages/prism/token-contract.md` "레이아웃 `layout.*`" 절, 근거는 `design-system/foundation/layout.md`.
  - 브레이크포인트 Mobile <768 / Tablet 768–1279 / Desktop ≥1280. 768은 토큰 `{mo,pc}` 분기와 같고, **1280은 토큰이 아니다**(`@media` 조건은 `var()`를 못 받는다).
  - **컬럼은 한 겹이 아니다** — 800(평문 답변) 안에서 리포트 560·투표/폼 520이 자기 상한을 갖는다. 토큰 `--layout-column-{text,card,decision}` + 유틸리티 `max-w-{text,card,decision}`.
  - 웹 셸: 사이드바 260/rail 60 + gutter 8 → **zone = width + gutter×2**(276/76). max-width는 뷰포트가 아니라 **콘텐츠 영역** 기준.
  - 모바일 바텀시트의 웹 대체는 시트 성격으로 가른다(LAYOUT 05): 짧은 액션 Popover 240 / 결정 차단 Dialog 400·660 / 대조하며 읽기 Side Panel 400·520.
  - **유저 버블은 두 메커니즘 분업이다** — 상자 max/min은 `layout` 변수(Mobile/Web 모드), 텍스트 줄바꿈 캡은 `_TextBubble`의 `breakpoint=mo|web` variant. **하나로 합치려다 되돌린 이력이 있으니 다시 합치지 말 것.**
- **제품 타이포 램프에 Bold가 없다.** 강조 굵기는 전부 SemiBold이고 Bold는 `foundation/*`(DS 문서용)과 `chat/h1`뿐이다. 15px 강조는 `body/md-sb`.

### 열려 있는 결정 (진행을 막고 있는 것)

- **색 규칙 잔여 2건** — 규칙 자체는 08-03 확정(구간 3색: 다수·압도 `blue/500` / 접전 `orange/500` / 일부 `purple/400` / 소수 라임, 판정 기준 v1.0.3). 남은 것: ① 라임 소수 바가 트랙 대비 1.19로 3:1 미달 — 색으로 못 풀어 stroke 같은 비색 수단 결정 필요 ② 소수 3개 이상이면 스택바 범례가 전부 라임이라 구분 불가.
- **히어로 레전드 유무**(07-28 이후 휴면) — 비교 스토리 제작 완료, 채택만 남음. 흡수 전환 4컷이 "레전드 포함" 기준이라 뒤집히면 재작업.
- **`Chip` 축 확장 — Figma 결정 2건 선행**(08-03 이후 휴면) — radius 사각 variant 부재 / 눌린 색 패키지 파랑 vs Figma 검정 / md 텍스트 16 vs 17. 정본을 정해야 코드를 고칠 수 있다.
- **processing 중 전송 처리**(기획 확정 대기) — 오프라인 배너 철회로 "전송만 잠근다"의 근거가 소멸. 컴포저 processing 비교 시안·스토리북 processing 전이 데모가 이것 대기. 단 **"에러 칩이 남아 있으면 전송 불가"는 §3.4 명문이라 유효** — 둘을 섞지 않는다.
- **입력창 글로우 — 4안 픽 대기**(08-11) — `Explorations/Home Composer Glow`에 A 대조 / B 상시 브랜드 링+발광 / C 포커스 전용 / D Deep On 기준선 제작 완료(#130). 세그먼트 토글 폐기와는 분리된 결정.
- **`ProfileGroup` hover — 3안 픽 대기**(08-11) — `Explorations/ProfileGroup Hover`에 A 배경 필 / B 보더 강조 / C 리프트 제작 완료(#130). 픽 후 피그마 `state=hover` variant 신설(write 게이트) → 코드 순서.
- **§5.3 주미님 확인 4건**(게이트/토스트 문구·세션 승계 고지·비로그인 복구 불가 문구·전송 실패 opacity 20%) + **PM 노트 전달**(`7833:97335`, S9-3 정의 한 줄 수정 포함).
- 기획서(`docs/20-socra-product-spec-2026-07.md`) [Open Issues] — 타임아웃·RAG 도메인·계정/인증·APPI는 PM/법무 대기라 디자인 착수 불가.
- 열린 PR 처분 — **#35**(plan-19 일정 v4, CONFLICTING — rebase/close 미정) · **#13**(codex Chip locale, draft — close 유력).

**종결 — 되돌리기 금지(폐기 기록):**

- **오프라인 배너·전송 비활성 승격 철회(08-10)** — 기획서 §5.3에 없는 표면이 자체 승인으로 들어와 있었다. "전송 시도 → 토스트 안내 + 입력 보존"이 정본. 시안·정합표·`error/offline-banner` 변수까지 정리 완료. **승격을 재개하지 말 것.**
- 색 "강조 여부 2단"안 폐기(08-03) — `docs/plans/16` §8만 읽으면 반대로 간다. 폐기 표시가 문서 정정 잔업.
- 전송 실패 전용 프레임 삭제 — S9 케이스로 일원화(08-09).
- Quick|Deep 세그먼트 토글 탐색 폐기(08-11) — v1.0.6 'Deep On/Off 스위치 하나' 명문. 현행 Deep 칩이 정답.
- 웹 빠르게 시작하기 = 키워드 칩(08-11, §4.1 명문·주미님 확정) — 탭+문장 필 판은 참고용 보존.
- 로그인 first-screen = LINE·Google·이메일 3수단, Apple은 앱 단계(08-11, §3.1) — 6/23 결정 노트(JP=LINE·Apple·Google)는 대체됨.
- **`Popover`·`Menu`는 `className` 폭 지정을 지원하지 않는다(08-11 확정, #130)** — `GlassSurface` 인라인 width가 이기는 구조를 API 모순으로 보지 않고 계약으로 확정했다. 폭은 `style` 또는 변수로 준다. **className 지원으로 되돌리지 말 것.**
- 6자리 코드 입력 = `OTP Input` 신설로 종결(08-11) — `Text Field` 6개 조합안 폐기. DS `4407:2099` 게시 완료, 계약 `otp-input.md`.
- 설정 화면 스펙 외 항목 제거(08-11, §4.12·§3.2) — 구독 섹션(MVP 무료)·알림(웹 MVP 미포함)·로그아웃(=[내 계정] 메뉴 소관) 제거. 다크 모드 토글만 재량 유지.

### 알려진 캐비엇

- Product 파일 홈 화면(`5027:3909`)의 컴포저는 DS 라이브러리 마스터가 아니라 **Product 파일 내 로컬 카피**(`5338:50726`)를 참조한다(포크 상태 — DS 마스터를 고쳐도 전파 안 됨). 라이브러리 publish 후 재연결은 defer.
- 죽은 로컬 브랜치 ~20개(`codex/*`·`canary/*`)가 남아 있다. 정리 시 머지 여부를 개별 확인한다.
- **같은 폴더에서 두 세션이 동시에 작업하는 일이 반복된다(07-31·08-03·08-10~11).** 대응: 편집 중인 파일은 먼저 별도 브랜치에 스냅샷해 두고, 브랜치 전환·머지는 **전부 `git worktree`로 분리**한다. 공유 체크아웃에서 브랜치를 갈아타면 남의 미커밋 작업이 사라진다.
- **"PR 냈다"를 완료로 쓰지 않는다(08-03).** 완료 처리한 세 건이 전부 OPEN이었고 하나는 CI가 깨져 있었다. 로컬 `pnpm typecheck`/`pnpm test`는 CI 게이트가 아니다 — CI가 도는 건 **`pnpm check`**다.
- **이월 문서는 반나절 만에 낡는다(08-11).** 이월 항목 착수 전 해당 plan 상태 줄과 최근 머지를 먼저 본다 — 피어 세션이 밤사이 전건 완료한 항목을 다시 착수할 뻔했다.
- **버전 관리 밖 작업이 실제로 쌓인다.** 소비처가 없는 탐색물은 PR에 섞지 말고 wip 브랜치로 뺀다(예: `wip/verdict-engine-second-target`).
- **라이브러리 업데이트가 와도 기존 인스턴스는 옛 값을 들고 있다(2026-08-06).** 게시·수락이 끝났는데 버블 폭이 안 바뀌었다 — 인스턴스의 `boundVariables`에서 maxWidth/minWidth가 빠져 있었고 모드·variant 어느 쪽도 안 먹었다. **부모 인스턴스에 `resetOverrides()`** 해야 복구되며, 텍스트 override가 함께 날아가므로 **저장→리셋→복원** 절차가 필요하다. 또 업데이트 후 중첩 인스턴스 **이름이 바뀐다**(`BubbleBox`→`_TextBubble`) — 이름 대신 `componentProperties` 보유 여부로 찾는다.
- **라이브러리 publish는 플러그인 API에 없다.** DS에 컴포넌트를 만들어도 주미님이 Figma에서 직접 게시해야 제품 파일이 본다. 신설 → 게시 대기 → 인스턴스 교체가 기본 리듬이다.
- **게시된 variant를 지우면 다른 세션 인스턴스가 뜬다(07-28).** 축 개편 전 소비자 확인.
- **plan-20 감사표 수치를 근거로 쓰기 전에 다시 센다(2026-08-03).** Tier 1 재사용 잔여는 **5종**이다 — `MessageBubble`·`Button/ActionBar`는 Deep 경로에선 아직 인라인이고, `HeaderNavBar`도 3곳 중 2곳만 치환됐다(`DeepWaitVote.stories.tsx:357`). 같은 날 "6종→4종→3종"으로 두 번 줄였는데 두 번 다 낙관적이었다.
- **한 페이지에서 못 찾은 걸 "파일에 없다"로 쓰지 않는다(2026-08-03).** `ModelChip`·`ChipGroup`이 ✅ Components 검색에 0건이라 "Figma에 없다"고 단정했는데 **틀렸다** — `🧪 Opinion Viz (ideation)` 페이지라 안 잡혔을 뿐이다. 남은 건 제작이 아니라 **ideation → ✅ Components 승격**이다.
- **병렬 팬아웃은 Figma MCP 의존 작업으로 채우지 않는다(2026-08-03).** 조사 4건을 서브에이전트로 갈랐다가 전부 MCP 재연결에 걸려 3시간 반 동안 진전 0. 나눌 땐 **외부 의존이 없는 쪽부터** 가른다.
- **게시 스냅샷은 DS 현행이 아니다(2026-08-10).** `importComponentSetByKeyAsync`로 본 variant 목록은 **마지막 게시 시점**이다. **세트에 변형이 없으면 "왜 없는지"를 계약 문서에서 먼저 확인한다.**
- **원격 컴포넌트는 노드 ID가 아니라 component key로 인용한다(2026-08-10).** 원격 DS 컴포넌트의 제품 파일 프록시 ID는 어느 쪽에서도 안 열려 "소멸"로 오진하기 쉽다. `design-system/rules.md` 30번.
- **인스턴스 감사는 중첩 포함이 기본이다(2026-08-10).** 최상위만 훑으면 중첩 안의 고아를 놓친다.
- **드리프트가 규칙적이면 상위 합성 마스터를 의심한다(2026-08-10).** 값이 variant별로 깔끔히 갈리면 인스턴스 오버라이드가 아니라 마스터 내부값이다 — DS 24노드 수정으로 제품 230개가 자동 정합된 사례. `design-system/rules.md` 32번.
- **`swapComponent`는 텍스트 override를 흘린다(2026-08-09·08-10 두 번).** 스왑 전후 텍스트 대조 게이트(NFC normalize) 없이는 파일명·placeholder가 마스터 기본값으로 조용히 덮인다. `design-system/rules.md` 31번.
- **변수 바인딩된 paint의 opacity(<1)는 게시·인스턴스 경계에서 소실된다(2026-08-10).** 틴트는 alpha가 아니라 그 값을 가진 컬러 토큰을 바인딩한다. 게시 포함 여부 판정은 DS에서 `getPublishStatusAsync`(CURRENT/CHANGED) 실측으로 한다.
- **제품 파일에 붙은 기획서 보드 이미지는 구버전 스냅샷이다(2026-08-11).** 카피·규칙 정합의 근거는 항상 노션 버전 폴더 최신본 원문이다.
- **invisible 인스턴스 자식은 기본 스캔에서 빠진다(2026-08-11).** 전수 감사·수정 스크립트는 `figma.skipInvisibleInstanceChildren = false`를 명시하고 시작한다.
- **컴포넌트 TEXT 속성이 걸린 라벨은 `characters` 쓰면 마스터 기본값으로 리셋된다(2026-08-11).** 인스턴스 복제 후 라벨을 바꿀 땐 `setProperties({'label#…': …})`로 속성 단위로 쓴다. 같은 이유로 라이브러리 업데이트 수락 전 인스턴스는 `setProperties`가 새 variant를 못 봐서 실패한다 — variant key `importComponentByKeyAsync` + `swapComponent`로 우회(텍스트 NFC 대조 게이트 필수).
- **게시 다이얼로그는 해제 선택을 기억한다(2026-08-11, 추정).** 로컬 상태가 정상인데 CHANGED가 반복되면 파일이 아니라 게시 선택 목록을 본다.
- **"위반 N건" 감사 count는 판정 전 숫자다(2026-08-11).** stroke "위반 43건"의 실제 수정 대상은 9노드였다 — 계약·코드·규칙 3자 대조 없이 count로 달려들면 계약을 깬다.
- **공유 워킹트리에서 `git add -A` 금지(2026-08-11 실제 사고).** Claude 세션 둘이 같은 폴더에서 일하다 옆 세션 작업 7파일이 남의 PR로 갔고, 저녁엔 역방향으로 옆 세션이 내 브랜치에 커밋했다. 경로를 명시해 커밋하고, 두 번째 세션은 시작할 때 `git worktree`로 분리한다. 복구 레시피는 `docs/agent-parallel-rules.md`(휴면 아님 — 08-11 정정).
- **헤드리스 브라우저로 판정 못 하는 게 있다(2026-08-11).** Playwright WebKit은 backdrop-filter를 아예 못 그리고(`CSS.supports`는 true), 헤드리스 Chromium의 rAF는 vsync에 고정돼 페인트 비용이 안 잡힌다. 기능 판정 전에 **대조군**으로 도구 한계부터 확인한다.
- **컴포넌트 root가 `relative`면 className의 `absolute`는 안 먹는다(2026-08-11).** Tailwind 출력 순서상 `.relative`가 이긴다. 오버레이는 래퍼 div로 띄운다 — `Pages/Chat` Mobile의 BottomBar가 이 이유로 실제로는 안 떠 있었다.
- **카운트 비교 전에 가시성 필터부터.** `visible:false` 잔재와 타 제품 보드가 섞이면 수치가 오염된다.

---

## 다음 후보 작업

아래는 후보/백로그다. 실제 실행 전 범위와 승인 상태를 다시 확인한다. 상세 to-do는 public viewer의 계획 탭을 정본으로 본다.

- **[내일] DS `Bottom Bar`의 `Dark` variant 축 → 피그마 모드 전환.** 피그마는 다크를 variant로 고르고 코드는 모드로 뒤집는 불일치. 영향 실측 = 인스턴스 4개뿐(`chat/chart` 103개 전부 `Dark=false`, `home/history` 4개만 `true`). 마스터를 `semantic/surface/fade-*`로 재바인딩 → 축 제거 → 홈 다크 컷 3장 모드 명시. 죽은 `Toolbar` 축(옵션 `off` 하나)도 같이. 되돌리기가 번거로워 컷이 적은 지금이 싸다.
- **[머지 확인] plan-22 문서 커밋 10개 브랜치 4곳 산재(08-09)** — 공유 체크아웃 브랜치 이동 탓. main에는 `e65ae61`만 반영, 나머지는 각 feat/docs 브랜치 PR 머지로 합류. 첨부 에러 정책 충돌 시 `9311cbf`(기획서 정합)가 정답.
- **DS 게시 잔여** — `RetryButton` 세트만 두 번 연속 게시에서 빠져 CHANGED(위생분·비블로킹) — 다음 게시 때 다이얼로그 체크 확인. FileCard stroke 3건도 다음 재게시 포함. (`History Item` `State=loading`·`OTP Input`은 08-11 게시·제품 반영 완료.)
- **홈 스토리 재정합 2차** — placeholder·액센트 정본 확정(위 결정) 후 `HomePage`·`WebShellFlow`를 새 `web/home` 기준으로 재대조(#117은 8/10 기준).
- **홈/히스토리 후속** — 기획 요청 발신 2건(칩 9종 변환 문장·유도 질문 데이터셋 / 딥링크 파라미터↔홈 요소 매핑) · Coachmark 컴포넌트화(딤+스포트라이트+툴팁) 판단.
- **로그인·설정 트랙 잔무(08-11 본체 완료 후)** — 모바일 이메일 플로우 8시트·설정 §4.12 보완·탈퇴/언어/비로그인 4시트는 완료. 남은 것: ① **웹 설정 3탭(계정·앱·정보)에 같은 §4.12 정합** ② 👁 비밀번호 보기 토글(`lucide:eye` 키 확보, 아이콘 추가만) ③ 신규 카피 strings 등재·JP 전환 ④ 비밀번호 찾기 '발송 완료' 상태 1장.
- **첨부 잔무** — 개수 토스트 카피(디자인 초안)·툴팁 2.5s 체감 확인·PR #63 머지 상태 재확인.
- **[주미님 손] empty state 일러스트** — 검토 보드 `4347:2073`에 일러스트를 넣어 전체 UI 정합 판단. 채택 시 마스터 반영은 별도 승인.
- **[주미님 확인]** `Message Bubble Content=Image` 2건(DS 추가 vs Text+Image 스왑 vs 유지) · 고아 치환 제외 2건(`투자` 세트·변칙 Bottom Bar)과 하단 바 Deep 칩 노출(plan-20) · History/Footer `PlanLabel` "Free" 처분(비로그인 variant 재작업 때).
- **오프스케일 그림자 29건** — auth-card 8%·modal 16%·dialog 15%·Toast 복합. 램프 확장 vs 동결 결정 대기.
- **prism 미커밋 잔여 2건**(19-mvp plan 수정·AttachmentLightbox.stories.tsx, 다른 세션 산출물로 보임) — 커밋 여부 판단.
- **형제 칩 포팅** — `SourceChip`(2변형, 쉬움) / `Attachment/Preview` 팝오버(피그마만, 코드 없음) / `ModelChip`·`ChipGroup`(ideation 승격 선행).
- **Tier 1 잔여 5종** — `ChatInputBar` · `ModelProfile`(데이터 계약 선행) · `Spinner`(반쪽) · `MessageBubble`·`Button/ActionBar`(Deep 경로 인라인) · `HeaderNavBar` 1곳.
- **문서 정정 4건** — `plan-16` §8 폐기 표시 / `plan-21` 대비표 접전 `cyan`→`orange` / `plan-20` Tier 1 수 / `design-system/tokens/color.md` 낡은 헥스 표.
- **눈으로 볼 것 2건** — `DeepCTA` conic 그라데이션 테두리 브라우저 렌더 / 헤더 치환 후 Deep 화면.
- 기획서 대조 B-1 잔여 — Chat 응답 화면 3종 · 피드백 UI(좋아요/싫어요+사유) · 모드명 JP 보조 라벨 · 시각화 그래프 형태 좁히기.
- **기획 대기(차주) — 착수 금지** — 등급 판정 로직 승격·범례 % 노출 / ReportCard shell 실측 / 브레이크포인트 구간 경계 / 헤드라인 18px(off-scale).
- **외부/인프라 블로킹** — 제품 파일 REST 토큰 만료(403) 재발급(팝오버 전수 감사가 막혀 있음) / Chromatic 월 스냅샷 쿼터.
- 미검증 스킬 5개(`bump-version`·`record-trap`·`save-ideation`·`prep-meeting`·`ux-review-gate`) — 따로 돌리지 말고 실제로 그 일을 할 때 결과를 확인한다.

---

## 피그마 기준 정보

| 항목 | 값 |
| --- | --- |
| Socra Design System file key | `DcYgJjGAfObOIM4IyrQjgj` |
| Components page | `0:1` |
| Foundation page | `70:218` |
| Icons page | `74:10109` |
| Page design test | `76:10172` |
| Image reference | `76:10169` |

---

## 공통 스킬

| 스킬 | 트리거 |
| --- | --- |
| `write-worklog` | `워크로그 써줘`, `오늘 정리해줘`, `/write-worklog` |
| `session-snapshot` | `지금까지 뭐했어?`, `중간 정리`, `/session-snapshot` |
| `sync-entry` | `동기화 확인해줘`, `뷰어랑 맞아?`, `/sync-entry` |
| `handoff-check` | `handoff 확인해줘`, `클로드 코드에서 이어받을 수 있어?`, `/handoff-check` |
| `prep-meeting` | `미팅 준비해줘`, `이번주 요약해줘`, `/prep-meeting` |
| `bump-version` | `버전 올려줘`, `배포할게`, `/bump-version` |
| `record-trap` | `이거 기억해줘`, `규칙 추가해줘`, `/record-trap` |

---

## 계정

| 서비스 | 계정 |
| --- | --- |
| Claude Code | candoit.j@gmail.com |
| Figma | jumi.jeong@socra.ai |
| GitHub | JumiJeong-design |
