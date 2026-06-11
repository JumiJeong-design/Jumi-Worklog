# AX 실험 소스 스캔 후 인사이트 후보

## 읽은 범위

이번 정리는 아래 자료를 함께 보고 만든다.

| 범위 | 확인한 내용 |
| --- | --- |
| `jumi-worklog` | 2026-05-21~05-31, 2026-06-04~06-06 로그, `CONTEXT.md`, 주요 스킬 문서(`write-worklog`, `sync-entry`, `session-snapshot`, `handoff-check`, `record-trap`, `save-ideation`, `bump-version`) |
| workflow wiki | `figma-first-storybook-verified`, `figma-git-sync`, `ai-design-review`, `designer-dev-terms`, `component-update-playbook`, `screen-design-playbook`, `agent-handoff-playbook`, `daily-worklog-to-wiki`, 주간 메모와 Storybook 메모 |
| Prism / product design repo | `README.md`, `AGENTS.md`, `CLAUDE.md`, `docs/agent-rules.md`, `docs/workflows.md`, `docs/plans/*`, `design-system/foundation/*`, `design-system/sync/sync-log.md`, ADR, package token/component contract, Storybook usage/visual QA |
| Figma design file | `Socra Design system test` metadata. 최상위 페이지는 현재 `Foundation`, `Components` 중심으로 정리되어 있고, Foundation에는 color/semantic alpha/shadow/markdown rules, Components에는 Button/Chat Input Bar/Text Field/History Item/User Profile/Tooltip/Table 등 실제 컴포넌트 축이 있음 |
| FigJam board | 브랜드 아이데이션, 제품 근거, 후보 탈락/생존, Phase 0~6 로드맵, 날짜별 결정 카드 구조 확인 |

짧게 말하면, 이번 실험의 핵심 자료는 모두 “결과물”보다 “기준을 만드는 과정”에 더 많은 흔적이 남아 있다.

---

## 제일 큰 인사이트

이번 글의 중심은 `AI로 UI를 빨리 만들었다`가 아니라 아래 쪽이 더 정확하다.

```text
AI를 디자인 시스템에 넣어보니,
진짜 작업은 화면 생성이 아니라
Figma, Git, Storybook, Worklog, Wiki 사이의 기준 레벨을 설계하는 일이었다.
```

AI는 빠르게 만든다. 하지만 빠르게 만드는 만큼, 아직 탐색 중인 것과 승인된 것, 코드로 옮겨도 되는 것과 멈춰야 하는 것을 더 엄격히 나눠야 했다.

---

## 인사이트 후보 1. 직접 코드화는 탐색을 줄였다

초기에는 Figma나 시안을 바로 코드로 바꾸면 빠를 것처럼 보였다.

하지만 워크로그를 보면 5/21~5/26 사이에 이미 방향 전환이 있었다.

- 코드가 먼저 생기면 Figma가 디자인 도구가 아니라 캡처/문서화 도구처럼 밀린다.
- 코드가 source of truth처럼 굳으면 탐색 단계가 사라진다.
- AI가 완성본처럼 보이는 결과를 너무 빨리 주면 이후 발산이 `다른 방향 탐색`이 아니라 `그 결과물 수정`으로 좁아진다.
- 특히 브랜드 톤, 제품 감도, B2C 품질처럼 애매한 판단이 필요한 영역에서는 완성도가 높아 보이는 AI 결과물이 오히려 생각의 틀을 만들 수 있다.

공유글에서는 이렇게 쓰면 좋다.

```text
AI가 빨리 완성해주는 능력은 구현 단계에서는 장점이지만,
탐색 단계에서는 디자이너가 일부러 흔들어봐야 하는 생각을 너무 빨리 고정시키는 리스크가 있었다.
```

---

## 인사이트 후보 2. Figma-first는 Figma-only가 아니었다

위키와 주간 메모에서 중요한 정리가 있다.

Figma가 시각 기준의 source of truth이긴 하지만, 모든 탐색을 Figma에서만 시작해야 한다는 뜻은 아니다.

- 인터랙션
- 데이터 상태
- 입력/로딩/에러
- 모바일 반응형
- 실제 텍스트 overflow

이런 것은 코드 prototype, Storybook screen, local app에서 먼저 보는 편이 더 빠를 수 있다.

다만 중요한 선은 이것이다.

```text
탐색은 여러 표면에서 할 수 있다.
하지만 승인 기준은 Figma와 contract로 돌아와야 한다.
```

