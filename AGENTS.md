# Jumi-Worklog — 운영 지침

날짜별 작업 로그·세션 맥락·공통 스킬을 관리하는 오케스트레이션 레포다.
레포와 무관한 공통 작업 방식은 `~/.claude/CLAUDE.md`에 있다.

---

## 세션 시작 시

1. 이 레포(`JumiJeong-design/Jumi-Worklog`)의 최근 `logs/YYYY/MM/` 날짜 파일 1~2개를 읽어 맥락 파악
2. 오늘 날짜 worklog 파일이 없으면 세션 종료 시 생성
3. `skills/` 폴더에 공통 스킬 목록이 있음 — 사용자가 트리거하면 해당 SKILL.md 로드
4. `scripts/check-context-freshness.sh`를 실행해 `CONTEXT.md`가 최신 worklog보다 오래됐는지 확인. 경고가 나오면 `CONTEXT.md`를 현재 상태로 믿지 말고 최신 worklog와 관련 repo의 git 상태를 먼저 확인
5. 문서 구조를 정리하거나 새 문서를 만들 때는 `docs/00-document-role-map.md`의 번호 체계를 따른다

## 에이전트 체제

2026-07-13부터 **Claude Code 단일 에이전트** 체제다(Codex 병행 중단). 같은 세션에서 병렬이 필요하면 별도 에이전트가 아니라 서브에이전트 + `git worktree` 격리를 쓰고, 팬아웃은 3~4개 소규모를 기본으로 한다(감사·리서치류는 인라인 우선 — 대규모 팬아웃이 두 번 세션리밋에 걸렸다).

## 기본 운영 방식 — 토큰/범위 절약

사용자가 모호하게 말해도 아래 방식을 기본값으로 잡는다.

- 먼저 **분석만** 할지, **수정까지** 할지 구분한다. 사용자가 "진행해", "수정해", "반영해"라고 하기 전에는 큰 수정으로 바로 확장하지 않는다.
- 한 턴에는 가능하면 **한 레포만** 처리한다. 여러 레포가 필요하면 순서를 나눠 보고한다.
- 공개 배포/공개 URL 검증은 문서나 public viewer를 실제로 변경했을 때만 수행한다.
- AI 위키/스킬 승격 검토는 하루 끝이나 사용자가 명시적으로 요청했을 때만 수행한다.
- 새 채팅 시작 시에는 우선 `CLAUDE.md`, `CONTEXT.md`, 오늘 worklog만 읽고 시작한다. 필요할 때만 추가 문서를 연다.
- `CONTEXT.md`의 `Last updated`가 최신 worklog보다 오래됐으면 stale snapshot으로 보고, 자동 로드된 내용을 근거로 바로 수정하지 않는다.
- `오늘 할 일`, `이어받자`, `진행하자`처럼 상태 확인이 필요한 요청은 먼저 최신 worklog → `scripts/check-context-freshness.sh` → 관련 repo `git status -sb` 순서로 확인한 뒤 실행 범위를 잡는다.
- plan/worklog/backlog 문구는 후보와 기록이지 실행 승인이나 실제 완료 증거가 아니다. write 작업 전에는 source-of-truth 파일, GitHub 상태, 필요 시 Figma 실제 상태를 직접 확인한다.
- 완료 보고에서 "완료"라고 부르려면 source 변경, 생성물/뷰어 fallback, 공개 또는 시각 표면, plan/log 기록이 서로 맞아야 한다. 해당 작업에 없는 축은 "해당 없음"으로 명시하고 넘어간다.

## 동시 작업

**한 repo에 한 에이전트.** 같은 체크아웃(폴더)을 둘이 동시에 git 작업하지 않는다.
한 폴더엔 HEAD·index·stash가 각각 1개뿐이라 동시 commit/rebase/push는 서로를 덮어쓴다
(오늘 worklog `logs/*.md` 동시 append + push 충돌이 이 경우). 공유 working tree에서
`git stash -u` 금지. 꼭 동시여야 하면 `git worktree`로 폴더를 분리한다.

> 두 에이전트 병행 시의 상세 규칙(소유 경계·생성물 단일 소유·계약 우선·foundation-first 머지)은
> 휴면 상태이며 정본은 `riiid/prism`의 `docs/agent-parallel-rules.md`에 있다.

