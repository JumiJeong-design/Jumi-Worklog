# 01. Socra AI Storybook 확장 전략 문서

## 1. 문서 목적

이 문서는 Socra AI의 현재 Figma 컴포넌트, MVP Storybook, 향후 Multi-model / Multi-agent 비교 UX 확장 방향을 기준으로, 6월 안에 어떤 방식으로 디자인 시스템과 Storybook을 확장할지 정리한 전략 문서다.

목표는 컴포넌트를 많이 만드는 것이 아니라, Socra AI의 제품 정체성인 아래 경험을 실제 개발 가능한 구조로 옮기는 것이다.

```txt
여러 모델/에이전트 답변
→ 각 답변의 입장 비교
→ 공통점과 차이점 정리
→ Socra의 종합 판단
→ 긴 텍스트, 출처, 차트, 반응형, 다국어, 다크모드 대응
```

---

## 2. 참고 자료 및 확인 범위

| 구분 | 링크 | 확인 상태 |
|---|---|---|
| Figma Foundation / Markdown Rendering | `https://www.figma.com/file/DcYgJjGAfObOIM4IyrQjgj?node-id=70:218&locale=ko-kr&type=design` | 확인함 |
| Figma Components | `https://www.figma.com/file/DcYgJjGAfObOIM4IyrQjgj?node-id=0:1&locale=ko-kr&type=design` | 확인함 |
| Chromatic Storybook | `https://6a1e5942ec7ecc06429b1040-iycryfufxc.chromatic.com/?path=/docs/components-toggle--docs&globals=theme:light` | 직접 접근 실패. 사용자 캡처 기준으로 확인 |
| POC 링크 | `https://programming-run-storm-palm.trycloudflare.com/?session=b1dc4e4d-a902-4c94-a6c7-c13b90a16855` | 직접 접근 실패. 내부 화면 미확인 |

### 실제 확인한 것

Figma 기준으로 Foundation, Markdown Rendering, Components 구조를 확인했다.  
Storybook은 사용자가 제공한 캡처 기준으로 현재 IA를 확인했다.

### 확인하지 못한 것

- Chromatic Storybook의 실제 Canvas / Docs 상세 내용
- Storybook Controls 구성
- 실제 theme toggle 동작 여부
- viewport / locale toolbar 설정 여부
- POC 내부 화면과 플로우
- 실제 코드 구조 및 props 구조

---

## 3. 현재 상태 요약

현재 Socra AI의 Figma와 Storybook은 MVP 기본 컴포넌트 검증 단계로 보인다.

### 잘 되어 있는 점

| 항목 | 판단 |
|---|---|
| Figma Foundation | 기본 토큰 체계 존재 |
| Markdown Rendering | AI 답변 렌더링 기본 블록 존재 |
| Figma Components | 기본 UI와 Chat 관련 핵심 컴포넌트 구축 |
| Storybook MVP | Button, ChatInputBar 등 기본 컴포넌트가 이미 올라가 있음 |
| Story 하위 구조 | Docs, Default, Matrix, Long Content, Interactive Action 등 좋은 초기 패턴 |
| QA / Theme | theme QA를 별도 섹션으로 둔 점은 좋은 방향 |

### 현재 구조의 한계

| 한계 | 설명 |
|---|---|
| IA가 아직 단순함 | 대부분 `Components` 아래에 평면적으로 들어가 있음 |
| Product UX 레이어 부족 | Agent, Compare, Source, Chart, Pattern, Screen 분리 필요 |
| 반응형 검증 구조 부족 | 모바일/PC 웹 대표 케이스가 IA에서 명확하지 않음 |
| 다국어 검증 구조 부족 | ko/en/ja 텍스트 길이 대응 필요 |
| 긴 텍스트 대응 제한적 | Button Long Content는 있으나 답변/질문 긴 텍스트 대응 필요 |
| POC 미확인 | POC 실제 화면 기반 판단은 아직 포함하지 않음 |

---

## 4. 제품 경험의 핵심 구조

Socra AI는 일반 AI 채팅 서비스보다 아래 구조에 가깝다.

```txt
User 질문
→ 여러 모델/에이전트의 답변
→ 각 답변의 입장 요약
→ 공통점 / 차이점 / 충돌점 정리
→ Socra의 종합 판단
→ 필요 시 원문, 출처, 차트, 근거 확인
```

따라서 Storybook 확장은 일반 컴포넌트 추가보다 아래 7개 축을 중심으로 한다.

