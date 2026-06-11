# Workflow Wiki Source Map

마지막 갱신: 2026-06-11

이 파일은 workflow wiki에서 Medium 글감으로 뽑을 수 있는 원본 위치와 각 문서의 글감 역할을 정리한다.

원본 위치: `/Users/jeongjumi/Desktop/AI_product design_guide/wiki`

## 핵심 글감

### 1. Wiki는 worklog의 예쁜 버전이 아니다

원본:

- `/Users/jeongjumi/Desktop/AI_product design_guide/wiki/guides/daily-worklog-to-wiki.md`
- `/Users/jeongjumi/Desktop/AI_product design_guide/wiki/guides/figma-git-sync.md`
- `/Users/jeongjumi/Desktop/jumi-worklog/writing/_sources/source_scan_insight_candidates.md`

글감:

- worklog는 오늘 실제로 무슨 일이 있었는지 남기는 곳.
- wiki는 그 일을 겪고 나서 다음에도 쓸 수 있는 운영 지식을 남기는 곳.
- 모든 기록을 wiki로 옮기는 것이 아니라, 반복 가능한 교훈만 승격한다.

Medium 제목 후보:

- Wiki는 worklog의 예쁜 버전이 아니었다
- AI 작업 기록을 팀 지식으로 바꾸는 법
- 오늘의 시행착오를 다음 작업의 기준으로 남기기

## 2. Storybook은 디자이너 QA 공간이다

원본:

- `/Users/jeongjumi/Desktop/AI_product design_guide/wiki/notes/storybook-design-system-memo-2026-06-02.md`
- `/Users/jeongjumi/Desktop/AI_product design_guide/wiki/guides/designer-dev-terms.md`
- `/Users/jeongjumi/Desktop/AI_product design_guide/wiki/guides/figma-first-storybook-verified.md`

글감:

- Storybook은 개발자 문서만이 아니라 구현된 디자인 시스템을 확인하는 QA 표면이다.
- Figma는 시각 의도, Git은 구현 계약, Storybook은 실제 상태별 검수에 가깝다.
- 디자이너가 모든 코드를 알아야 한다는 뜻이 아니라, 구현된 컴포넌트의 품질을 볼 수 있는 화면을 갖는다는 뜻이다.

Medium 제목 후보:

- 디자이너가 Storybook을 봐야 하는 이유
- Figma 다음에 Storybook을 보는 디자인 QA
- "Figma랑 달라요"를 줄이는 방법

## 3. Figma-first는 Figma-only가 아니다

원본:

- `/Users/jeongjumi/Desktop/AI_product design_guide/wiki/notes/storybook-design-system-memo-2026-06-02.md`
- `/Users/jeongjumi/Desktop/AI_product design_guide/wiki/guides/figma-git-sync.md`
- `/Users/jeongjumi/Desktop/AI_product design_guide/wiki/playbooks/screen-design-playbook.md`

글감:

- 탐색은 Figma, code prototype, Storybook screen, local app 등 가장 빠르게 판단할 수 있는 표면에서 할 수 있다.
- 다만 확정 기준은 Figma, Git spec, Storybook QA에 맞는 형태로 되돌려야 한다.
- 코드로 먼저 탐색한 것이 곧 최종 기준이 되면 위험하다.

Medium 제목 후보:

- Figma-first는 Figma-only가 아니다
- 디자인 탐색은 여러 표면에서, 기준은 다시 Figma로
- AI가 만든 프로토타입을 디자인 기준으로 승격하는 법

## 4. 디자이너를 위한 개발 협업 용어 번역

원본:

- `/Users/jeongjumi/Desktop/AI_product design_guide/wiki/guides/designer-dev-terms.md`

글감:

- PR, CI, Storybook, Token, Contract, Source of Truth 같은 말을 디자이너가 업무 맥락으로 이해할 수 있게 풀어쓴다.
- 이 글은 방법론보다 자료형 글에 가깝다.
- Medium보다는 Notion/팀 공유용으로도 좋다.

Medium 제목 후보:

- 디자이너가 AI와 개발 문서를 볼 때 필요한 말들
- PR, CI, Contract를 디자이너 언어로 번역하기
- 디자인 시스템에서 개발 용어를 겁내지 않기

## 5. AI agent handoff 문서

원본:

- `/Users/jeongjumi/Desktop/AI_product design_guide/wiki/playbooks/agent-handoff-playbook.md`
- `/Users/jeongjumi/Desktop/jumi-worklog/CONTEXT.md`
- `/Users/jeongjumi/Desktop/jumi-worklog/scripts/check-context-freshness.sh`

글감:

- AI와 오래 일하려면 "이번 세션의 결과"보다 "다음 세션이 어디서 시작할지"가 중요하다.
- CONTEXT, latest worklog, public viewer, git status, source-of-truth 문서를 교차 확인하는 이유를 설명한다.
- stale context를 믿지 않게 하는 장치가 필요하다.

Medium 제목 후보:

- AI가 다음 세션에서도 이어서 일하게 만드는 법
- 좋은 handoff 문서는 AI 협업의 절반이다
- 긴 AI 작업에서 context가 오래되지 않게 관리하기

## 6. Exploration, Candidate, Approved

원본:

- `/Users/jeongjumi/Desktop/AI_product design_guide/wiki/playbooks/screen-design-playbook.md`
- `/Users/jeongjumi/Desktop/AI_product design_guide/wiki/playbooks/component-update-playbook.md`
- `/Users/jeongjumi/Desktop/AI_product design_guide/wiki/guides/figma-first-storybook-verified.md`

글감:

- Figma 안의 모든 것이 구현 기준은 아니다.
- 탐색, 후보, 승인, 아카이브 상태를 나누면 AI가 잘못된 기준을 코드나 Storybook에 반영하는 일을 줄일 수 있다.
- 디자이너의 자유로운 탐색과 시스템의 안정성을 같이 지키는 장치다.

Medium 제목 후보:

- Figma 안의 모든 것은 아직 기준이 아니다
- AI에게 디자인 탐색과 승인 기준을 구분시키기
- Exploration과 Approved를 나누는 이유

## 7. 문서 레벨 설계

원본:

- `/Users/jeongjumi/Desktop/jumi-worklog/docs/00-document-role-map.md`
- `/Users/jeongjumi/Desktop/jumi-worklog/docs/80-external-prompt-architecture-notes.md`
- `/Users/jeongjumi/Desktop/jumi-worklog/CONTEXT.md`

글감:

- 문서가 많아질수록 더 많이 쓰는 것보다 읽는 순서와 역할을 설계해야 한다.
- Entry, Rules, Playbooks, QA, Archive를 나누면 AI가 현재 기준과 과거 맥락을 덜 헷갈린다.
- 00-99 번호 체계는 문서 자체의 정보 구조다.

Medium 제목 후보:

- AI와 일하다 보니 문서에도 정보 구조가 필요했다
- 문서가 많아질수록 중요한 것은 더 쓰는 게 아니라 나누는 일
- AI가 읽을 수 있는 문서 구조 만들기

## 우선순위 판단

가장 먼저 쓸 글:

1. `Wiki는 worklog의 예쁜 버전이 아니었다`
2. `디자이너가 Storybook을 봐야 하는 이유`
3. `Figma-first는 Figma-only가 아니다`

AX 5편 안에 흡수할 글감:

- Figma-first는 Figma-only가 아니다
- Storybook은 디자이너 QA 표면이다
- Wiki는 리서치 승격 레이어다

Compound 3편 안에 흡수할 글감:

- agent handoff
- stale context
- 문서 레벨 설계
- Exploration/Candidate/Approved 구분