이 문장은 2편이나 3편에 꼭 들어가면 좋다. 현재 3편에 `모바일/데스크톱 분업`은 들어갔지만, `Figma-first != Figma-only`까지 명시하면 오해가 줄어든다.

---

## 인사이트 후보 3. Figma Foundation은 AI 통제 장치였다

Figma 파일을 실제로 보니 Foundation 페이지가 단순 팔레트가 아니었다.

- Colors / Material Palette
- Opacity / Semantic Alpha
- Shadow / Elevation
- Markdown Rendering Rules
- Markdown Blocks / Components

Prism 문서에서도 같은 흐름이 반복된다.

- category color는 taxonomy가 없어서 제거
- disabled/loading/pressed는 layer opacity가 아니라 semantic token으로 처리
- dark shadow는 단순 alpha 반전이 아니라 surface/stroke/drop/inner highlight 조합으로 판단
- typography는 한국어/일본어/영문 역할이 다름
- icon stroke, table structure, markdown table cell까지 foundation 범위에 포함

즉 Foundation은 예쁜 기본값 목록이 아니라 AI가 임의로 값을 만들지 못하게 하는 시각 규칙이었다.

공유글에서는 `Figma 안에서도 Foundation 설계를 잘해야 한다`를 별도 인사이트로 빼는 게 맞다.

---

## 인사이트 후보 4. Git Rules는 두 번째 디자인 시스템이었다

Git은 Figma의 백업이 아니었다. Git은 Figma를 AI/FE가 실행할 수 있는 언어로 바꾸는 곳이었다.

Prism 쪽 문서들은 계속 같은 말을 한다.

- Figma 디자인 > git package > Storybook
- component contract와 token contract는 Figma 결정을 코드로 기록하는 계약
- Figma에 없는 컴포넌트를 package나 Storybook에서 먼저 만들지 않는다
- public props, DOM semantics, ARIA, keyboard behavior, CSS import path, public token name은 승인 없이 바꾸지 않는다
- projectless Codex 폴더는 scratch이고 source of truth가 아니다

이건 개발 문서 정리가 아니라, AI의 행동 범위를 정하는 디자인 시스템이었다.

공유글 문장 후보:

```text
Figma Foundation이 시각 값을 통제했다면,
Git Rules는 AI가 무엇을 읽고, 어디까지 고치고, 어디서 멈춰야 하는지를 통제했다.
```

---

## 인사이트 후보 5. FE package는 제한이 아니라 기준점이었다

사용자가 말한 `FE님이 패키지 줘서 반영한 것`은 중요하다.

이전 흐름은 `디자인 -> AI 코드화`였다. 이때는 AI가 빠르게 만들 수 있지만, 실제 FE 패키지 구조와 맞는지 알기 어렵고 토큰/상태/접근성/API가 흔들릴 수 있었다.

FE package가 들어온 뒤에는 흐름이 바뀌었다.

```text
Figma 승인
-> Git에서 component/token contract로 언어화
-> Package contract/source에 반영
-> Storybook에서 상태별 QA
```

이 전환 덕분에 대화도 달라진다.

- `느낌 맞춰줘`가 아니라 `variant axis와 prop 계약을 어떻게 둘지`
- `Storybook이 달라요`가 아니라 `shell은 달라도 component internals가 Figma/token/contract를 따르는지`
- `AI가 고쳤어요`가 아니라 `Figma, contract, package, Storybook 중 어디를 바꿨는지`

이건 1편의 전환점이자 2편의 workflow 핵심으로 남겨야 한다.

---

## 인사이트 후보 6. Storybook은 예쁜 문서가 아니라 QA 표면이었다

Storybook 메모와 Prism 문서는 Storybook의 역할을 명확히 나눈다.

- Storybook은 Figma를 대체하지 않는다.
- Storybook page chrome/shell은 Figma와 같을 필요 없다.
- 중요한 것은 렌더링된 component internals가 Figma token과 package contract를 따르는지다.
- Button, Tooltip, locale, long text, dark mode, matrix story, Chromatic baseline은 디자이너가 구현 품질을 확인하는 표면이다.

공유글에서 `Storybook = FE 문서`가 아니라 `디자이너 QA surface`라고 쓰면 이번 실험의 차별점이 살아난다.

---

## 인사이트 후보 7. Worklog는 회고가 아니라 운영 엔진이었다

`write-worklog` 스킬을 보면 worklog는 꽤 엄격하다.

