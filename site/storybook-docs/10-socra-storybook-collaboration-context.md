# Socra Storybook 협업 컨텍스트

> 목적: Socra Storybook 확장 계획을 AI와 주미님이 함께 빠르게 회수하기 위한 짧은 진입점.
> 원문 패키지: `docs/70-socra-storybook-docs/`
> 작성일: 2026-06-11

---

## 언제 읽나

아래 요청이 나오면 이 문서를 먼저 읽고, 필요한 원문만 추가로 연다.

- Socra Storybook 확장
- Multi-agent / Multi-model 비교 UX
- AgentProfile, AgentAnswerCard, SocraSummaryCard, ModelStanceRow
- Source, Citation, Chart, ScoreBar, ComparisonBarChart
- 긴 질문/긴 답변 접기, streaming, partial failure, retry
- mobile 390 / desktop 1280 Storybook QA
- ko/en/ja fixture, dark mode, accessibility, performance budget

---

## 핵심 방향

Storybook은 단순 컴포넌트 전시장이 아니라 Socra의 핵심 제품 경험을 검증하는 공간으로 둔다.

```txt
User 질문
→ 여러 모델/에이전트 답변
→ 각 답변의 입장 비교
→ 공통점/차이점/충돌점 정리
→ Socra 종합 판단
→ 원문, 출처, 차트, 근거 확인
```

6월 목표는 완성형 디자인 시스템이 아니라, 핵심 UX가 Storybook과 실제 프론트 구조에서 검증 가능한 상태가 되는 것이다.

---

## 6월 범위

반드시 할 것:

- Storybook IA를 `Foundations / Primitives / Chat / Product / Patterns / Screens / QA`로 확장
- Agent / Compare 핵심: `AgentProfile`, `AgentAnswerCard`, `SocraSummaryCard`, `ModelStanceRow`
- 비교 정리: `ConsensusBlock`, `DisagreementBlock`
- Long text: `CollapsibleAnswer`, `CollapsibleUserMessage`
- Source 기본: `Citation`, `SourceCard`, `SourceSection`
- Chart MVP: `ChartContainer`, `MetricCard`, `ScoreBar`, `ComparisonBarChart`
- Radial/gauge chart는 shadcn/ui radial chart를 참고하되, 추천도·신뢰도·진행률 같은 score형 metric 후보로만 검토
- Pattern: `MultiAgentComparison`
- QA 대표 케이스: mobile 390, desktop 1280, light/dark, ko/en/ja
- FE 적용 가능성 1회 검증

6월에서 제외:

- Debate Mode
- Panel Discussion Mode
- Advanced Agent Character
- 복잡한 dashboard layout
- Radial / Radar / Donut / Scatter 전체 chart system
- 완전한 i18n QA
- 완전한 accessibility QA
- 완전한 visual regression matrix

---

## 추천 Storybook IA

```txt
Foundations
Primitives
Chat
Product / Agent
Product / Compare
Product / Source
Product / Chart
Patterns
Screens
QA
Experiments
```

6월에는 `Experiments`를 구현 목표로 보지 않는다. 실험 아이디어를 보관하는 영역이다.

---

## Codex 작업 우선순위

1. `Product/Agent/AgentProfile`
2. `Product/Agent/AgentAnswerCard`
3. `Product/Compare/SocraSummaryCard`
4. `Product/Compare/ModelStanceRow`
5. `Product/Compare/ConsensusBlock`, `DisagreementBlock`
6. `Chat/CollapsibleUserMessage`, `Product/LongText/CollapsibleAnswer`
7. `Product/Source/Citation`, `SourceCard`, `SourceSection`
8. `Product/Chart/ChartContainer`, `MetricCard`, `ScoreBar`, `ComparisonBarChart`
9. `Patterns/MultiAgentComparison`
10. `QA/Theme`, `QA/Viewport`, `QA/Locale`, `QA/ErrorStates`

구현 전에는 실제 `riiid/prism` 또는 `socraAI_product design` repo의 기존 컴포넌트 구조, token, Storybook 설정을 먼저 확인한다.

---

## 데이터 계약 초안

최소 데이터 축:

