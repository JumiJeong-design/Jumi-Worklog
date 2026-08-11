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
- **첨부 라이트박스 이미지는 안전영역 안에서 중앙 정렬한다(08-11, PR 대기).** "최대 뷰포트 90%"만 걸면 세로 사진이 하단 고정 캡션을 15.8px 침범한다 — 카운터·캡션이 있을 때만 위아래를 비우고(`attachment-lightbox.safe-top` 60 · `safe-bottom` 83) 그 안에서 중앙 정렬한다. 캡션 기준을 이미지 아래로 되돌리는 대안은 폐기(하단 고정을 세로에서만 뒤집게 됨). 피그마 마스터 4종 반영은 남아 있다.
- **첨부 실패 칩은 썸네일을 보여주지 않는다(08-11 확정).** 첨부가 실패하면 프리뷰 자체를 만들 수 없다(개발 확인) — 이미지형 `error`/`error-retry`는 `src`를 받아도 그리지 않고, 사진 없는 기본 면(`bg-surface-muted` = 피그마 `neutral/50`) 위에 빨강 보더와 아이콘만 남는다. 스크림 토큰 `attachment.scrim.error`는 제거. 피그마 마스터(`4189:1909`·`4189:1919`)·게시·제품 인스턴스 9건까지 반영 완료, 코드는 PR 대기(`feat/attachment-failed-preview`). `error-retry`는 MVP에서 안 나올 수 있지만(디바이스→웹 업로드는 네트워크 요청 없음) 주미님 판단으로 마스터·규칙은 보존한다.
  - **함정**: `importComponentByKeyAsync(key)`는 로컬 마스터가 아니라 **게시 스냅샷 프록시**를 돌려준다 — 마스터 실측에 쓰면 이미 고친 것도 "미반영"으로 오진한다.
