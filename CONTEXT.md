# 현재 상태 스냅샷

> 새 세션이 현재 기준과 위험 게이트만 빠르게 잡도록 돕는 파일.
> 상세 이력은 `logs/YYYY/MM/YYYY-MM-DD.md`와 각 repo git history를 본다.
> Last updated: 2026-06-17

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

## 2026-06-17 현재 상태

- `riiid/prism`: PR [#8](https://github.com/riiid/prism/pull/8) `review-pasted-text-content` -> `main` 생성. Figma 실대조 기준으로 Checkbox / Toggle / Toast / History Item gray off-ramp를 palette reference로 복구하고, chromatic ramp, status muted dark tint, Storybook QA/Viewport/Locale 표면을 함께 반영했다.
- `riiid/prism`: 검증 `pnpm token:build`, `pnpm typecheck`, `pnpm test`, `pnpm build`, `pnpm pack:check`, `pnpm storybook:build`, `pnpm demo:build` 통과. Gradient old gray 교정은 Figma-side 후속으로 남김.
- `riiid/prism`: Text Field Figma component(`52:49`)에 `Type=box/line` variant 축을 추가했다. 패키지 `TextField` 구현과 Storybook 반영은 승인 후 별도 진행.
- `jumi-worklog`: 2026-06-17 worklog 원본과 `site/worklog.html` public viewer에 Text Field 작업 및 PR #8 기록을 반영했다.
- 남은 후속 작업: Figma-side gradient old gray master 9개 바인딩, Model Profile 브랜드 아이콘 색 결정, focus ring accent 토큰 도입 여부 결정, Text Field package/Storybook 연결.

## 2026-06-16 현재 상태

- `riiid/prism`: PR [#7](https://github.com/riiid/prism/pull/7) `glass-light-dark-colors` → `main` **머지 완료** (`a296620`, 2026-06-16 03:21:46). Glass 표면/컨트롤 색상 동기화, stroke-width 기준 동기화, Storybook autodocs 복구, Checkbox/ChatHistoryPanel glass 보정 등 30개 커밋 반영.
- Chromatic: Build 58 업로드 성공(Storybook Publish, 47 stories published) + UI Review `정주미` 승인(34건 visual/a11y 변경 baseline 채택). `CHROMATIC_PROJECT_TOKEN` 재실행 항목과 Storybook 매트릭스 육안 QA 항목 모두 이 승인으로 완료 처리.
- 이전 세션에서 "남은 항목"으로 기록했던 PR 머지·Chromatic 업로드·Storybook QA 3개는 실제로는 완료돼 있었으나 worklog/CONTEXT.md/prism plan 문서에 반영되지 않았던 것을 발견하고 정정함.
- 남은 후속 작업: Chat History Panel PR #6 EN/JP 말줄임 QA, NavItem 패키지 구현 승인, 글래스모피즘 Modal/Bottom Sheet·Settings·Web 헤더 적용.

## 2026-06-15 현재 상태

- `riiid/prism`: `glass-light-dark-colors` 브랜치에 React Bits 기반 `GlassSurface`, glass semantic tokens, Header/Chat/Toast glass 동기화, Checkbox/Radio/Toggle custom control 보정, HistoryItem 한 줄 구조 보정, Storybook glass review 배경 강화, 작업 완료 후 다음 작업 허락 규칙을 커밋/푸시했다. 커밋은 `adf6454`.
- `riiid/prism`: stroke width 후속으로 `1px` border, `1.5px` small icon thin, `1.8px` 기본 icon/control, `2.2px` strong mark 기준을 Foundation 문서와 package tokens에 추가했다. Checkbox checked mark와 Toast 타입 배지 아이콘은 2.2px, Chip/Photo XBtn small icon은 1.5px로 맞췄고, Chat Input Bar attachment row crop을 보정했다.
- `riiid/prism` 검증: `pnpm check` 통과. `pnpm visual`은 Storybook build까지 통과했지만 `CHROMATIC_PROJECT_TOKEN` 누락으로 Chromatic 업로드 실패.
- `jumi-worklog`: 2026-06-15 worklog 원본과 `site/worklog.html` public viewer에 Prism glass / Storybook QA 동기화 및 stroke width 후속 기록을 추가했다.
- 다음 작업은 새 규칙대로 먼저 범위와 의도를 설명하고 주미님 허락을 받은 뒤 진행한다.

## 2026-06-12 상태 스냅샷

- `jumi-worklog`: 6/12 worklog와 public viewer를 오늘 커밋 전체 기준으로 보강 중이다. 6/11 로컬 수정은 최신 원격과 충돌해 `stash@{0}: preserve-2026-06-11-local-worklog-edit`에 보존되어 있다.
- 공개 워크로그 뷰어는 `https://jumijeong-design.github.io/Jumi-Worklog/worklog.html` 기준이다. 오늘 focus, plan/log 탭 유지, roadmap view, 모바일 drawer, edit/link action, checkbox refresh를 보강했다.
- Socra Storybook 6월 확장 계획은 `docs/10-socra-storybook-collaboration-context.md`를 먼저 읽는다. 원문 30개 문서는 `docs/70-socra-storybook-docs/`에 보존하고, 공개 확인용으로 `site/storybook-docs.html` + `site/storybook-docs/`에 반영했다.
- 글쓰기/Medium 발행 준비는 `writing/글감_리스트.md`를 진입점으로 본다. AX 5편 사례 연재와 Compound Engineering 3편 방법론 연재 초안, `VOICE_GUIDE.md`, 제품/운영 실험 백로그가 `writing/` 아래에 있고, 공개 확인용 `site/writing.html`에 이관했다.
- Glassmorphism 웹 구현 후속 4개는 6/12 plan에서 완료 처리했다. 기준은 `surface/glass-*`, `stroke/glass`, `Effect/glass`, `backdrop-filter`/`-webkit-backdrop-filter`, 미지원 시 alpha surface + stroke + shadow fallback이다.
- 6/12 Figma / 디자인 시스템 plan에서 red scale hue 전체 정규화는 완료 처리했다. 글래스모피즘 추가 적용 영역은 `Chat History Panel`만 완료, Modal / Bottom Sheet, Settings 카드, Web 헤더, Notification / Toast는 잔여 후보로 둔다.
- `riiid/prism`: `component-history-i18n-sync` 브랜치에 `ChatHistoryPanel` 다국어 토큰화와 Storybook 반영을 커밋/푸시했다. Draft PR은 https://github.com/riiid/prism/pull/6 이다.
- Figma `Socra Design system test`: EN/JP mobile history와 EN/JP web home/chat의 `Chat History Panel` 텍스트 override를 토큰 기준으로 동기화했다. 최종 검사 기준 패널 내 한글 잔여 텍스트는 0개다.
- `socra-ai-workflow-wiki`: 최신 원격 기준으로 맞춘 뒤 playbook/guide 번호화, local markdown link check와 role prefix check 추가, site html 재생성.
- 6/12 plan의 완료 항목은 public viewer의 `plan-2026-06-12`에서 `[x]`로 표시한다. 후보는 승인과 다르다.
- 이번 세션에서 잘못 진행한 피그마 glassmorphism 변경은 rollback 완료. 이후 피그마 시각 변경은 명시 승인 전 write 금지.
- `apps/storybook/src/stories/GlassEffect.stories.tsx`는 Chat History Panel 작업 범위 밖 untracked 파일이다. 출처 확인 전 PR/커밋에 포함하지 않는다.
- 완료 보고 전 `jumi-worklog`, `socra-ai-workflow-wiki`, `riiid/prism`의 `git status -sb`와 검증 결과를 다시 확인한다.

---

## 다음 후보 작업

아래는 후보/백로그다. 실제 실행 전 범위와 승인 상태를 다시 확인한다.

- EN/JP mobile/web `Chat History Panel`의 긴 텍스트 `clipping + ellipsis` 처리를 디자이너 QA로 최종 확인한다.
- `GlassEffect.stories.tsx`가 별도 foundation 작업 산출물인지 확인한다.
- 실제 POC 화면/기능을 다시 확인하고 Storybook 컴포넌트 후보를 구현 단위로 연결한다.
- Storybook IA / inventory를 실제 `riiid/prism` Storybook 구조와 연결하는 구현 TODO를 분리한다.
- Prism 다음 구현 후보는 `NavItem` 패키지 구현 → `ChatHistoryPanel` 패키지 구현 → `Components/ChatHistoryPanel` Storybook → `Screens/HomeHistory` 순서다. 시작 전 범위 설명과 허락이 필요하다.
- 가입/탈퇴 플로우는 설계 먼저 → 주미님 확인 → 빌드 순서로 진행한다. 아직 시작하지 않았다.
- AI 워크플로우 Medium 업로드와 POC 페이지 기반 컴포넌트 추가는 백로그로 유지한다.

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
| Claude Code / Codex | candoit.j@gmail.com |
| Figma | jumi.jeong@socra.ai |
| GitHub | JumiJeong-design |