- 원본 md 저장
- public viewer 동기화
- CONTEXT.md 갱신
- Notion 업로드
- 3개 repo commit 조회
- main 도달 가능한 SHA만 기록
- 미완료 항목 이월
- 함정과 회고/인사이트 필수
- 공개 HTML 월별 체크박스 검증

그리고 `handoff-check`는 다음 AI가 문서만 읽고 이어갈 수 있는지 확인한다.

그래서 worklog는 단순히 `오늘 뭐 했는지`가 아니다.

```text
계획을 쓴다
-> 작업하면서 체크한다
-> 미완료와 리스크를 분리한다
-> 다음 액션을 계산한다
-> 반복되는 교훈을 wiki/rule/playbook으로 승격한다
```

사용자가 말한 `계획 -> 작업한 일 체크 -> 다음에 할 일 계산`은 반드시 유지하면 좋다.

---

## 인사이트 후보 8. Wiki는 worklog 정리가 아니라 리서치 승격이었다

wiki를 보면 단순 요약이 아니라 별도 조사 흔적이 많다.

- `designer-dev-terms`: 디자이너가 PR/CI/Storybook/Token/Contract/Source of Truth를 FE와 같은 언어로 이해하기 위한 문서
- `figma-git-sync`: wiki가 실제 package contract를 소유하지 않는다는 경계 문서
- `component-update-playbook`: Figma origin status를 먼저 분류하고, source가 불명확하면 멈추는 절차
- `screen-design-playbook`: exploration/candidate/approved를 분리
- `daily-worklog-to-wiki`: 어떤 worklog를 팀 지식으로 승격할지 판단 기준

즉 wiki는 `worklog의 예쁜 버전`이 아니다.

```text
worklog = 오늘 실제로 무슨 일이 있었는지
wiki = 그 일을 겪고 나서 다음에도 쓸 수 있는 운영 지식은 무엇인지
```

공유글에서는 wiki를 2편의 workflow 안에 넣고, 3편에서 `Research Layer`로 다시 강조하면 좋다.

---

## 인사이트 후보 9. 문서가 많아지면 문서 레벨 설계가 필요하다

사용자가 말한 것처럼, Git 안에 문서 파일이 많아지면 한 번에 파악하기 어렵다.

Prism에도 이미 여러 레벨이 있다.

- Entry: `README.md`, `AGENTS.md`, `CLAUDE.md`
- Rules: `docs/agent-rules.md`, `design-system/rules.md`
- Contract: `packages/prism/token-contract.md`, `component-contracts/*.md`
- Evidence: `design-system/components/*.md`, `design-system/foundation/*.md`
- History: `sync-log`, ADR, worklog
- Plan: follow-up docs, schedule replan

앞으로 더 필요해지는 작업은 `문서 작성`이 아니라 `문서 읽기 레벨 설계`다.

글에 넣을 문장:

```text
AI는 많은 문서를 읽을 수 있지만, 문서가 많아질수록 현재 기준과 과거 근거를 구분하는 레벨 설계가 필요했다.
```

---

## 인사이트 후보 10. AI는 더 나은 방향으로 가려는 경향이 있어 멈춤 조건이 필요했다

특히 Codex는 repo를 읽고 판단한 뒤, 더 낫다고 생각하는 방향으로 고치려는 실행력이 있다.

이건 장점이지만 디자인 시스템에서는 위험했다.

실제 Button 작업에서도 Storybook/Figma 차이를 보고 package token/implementation을 고치려다, `package source는 임의 수정하지 않는다`는 조건과 충돌해 revert했다.

따라서 프롬프트에는 `해줘`만이 아니라 `멈춰야 하는 조건`이 들어가야 한다.

- Figma source가 불명확하면 멈춘다.
- package-sensitive 항목이면 contract부터 확인한다.
- Figma에 없는 variant는 만들지 않는다.
- AI가 만든 candidate를 approved처럼 기록하지 않는다.
- 사용자의 시각 판단이 필요한 항목은 완료 처리하지 않는다.

이 내용은 3편의 핵심이다.

---

## 인사이트 후보 11. 모바일과 데스크톱 AI 분업도 운영 설계다

사용자 메모처럼 Claude는 모바일 앱에서 바로 쓸 수 있고, Codex는 로컬 repo/파일/빌드/Storybook 검증 때문에 컴퓨터가 켜져 있어야 한다.

이 차이는 단순 편의가 아니라 토큰과 집중도 운영이다.

| 환경 | 잘 맞는 일 |
| --- | --- |
| Claude mobile | 이동 중 생각 정리, 아이디어 발산, 계획 초안, 회고, 다음 질문 정리 |
| Codex desktop | 실제 repo 읽기, 문서/코드 수정, 빌드/테스트, Storybook QA, 커밋 전 점검 |