- **History Item 시각은 상시 표시가 캐논이다(08-11 B/C 모순 해소).** plan-23=B안·계약=C안(웹 숨김)이 같은 날짜로 반대 기록돼 있던 것을 §4.9 문자+승인 시안+실물 실측으로 상시 표시로 판정 — 계약 재작성, `HeroSidebar`·`WebSidebar`의 `showTime={false}` 잔재 제거. loading 행은 스피너+··· **비활성 노출**(`semantic/disabled/fg`, §4.9 "삭제 버튼을 비활성"), engaged ···의 primitive `neutral/400` 직결 드리프트를 `semantic/icon-default`로 복귀(활성 #53555C/비활성 #84878F 단계). **DS 게시 대기**, prism 커밋 `bac81e9`는 `feat/edge-scrim-exploration` 미푸시(ahead 3).
- **Chromatic은 월 스냅샷 쿼터 소진 상태다(08-10).** 머지분이 전부 UI Review pending — 주미님 "당장은 눈으로 QA하니 비블로커". 쿼터 해제 시 main 전체 비교 1회, 육안 우선순위는 `ModelProfile`을 쓰는 5곳(MessageBubble·ProfileGroup·SheetProfile·Comment·ReportParticipants). CI 자동 업로드는 없고 필요할 때 `pnpm visual` 수동 실행이 기준. **로컬 `pnpm visual`은 게시+최소 스냅샷이다(08-11)** — `preview.tsx` 전역 `disableSnapshot`(`VITE_STORYBOOK_FULL_SNAPSHOTS=true`로만 해제) + `--only-changed`라 Theme 스토리만 찍힌다. 전수 픽셀 비교는 CI `workflow_dispatch`가 정본.
- 문서 형식 게이트는 `.githooks/pre-commit`(→ `scripts/validate-design-system.sh`)으로 커밋 전 자동 실행된다. 새 클론은 `git config core.hooksPath .githooks` 필요.
- 뱃지·칩 기준선: **눌러서 상태가 바뀌면 `Chip`, 그냥 읽는 라벨이면 `BadgeLabel`**(정본 `docs/plans/20` §5-1~5-3). 패키지엔 `Badge`·`BadgeLabel` 포팅 완료, `Button/DeepCTA`는 Figma만.
- `chart/*` semantic은 **종결됐다(08-09)** — 코드 `color.band.*`+`color.badge.{band}.*`, 피그마 `chart/band·badge` 모두 main/DS에 있다. 다만 `apps/storybook/src/stories/chartPalette.ts`의 5색은 **폐기된 시리즈 팔레트**라 교체 대상이다.
- **반응형 레이아웃 기준(2026-08-06~).** DS `Layout` 페이지(`4054:1848`)가 정본, 코드 계약은 `packages/prism/token-contract.md` "레이아웃 `layout.*`" 절, 근거는 `design-system/foundation/layout.md`.
  - 브레이크포인트 Mobile <768 / Tablet 768–1279 / Desktop ≥1280. 768은 토큰 `{mo,pc}` 분기와 같고, **1280은 토큰이 아니다**(`@media` 조건은 `var()`를 못 받는다).
  - **컬럼은 한 겹이 아니다** — 800(평문 답변) 안에서 리포트 560·투표/폼 520이 자기 상한을 갖는다. 토큰 `--layout-column-{text,card,decision}` + 유틸리티 `max-w-{text,card,decision}`.
  - 웹 셸: 사이드바 260/rail 60 + gutter 8 → **zone = width + gutter×2**(276/76). max-width는 뷰포트가 아니라 **콘텐츠 영역** 기준.
  - 모바일 바텀시트의 웹 대체는 시트 성격으로 가른다(LAYOUT 05): 짧은 액션 **Popover 320**(08-11 첨부 240→320) / 결정 차단 Dialog 400·660 / 대조하며 읽기 Side Panel 400·520.
  - **대체는 형태만 옮기는 게 아니라 정보량도 같이 옮긴다(08-11).** 첨부 시트는 행마다 아이콘+라벨+제약(형식·장수·용량)을 주는데 PC 팝오버는 라벨만 있었다. 폭 320은 그 제약 문구(실측 249)를 한 줄로 담는 최소치다. 결과적으로 Desktop 앵커드 오버레이는 첨부·모델 리스트 둘 다 320.
  - **유저 버블은 두 메커니즘 분업이다** — 상자 max/min은 `layout` 변수(Mobile/Web 모드), 텍스트 줄바꿈 캡은 `_TextBubble`의 `breakpoint=mo|web` variant. **하나로 합치려다 되돌린 이력이 있으니 다시 합치지 말 것.**
- **제품 타이포 램프에 Bold가 없다.** 강조 굵기는 전부 SemiBold이고 Bold는 `foundation/*`(DS 문서용)과 `chat/h1`뿐이다. 15px 강조는 `body/md-sb`.

### 열려 있는 결정 (진행을 막고 있는 것)

- **색 규칙 잔여 2건** — 규칙 자체는 08-03 확정(구간 3색: 다수·압도 `blue/500` / 접전 `orange/500` / 일부 `purple/400` / 소수 라임, 판정 기준 v1.0.3). 남은 것: ① 라임 소수 바가 트랙 대비 1.19로 3:1 미달 — 색으로 못 풀어 stroke 같은 비색 수단 결정 필요 ② 소수 3개 이상이면 스택바 범례가 전부 라임이라 구분 불가.
- **히어로 레전드 유무**(07-28 이후 휴면) — 비교 스토리 제작 완료, 채택만 남음. 흡수 전환 4컷이 "레전드 포함" 기준이라 뒤집히면 재작업.
- **`Chip` 축 확장 — Figma 결정 2건 선행**(08-03 이후 휴면) — radius 사각 variant 부재 / 눌린 색 패키지 파랑 vs Figma 검정 / md 텍스트 16 vs 17. 정본을 정해야 코드를 고칠 수 있다.
- **processing 중 전송 처리**(기획 확정 대기) — 오프라인 배너 철회로 "전송만 잠근다"의 근거가 소멸. 컴포저 processing 비교 시안·스토리북 processing 전이 데모가 이것 대기. 단 **"에러 칩이 남아 있으면 전송 불가"는 §3.4 명문이라 유효** — 둘을 섞지 않는다.
- **`--layout-overlay-popover`(240) 처분**(08-11) — 첨부가 320으로 옮겨가며 이 토큰의 소비처가 0이 됐다. 공개 manifest에 실려 있어 값 변경·삭제 둘 다 브레이킹이라 **값은 그대로 두고 비고만 "`Popover` 마스터 기본 폭"으로 정정**했다. 남은 판단 = Figma `Popover` 마스터(`4276:1991`)와 `Popover.tsx` 기본값을 320으로 볼지.
- **§5.3 주미님 확인 4건**(게이트/토스트 문구·세션 승계 고지·비로그인 복구 불가 문구·전송 실패 opacity 20%) + **PM 노트 전달**(`7833:97335`, S9-3 정의 한 줄 수정 포함).
- **비로그인 게이트 닫은 뒤(SA-1a) 4건**(08-11, 정본 plan-25) — ① **PM 확인**: 소진 후 화면 표시가 기획서 미규정(§3.2는 모달만 정한다). 이번 잠금 상태는 디자인 제안이다 ② **KR 문구 확정 → `strings` 등재**(JP/EN 초안 작성 완료, DS write+게시 필요) ③ **DS 승격 `Chat Input Bar State=locked`** — 제안서 작성 완료, variant 옵션 추가라 기존 인스턴스 픽셀 변화 0 ④ **DS 승격 `disabled`의 중첩 `Mode Toggle` 비활성화** — 실측 확인된 실재 건이나 **픽셀 변화 있는 시각 변경**이라 게시 전 대상 조회 선행.
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
- 설정 화면 스펙 외 항목 제거(08-11, **§4.11**·§3.2) — 구독 섹션(MVP 무료)·알림(웹 MVP 미포함)·로그아웃(=[내 계정] 메뉴 소관) 제거. 다크 모드 토글은 재량 유지, 오픈소스 라이선스 행은 미결. 8/11 밤 모바일·웹 3탭(라이트/다크)·태블릿 **전 9컷 적용** + **사업자 정보 푸터**(수용기준 7) 신설. ※ 절 번호는 **§4.11**이다 — v1.0.5·v1.0.6 모두 4.11이고 `§4.12`는 구판이다.
- 입력창 글로우 = E안 확정·반영 완료(08-11, #136·#137) — `gradient/brand` 링 1px + 정적 halo 0.13, 포커스 트리거, Deep On이면 링 생략. B(2색 선형)·C 계열(흰색 교차 링)·E-1(halo 없음) 폐기.
- `ProfileGroup` hover = B 보더 강조 확정·반영 완료(08-11, #140) — A 배경 필(focus와 같은 그림)·C 리프트(과함) 폐기.

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
- **SECTION 자식의 `x`/`y`는 섹션 기준 상대좌표다(2026-08-11).** `sec.x`를 더해 옮기면 자식 전체가 섹션 밖 수만 유닛으로 밀리는데, **자식끼리의 상대 배치는 그대로라 개별 프레임 스크린샷은 멀쩡하다.** 신호는 섹션 스크린샷의 `original_width`가 `sec.width`와 다른 것. 검증은 `자식.x + width ≤ sec.width`로 하고 절대bbox와 섞어 계산하지 않는다(오프셋이 상쇄돼 "이상 없음"이 나온다).
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
- **인스턴스 variant를 바꾸면 슬롯 콘텐츠가 초기화된다(2026-08-11).** 라이트박스 `count` 전환에 `이미지` 슬롯 사진이 마스터 자리표시로 되돌아갔다. 슬롯 작업은 전환 → 재조회 → 내용 재확인 순으로.
- **렌더 판정은 스크린샷 육안이 아니라 픽셀로 한다(2026-08-11).** 밝아 보인다고 "스크림 미적용"으로 보고했다가 픽셀 (97,98,99) = 흰 배경 + `black-alpha/60`으로 정상임을 확인해 정정했다.
- **카운트 비교 전에 가시성 필터부터.** `visible:false` 잔재와 타 제품 보드가 섞이면 수치가 오염된다.
- **`resize()`는 세로 사이징을 FIXED로 되돌리고, 같은 스크립트에서 읽은 크기는 재레이아웃 전 값이다(2026-08-11).** 폭만 바꾸려 `resize(w, h)`를 부르면 HUG였던 높이가 굳고, 리플로우 직후 `node.height`로 좌표를 계산하면 옛 값이 나온다(211 vs 실제 167 → 44px 어긋남). 리플로우 뒤 좌표는 **다음 호출에서 `get_metadata`로 확정 높이**를 받아 잡는다.
- **규칙 보드의 값을 고쳤으면 그 값이 렌더되는지까지 본다(2026-08-11).** DS `LAYOUT 05` 대체 규칙 표는 셀 32개가 높이 10px + `clipsContent`라 텍스트가 한 줄도 안 보이는 상태로 방치돼 있었다(패딩 합 28 < 높이 10이 신호). 표 데이터를 고쳐도 아무도 못 읽는다.
- **내부가 HUG면 프레임 폭을 줄여도 안 접히고 넘친다(2026-08-11).** 토스트를 536→344로 줄였더니 노드는 344인데 렌더는 570이었다(536은 override가 아니라 hug 결과였다). 폭 감사는 `node.width`만 보면 통과한다 — **`absoluteRenderBounds.width`와 대조**해야 오버플로가 잡힌다(그림자 bleed 약 40px은 정상). 접히게 하려면 `FILL` + TEXT `autoResize=HEIGHT`.
- **`SECTION` 안에 화면이 있으면 "최상위 프레임" 탐색이 섹션에서 멈춘다(2026-08-11).** 토스트 전수에서 flow 섹션 안의 393 화면 4건을 "보드"로 분류해 빼는 바람에 "모바일은 전부 상단"이라는 **결론이 통째로 뒤집혔다**. 화면에 절대 배치되는 오버레이는 최상위가 아니라 **`parent`가 화면인지**로 판정한다. 같은 맥락으로 동명 프레임(`deep` 13장·`Chat` 3장)이 흔해 **이름으로 화면을 세면 "중복"으로 오판**한다.
- **격리 브랜치로 옮길 땐 `git diff`가 아니라 `git diff main`으로 검증한다(2026-08-11, CI가 잡음).** 공유 워킹트리에서 `index.ts`가 "내 변경만"인 걸 `git diff`로 확인하고 통째로 복사했는데, 옆 세션이 **이미 커밋한** `EdgeBand` export가 딸려와 CI가 `Cannot find module './components/EdgeBand.tsx'`로 깨졌다. 커밋된 남의 변경은 작업 브랜치 diff에 안 잡힌다 — **기준은 옮겨갈 base(main)다.** 같은 이유로 **로컬 통과가 CI 통과가 아니다**: 로컬은 옆 세션 파일이 워킹트리에 있어서 통과했다. 격리 worktree에서 같은 명령을 돌려 확인한다(`pnpm`은 심링크 node_modules를 거부하므로 `node_modules/.bin/*` 직접 호출).
- **`git worktree add`를 HEAD에서 따면 남의 브랜치 위에 얹힌다(2026-08-11).** 격리했는데도 base가 옆 세션 PR 브랜치라 내 브랜치에 남의 커밋 9개가 딸려 있었다. **worktree는 `main`에서 따고**, `git rev-list --count main..HEAD`로 내 커밋 수만 남았는지 확인한다. 생성물(토큰 `theme.css`·manifest)은 patch로 옮기지 말고 격리 쪽에서 **재생성**해야 남의 변경이 안 섞인다.
- **피그마 모바일 시안의 y값에는 iOS StatusBar(59)가 들어 있다(2026-08-11).** 이 제품은 모바일 **웹**이 본선이라 실제 렌더엔 StatusBar가 없다 — 시안 절대 y를 코드 계약에 옮기면 틀린다. 앵커 기준(예: "헤더 하단 +8")으로 쓴다.
- **`upload_assets`의 `success`는 "커밋됨"이지 "적용됨"이 아니다(2026-08-11).** `nodeId`를 줬는데도 대상 fill이 안 바뀌었다 — 반환된 `imageHash`로 `fills`를 직접 갈아끼워야 했다. 업로드 후 노드 fill을 다시 읽어 확인한다.

---

## 다음 후보 작업

아래는 후보/백로그다. 실제 실행 전 범위와 승인 상태를 다시 확인한다. 상세 to-do는 public viewer의 계획 탭을 정본으로 본다.

- **[내일] DS `Bottom Bar`의 `Dark` variant 축 → 피그마 모드 전환.** 피그마는 다크를 variant로 고르고 코드는 모드로 뒤집는 불일치. 영향 실측 = 인스턴스 4개뿐(`chat/chart` 103개 전부 `Dark=false`, `home/history` 4개만 `true`). 마스터를 `semantic/surface/fade-*`로 재바인딩 → 축 제거 → 홈 다크 컷 3장 모드 명시. 죽은 `Toolbar` 축(옵션 `off` 하나)도 같이. 되돌리기가 번거로워 컷이 적은 지금이 싸다.
- **[머지 확인] plan-22 문서 커밋 10개 브랜치 4곳 산재(08-09)** — 공유 체크아웃 브랜치 이동 탓. main에는 `e65ae61`만 반영, 나머지는 각 feat/docs 브랜치 PR 머지로 합류. 첨부 에러 정책 충돌 시 `9311cbf`(기획서 정합)가 정답.
- **DS 게시 잔여** — `RetryButton` 세트만 두 번 연속 게시에서 빠져 CHANGED(위생분·비블로킹) — 다음 게시 때 다이얼로그 체크 확인. FileCard stroke 3건도 다음 재게시 포함. (`History Item` `State=loading`·`OTP Input`은 08-11 게시·제품 반영 완료.)
- **홈 스토리 재정합 2차** — placeholder·액센트 정본 확정(위 결정) 후 `HomePage`·`WebShellFlow`를 새 `web/home` 기준으로 재대조(#117은 8/10 기준).
- **홈/히스토리 후속** — 기획 요청 발신 2건(칩 9종 변환 문장·유도 질문 데이터셋 / 딥링크 파라미터↔홈 요소 매핑) · Coachmark 컴포넌트화(딤+스포트라이트+툴팁) 판단.
- **첨부 라이트박스 마무리** — 피그마 마스터 4종에 안전영역 반영(flow·마스터 담당 세션 몫) · `be2fdd1` 머지(`feat/attachment-lightbox-safe-area` 푸시됨) · 세로 원본 사진 확보 시 슬롯 paint 교체.
- **로그인·설정 트랙(08-11 밤 기준 · 설정 정본 = plan-27)** — 설정은 §4.11 정합 완료(모바일·웹 3탭 라이트/다크·태블릿 9컷 + 사업자 정보 푸터), **언어 선택 5컷 · 비로그인 4컷 · 인증 플로우 6컷**(비밀번호 변경 2 · 탈퇴 인증 1 · 탈퇴 확인 모달 3) 신설. ⚠️ 8/11 이전 기록은 "탈퇴/언어/비로그인 4시트 완료"로 적혀 있었으나 **파일에는 없었다** — 이번 세션에 실제로 제작했다. 남은 것: ① 설정 신규 문구 `strings` 미등재 5종(비밀번호 변경·문의·고객센터·회원 탈퇴·푸터 2행·언어 라벨/버튼 — DS write 승인 선행) ② `Settings/Row` `Type=select` variant 신설 여부 ③ 오픈소스 라이선스 행 존치 여부 ④ 👁 비밀번호 보기 토글(`lucide:eye` 키 확보, 아이콘 추가만).
- **첨부 잔무** — 개수 토스트 카피(디자인 초안)·툴팁 2.5s 체감 확인·PR #63 머지 상태 재확인.
- **토스트 배치 트랙(08-11)** — **PR #147 OPEN**, 빌드 게이트 전부 통과(`check`·`validate`·`storybook`). **[주미님 손] Chromatic 베이스라인 1건 승인 필요**(신규 `Placement` 스토리) — 승인 전까지 `mergeState=UNSTABLE`. 규칙·제품 파일 13건 정합·`ToastViewport` 포팅은 완료. 남은 것: ① `ToastViewport`가 안 다루는 스택 규칙·진입/퇴장 모션·`duration` 자동 소멸 ② 패널 열림 화면 `EdgeBand` 부재(스트림 748 + 패널 자체 밴드, 시각 변경이라 승인 대기) ③ Side Panel **400 요약 실물 데모 부재**(옛 `7449:11658` 소멸 — "패널 열리면 폭 무관 rail 접힘" 확인용 재작성 필요).
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
