# 02. 6월 실행 계획

## 1. 목표 기간

- 시작일: 2026-06-11
- 종료일: 2026-06-30
- 작업 방식: Claude Pro + Codex Pro 병행
- 핵심 목표: 6월 안에 Socra의 Multi-agent 비교 UX를 Storybook에서 검증 가능한 구조로 확장하고, FE 적용 가능성 검증 루프를 1회 거친다.

---

## 2. 6월 목표 범위

### 반드시 할 것

| 영역 | 작업 |
|---|---|
| Storybook IA | Components 중심 구조를 Primitives / Chat / Product / Patterns / QA로 확장 |
| Agent / Compare | AgentProfile, AgentAnswerCard, SocraSummaryCard, ModelStanceRow |
| Long Text | CollapsibleAnswer, CollapsibleUserMessage |
| Source | Citation, SourceCard, SourceSection 기본 |
| Chart | ChartContainer, MetricCard, ScoreBar, ComparisonBarChart 기본 |
| Pattern | MultiAgentComparison 대표 Story |
| Screen | MobileCompareAnswer, DesktopCompareAnswer 초안 |
| QA | Theme / Viewport / Locale 대표 케이스 |
| FE 검증 | 실제 프론트 적용 가능성 1회 확인 |

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

---

## 4. Week 2: 6/15 ~ 6/21

### 목표

Agent / Compare 핵심 컴포넌트 Storybook 반영

| 날짜 | 작업 | 담당 | 산출물 |
|---|---|---|---|
| 6/15 | AgentProfile / AgentHeader | Claude + Codex | Storybook stories |
| 6/16 | AgentAnswerCard | Claude + Codex | default / loading / error |
| 6/17 | SocraSummaryCard | Claude + Codex | summary / decision / caution |
| 6/18 | ModelStanceRow | Claude + Codex | stance / confidence / reason |
| 6/19 | ConsensusBlock / DisagreementBlock | Claude + Codex | compare blocks |
| 6/20 | locale fixture 초안 | Claude + Codex | ko/en/ja fixture |
| 6/21 | Week 2 review | 사용자 + Claude | 수정 list |

### 완료 기준

- Socra의 비교형 UX 핵심 컴포넌트가 Storybook에 올라감
- Agent와 Model의 구분 기준이 생김
- 각 컴포넌트에 필요한 대표 Story가 존재함
  - Default
  - Matrix
  - Long Content
  - Theme
  - Locale

---

## 5. Week 3-1: 6/22 ~ 6/27

### 목표

긴 텍스트 + Source 기본 + Chart MVP + Pattern 구축

| 날짜 | 작업 | 담당 | 산출물 |
|---|---|---|---|
| 6/22 | CollapsibleAnswer | Claude + Codex | long answer stories |
| 6/23 | CollapsibleUserMessage / UserPromptSummary | Claude + Codex | long prompt stories |
| 6/24 | Citation / SourceCard / SourceSection 기본 | Claude + Codex | source components |
| 6/25 | ChartContainer / MetricCard / ScoreBar | Claude + Codex | chart MVP stories |
| 6/26 | ComparisonBarChart / Chart states | Claude + Codex | chart comparison stories |
| 6/27 | MultiAgentComparison Pattern | Claude + Codex | agent + source + chart pattern |

### 완료 기준

- 긴 질문 / 긴 답변 대응이 Storybook에서 확인됨
- Source 기본형이 존재함
- Chart MVP 기본형이 존재함
- MultiAgentComparison 대표 패턴이 존재함

---

## 6. Week 3-2: 6/28

### 목표

프론트 개발자 연동 검증 루프 1차

| 날짜 | 작업 | 담당 | 산출물 |
|---|---|---|---|
| 6/28 | FE handoff 문서 전달 | Claude / 사용자 | handoff note |
| 6/28 | 실제 화면 적용 가능성 1차 확인 | FE / Codex | issue list |
| 6/28 | props / data shape / layout 피드백 정리 | FE / Claude | sync checklist |

### 완료 기준

- Storybook 컴포넌트가 실제 프론트 구조에 적용 가능한지 확인됨
- props나 data shape에서 큰 충돌이 있는지 확인됨
- 모바일/PC 대표 화면에서 큰 레이아웃 문제를 확인함
- 수정할 부분이 6/29~6/30 작업으로 정리됨

---

## 7. Final Buffer: 6/29 ~ 6/30

### 목표

FE 피드백 반영 + 정리 + 7월 backlog

| 날짜 | 작업 | 담당 | 산출물 |
|---|---|---|---|
| 6/29 | FE 피드백 반영 | Codex | Storybook cleanup |
| 6/29 | Theme / Viewport / Locale 대표 QA | Codex / 사용자 | checked stories |
| 6/30 | 6월 결과 문서화 | Claude | `june-summary.md` |
| 6/30 | 7월 backlog 작성 | Claude | `next-backlog.md` |

### 완료 기준

- 6월 내 P0 컴포넌트와 대표 패턴이 정리됨
- FE 적용 가능성 검증을 1회 거침
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
