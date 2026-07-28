# 현재 상태 스냅샷

> 새 세션이 현재 기준과 위험 게이트만 빠르게 잡도록 돕는 파일.
> 상세 이력은 `logs/YYYY/MM/YYYY-MM-DD.md`와 각 repo git history를 본다.
> Last updated: 2026-07-28 (전면 갱신은 07-16 기준 · 07-28에 Quick/Deep 결과 화면 항목만 갱신)
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

## 현재 상태 (2026-07-16 기준)

### 운영 모드

- **Claude Code 단일 에이전트** 체제다(2026-07-13~, Codex 병행 중단). 브랜치 전략은 main-first: 짧은 feature 브랜치 → PR → main. 장수 병렬 트랙(`plan/parallel-codex`류)은 새로 만들지 않는다.
- 같은 세션에서 병렬이 필요하면 서브에이전트 + `git worktree` 격리를 쓰되 팬아웃은 3~4개 소규모가 기본이다. **감사·리서치류는 인라인이 기본**(7/10·7/13 대규모 팬아웃이 두 번 다 세션리밋에 걸렸다).
- 2-에이전트 병렬 규칙은 휴면 상태로 보존돼 있다(정본: `riiid/prism`의 `AGENTS.md`). `socra-ai-workflow-wiki`의 핸드오프/컴포넌트 플레이북과 `AGENTS.md`도 2026-07-16에 같은 (휴면) 패턴으로 맞췄다.

### `riiid/prism`

- main 최신은 PR #33까지 통합된 상태다: changeset은 publish가 아니라 changelog 전용으로 명문화됐다. 2026-07-16에 이 방침을 워크플로에도 강제했다 — `release.yml`의 `version-pr` job이 repo variable `ENABLE_VERSION_PR == 'true'`일 때만 돈다(미설정 = 비활성). 배포 재개 시 `.changeset/readme.md` 방침 블록 삭제 + variable 설정 두 곳을 함께 되돌린다.
- `docs/plan19-web-first-v3`는 일정 트랙이다. Codex는 일정 문서 변경을 중단하고, 하네스 변경은 `main` 기준 별도 브랜치 `docs/storybook-harness-followup-2026-07-15`로 분리했다.
- 하네스 후속 브랜치 `docs/storybook-harness-followup-2026-07-15` 커밋 `d5057fe`가 원격에 push됐다. 내용은 Storybook IA/API Docs 문서 정리, 죽은 루트 `.storybook` 설정 제거, component contract ↔ story map coverage gate 보강이다. PR 오픈/머지는 아직 별도 결정 필요.
- 외부 공유용 Storybook은 Chromatic **Build 124**(2026-07-14 수동 업로드, 172 stories). CI 자동 업로드 워크플로는 없어 필요할 때 `pnpm visual`을 수동 실행한다.
- 문서 형식 게이트는 `.githooks/pre-commit`(→ `scripts/validate-design-system.sh`)으로 커밋 전 자동 실행된다. 새 클론은 `git config core.hooksPath .githooks` 필요.

### 열려 있는 결정 (진행을 막고 있는 것)

- **Quick/Deep 결과 화면 방향** — 2026-07-28 기준 크게 전진했다. 형태는 히어로 스택바 + 하단 선택지 카드(개별 막대)로 이미 그려져 있고, 남은 건 **그래프 색 규칙 최종 확정** 하나다. 방향은 "색 = 강조 여부" 2단(강조 = 1등 + 7%p 이내 → `blue/500` 막대 + `blue/100`/`blue/800` 칩 / 나머지 → `neutral/300` 회색)으로 잡혔고, Product 파일 섹션 `6392:12854`에 Quick·Deep × 이지·다지 전체 화면 시안 9개가 있다. 정본은 `riiid/prism`의 `docs/plans/16-quick-deep-result-ui-2026-07.md` §8. 채택되면 `chart/*` 토큰 승격·대기 투표 바 정리·Storybook 정합이 뒤따른다.
- **Prism 미오픈 브랜치 2개 처리** — `docs/storybook-harness-followup-2026-07-15`(`d5057fe`)와 `chore/version-pr-switch-chat-counter`(`7eadfa9`·`9877e40`) 둘 다 원격에 push됐지만 PR 미오픈. 처리 방침을 함께 정하는 게 낫다.
- 기획서(`docs/20-socra-product-spec-2026-07.md`)의 [Open Issues] — 타임아웃 정책·RAG 도메인·계정/인증·개인정보(APPI) 등은 PM/법무 결정 대기라 디자인 착수 불가.

### 알려진 캐비엇

- Product 파일 홈 화면(`5027:3909`)의 컴포저는 DS 라이브러리 마스터가 아니라 **Product 파일 내 로컬 카피**(`5338:50726`)를 참조한다(포크 상태 — DS 마스터를 고쳐도 전파 안 됨). 라이브러리 publish 후 재연결은 defer.
- 죽은 로컬 브랜치 ~20개(`codex/*`·`canary/*`)가 남아 있다. 정리 시 머지 여부를 개별 확인한다.

---

## 다음 후보 작업

아래는 후보/백로그다. 실제 실행 전 범위와 승인 상태를 다시 확인한다. 상세 to-do는 public viewer의 계획 탭을 정본으로 본다.

- Prism 미오픈 브랜치 2개(하네스 후속 / version-pr·카운터) PR 오픈·머지 여부 결정.
- 기획서 대조 B-1(결과 화면 방향과 독립적이라 지금 착수 가능): Chat 응답 화면 3종, 피드백 UI(좋아요/싫어요+사유), 예외·에러·빈 상태 화면, 파일 첨부 UI, 모드명 JP 보조 라벨, 시각화 그래프 형태 좁히기.
- 가입/탈퇴 플로우는 설계 먼저 → 주미님 확인 → 빌드 순서. 아직 시작하지 않았다.

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
