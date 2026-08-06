# 현재 상태 스냅샷

> 새 세션이 현재 기준과 위험 게이트만 빠르게 잡도록 돕는 파일.
> 상세 이력은 `logs/YYYY/MM/YYYY-MM-DD.md`와 각 repo git history를 본다.
> Last updated: 2026-08-06 (전면 갱신은 07-16 기준 · 07-28에 Quick/Deep 결과 화면 + 라벨 뱃지 계열·타이포 램프·브랜치 캐비엇 갱신 · 07-29에 스킬 검증·오탐 수정 반영 · 07-30~31에 prism npm 배포 재개와 `prism-dist` 은퇴 반영 · 08-03에 색 규칙 확정(구간 3색)·PR 4건 머지·Version PR #43·감사표 수치 재정정 반영 · 08-06에 기획서 v1.0.6 정합·첨부 정책 피벗·시트 패밀리 포팅·고아 마스터 종료 반영)
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

## 현재 상태 (2026-08-06 기준)

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
- **라이브러리 publish는 플러그인 API에 없다.** DS에 컴포넌트를 만들어도 주미님이 Figma에서 직접 게시해야 제품 파일이 본다. 신설 → 게시 대기 → 인스턴스 교체가 기본 리듬이다.
- **게시된 variant를 지우면 다른 세션 인스턴스가 뜬다.** 2026-07-28에 `Badge/Label`의 역할 이름 축(success/error/info/warning)을 색 이름 축으로 갈면서 삭제했더니, 그 사이 다른 세션이 쓴 `Type=info` 인스턴스 16개가 마스터에 없는 변형을 붙들었다. 7/29 화면 개편으로 해소됐지만(현재 0개), **축 개편 전 소비자 확인**이라는 교훈은 유효하다.
- **plan-20 감사표 수치를 근거로 쓰기 전에 다시 센다(2026-08-03).** Tier 1 재사용 잔여는 **5종**이다 — `MessageBubble`·`Button/ActionBar`는 Deep 경로에선 아직 인라인이고, `HeaderNavBar`도 3곳 중 2곳만 치환됐다(`DeepWaitVote.stories.tsx:357`). 같은 날 "6종→4종→3종"으로 두 번 줄였는데 두 번 다 낙관적이었다.
- **한 페이지에서 못 찾은 걸 "파일에 없다"로 쓰지 않는다(2026-08-03).** `ModelChip`·`ChipGroup`이 ✅ Components 검색에 0건이라 "Figma에 없다"고 단정했는데 **틀렸다.** 게시 라이브러리에 componentKey가 살아 있고 `docs/plans/11`에 `ModelChip 2937:122`·`ChipGroup 2998:231` 생성 기록도 있다 — `🧪 Opinion Viz (ideation)` 페이지라 안 잡혔을 뿐이다. 남은 건 제작이 아니라 **ideation → ✅ Components 승격**이다.
- **병렬 팬아웃은 Figma MCP 의존 작업으로 채우지 않는다(2026-08-03).** 조사 4건을 서브에이전트로 갈랐다가 전부 MCP 재연결에 걸려 3시간 반 동안 진전 0, 중간 산출물도 못 건졌다. 인라인 재실행에서는 MCP를 안 타는 감사가 제일 먼저 끝났다. 나눌 땐 **외부 의존이 없는 쪽부터** 가른다.
- **카운트 비교 전에 가시성 필터부터.** 7/29에 남은 `Chip` 31개를 보고 "안 써야 할 칩이 다시 들어왔나" 의심했는데 전부 `visible:false`인 잔재였다. 또 페이지 전체를 훑으면 인스턴스 내부 레이어와 타 제품 보드(`vai-home` 등)가 섞인다 — 이 페이지는 최상위 노드가 222개다.

---

## 다음 후보 작업

아래는 후보/백로그다. 실제 실행 전 범위와 승인 상태를 다시 확인한다. 상세 to-do는 public viewer의 계획 탭을 정본으로 본다.

- **[PM 대기] 첨부 정책 2건** — 08-06 디자인 결정이 기획서 v1.0.6과 충돌한다. ① 형식·용량 초과를 에러 칩이 아니라 **즉시 차단+알림**으로 ② 드롭 판정 범위를 창 전체가 아니라 **채팅 영역(LNB 제외)**으로. 보드·컷·plan-19에 플래그돼 있고, PM 확인 전까지 코드/피그마 추가 작업은 멈춘다.
- **[주미님 손] DS 라이브러리 퍼블리시** — 제품 파일의 첨부 칩 인스턴스가 새 마스터(`State=focused` 등)를 받으려면 필요. Plugin API에 게시 기능이 없어 피그마 UI에서만 가능하다.

- ~~**라이브러리 재게시 1회**~~ — **이미 됨(2026-07-31 06:51).** `Badge/Label` 18변형·`Button/DeepCTA`가 게시본에 들어가 있는 것을 componentKey로 확인했다. 다만 8/2에 **라임 변수 값이 바뀌어** 제품 파일 반영을 위한 재게시가 다시 필요하다(주미님 손).
- **`chart/*` semantic 토큰 승격** — 확정된 구간색을 토큰으로. 라임이 main에 있어 착수 가능. 설계안 심사 중.
- **형제 칩 포팅** — `SourceChip`(2변형, 쉬움). `Attachment/Chip`은 08-06에 `focused`까지 포팅됨(미리보기 팝오버 `Attachment/Preview`는 피그마만 있고 코드 없음). `ModelChip`·`ChipGroup`은 ideation 승격이 선행.
- **Tier 1 잔여 5종** — `ChatInputBar`(레이아웃이 커진다) · `ModelProfile`(컨트리뷰터 데이터가 `{role, note}`뿐이라 어느 모델인지 정보가 없다 — 데이터 계약 선행) · `Spinner`(반쪽) · `MessageBubble`·`Button/ActionBar`(Deep 경로 인라인 잔존) · `HeaderNavBar` 나머지 1곳(`DeepWaitVote.stories.tsx:357`).
- **문서 정정 4건** — `plan-16` §8 폐기 표시 / `plan-21` 대비표 접전 `cyan`→`orange` / `plan-20` Tier 1 수 / `design-system/tokens/color.md` 낡은 헥스 표(`blue/500`이 문서 `#1292F4` vs 토큰 `#0092F8`).
- **눈으로 볼 것 2건** — `DeepCTA`의 conic 그라데이션 테두리 브라우저 렌더 / 헤더 치환 후 Deep 화면(이모지 → 실제 lucide 아이콘·44px 터치 타깃·glass surface로 시각이 바뀐다).
- 기획서 대조 B-1(결과 화면 방향과 독립적이라 지금 착수 가능): Chat 응답 화면 3종, 피드백 UI(좋아요/싫어요+사유), 예외·에러·빈 상태 화면, ~~파일 첨부 UI~~(08-06 v1.0.6 정합 + PC 드래그앤드롭까지 완료 — PM 정합 2건만 대기), 모드명 JP 보조 라벨, 시각화 그래프 형태 좁히기.
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