이렇게 나누면 Codex에서 긴 맥락을 다시 설명하는 비용을 줄이고, 컴퓨터를 켰을 때 바로 실행으로 들어갈 수 있다.

---

## 인사이트 후보 12. 브랜드와 마지막 디테일은 디자이너가 직접 해야 한다

FigJam과 Foundation 기록을 같이 보면 AI가 아이데이션과 구조화는 잘했지만, 마지막 브랜드 품질은 직접 봐야 한다는 흐름이 보인다.

- 후보를 넓히고 줄이는 과정
- 일본 시장에서 어떻게 읽힐지
- 제품의 신뢰감과 캐릭터/아이콘 톤이 맞는지
- category color를 지금 token으로 만들면 오히려 톤이 흔들리는지
- dark shadow, icon stroke, table cell, 긴 텍스트 여백이 실제 화면에서 자연스러운지

AI가 제안할 수는 있지만 `이게 우리 제품답다`는 판단은 디자이너 몫이다.

---

## 3편 구성에 반영할 위치

### 1편 보강 포인트

현재 1편의 방향은 좋다. 여기에 아래 두 문장을 더 선명하게 넣으면 좋다.

- `AI가 완성본처럼 보이는 결과를 너무 빨리 만들면, 디자이너의 탐색이 결과물 수정으로 좁아졌다.`
- `직접 코드화가 문제였던 이유는 코드 품질만이 아니라, 탐색 단계가 사라지는 구조였기 때문이다.`

### 2편 보강 포인트

2편은 workflow 설명이 중심이라 아래를 더 강조하면 좋다.

- `Figma-first는 Figma-only가 아니다. 탐색 표면은 여러 개일 수 있지만 승인 기준은 Figma/contract로 돌아와야 한다.`
- `FE package는 AI workflow의 제한이 아니라 기준점이었다.`
- `Wiki는 worklog 정리가 아니라 리서치 승격 레이어였다.`
- `Storybook은 예쁜 docs가 아니라 디자이너 QA surface였다.`

### 3편 보강 포인트

3편은 안전장치 중심이라 아래가 핵심이다.

- `Figma Foundation`과 `Git Rules`를 따로 빼는 것이 맞다.
- `문서 레벨 설계`는 앞으로 해야 할 과제로 남긴다.
- `Codex는 더 낫다고 판단하면 실행하려는 경향이 있어 stop condition이 필요했다.`
- `모바일/데스크톱 분업`은 토큰 소모와 실행 효율 관점에서 넣는다.
- `마지막 디테일은 디자이너가 직접 만든다`를 결론부에 둔다.

---

## 추천 제목 후보

### 시리즈 제목

- AI가 디자인을 대신하지 않게 만들기
- 디자인 시스템에 AI를 넣기 전에 정해야 했던 것들
- AI-Figma-Git-Storybook: 빠른 제작보다 기준 설계가 먼저였다

### 1편

- AI로 바로 코드화하려다 멈춘 이유
- 빠른 완성본이 디자인 탐색을 좁힐 때
- 코드가 너무 빨리 기준이 되면 생기는 일

### 2편

- Figma를 Git으로 번역하고 Storybook으로 검수하기
- FE package를 기준으로 AI workflow 다시 짜기
- Figma 승인, Git 계약, Storybook QA

### 3편

- AI가 디자인 시스템을 망치지 않게 만든 안전장치들
- Foundation, Rules, Worklog: AI를 통제하는 세 가지 레이어
- AI가 멈춰야 하는 지점을 설계하기

---

## 최종 공유글에서 가장 세게 가져갈 문장

```text
이번 실험에서 AI가 줄여준 시간은 디자인 판단 자체라기보다,
판단 이후의 정리, 검증, 전달, 재사용 비용이었다.
```

```text
AI를 디자인 시스템에 넣는 일은 자동화가 아니라 운영 설계에 가까웠다.
```

```text
Figma는 시각 기준을 승인하고, Git은 그 기준을 언어화하고,
Storybook은 package에 반영된 결과를 검수하고,
Worklog/Wiki는 다음 세션과 팀이 다시 쓸 수 있게 만든다.
```

```text
AI가 잘하는 일은 넓게 보고 빠르게 정리하는 것이고,
디자이너가 해야 하는 일은 무엇을 승인된 기준으로 남길지 판단하는 것이다.
```
