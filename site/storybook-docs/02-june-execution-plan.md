# 02. 6월 실행 계획

## 1. 목표 기간

- 시작일: 2026-06-11
- 종료일: 2026-06-30
- 작업 방식: Claude Pro + Codex Pro 병행
- 핵심 목표: 6월 안에 POC 제품 흐름을 기준으로 Socra의 Multi-agent 비교 UX와 Chart / Decision Visualization을 Storybook에서 검증 가능한 구조로 확장하고, FE 적용 가능성 검증 루프를 1회 거친다.

---

## 2. 6월 목표 범위

### 반드시 할 것

| 영역 | 작업 |
|---|---|
| Storybook IA | Components 중심 구조를 Primitives / Chat / Product / Patterns / QA로 확장 |
| Agent / Compare | AgentProfile, AgentAnswerCard, SocraSummaryCard, ModelStanceRow |
| Chart / Decision Visualization | ChartContainer, MetricCard, ScoreBar, ComparisonBarChart를 핵심 비교 UX 안에서 우선 검증 |
| Long Text | CollapsibleAnswer, CollapsibleUserMessage |
| Source | Citation, SourceCard, SourceSection 기본 |
| Pattern | MultiAgentComparison 대표 Story |
| Screen | MobileCompareAnswer, DesktopCompareAnswer 초안 |
| QA | Theme / Viewport / Locale 대표 케이스 |
| FE 검증 | 실제 프론트 적용 가능성 1회 확인 |

### 상시 병행할 것

| 작업 축 | 계속 할 일 |
|---|---|
| POC 업데이트 팔로우 | POC 업데이트 내역을 기획 변화로 보고 Storybook scope, Figma, 7월 backlog에 반영 |
| Interaction 고도화 | loading, streaming, retry, collapse/expand, source preview, chart reveal, feedback micro-interaction을 상태 이해와 연결 |
| UI/UX 시각·요소 고도화 | 정보 계층, density, spacing, typography, chart/source/long text가 한 화면에서 경쟁하지 않는지 점검 |
| Git 운영 / 코드 하네스 | Storybook 구현 단위, branch/PR 범위, check/test/visual QA 명령, fixture 관리, regression 방지 루틴 정리 |
| Figma / 문서 관리 | Figma source-of-truth, component spec, Storybook docs, handoff checklist, QA 결과를 최신 POC 기준으로 유지 |

### 6월에서 제외할 것

- Debate Mode
- Panel Discussion Mode
- Advanced Agent Character
- 복잡한 Dashboard Layout
- Radar / Donut / Scatter 전체 체계
- 완전한 i18n QA
- 완전한 accessibility QA
- 완전한 visual regression matrix

---

## 3. Week 1: 6/11 ~ 6/14

### 목표

기준 정리 + Storybook IA 확정 + Codex 작업 준비

| 날짜 | 작업 | 담당 | 산출물 |
|---|---|---|---|
| 6/11 | Figma / Storybook 현황 정리 | Claude | inventory 초안 |
| 6/12 | Storybook IA 개편안 작성 | Claude | `storybook-ia.md` |
| 6/12 | 기존 컴포넌트 매핑 | Claude / Codex | `storybook-inventory.md` |
| 6/13 | MD 템플릿 작성 | Claude | `component-doc-template.md` |
| 6/13 | Story 작성 규칙 정리 | Claude | `storybook-guidelines.md` |
| 6/14 | Codex 작업용 TODO 분리 | Claude | implementation checklist |

### 완료 기준

- 기존 컴포넌트가 새 IA에서 어디로 가야 하는지 정리됨
- 신규 P0 컴포넌트 목록 확정
- Codex가 바로 작업할 수 있는 TODO로 쪼개짐
- 6/13~6/14는 주말이므로 팀 요청을 넣지 않고, 6/15 월요일에 확인할 질문만 정리됨

---

## 4. Week 2: 6/15 ~ 6/21

### 목표

Agent / Compare / Chart 핵심 컴포넌트 Storybook 반영

| 날짜 | 작업 | 담당 | 산출물 |
|---|---|---|---|
| 6/15 | AgentProfile / AgentHeader | Claude + Codex | Storybook stories |
| 6/16 | AgentAnswerCard | Claude + Codex | default / loading / error |
| 6/17 | ChartContainer / MetricCard / ScoreBar | Claude + Codex | chart MVP stories |
| 6/18 | ComparisonBarChart / Chart states | Claude + Codex | chart comparison stories |
| 6/19 | SocraSummaryCard / ModelStanceRow / ConsensusBlock / DisagreementBlock | Claude + Codex | chart 포함 compare blocks |
| 6/20 | locale fixture 초안 + 내부 QA | Claude + Codex | ko/en/ja fixture |
| 6/21 | Week 2 내부 review | 사용자 + Claude | 6/22 수정 list |

