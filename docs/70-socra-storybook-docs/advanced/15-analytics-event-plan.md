# 15. Analytics Event Plan

## 1. 문서 목적

이 문서는 Socra AI의 Multi-agent 비교 UX가 실제로 어떻게 사용되는지 이해하기 위한 이벤트 설계 초안이다.

사용자가 어떤 모델/에이전트 답변을 보고, 어떤 출처를 열고, 어떤 차트를 확인하고, 어떤 답변을 신뢰하는지 추적해야 제품 개선이 가능하다.

---

## 2. 분석 목표

| 목표 | 설명 |
|---|---|
| 비교 UX 사용 여부 | 사용자가 여러 답변을 실제로 비교하는가 |
| 에이전트 선호 | 어떤 에이전트 답변을 더 많이 읽고 선택하는가 |
| Source 신뢰도 | 출처를 열어보는가 |
| Chart 유용성 | 차트를 보는가, 이해에 도움이 되는가 |
| 긴 텍스트 피로도 | read more / collapse 사용 패턴 |
| 오류 영향 | partial failure가 사용 이탈을 만드는가 |
| 다국어/디바이스 차이 | 모바일/데스크톱, ko/en/ja 사용 차이 |

---

## 3. 핵심 이벤트

### 3.1 질문 / 세션

| Event | Trigger |
|---|---|
| `question_submitted` | 유저가 질문 전송 |
| `answer_generation_started` | 모델/에이전트 답변 생성 시작 |
| `answer_generation_completed` | 전체 생성 완료 |
| `answer_generation_partial_completed` | 일부 모델만 완료 |
| `answer_generation_failed` | 전체 또는 일부 실패 |

### 3.2 Agent / Model

| Event | Trigger |
|---|---|
| `agent_answer_viewed` | 에이전트 답변 카드 노출 |
| `agent_answer_expanded` | 긴 답변 펼침 |
| `agent_tab_clicked` | 특정 에이전트 탭 클릭 |
| `agent_detail_opened` | 에이전트 상세 열림 |
| `agent_retry_clicked` | 특정 에이전트 재시도 |
| `agent_answer_copied` | 답변 복사 |

### 3.3 Compare

| Event | Trigger |
|---|---|
| `socra_summary_viewed` | 종합 요약 노출 |
| `stance_row_clicked` | stance row 클릭 |
| `consensus_viewed` | 공통점 블록 노출 |
| `disagreement_viewed` | 차이점 블록 노출 |
| `raw_answer_opened` | 원문 답변 열기 |
| `view_mode_changed` | Summary / Compare / Raw 전환 |

### 3.4 Source

| Event | Trigger |
|---|---|
| `citation_clicked` | 본문 citation 클릭 |
| `source_section_expanded` | 출처 섹션 펼침 |
| `source_card_clicked` | 출처 카드 클릭 |
| `source_external_opened` | 외부 출처 이동 |
| `source_unavailable_viewed` | 출처 없음/실패 상태 노출 |

### 3.5 Chart

| Event | Trigger |
|---|---|
| `chart_viewed` | 차트 노출 |
| `chart_tooltip_opened` | 차트 tooltip 확인 |
| `chart_fallback_table_opened` | 표 대체 보기 |
| `chart_source_clicked` | 차트 출처/산식 클릭 |
| `chart_error_viewed` | 차트 오류 상태 노출 |

### 3.6 Feedback

| Event | Trigger |
|---|---|
| `feedback_submitted` | 도움됨/별로임 제출 |
| `feedback_reason_selected` | 이유 선택 |
| `winning_answer_selected` | 가장 도움 된 답변 선택 |
| `regenerate_clicked` | 다시 생성 |
| `shorten_answer_clicked` | 더 짧게 보기 |
| `more_evidence_clicked` | 근거 더 보기 |

---

## 4. 공통 Event Properties

```ts
type CommonEventProperties = {
  sessionId: string;
  questionId: string;
  userId?: string;
  locale: 'ko' | 'en' | 'ja';
  theme: 'light' | 'dark';
  viewport: 'mobile' | 'tablet' | 'desktop';
  deviceType?: string;
  timestamp: string;
};
```

## 5. Agent Event Properties

```ts
type AgentEventProperties = CommonEventProperties & {
  agentId: string;
  agentName: string;
  baseModel: string;
  agentRole?: string;
  answerStatus?: 'loading' | 'streaming' | 'complete' | 'failed';
};
```

## 6. Source Event Properties

```ts
type SourceEventProperties = CommonEventProperties & {
  sourceId: string;
  sourceType: 'web' | 'file' | 'history' | 'model' | 'manual';
  reliability?: string;
  position?: number;
};
```

## 7. Chart Event Properties

```ts
type ChartEventProperties = CommonEventProperties & {
  chartId: string;
  chartType: 'metric' | 'score' | 'bar' | 'line' | 'composition';
  hasSource: boolean;
  hasFallbackTable: boolean;
};
```

---

## 8. 주의할 점

- 개인정보/민감정보를 event payload에 직접 넣지 않는다.
- 유저 질문 전문을 analytics에 넣지 않는다.
- 파일명/출처명도 민감할 수 있으므로 필요 시 hash 또는 type만 사용한다.
- 피드백 사유는 제품 개선 목적에 필요한 최소 수준으로 저장한다.
- 한국어/영어/일본어 텍스트 자체가 아니라 locale code만 저장한다.

---

## 9. 6월 최소 이벤트

6월 MVP에서는 아래만 우선 정의해도 충분하다.

```txt
question_submitted
answer_generation_completed
agent_answer_expanded
source_section_expanded
chart_viewed
feedback_submitted
answer_generation_failed
```