## 공통 스킬

`skills/`의 스킬은 `~/.claude/skills/`에 심링크로 등록되어 있어 어느 레포에서든
트리거만으로 실행된다. 새 스킬을 추가하면 심링크도 함께 만든다:
`ln -sfn <경로> ~/.claude/skills/<이름>`

## UX 리뷰 게이트

프론트엔드·public viewer·문서 뷰어·모바일 UI·내비게이션·편집 화면을 수정할 때는
구현 전에 `ux-review-gate` 스킬을 통과한다.

## 완료 기준

에이전트는 산출물에 "완료"를 단독으로 쓰지 않는다. `1차` / `공유 가능` / `픽스` 단계명으로
보고하고, 남은 단계를 문장으로 남긴다(`1차 완료 — 남은 것: 시각 품질, UX 흐름`).
`공유 가능` 선언은 자가 검사 결과를 첨부했을 때만, `픽스`는 디자이너만 선언한다.
기준 정본은 `docs/20-completion-criteria.md`.

## worklog 작성 규칙

- 파일명: `YYYY-MM-DD.md`
- 저장 경로: `logs/YYYY/MM/YYYY-MM-DD.md`
- 사용자 요청은 코드블록으로, Claude 작업은 불릿 포인트로
- `entry-*` / `logs/YYYY/MM/*.md`는 실제 작업 기록, 맥락, 결정, 함정, 회고를 서술하는 곳이다.
- `plan-*`은 todo와 체크 상태만 관리하는 곳이다. 이미 한 작업은 `plan-*`에서 `[x]`, 아직 남은 작업은 `[ ]`로 둔다.
- 체크박스가 사라졌거나 완료 상태가 틀렸다는 요청은 기록에 체크리스트를 새로 만드는 뜻이 아니다. 해당 날짜 `plan-*`에서 todo/check 상태를 복구하거나 수정한다.
- 이월은 미완료 `[ ]` 항목을 빠짐없이 모두 다음 날짜 계획으로 옮긴다. 완료 `[x]` 항목은 이월하지 않고 원래 날짜 plan에 남긴다.
- 프로젝트명을 섹션 헤더에 명시
- 커밋이 있으면 커밋 테이블 포함
- `##` 헤더는 worklog 뷰어에서 서브탭이 되므로 큰 작업 흐름에만 사용한다
- 커밋, 회고, 다음 액션, 보조 기록은 별도 탭으로 만들지 말고 `###` 이하에 둔다
- 새 `##`를 추가하기 전에는 "이 항목이 사용자가 독립 탭으로 전환해 볼 만큼 큰 작업 흐름인가?"를 먼저 판단한다
- 후속 체크리스트는 이전 작업 탭 안에 묻어두지 말고 해당 날짜의 `Next` 또는 다음 날짜 로그로 이월한다
- 워크로그를 수정하면 원본 MD만 고치고 끝내지 않는다. 반드시 같은 repo의 `site/worklog.html`도 같은 내용으로 갱신하고, 커밋/푸시한 뒤 공개 URL `https://jumijeong-design.github.io/Jumi-Worklog/worklog.html`에서 실제 문구가 보이는지 확인한다.
- 공개 URL 확인은 문구 존재만 보면 안 된다. 사용자가 보는 월 전체를 기준으로 `scripts/verify-public-worklog-month.mjs --html <worklog.html> --month YYYY-MM --allow-plan plan-YYYY-MM-DD --allow-unchecked plan-YYYY-MM-DD`처럼 실행해 날짜별 unchecked 수와 허용되지 않은 plan 블록을 확인한다. Plan/Log 탭과 캘린더 두 색 점은 `plan-*` 블록에 의존하므로 정상 plan 블록을 삭제하지 않는다.

## 커뮤니케이션

- 짧고 직접적으로
- 설명보다 행동 우선
- 확인이 필요한 경우에만 질문

## 계정 정보

| 서비스 | 계정 |
|--------|------|
| Claude Code / Codex | candoit.j@gmail.com |
| Figma | jumi.jeong@socra.ai |
| GitHub | JumiJeong-design |
