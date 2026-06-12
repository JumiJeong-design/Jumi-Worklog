# 03. 6월 작업 티켓 분해

이 문서는 Claude / Codex에게 실제로 넘길 수 있는 작업 단위로 구성한다.

---

## 실행 순서 기준

6월 실행 순서는 POC 제품 업데이트를 계속 팔로우하면서 조정한다. Storybook이 POC와 별도의 새 기준을 만들지 않도록, 실제 제품 흐름에 있는 비교/판단/차트/출처/긴 텍스트를 우선 검증한다.

| 순서 | 작업 |
|---|---|
| 1 | IA / inventory / Storybook guideline 정리 |
| 2 | AgentProfile / AgentAnswerCard |
| 3 | Chart MVP: ChartContainer, MetricCard, ScoreBar, ComparisonBarChart |
| 4 | SocraSummaryCard, ModelStanceRow, ConsensusBlock, DisagreementBlock |
| 5 | CollapsibleAnswer, CollapsibleUserMessage |
| 6 | Citation, SourceCard, SourceSection |
| 7 | MultiAgentComparison Pattern |
| 8 | FE 제품 적용성 검증 |

---

## TASK-01. Storybook IA 개편안 작성

| 항목 | 내용 |
|---|---|
| 목적 | 기존 Components 중심 IA를 Product UX 확장 가능한 구조로 재정리 |
| 담당 | Claude |
| 입력 | 현재 Storybook 캡처, Figma Components 구조 |
| 산출물 | `docs/storybook-ia.md` |
| 완료 기준 | Primitives / Chat / Product / Patterns / Screens / QA 구조가 정의됨 |

---

## TASK-02. 기존 컴포넌트 Inventory 작성

| 항목 | 내용 |
|---|---|
| 목적 | 기존 Figma / Storybook 컴포넌트를 existing / extend / new / experiment로 분류 |
| 담당 | Claude |
| 산출물 | `docs/storybook-inventory.md` |
| 완료 기준 | 기존 컴포넌트의 새 IA 위치가 정의됨 |

---

## TASK-03. Storybook Guidelines 작성

| 항목 | 내용 |
|---|---|
| 목적 | Story 작성 규칙, viewport/theme/locale 기준 정의 |
| 담당 | Claude |
| 산출물 | `docs/storybook-guidelines.md` |
| 완료 기준 | Default / Matrix / LongContent / Theme / Locale / Edge Case 기준 정의 |

---

## TASK-04. AgentProfile 스펙 작성

| 항목 | 내용 |
|---|---|
| 목적 | ModelProfile을 Agent 개념으로 확장 |
| 담당 | Claude |
| 산출물 | `docs/components/agent-profile.md` |
| 필수 상태 | default, long name, with model, with capability tags, dark, ja |
| 완료 기준 | Codex가 구현 가능한 props/variant가 정의됨 |

---

## TASK-05. AgentProfile Storybook 구현

| 항목 | 내용 |
|---|---|
| 목적 | AgentProfile을 Storybook에 추가 |
| 담당 | Codex |
| 위치 | `Product/Agent/AgentProfile` |
| 필수 Story | Docs, Default, Matrix, LongContent, Theme, Locale |
| 완료 기준 | Storybook에서 AgentProfile 대표 케이스 확인 가능 |

---

## TASK-06. AgentAnswerCard 스펙 작성

| 항목 | 내용 |
|---|---|
| 목적 | 모델/에이전트별 답변 카드 정의 |
| 담당 | Claude |
| 산출물 | `docs/components/agent-answer-card.md` |
| 필수 상태 | default, loading, error, long text, with source, with chart |
| 완료 기준 | AnswerCard와 차이점 및 재사용 기준 명시 |

---

## TASK-07. AgentAnswerCard Storybook 구현

| 항목 | 내용 |
|---|---|
| 목적 | AgentAnswerCard 구현 및 Story 추가 |
| 담당 | Codex |
| 위치 | `Product/Agent/AgentAnswerCard` |
| 필수 Story | Default, Loading, Error, LongText, WithSource, WithChart, Mobile |
| 완료 기준 | multi-agent 비교 패턴의 기본 카드로 사용 가능 |

---

## TASK-08. SocraSummaryCard 스펙 작성

| 항목 | 내용 |
|---|---|
| 목적 | 여러 모델/에이전트 답변을 종합하는 Socra 요약 카드 정의 |
| 담당 | Claude |
| 산출물 | `docs/components/socra-summary-card.md` |
| 필수 상태 | summary, decision, caution, long summary |
| 완료 기준 | 결론/근거/주의점 영역이 정의됨 |

---

## TASK-09. SocraSummaryCard Storybook 구현

| 항목 | 내용 |
|---|---|
| 목적 | SocraSummaryCard 구현 |
| 담당 | Codex |
| 위치 | `Product/Compare/SocraSummaryCard` |
| 필수 Story | Default, Decision, Caution, LongContent, Dark, JA |
| 완료 기준 | 모바일/PC 비교 UX의 상단 요약 카드로 사용 가능 |

---

## TASK-10. ModelStanceRow 스펙 작성

| 항목 | 내용 |
|---|---|
| 목적 | 모델/에이전트별 입장 한 줄 요약 |
| 담당 | Claude |
| 산출물 | `docs/components/model-stance-row.md` |
| 필수 요소 | agent, stance, confidence, reason |
| 완료 기준 | 추천/보류/반대/조건부 등의 stance 정의 |

---

## TASK-11. ModelStanceRow Storybook 구현