1. Multi-model / Multi-agent 답변 비교
2. Agent identity / character 표현
3. 긴 유저 질문 / 긴 AI 답변 처리
4. Source / citation 기반 신뢰도 표현
5. Chart / score 기반 판단 시각화
6. Responsive / theme / locale QA 체계
7. 실제 프론트 적용 검증 루프

---

## 5. Claude Pro + Codex Pro 역할 분담

```txt
Figma / UX 설계 / 문서화 → Claude
Storybook / 코드 구현 / 컴포넌트화 → Codex
검토 / 우선순위 / 최종 판단 → 사용자
```

### Claude Pro 역할

- Figma 구조 분석
- Agent / Compare UX 설계
- MD 스펙 작성
- Edge case 정리
- FE handoff 문서 작성
- 리뷰 후 수정 방향 정리

### Codex Pro 역할

- Storybook IA 리팩터링
- stories 폴더 구조 정리
- 컴포넌트 구현
- Story 파일 생성
- fixture 연결
- theme / locale / viewport decorator 설정
- build / Chromatic 오류 수정
- FE 피드백 반영

---

## 6. 추천 Storybook IA

```txt
Foundations
  Colors
  Typography
  Breakpoints

Primitives
  Button
  Checkbox
  Chip
  Radio
  Spinner
  TabItem
  Toast
  Toggle
  Badge
  Tooltip

Chat
  ChatInputBar
  HeaderNavBar
  HistoryItem
  MessageBubble
  AnswerCard
  ActionBar
  MessageContextMenu

Product / Agent
  ModelProfile
  UserProfile
  AgentProfile
  AgentHeader
  AgentAnswerCard

Product / Compare
  SocraSummaryCard
  ModelStanceRow
  ConsensusBlock
  DisagreementBlock

Product / Source
  Citation
  SourceCard
  SourceSection

Product / Chart
  ChartContainer
  MetricCard
  ScoreBar
  ComparisonBarChart

Patterns
  MultiAgentComparison
  LongAnswerHandling
  SourceExpansion

Screens
  MobileCompareAnswer
  DesktopCompareAnswer

QA
  Theme
  Viewport
  Locale
  LongContent
  MultiAgentStates
  EmptyStates
  PartialFailure

Experiments
  DebateMode
  PanelDiscussionMode
  AskAgentMore
```

---

## 7. 6월 안에 할 것

| 영역 | 작업 |
|---|---|
| Storybook IA | Product UX 확장 가능한 구조로 정리 |
| 문서 | Figma → MD → Storybook → FE handoff 플로우 작성 |
| Agent UX | AgentProfile, AgentHeader |
| Compare UX | AgentAnswerCard, SocraSummaryCard, ModelStanceRow |
| 비교 정리 | ConsensusBlock, DisagreementBlock |
| 긴 텍스트 | CollapsibleAnswer, CollapsibleUserMessage |
| Source 기본 | Citation, SourceCard, SourceSection |
| Chart MVP | ChartContainer, MetricCard, ScoreBar, ComparisonBarChart |
| Pattern | MultiAgentComparison 대표 Story |
| Responsive | mobile 390 / desktop 1280 대표 케이스 |
| Theme | light / dark 대표 케이스 |
| Locale | ko / en / ja fixture 초안 |
| FE Loop | 실제 프론트 적용 가능성 1회 검증 |

---

## 8. 6월 안에 무리하지 않을 것

| 항목 | 이유 |
|---|---|
| Debate Mode | 실험성 높음 |
| Panel Discussion Mode | Agent identity 안정화 후 |
| 복잡한 dashboard layout | MVP 이후 |
| Radar / Donut / Scatter 전체 체계 | 차트 MVP 이후 |
| 모든 다국어 QA | 대표 fixture 우선 |
| 모든 responsive 조합 | 대표 케이스 우선 |
| 완전한 accessibility QA | 7월 이후 |
| 완전한 visual regression matrix | Story 안정화 이후 |

---

## 9. 최종 결론

6월 안의 목표는 완성형 디자인 시스템이 아니라, Socra의 핵심 UX를 Storybook과 실제 프론트 구조에서 검증 가능한 상태로 만드는 것이다.

```txt
Figma / MD에서 구조 정의
→ Storybook P0 컴포넌트 구현
→ 모바일/PC, light/dark, ko/en/ja 대표 확인
→ 실제 프론트 적용 가능성 1회 검증
→ 피드백 반영
→ 7월 backlog 정리
```
