# 현재 상태 스냅샷

> 새 세션이 현재 기준과 위험 게이트만 빠르게 잡도록 돕는 파일.
> 상세 이력은 `logs/YYYY/MM/YYYY-MM-DD.md`와 각 repo git history를 본다.
> Last updated: 2026-06-12

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

## 2026-06-12 현재 상태

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

## 6/13 후보 작업

아래는 오늘 후보/백로그다. 실제 실행 전 범위와 승인 상태를 다시 확인한다.

- `CHROMATIC_PROJECT_TOKEN`이 있는 환경에서 `pnpm visual` 재실행 후 Chromatic 링크를 기록한다.
- EN/JP mobile/web `Chat History Panel`의 긴 텍스트 `clipping + ellipsis` 처리를 디자이너 QA로 최종 확인한다.
- `GlassEffect.stories.tsx`가 별도 foundation 작업 산출물인지 확인한다.
- 실제 POC 화면/기능을 다시 확인하고 Storybook 컴포넌트 후보를 구현 단위로 연결한다.
- Storybook IA / inventory를 실제 `riiid/prism` Storybook 구조와 연결하는 구현 TODO를 분리한다.
- 다음 sync audit은 hardcoded fill/stroke → text style → effect style → radius/spacing/padding → icon strokeWeight 순서로 진행한다.
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