| 항목 | 내용 |
|---|---|
| 목적 | ModelStanceRow 구현 |
| 담당 | Codex |
| 위치 | `Product/Compare/ModelStanceRow` |
| 필수 Story | Default, MultipleRows, LongReason, Mobile, Dark, Locale |
| 완료 기준 | 모델별 결론을 빠르게 비교 가능 |

---

## TASK-12. ConsensusBlock / DisagreementBlock 구현

| 항목 | 내용 |
|---|---|
| 목적 | 공통점과 차이점을 보여주는 비교 블록 구현 |
| 담당 | Claude + Codex |
| 위치 | `Product/Compare/*` |
| 필수 Story | Default, LongContent, NoConsensus, StrongDisagreement |
| 완료 기준 | MultiAgentComparison에서 공통/차이 영역으로 사용 가능 |

---

## TASK-13. CollapsibleAnswer 구현

| 항목 | 내용 |
|---|---|
| 목적 | 긴 AI 답변 접기/펼치기 |
| 담당 | Claude + Codex |
| 위치 | `Product/LongText/CollapsibleAnswer` 또는 `Chat/CollapsibleAnswer` |
| 필수 Story | Short, LongCollapsed, LongExpanded, Mobile, Dark, JA |
| 완료 기준 | 긴 모델 답변 여러 개가 있을 때 기본 collapsed 처리가 가능 |

---

## TASK-14. CollapsibleUserMessage 구현

| 항목 | 내용 |
|---|---|
| 목적 | 긴 유저 질문 접기/펼치기 |
| 담당 | Claude + Codex |
| 위치 | `Chat/CollapsibleUserMessage` |
| 필수 Story | ShortPrompt, LongPromptCollapsed, LongPromptExpanded, WithSummary |
| 완료 기준 | 긴 질문이 비교 UX 화면을 밀어내지 않음 |

---

## TASK-15. Source 기본 컴포넌트 구현

| 항목 | 내용 |
|---|---|
| 목적 | Citation / SourceCard / SourceSection 기본 구현 |
| 담당 | Claude + Codex |
| 위치 | `Product/Source/*` |
| 필수 Story | WebSource, FileSource, NoSource, LongTitle, ExpandedSection |
| 완료 기준 | 답변 하단에 출처 기본 구조 표시 가능 |

---

## TASK-16. Chart MVP 구현

| 항목 | 내용 |
|---|---|
| 목적 | Socra 판단/비교 UX의 핵심인 차트/점수/지표 표현을 먼저 검증 |
| 담당 | Claude + Codex |
| 위치 | `Product/Chart/*` |
| 범위 | ChartContainer, MetricCard, ScoreBar, ComparisonBarChart |
| 필수 Story | Default, Loading, Empty, Error, Mobile, Dark, JA, LongLabels |
| 완료 기준 | Socra 판단/비교 UX에서 수치/점수/비교 차트가 핵심 정보로 작동하고, chart fallback table까지 확인 가능 |

---

## TASK-17. MultiAgentComparison Pattern 구현

| 항목 | 내용 |
|---|---|
| 목적 | Agent + Summary + Stance + Source + Chart 조합 패턴 구현 |
| 담당 | Codex |
| 위치 | `Patterns/MultiAgentComparison` |
| 필수 Story | Default, Mobile, Desktop, LongAnswers, PartialFailure, WithChart |
| 완료 기준 | Socra 핵심 비교 UX가 Storybook에서 보이고, chart/source/long text가 한 화면에서 서로 경쟁하지 않음 |

---

## TASK-18. FE Handoff 체크리스트 작성

| 항목 | 내용 |
|---|---|
| 목적 | 프론트 개발자 연동 검증 기준 작성 |
| 담당 | Claude |
| 산출물 | `docs/fe-handoff-checklist.md` |
| 완료 기준 | props/data/theme/locale/responsive/source/chart 검증 항목 포함 |

---

## TASK-19. FE 적용성 1차 검증

| 항목 | 내용 |
|---|---|
| 목적 | Storybook 컴포넌트가 실제 프론트 화면에 적용 가능한지 확인 |
| 담당 | FE + Codex + 사용자 |
| 산출물 | issue list |
| 완료 기준 | 컴포넌트 재사용성, 페이지 조립 용이성, interaction wiring, responsive 흐름, chart/source fallback 관련 주요 이슈 정리 |

---

## TASK-20. 6월 결과 정리

| 항목 | 내용 |
|---|---|
| 목적 | 6월 작업 결과와 7월 backlog 정리 |
| 담당 | Claude |
| 산출물 | `june-summary.md`, `next-backlog.md` |
| 완료 기준 | 완료/보류/추가 필요 항목이 구분됨 |

---

## TASK-21. POC 업데이트 팔로우 및 문서 동기화

| 항목 | 내용 |
|---|---|
| 목적 | POC 업데이트 내역을 기획 변화로 보고 Storybook / Figma / 문서 / 7월 backlog에 반영 |
| 담당 | 사용자 + Claude |
| 입력 | POC 업데이트 내역, Figma source-of-truth, Storybook docs, 실제 repo 상태 |
| 산출물 | scope change note, backlog update, docs sync |
| 완료 기준 | Storybook이 POC 제품 흐름과 다른 기준을 만들지 않음 |

---

## TASK-22. Git 운영 / 코드 하네스 정리

| 항목 | 내용 |
|---|---|
| 목적 | Codex가 반복 실행할 수 있는 구현·검증 루틴을 정리 |
| 담당 | Codex |
| 범위 | branch/PR 범위, Storybook 구현 단위, fixture 관리, check/test/visual QA 명령, regression 방지 |
| 산출물 | implementation checklist, verification command list |
| 완료 기준 | 각 Storybook 작업이 실제 repo 상태와 검증 명령에 연결됨 |
