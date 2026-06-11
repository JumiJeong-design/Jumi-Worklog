# Claude 공통 지침 — 정주미

이 파일은 프로젝트에 관계없이 주미님과 일할 때 항상 적용되는 공통 룰이다.
프로젝트별 세부 규칙은 각 프로젝트의 `CLAUDE.md`를 따른다.

---

## 세션 시작 시

1. 이 레포(`JumiJeong-design/jumi-worklog`)의 최근 `logs/YYYY/MM/` 날짜 파일 1~2개를 읽어 맥락 파악
2. 오늘 날짜 worklog 파일이 없으면 세션 종료 시 생성
3. `skills/` 폴더에 공통 스킬 목록이 있음 — 사용자가 트리거하면 해당 SKILL.md 로드
4. `scripts/check-context-freshness.sh`를 실행해 `CONTEXT.md`가 최신 worklog보다 오래됐는지 확인. 경고가 나오면 `CONTEXT.md`를 현재 상태로 믿지 말고 최신 worklog와 관련 repo의 git 상태를 먼저 확인
5. 문서 구조를 정리하거나 새 문서를 만들 때는 `docs/00-document-role-map.md`의 번호 체계를 따른다

## AI 도구별 진입점

| 도구 | 세션 시작 방식 |
|------|---------------|
| Claude Code | `CLAUDE.md` + SessionStart 한스 (`~/.claude/settings.json`) — 자동으로 이 체크리스트 실행 |
| Codex | 이 파일(`AGENTS.md`) 자동 로드 |

## 기본 운영 방식 — 토큰/범위 절약

사용자가 모호하게 말해도 아래 방식을 기본값으로 잡는다.

- 먼저 **분석만** 할지, **수정까지** 할지 구분한다. 사용자가 "진행해", "수정해", "반영해"라고 하기 전에는 큰 수정으로 바로 확장하지 않는다.
- 한 턴에는 가능하면 **한 레포만** 처리한다. 여러 레포가 필요하면 순서를 나눠 보고한다.
- 공개 배포/공개 URL 검증은 문서나 public viewer를 실제로 변경했을 때만 수행한다.
- AI 위키/스킬 승격 검토는 하루 끝이나 사용자가 명시적으로 요청했을 때만 수행한다.
- 새 채팅 시작 시에는 우선 `CLAUDE.md`, `CONTEXT.md`, 오늘 worklog만 읽고 시작한다. 필요할 때만 추가 문서를 연다.
- `CONTEXT.md`의 `Last updated`가 최신 worklog보다 오래됐으면 stale snapshot으로 보고, 자동 로드된 내용을 근거로 바로 수정하지 않는다.

## 공통 스킬 목록

프로젝트에 관계없이 쓰는 스킬은 `skills/` 폴더에 있다.
어느 레포에서 작업 중이더라도 아래 스킬이 트리거되면 해당 SKILL.md를 읽어서 실행한다.

| 스킬 | 트리거 | 파일 |
|------|--------|------|
| `write-worklog` | `워크로그 써줘`, `오늘 정리해줘`, `/write-worklog` | `skills/write-worklog/SKILL.md` |
| `session-snapshot` | `지금까지 뭐했어?`, `중간 정리`, `/session-snapshot` | `skills/session-snapshot/SKILL.md` |
| `sync-entry` | `동기화 확인해줘`, `뷰어랑 맞아?`, `/sync-entry` | `skills/sync-entry/SKILL.md` |
| `handoff-check` | `handoff 확인해줘`, `클로드 코드에서 이어받을 수 있어?`, `/handoff-check` | `skills/handoff-check/SKILL.md` |
| `bump-version` | `버전 올려줘`, `배포할게`, `/bump-version` | `skills/bump-version/SKILL.md` |
| `prep-meeting` | `미팅 준비해줘`, `이번주 요약해줘`, `/prep-meeting` | `skills/prep-meeting/SKILL.md` |
| `record-trap` | `이거 기억해줘`, `규칙 추가해줘`, `/record-trap` | `skills/record-trap/SKILL.md` |

## 디자이너 에이전트 / UX 리뷰 게이트

프론트엔드, public viewer, 문서 뷰어, 모바일 UI, 내비게이션, 편집 화면을 수정할 때는 구현 전에 아래 UX 리뷰 게이트를 통과한다. 이 기준은 Avenir-UX의 step-level usability 평가(SEQ, efficiency, clarity, confidence), Agentic Design Review의 다중 관점 리뷰(배치, 계층, 색, 구성), PrototypeAgent의 의도 정렬/중간 검토 흐름을 이 레포 작업 방식에 맞게 가져온 것이다.

