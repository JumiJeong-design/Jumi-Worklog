# 현재 상태 스냅샷

> 새 세션이 현재 기준과 위험 게이트만 빠르게 잡도록 돕는 파일.
> 상세 이력은 `logs/YYYY/MM/YYYY-MM-DD.md`와 각 repo git history를 본다.
> Last updated: 2026-08-09 (전면 갱신은 07-16 기준 · 07-28에 Quick/Deep 결과 화면 + 라벨 뱃지 계열·타이포 램프·브랜치 캐비엇 갱신 · 07-29에 스킬 검증·오탐 수정 반영 · 07-30~31에 prism npm 배포 재개와 `prism-dist` 은퇴 반영 · 08-03에 색 규칙 확정(구간 3색)·PR 4건 머지·Version PR #43·감사표 수치 재정정 반영 · 08-06에 기획서 v1.0.6 정합·첨부 정책 피벗·시트 패밀리 포팅·고아 마스터 종료·**반응형 레이아웃 기준 신설** 반영 · 08-07 오후에 Attachment 세트 통합·DS 토큰 정합 패스(deep-ring/tight 140%/그림자 스타일)·chat/chart 고아 마스터 24건 치환 반영 · 08-07 저녁에 비로그인 트랙 마감 — 스테일 스냅샷 스왑·웹 게이트 1440 신설·첨부 트리거 결정노트 갈음·ChatHistoryPanel auth 포팅 확인, PR #54 push 반영 · 08-07 밤에 TextDivider `type=default|loading`+`trailing` 신설·분리본 11개 재연결·패키지 포팅, 다크 시멘틱 충돌 지도 확정, 기획서 보드 감사 제외 규칙 · 08-07 심야에 Deep data-viz 3종 코드 포팅 — VoteBar·LegendItem·VoteResult PR #58 오픈 · 08-09에 PR #54·#58·#59 전부 머지 — **`@riiid/prism@0.6.0` npm latest 배포**, 마스터 3종 삭제, 고아 로컬 마스터 치환 212/214, 결정 대기 3건 감사·권고화 · 08-09 밤에 History 빈 목록 문구 기획서 §4.11 통일 — 피그마 마스터 241:81+코드, PlanLabel "Free"는 Footer 재작업 때 결정으로 미결 유지 · 08-09 심야에 바텀시트 혼재 정리 — 제품 action 인스턴스 교체·잔재 삭제로 실화면 action 0(낮 "사용 0" 실측은 오탐 정정), ActionRow/MenuItem 마스터 393 정합, DS action variant 처분은 택일 대기 · 08-09 이 세션에서 브랜드 그라데이션 페인트 스타일 2종(`gradient/brand`·`brand-fill`) 등록·사용처 전수 스냅(주미님 게시 완료), 스크롤 복귀(Scroll FAB) 종결 — MVP 케이스·Storybook 모션 정본·BottomBar 트랜지션 승격, PR #60·#61 머지 · 08-09 DnD 정합 세션 — 드롭존 톤 검정 확정·판정 창 전체 재확정·흡수 비행 컷 신설(PR #63), 로컬 main diverge 5건 구출(PR #66) · 08-09 오버레이 트랙 — 규칙 29 신설(오버레이 표면 3등급·glass-strong), Figma Menu 마스터 글래스 전환·Popover 프리미티브 신설(4276:1991)·손코딩 팝오버 2곳 흡수, 패키지 PR #62(시각 QA 대기), 네트워크·게이트 4건 처리(S9-2N 신설·§4.9 기획서 유지), 다크 시안 20장 원격 컬렉션 모드 복구 · 08-09 plan-22 기준 골격 세션 — Guidelines 페이지(구 Layout) 신설·접근성 foundation·focus 링 검정 확정·정렬 실측·토스트 3/6s·사진 버블=칩 재사용, 첨부 에러 정책은 기획서 v1.0.6 정합으로 종결(즉시 차단안 철회) · 08-09 오후 마감 세션 — Android 360 QA(첨부 칩 5장 오판 정정·상대 규칙 계약화), collapsed 첨부 동반 숨김 계약, 입력창 상단 페이드 시안→DS `State=max` 마스터→계약→`ChatInputBar` mask-image 코드까지 전 구간 반영, plan-22 종결(잔여 0) · 08-09 밤 네트워크·오류 케이스 시안 세션 — 오프라인 지속 상태 시안(배너 변수 바인딩+SendButton만 disabled, §5.3 입력 보존 정합)·첨부 칩은 DS `state=processing/error/error-retry` 기존 변형 재사용 확정(신설 불필요)·오류 케이스 정합표 노트(§5.1/§5.3/신규 배너/§3.4 + 표면 위계) chat/chart에 등재, 전송 실패 프레임(6246:10085)은 §5.3 케이스로 유지)
>
> 이 파일은 **누적 이력이 아니라 스냅샷**이다. 날짜별 경과는 `logs/`가 정본이므로 여기에 날짜 섹션을 쌓지 않고, 현재 상태 한 벌만 덮어쓴다(2026-07-14 정리 — 6/12~6/23 날짜 섹션 6개가 누적돼 worklog와 중복되고 갱신이 밀리던 것을 접음).

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

## 현재 상태 (2026-08-07 기준)

### 운영 모드

- **Claude Code 단일 에이전트** 체제다(2026-07-13~, Codex 병행 중단). 브랜치 전략은 main-first: 짧은 feature 브랜치 → PR → main. 장수 병렬 트랙(`plan/parallel-codex`류)은 새로 만들지 않는다.
- 같은 세션에서 병렬이 필요하면 서브에이전트 + `git worktree` 격리를 쓰되 팬아웃은 3~4개 소규모가 기본이다. **감사·리서치류는 인라인이 기본**(7/10·7/13 대규모 팬아웃이 두 번 다 세션리밋에 걸렸다).
- 2-에이전트 병렬 규칙은 휴면 상태로 보존돼 있다(정본: `riiid/prism`의 `AGENTS.md`). `socra-ai-workflow-wiki`의 핸드오프/컴포넌트 플레이북과 `AGENTS.md`도 2026-07-16에 같은 (휴면) 패턴으로 맞췄다.

### `riiid/prism`

- **배포 재개됨 (2026-07-30). `@riiid/prism@0.2.0`이 npm에 `latest`·restricted로 배포됐다.** 첫 실배포다. 2026-07-14~07-16의 "changelog 전용 / 배포 금지" 방침은 접었고 `.changeset/readme.md` 방침 블록도 제거됐다. 설치는 `pnpm add @riiid/prism@0.2.0`. canary도 살아 있다(`0.2.0-canary.05a7f381...`).
  - 배포 경로는 로컬 `npm publish`가 아니라 **GitHub Actions + npm Trusted Publishing(OIDC)**이다. latest = Version PR을 `main`에 머지 / canary = `canary/**` 브랜치 push + changeset. 필요한 시크릿은 `NPM_READ_TOKEN`(restricted 버전 조회)·조직 앱 토큰·`CHROMATIC_PROJECT_TOKEN`. 정본은 `docs/release.md`.
  - 로컬에서 `npm view @riiid/prism`이 404여도 미배포가 아니다 — restricted라 미인증 조회가 막힌 것이다. 확인은 워크플로 로그로 한다.
  - `0.2.0`은 **내부 검증용**이다. 디자인 픽스(variant·토큰 피그마 정합)는 아직 진행 중이라 다음 버전이 뒤따른다.
  - 산출물 브랜치 `prism-dist`는 2026-07-31에 은퇴(원격·로컬 삭제, 마지막 `4739e39`). 깃헙을 정적 저장소로 쓰는 방식은 유지 비용 때문에 폐기했고, **빌드 산출물을 저장소에 커밋하지 않는다**가 기준이다.
- `docs/plan19-web-first-v3`는 일정 트랙이다. Codex는 일정 문서 변경을 중단하고, 하네스 변경은 `main` 기준 별도 브랜치 `docs/storybook-harness-followup-2026-07-15`로 분리했다.
- 하네스 후속 브랜치 `docs/storybook-harness-followup-2026-07-15`의 내용은 Storybook IA/API Docs 문서 정리, 죽은 루트 `.storybook` 설정 제거, component contract ↔ story map coverage gate 보강이다. 2026-08-03에 PR #41로 오픈됐다.
- 외부 공유용 Storybook은 Chromatic **Build 124**(2026-07-14 수동 업로드, 172 stories). CI 자동 업로드 워크플로는 없어 필요할 때 `pnpm visual`을 수동 실행한다.
- 문서 형식 게이트는 `.githooks/pre-commit`(→ `scripts/validate-design-system.sh`)으로 커밋 전 자동 실행된다. 새 클론은 `git config core.hooksPath .githooks` 필요.
- **라벨 뱃지 계열이 2026-07-28에 들어왔다.** Figma `Badge`(`125:94`, 숫자 카운트) / `Badge/Label`(`3704:1797`, 텍스트 라벨 18변형) / `Button/DeepCTA`(`3719:1993`) + 텍스트 스타일 `body/md-sb`. 패키지엔 `Badge`·`BadgeLabel` 2종이 포팅됐고(`Button/DeepCTA`는 아직 Figma만), 시안 인스턴스 110개가 교체됐다. 기준선은 **눌러서 상태가 바뀌면 `Chip`, 그냥 읽는 라벨이면 `BadgeLabel`** — 시안에 눌리는 Chip은 0개였다. 정본은 `docs/plans/20-report-view-componentization-audit-2026-07.md` §5-1~5-3.
- **차트 색은 코드에서 `apps/storybook/src/stories/chartPalette.ts` 한 곳이다**(2026-08-03, `4980b79`). 그전엔 같은 5색이 세 파일에 복붙돼 있었다. 다만 그 5색은 **폐기된 시리즈 팔레트**이고 확정된 구간색 규칙과 무관하다 — 교체 대상이다.
- **`chart/*` semantic 승격은 보류 해제**(2026-08-03). 색 규칙이 확정되고 라임 primitive가 PR #39로 main에 들어왔다(`--prism-color-lime-*` 10단계). 설계 관점 셋(구간 이름 우선 / 강조 슬롯 우선 / 공개 표면 최소화)을 놓고 심사 중이다. 공개 토큰 개명은 0.3.0 이후라 브레이킹이라는 점이 제약이다.
- **반응형 레이아웃 기준이 생겼다(2026-08-06).** DS `Layout` 페이지(`4054:1848`)가 정본이고, 코드 계약은 `packages/prism/token-contract.md`의 "레이아웃 `layout.*`" 절, 근거 문서는 `design-system/foundation/layout.md`다.
  - 브레이크포인트 Mobile <768 / Tablet 768–1279 / Desktop ≥1280. 768은 토큰 `{mo,pc}` 분기와 같고, **1280은 토큰이 아니다**(`@media` 조건은 `var()`를 못 받는다).
  - **컬럼은 한 겹이 아니다** — 800(평문 답변) 안에서 리포트 560·투표/폼 520이 자기 상한을 갖는다. 토큰 `--layout-column-{text,card,decision}` + 유틸리티 `max-w-{text,card,decision}`.
  - 웹 셸: 사이드바 260/rail 60 + gutter 8 → **zone = width + gutter×2**(276/76). max-width는 뷰포트가 아니라 **콘텐츠 영역** 기준.
  - 모바일 바텀시트의 웹 대체는 시트 성격으로 가른다(LAYOUT 05): 짧은 액션 Popover 240 / 결정 차단 Dialog 400·660 / 대조하며 읽기 Side Panel 400·520.
  - **유저 버블은 두 메커니즘 분업이다** — 상자 max/min은 `layout` 변수(Mobile/Web 모드), 텍스트 줄바꿈 캡은 `_TextBubble`의 `breakpoint=mo|web` variant. 중첩 인스턴스의 `maxWidth`는 variant로 안 바뀌고, 텍스트 max width는 변수를 못 받아서 갈렸다. **하나로 합치려다 되돌린 이력이 있으니 다시 합치지 말 것.**
- **제품 타이포 램프에 Bold가 없다.** 강조 굵기는 전부 SemiBold이고 Bold는 `foundation/*`(DS 문서용)과 `chat/h1`뿐이다. 15px 강조가 필요하면 2026-07-28 신설한 `body/md-sb`를 쓴다.

### 열려 있는 결정 (진행을 막고 있는 것)

- ~~**Quick/Deep 결과 화면 방향 — 그래프 색 규칙**~~ — **2026-08-03 확정: 구간 3색.** 다수·압도적 `blue/500` / **접전 `orange/500`** / 일부 `purple/400` / **소수 라임**. 뱃지는 각 계열 100 배경 + 800·700·900 글자. 트랙 `neutral/100`. 판정은 기획서 v1.0.3 그대로(접전 = 1위 포함 7%p 이내 2개 이상 · 압도 80% · 일부 20% 이상 · 소수 20% 미만).
  - **`docs/plans/16-…-07.md` §8의 "색 = 강조 여부 2단"안은 폐기됐다.** 그 문서만 읽으면 반대로 간다 — 폐기 표시 붙이는 게 잔업으로 남았다.
  - 두 안이 7/28과 8/2에 각각 승인돼 서로를 모른 채 공존하고 있었다. **결정 문서에 "무엇을 폐기했는지"를 같이 적어야** 다음 세션이 되돌리지 않는다.
  - 미해결로 남는 것: 라임 소수 바가 트랙 대비 **1.19**로 3:1 미달인데 색으로는 못 푼다(`lime/600`까지 올리면 통과하지만 `blue/500`보다 어두워져 위계가 뒤집힘) → stroke 같은 비색 수단 결정 필요. 소수가 3개 이상이면 스택바 범례가 전부 라임이라 구분 불가.
- **히어로 레전드 유무** — 비교 스토리는 만들어뒀고 채택만 남았다. Figma 흡수 전환 4컷을 "레전드 포함" 기준으로 그려둬서, 뒤집히면 그 4컷이 재작업이다. 색 규칙과 함께 정하는 게 낫다.
- ~~**미머지 작업 3건**~~ — **2026-08-03에 전부 머지됐다.** #41(하네스 문서+커버리지 게이트) · #40(2line 카운터) · #39(라임 팔레트) · #42(Badge·BadgeLabel·DeepCTA). 결과로 **Version PR #43 `chore: 0.4.0`이 자동 생성**됐다 — 머지 타이밍만 남았다.
  - 남은 열린 PR은 **#35**(plan-19 일정 v4, CONFLICTING — rebase냐 close냐 미정)와 **#13**(codex Chip locale, draft·CONFLICTING — Codex 병행은 7/13 중단이고 `chipStringTokens`는 이미 패키지에 있어 close 유력).
  - 교훈: **"PR 냈다"를 완료로 쓰지 않는다.** 8/3 낮에 세 건을 완료 처리했는데 셋 다 OPEN이었고 #42는 CI가 깨진 채였다. 그리고 로컬 `pnpm typecheck`/`pnpm test`는 CI 게이트가 아니다 — CI가 도는 건 **`pnpm check`**다.
- **`Chip` 축 확장 — Figma 결정 2건이 선행(2026-08-03).** 계획엔 "radius 알약/사각 2타입"이라 적혀 있는데 마스터에 사각 variant가 없다(6변형 전부 `radius/24`). 눌린 상태 색도 패키지 `action-primary`(파랑) vs Figma `neutral/900`(검정)으로 갈리고, md 텍스트는 패키지 16px vs Figma `body/lg-r`(17px)다. **어느 쪽이 정본인지 정해야 코드를 고칠 수 있다.**
- 기획서(`docs/20-socra-product-spec-2026-07.md`)의 [Open Issues] — 타임아웃 정책·RAG 도메인·계정/인증·개인정보(APPI) 등은 PM/법무 결정 대기라 디자인 착수 불가.

### 알려진 캐비엇

- Product 파일 홈 화면(`5027:3909`)의 컴포저는 DS 라이브러리 마스터가 아니라 **Product 파일 내 로컬 카피**(`5338:50726`)를 참조한다(포크 상태 — DS 마스터를 고쳐도 전파 안 됨). 라이브러리 publish 후 재연결은 defer.
- 죽은 로컬 브랜치 ~20개(`codex/*`·`canary/*`)가 남아 있다. 정리 시 머지 여부를 개별 확인한다.
- ~~로컬 브랜치 `explore/deep-wait-vote`가 `origin/explore/report-hero`를 추적한다.~~ 2026-07-29에 정리됨 — 지금은 `origin/explore/deep-wait-vote`를 올바르게 추적하고 원격과 동기 상태다.
- **같은 폴더에서 두 세션이 동시에 작업하는 일이 두 번 발생했다(2026-07-31, 08-03).** 8/3에는 `deepProfileLanding.tsx`를 다른 세션이 **실시간으로 편집 중인 것**을 확인했다(내가 스냅샷한 버전보다 132줄 앞서 있었다). 대응: 편집 중인 파일은 먼저 별도 브랜치에 스냅샷해 두고, 브랜치 전환·머지는 **전부 `git worktree`로 분리**한다. 공유 체크아웃에서 브랜치를 갈아타면 남의 미커밋 작업이 사라진다.
- **버전 관리 밖 작업이 실제로 쌓인다.** 8/3에 미커밋 엔진 변경 + 미추적 탐색 파일 870줄을 발견해 `wip/verdict-engine-second-target`에 보존했다. 소비처가 없는 탐색물은 PR에 섞지 말고 wip 브랜치로 뺀다.
- **라이브러리 업데이트가 와도 기존 인스턴스는 옛 값을 들고 있다(2026-08-06).** 게시·수락이 끝났는데 버블 폭이 안 바뀌었다 — 인스턴스의 `boundVariables`에서 maxWidth/minWidth가 빠져 있었고 모드·variant 어느 쪽도 안 먹었다. **부모 인스턴스에 `resetOverrides()`** 해야 복구되며, 텍스트 override가 함께 날아가므로 **저장→리셋→복원** 절차가 필요하다. 또 업데이트 후 중첩 인스턴스 **이름이 바뀐다**(`BubbleBox`→`_TextBubble`) — 이름 대신 `componentProperties` 보유 여부로 찾는다.
- **라이브러리 publish는 플러그인 API에 없다.** DS에 컴포넌트를 만들어도 주미님이 Figma에서 직접 게시해야 제품 파일이 본다. 신설 → 게시 대기 → 인스턴스 교체가 기본 리듬이다.
- **게시된 variant를 지우면 다른 세션 인스턴스가 뜬다.** 2026-07-28에 `Badge/Label`의 역할 이름 축(success/error/info/warning)을 색 이름 축으로 갈면서 삭제했더니, 그 사이 다른 세션이 쓴 `Type=info` 인스턴스 16개가 마스터에 없는 변형을 붙들었다. 7/29 화면 개편으로 해소됐지만(현재 0개), **축 개편 전 소비자 확인**이라는 교훈은 유효하다.
- **plan-20 감사표 수치를 근거로 쓰기 전에 다시 센다(2026-08-03).** Tier 1 재사용 잔여는 **5종**이다 — `MessageBubble`·`Button/ActionBar`는 Deep 경로에선 아직 인라인이고, `HeaderNavBar`도 3곳 중 2곳만 치환됐다(`DeepWaitVote.stories.tsx:357`). 같은 날 "6종→4종→3종"으로 두 번 줄였는데 두 번 다 낙관적이었다.
- **한 페이지에서 못 찾은 걸 "파일에 없다"로 쓰지 않는다(2026-08-03).** `ModelChip`·`ChipGroup`이 ✅ Components 검색에 0건이라 "Figma에 없다"고 단정했는데 **틀렸다.** 게시 라이브러리에 componentKey가 살아 있고 `docs/plans/11`에 `ModelChip 2937:122`·`ChipGroup 2998:231` 생성 기록도 있다 — `🧪 Opinion Viz (ideation)` 페이지라 안 잡혔을 뿐이다. 남은 건 제작이 아니라 **ideation → ✅ Components 승격**이다.
- **병렬 팬아웃은 Figma MCP 의존 작업으로 채우지 않는다(2026-08-03).** 조사 4건을 서브에이전트로 갈랐다가 전부 MCP 재연결에 걸려 3시간 반 동안 진전 0, 중간 산출물도 못 건졌다. 인라인 재실행에서는 MCP를 안 타는 감사가 제일 먼저 끝났다. 나눌 땐 **외부 의존이 없는 쪽부터** 가른다.
- **카운트 비교 전에 가시성 필터부터.** 7/29에 남은 `Chip` 31개를 보고 "안 써야 할 칩이 다시 들어왔나" 의심했는데 전부 `visible:false`인 잔재였다. 또 페이지 전체를 훑으면 인스턴스 내부 레이어와 타 제품 보드(`vai-home` 등)가 섞인다 — 이 페이지는 최상위 노드가 222개다.

---

## 다음 후보 작업

아래는 후보/백로그다. 실제 실행 전 범위와 승인 상태를 다시 확인한다. 상세 to-do는 public viewer의 계획 탭을 정본으로 본다.

- **[머지 필요] plan-22 문서 커밋 10개 브랜치 4곳 산재(08-09)** — 공유 체크아웃 브랜치 이동 탓. main에는 `e65ae61`만 반영, 나머지는 각 feat/docs 브랜치 PR 머지로 합류. 첨부 에러 정책 충돌 시 `9311cbf`(기획서 정합)가 정답. plan-22 자체는 결정 5건 전부 종결(정본 docs/plans/22).

- ~~**[PM 대기] 첨부 정책**~~ — **08-09 밤 전부 해소**: ① 형식·용량은 기획서 v1.0.6 정합으로 **에러 칩** 확정(즉시 차단안 철회, `9311cbf`), 이미지 에러 칩은 사유 툴팁 1회 자동 노출 — 재노출은 상태별(error=탭·hover / error-retry=탭 재시도 유지·hover만, 08-09 확정), Storybook `에러사유툴팁` 스토리·피그마 보드 하이퍼링크 연결. 잔무: 개수 토스트 카피(디자인 초안)·툴팁 2.5s 체감 확인. ② 드롭 판정 = **앱 창 전체 재확정**. 같은 날 드롭존 톤 = 검정(action-primary) 확정(블루는 Deep 전용 강조색), 피그마 3컷·스토리 정합 + 흡수 비행 시나리오 컷 신설. PR #63 머지 대기.
- **네트워크·오류 케이스 잔무(08-09 밤)** — 오프라인 배너 컴포넌트 승격(방향 확정 후 DS로) · JP 문구 일괄 검토(모달 제목·배너·에러 문구, 문구 확정 단계에 한 번에) · ComposerGroup 스테일 마스터 계보 청소(마스터 Slot 1~6 vs 인스턴스 내부 Image 1·2/File, 렌더는 정상).
- **[정정] 기획서 §5.3 오프라인 케이스는 이미 그려졌다(2026-08-06).** 다른 세션 인계 노트에 "바로 잡을 수 있는 것"으로 적혀 있으나, `plan-20`에 S9-1 전송 시점 오프라인(`7542:15623`)·S9-2 생성 중 끊김(`7542:94429`)이 결정 노트와 함께 기록돼 있다. 남은 건 그 절의 **주미님 확인 4건**(게이트/토스트 문구, 세션 승계 고지, 비로그인 복구 불가 문구, 기존 전송 실패 화면 opacity 20%)이다.
- **[주미님 손] DS 라이브러리 퍼블리시** — 제품 파일의 첨부 칩 인스턴스가 새 마스터(`State=focused` 등)를 받으려면 필요. Plugin API에 게시 기능이 없어 피그마 UI에서만 가능하다. **08-07 추가분**: `Report/Feedback`·`Button/ActionBar` 선택 슬롯 신규칙(면 `neutral/100`+선 `neutral/300`) 전파도 재게시 대기.
- ~~**[미푸시] prism 피드백 선택 문법 커밋**~~ — **push 완료 + PR #54에 반영됨(08-07 저녁, `origin/feat/dark-band-sheet-body` = `23b40cf`).** 머지는 주미님 리뷰 대기. 미커밋 잔여 2건(19-mvp plan 수정·AttachmentLightbox.stories.tsx, 다른 세션 산출물로 보임)은 커밋 여부 판단 필요.
- **[주미님 확인] `Message Bubble Content=Image` 2건** — chat/chart 고아 마스터 치환에서 제외(DS에 순수 이미지 변형 없음). DS 추가 vs Text+Image 스왑 vs 유지.
- **오프스케일 그림자 29건** — 제품 화면(auth-card 8%·modal 16%·dialog 15%·Toast 복합). 램프 확장 vs 동결 결정 대기. deep 손코딩 ~60건은 컴포넌트화 트랙에서 해소.
- ~~**홈/히스토리·로그인/설정 고아 마스터 치환**~~ — **08-09 완료(212/214)**. 제외 2건(`투자` 세트·변칙 Bottom Bar)과 하단 바 Deep 칩 노출 확인만 주미님 몫(plan-20 「주미님 확인」).
- **deep 손코딩 리포트 뷰 컴포넌트화** — **완료·머지됨(08-09, 0.6.0 배포)**: `VoteBar`·`LegendItem`·`VoteResult` 패키지 포팅(색은 `color.band.*`만, 폭이 데이터인 바는 코드가 정본 계약). DonutChart는 종결(v1.0.6 도넛 폐지)·OpinionRow 보류(손코딩 소스가 PR #48에서 삭제됨). 남은 판단 2건은 plan-20 「주미님 확인」(판정 로직 승격·범례 % 노출), 후순위는 StatHero·ReportCard shell(차주 기획 확정 후).

- ~~**라이브러리 재게시 1회**~~ — **이미 됨(2026-07-31 06:51).** `Badge/Label` 18변형·`Button/DeepCTA`가 게시본에 들어가 있는 것을 componentKey로 확인했다. 다만 8/2에 **라임 변수 값이 바뀌어** 제품 파일 반영을 위한 재게시가 다시 필요하다(주미님 손).
- ~~**`chart/*` semantic 토큰 승격**~~ — **종결 확인(08-09)**: 코드 `color.band.*`+`color.badge.{band}.*`·피그마 `chart/band·badge` 모두 main/DS에 있음.
- ~~**[미푸시] History 빈 목록 문구 통일 커밋 `a82e139`**~~ — **08-09 해소: PR #60 squash 머지로 main 합류(`51b5a53`).** PlanLabel "Free"는 History/Footer 비로그인 variant 재작업 때 결정(유지).
- **형제 칩 포팅** — `SourceChip`(2변형, 쉬움). `Attachment/Chip`은 08-06에 `focused`까지 포팅됨(미리보기 팝오버 `Attachment/Preview`는 피그마만 있고 코드 없음). `ModelChip`·`ChipGroup`은 ideation 승격이 선행.
- **Tier 1 잔여 5종** — `ChatInputBar`(레이아웃이 커진다) · `ModelProfile`(컨트리뷰터 데이터가 `{role, note}`뿐이라 어느 모델인지 정보가 없다 — 데이터 계약 선행) · `Spinner`(반쪽) · `MessageBubble`·`Button/ActionBar`(Deep 경로 인라인 잔존) · `HeaderNavBar` 나머지 1곳(`DeepWaitVote.stories.tsx:357`).
- **문서 정정 4건** — `plan-16` §8 폐기 표시 / `plan-21` 대비표 접전 `cyan`→`orange` / `plan-20` Tier 1 수 / `design-system/tokens/color.md` 낡은 헥스 표(`blue/500`이 문서 `#1292F4` vs 토큰 `#0092F8`).
- **눈으로 볼 것 2건** — `DeepCTA`의 conic 그라데이션 테두리 브라우저 렌더 / 헤더 치환 후 Deep 화면(이모지 → 실제 lucide 아이콘·44px 터치 타깃·glass surface로 시각이 바뀐다).
- 기획서 대조 B-1(결과 화면 방향과 독립적이라 지금 착수 가능): Chat 응답 화면 3종, 피드백 UI(좋아요/싫어요+사유), 예외·에러·빈 상태 화면, ~~파일 첨부 UI~~(08-06 v1.0.6 정합 + PC 드래그앤드롭까지 완료 — PM 정합 08-09 전부 해소), 모드명 JP 보조 라벨, 시각화 그래프 형태 좁히기.
- 가입/탈퇴 플로우는 설계 먼저 → 주미님 확인 → 빌드 순서. 아직 시작하지 않았다.
- 미검증 스킬 5개(`bump-version`·`record-trap`·`save-ideation`·`prep-meeting`·`ux-review-gate`). 07-28 정비 대상이었으나 실행 검증은 안 됐다. 따로 돌리지 말고 실제로 그 일을 할 때 결과를 확인한다.

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