### 완료 기준

- Socra의 비교형 UX 핵심 컴포넌트가 Storybook에 올라감
- Chart MVP가 MetricCard / ScoreBar / ComparisonBarChart 범위로 우선 검증됨
- chart loading / empty / error / fallback table 상태가 존재함
- Agent와 Model의 구분 기준이 생김
- 각 컴포넌트에 필요한 대표 Story가 존재함
  - Default
  - Matrix
  - Long Content
  - Theme
  - Locale
- 6/20~6/21은 주말이므로 팀 요청을 넣지 않고 내부 QA와 월요일 수정 리스트만 정리됨

---

## 5. Week 3-1: 6/22 ~ 6/27

### 목표

긴 텍스트 + Source 기본 + MultiAgentComparison 패턴 구축

| 날짜 | 작업 | 담당 | 산출물 |
|---|---|---|---|
| 6/22 | CollapsibleAnswer | Claude + Codex | long answer stories |
| 6/23 | CollapsibleUserMessage / UserPromptSummary | Claude + Codex | long prompt stories |
| 6/24 | Citation / SourceCard / SourceSection 기본 | Claude + Codex | source components |
| 6/25 | MultiAgentComparison Pattern | Claude + Codex | agent + summary + stance + source + chart pattern |
| 6/26 | Chart 포함 responsive / fallback QA | Claude + Codex | mobile 390 / desktop 1280 checks |
| 6/27 | 내부 QA와 월요일 공유용 이슈 정리 | 사용자 + Claude | 6/29 review note |

### 완료 기준

- 긴 질문 / 긴 답변 대응이 Storybook에서 확인됨
- Source 기본형이 존재함
- MultiAgentComparison 대표 패턴이 chart를 판단/비교 구조의 중심으로 포함함
- chart, source, long text가 한 화면에서 서로 경쟁하지 않음
- 6/27은 주말이므로 팀 요청을 넣지 않고 내부 QA와 6/29 공유용 이슈만 정리됨

---

## 6. Week 3-2: 6/28

### 목표

FE handoff 준비 및 내부 적용성 점검

| 날짜 | 작업 | 담당 | 산출물 |
|---|---|---|---|
| 6/28 | FE handoff checklist 초안 정리 | Claude / 사용자 | handoff draft |
| 6/28 | Storybook 문서 기준 대표 viewport 내부 QA | Claude / Codex | mobile 390 / desktop 1280 notes |
| 6/28 | 6/29 FE에게 공유할 제품 적용성 질문 정리 | Claude / 사용자 | question list |

### 완료 기준

- 6/28은 주말이므로 FE/PM/QA 요청을 넣지 않음
- Storybook에서는 되지만 실제 앱에서 깨질 수 있는 후보가 정리됨
- 월요일에 개발 파트가 빠르게 판단할 수 있도록 질문이 제품 적용성 중심으로 정리됨

---

## 7. Final Buffer: 6/29 ~ 6/30

### 목표

FE 피드백 반영 + 정리 + 7월 backlog

| 날짜 | 작업 | 담당 | 산출물 |
|---|---|---|---|
| 6/29 | FE 실제 화면 적용성 1차 검증 | FE + Codex + 사용자 | issue list |
| 6/29 | FE 피드백 반영 | Codex | Storybook cleanup |
| 6/29 | Theme / Viewport / Locale 대표 QA | Codex / 사용자 | checked stories |
| 6/30 | 6월 결과 문서화 | Claude | `june-summary.md` |
| 6/30 | 7월 backlog 작성 | Claude | `next-backlog.md` |

### 완료 기준

- 6월 내 P0 컴포넌트와 대표 패턴이 정리됨
- FE 적용 가능성 검증을 1회 거침
- POC 업데이트 팔로우 결과가 7월 backlog에 반영됨
- 7월로 넘길 항목이 명확히 분리됨

---

## 8. 6월 최종 데모 기준

6월 말까지 아래가 Storybook에서 보여야 한다.

```txt
AgentProfile
AgentHeader
AgentAnswerCard
SocraSummaryCard
ModelStanceRow
ConsensusBlock
DisagreementBlock
CollapsibleAnswer
CollapsibleUserMessage
Citation
SourceCard
SourceSection
ChartContainer
MetricCard
ScoreBar
ComparisonBarChart
MultiAgentComparison
MobileCompareAnswer or Mobile Variant
DesktopCompareAnswer or Desktop Variant
QA/Theme
QA/Viewport
QA/Locale
```