- `Agent`: id, name, role, baseModel, avatarUrl, tone, capabilities, status
- `AgentAnswer`: id, agentId, status, markdown, summary, stance, confidence, reasonPreview, sources, chartBlocks, errorMessage
- `Source`: id, title, url, type, domain, publishedAt, summary, reliability, freshness
- `ChartBlock`: id, type(`metric`, `scoreBar`, `comparisonBar`, `radialGauge`, `fallbackTable`), title, description, data, series, source, note, status
- `Multi-agent state`: allLoading, partialLoading, partialFailed, allComplete, allFailed, noConsensus, consensus

FE 확인 질문:

- 실제 API 응답에 agent 개념이 있는가?
- model과 agent를 분리할 수 있는가?
- streaming을 지원하는가?
- source는 각 모델별로 분리되는가?
- chart data는 내려오는가, 프론트가 만들어야 하는가?
- 실패/재시도 상태를 모델별로 관리할 수 있는가?

---

## QA 기준

6월 MVP 우선 검증:

- mobile 390px
- desktop 1280px
- light / dark
- ko / en / ja 긴 문자열
- 긴 유저 질문
- 긴 에이전트 답변 여러 개
- 일부 에이전트 실패
- 출처 없음 / 출처 실패
- 차트 empty / error / fallback table
- focus visible, touch target, `aria-expanded`, chart fallback

모션은 장식이 아니라 상태 이해를 위한 용도로만 쓴다. 과한 shimmer/glow는 지양하고 `prefers-reduced-motion`을 고려한다.

---

## 외부 참고 링크

- shadcn/ui radial chart: https://ui.shadcn.com/charts/radial#charts
  - Recharts 기반 radial/gauge 예시로 본다.
  - Socra MVP의 기본 차트 범위는 아니며, score/gauge형 metric이 실제 제품 판단에 필요할 때만 검토한다.
- ChatGPT share `AI 서비스 컴포넌트 설계`: https://chatgpt.com/share/6a2a9726-1340-83a6-9315-fcb6d383cabd
  - AgentAnswerCard, Source/Citation, Chart fallback, event properties, performance 관점을 보강하는 참고 자료로 본다.
  - 현재 source-of-truth는 이 문서와 `docs/70-socra-storybook-docs/` 원문 패키지다.

---

## 원문 읽기 순서

작업 목적별로 필요한 문서만 연다.

| 목적 | 먼저 읽을 문서 |
| --- | --- |
| 전체 방향 | `docs/70-socra-storybook-docs/01-socra-storybook-expansion-plan.md` |
| 일정/범위 | `docs/70-socra-storybook-docs/02-june-execution-plan.md` |
| 작업 티켓 | `docs/70-socra-storybook-docs/03-june-task-breakdown.md` |
| Story 작성 규칙 | `docs/70-socra-storybook-docs/04-storybook-guidelines.md` |
| FE handoff | `docs/70-socra-storybook-docs/05-fe-handoff-checklist.md` |
| 데이터 계약 | `docs/70-socra-storybook-docs/advanced/07-data-contract-and-state-model.md` |
| 모션/상태 | `docs/70-socra-storybook-docs/advanced/08-motion-interaction-guidelines.md` |
| streaming/error | `docs/70-socra-storybook-docs/advanced/09-streaming-feedback-error-states.md` |
| 반응형 | `docs/70-socra-storybook-docs/advanced/12-responsive-web-mobile-design-rules.md` |
| 예외 처리 | `docs/70-socra-storybook-docs/advanced/13-error-exception-case-guidelines.md` |
| 접근성 | `docs/70-socra-storybook-docs/qa/14-accessibility-checklist.md` |

컴포넌트별 문서는 `docs/70-socra-storybook-docs/components/` 폴더에 있다. 현재 공통 템플릿 성격이 강하므로, 실제 구현 시에는 repo의 기존 props/type 패턴에 맞춰 재정의한다.

---

## 주의

- 이 문서는 현재 Prism package/component/token 계약이 아니다.
- 이 문서만 보고 Figma나 코드에 write하지 않는다.
- 실제 구현은 대상 repo의 `README.md`, `AGENTS.md`, Storybook 설정, token/component contract를 먼저 확인한다.
- 공개 위키로 바로 승격하지 않는다. 반복 가능한 운영 교훈으로 정제된 뒤에만 `socra-ai-workflow-wiki` 후보로 본다.
