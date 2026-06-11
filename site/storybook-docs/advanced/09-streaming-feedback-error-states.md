# 09. Streaming / Feedback / Error States

## 1. 문서 목적

Multi-agent 비교 UX에서는 모든 모델/에이전트가 동시에 완벽하게 응답한다는 가정이 위험하다.

이 문서는 응답 생성 중, 일부 실패, 재시도, 피드백, 품질 평가 등 서비스 완성도에 영향을 주는 상태 UX를 정리한다.

---

## 2. Streaming UX

### 기본 시나리오

```txt
User 질문
→ Agent A 응답 생성 중
→ Agent B 응답 생성 중
→ Agent C 실패 또는 지연
→ 일부 답변 먼저 표시
→ Socra Summary는 모든 답변 완료 후 또는 부분 완료 기준으로 생성
```

### 필요한 UI 상태

| 상태 | 설명 | UI |
|---|---|---|
| preparing | 질문 분석 중 | Thinking indicator |
| generating | 에이전트 답변 생성 중 | Agent card loading |
| streaming | 답변 일부 표시 중 | partial text |
| comparing | 답변 비교 중 | Socra summary loading |
| complete | 완료 | full comparison |
| stopped | 사용자가 중단 | stopped notice |
| failed | 생성 실패 | error card + retry |

---

## 3. Partial Failure

| 케이스 | 처리 |
|---|---|
| 한 모델만 실패 | 실패 카드 표시, 나머지 비교 유지 |
| 두 모델 성공, 한 모델 지연 | 로딩 카드 유지 |
| 전체 실패 | 전체 error state |
| 출처만 실패 | 답변은 표시, source unavailable 표시 |
| 차트만 실패 | 답변은 표시, chart fallback 표시 |

---

## 4. Retry / Stop

| 액션 | 위치 |
|---|---|
| Retry this agent | failed agent card |
| Retry all | 전체 error state |
| Stop generating | 생성 중 상단 또는 input 근처 |
| Regenerate answer | answer action |
| Ask this agent more | 7월 이후 실험 |

---

## 5. Feedback UX

| 단위 | 설명 |
|---|---|
| 전체 Socra Summary 평가 | 최종 답변이 도움 됐는지 |
| 에이전트별 답변 평가 | 어떤 에이전트가 유용했는지 |
| Source 평가 | 출처가 도움이 됐는지 |
| Chart 평가 | 차트가 이해에 도움이 됐는지 |

### 추천 P1 UI

| 컴포넌트 | 설명 |
|---|---|
| FeedbackControl | 도움됨 / 별로임 |
| FeedbackReasonSheet | 이유 선택 |
| WinnerPick | 가장 도움 된 모델 선택 |
| ImproveAction | 더 짧게 / 더 구체적으로 / 근거 더 보기 |

---

## 6. Error Recovery

| 에러 | 회복 UX |
|---|---|
| 모델 실패 | 해당 모델만 재시도 |
| 전체 실패 | 전체 재시도 |
| Source 실패 | 출처 없이 답변 보기 |
| Chart 실패 | 표로 보기 / 차트 재시도 |
| 네트워크 실패 | 연결 확인 후 재시도 |
| 긴 답변 렌더 실패 | 원문 텍스트 보기 |

---

## 7. Storybook에 필요한 상태 Story

```txt
Patterns/MultiAgentComparison
- AllLoading
- PartialLoading
- OneAgentFailed
- AllFailed
- SourceFailed
- ChartFailed
- StoppedGenerating
- RetrySuccess
- FeedbackSelected
```