- **역할 분리**: `햄버거/메뉴`, `홈`, `뒤로`, `목록`, `편집`은 서로 다른 역할이다. 같은 기능에 여러 이름을 붙이지 않고, 다른 기능에 같은 이름을 붙이지 않는다.
- **모바일 내비게이션**: 모바일에서 메뉴/인덱스는 상시 접근 가능한 drawer 또는 고정 컨트롤로 제공한다. 사용자가 메뉴를 다시 열기 위해 본문 맨 위로 스크롤해야 하는 구조를 만들지 않는다.
- **홈과 메뉴**: `홈`은 현재 상세/문서 뷰를 닫고 첫 화면으로 돌아가는 동작이다. `햄버거`는 현재 위치와 관계없이 메뉴/인덱스를 여는 동작이다. 둘 중 하나로 다른 하나를 대체하지 않는다.
- **목록/상세 상태**: 목록 화면, 문서 상세 화면, 편집 링크 상태를 명확히 구분한다. 상세 화면에서 사용자는 "지금 무엇을 보고 있고 어디로 돌아갈 수 있는지"를 즉시 알아야 한다.
- **반복 접근 비용**: 주요 작업(메뉴 열기, 홈 복귀, 편집, 다음 문서 이동)은 모바일에서 1탭 이내로 접근 가능해야 한다. 스크롤 위치에 의존하는 탐색은 실패로 본다.
- **명확성 점검**: 버튼 라벨은 사용자의 목적어로 쓴다. 추상어(`인덱스로`)를 쓰기 전에 사용자가 실제로 찾는 말(`홈`, `메뉴`, `편집`, `문서 열기`)인지 확인한다.
- **시각 계층**: 상단바, 사이드바/drawer, 본문, 보조 액션이 서로 경쟁하지 않게 한다. 문서 읽기 화면에서는 본문을 가리지 않고, 탐색은 필요할 때 즉시 열리게 한다.
- **디자인 시스템 일관성**: 같은 레포의 public viewer는 토큰, spacing, 버튼 스타일, markdown 스타일을 공유한다. 새 UI를 만들기 전에 기존 `viewer.css`/`worklog.html` 패턴을 먼저 본다.
- **실제 시나리오 검증**: 수정 후 최소한 다음 경로를 모바일 기준으로 머릿속이 아니라 실제 화면/DOM으로 검증한다: 홈 진입 → 메뉴 열기 → 문서 열기 → 메뉴 다시 열기 → 홈 복귀 → 편집 링크 확인.
- **결과 보고**: UI/UX 수정 완료 보고에는 "무엇을 없앴다"가 아니라 "사용자가 어떤 경로로 무엇을 할 수 있게 됐는지"를 적는다.

## worklog 작성 규칙

- 파일명: `YYYY-MM-DD.md`
- 저장 경로: `logs/YYYY/MM/YYYY-MM-DD.md`
- 사용자 요청은 코드블록으로, Claude 작업은 불릿 포인트로
- `entry-*` / `logs/YYYY/MM/*.md`는 실제 작업 기록, 맥락, 결정, 함정, 회고를 서술하는 곳이다.
- `plan-*`은 todo와 체크 상태만 관리하는 곳이다. 이미 한 작업은 `plan-*`에서 `[x]`, 아직 남은 작업은 `[ ]`로 둔다.
- 체크박스가 사라졌거나 완료 상태가 틀렸다는 요청은 기록에 체크리스트를 새로 만드는 뜻이 아니다. 해당 날짜 `plan-*`에서 todo/check 상태를 복구하거나 수정한다.
- 이월은 미완료 `[ ]` 항목만 다음 날짜 계획으로 옮긴다. 완료 `[x]` 항목은 원래 날짜 plan에 남긴다.
- 프로젝트명을 섹션 헤더에 명시
- 커밋이 있으면 커밋 테이블 포함
- `##` 헤더는 worklog 뷰어에서 서브탭이 되므로 큰 작업 흐름에만 사용한다
- 커밋, 회고, 다음 액션, 보조 기록은 별도 탭으로 만들지 말고 `###` 이하에 둔다
- 새 `##`를 추가하기 전에는 "이 항목이 사용자가 독립 탭으로 전환해 볼 만큼 큰 작업 흐름인가?"를 먼저 판단한다
- 후속 체크리스트는 이전 작업 탭 안에 묻어두지 말고 해당 날짜의 `Next` 또는 다음 날짜 로그로 이월한다
- 워크로그를 수정하면 원본 MD만 고치고 끝내지 않는다. 반드시 `Jumi-Worklog/site/worklog.html`도 같은 내용으로 갱신하고, 커밋/푸시한 뒤 공개 URL `https://jumijeong-design.github.io/Jumi-Worklog/worklog.html`에서 실제 문구가 보이는지 확인한다.
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
