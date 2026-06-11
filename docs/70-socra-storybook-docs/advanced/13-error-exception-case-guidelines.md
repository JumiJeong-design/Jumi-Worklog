# 13. Error & Exception Case Guidelines

## 1. 문서 목적

이 문서는 Socra AI에서 발생할 수 있는 오류, 예외, 부분 실패 상태를 정의하고, 각 상태에서 사용자가 무엇을 기다려야 하는지, 무엇을 다시 시도할 수 있는지 명확히 알 수 있도록 하는 UX 기준을 정리한다.

사용자가 보낸 캡처의 예시처럼 `연결이 끊어졌습니다. 전체 답변을 기다리는 중입니다`와 같은 상태는 Multi-agent AI 서비스에서 반드시 고려해야 하는 예외 케이스다.

---

## 2. 오류 UX 원칙

| 원칙 | 설명 |
|---|---|
| Be honest | 현재 무슨 일이 일어났는지 숨기지 않는다 |
| Preserve progress | 일부 완료된 답변은 가능한 유지한다 |
| Give recovery | 사용자가 할 수 있는 다음 행동을 제공한다 |
| Avoid panic | 오류 메시지는 차분하고 명확하게 쓴다 |
| Separate severity | 경고/부분 실패/전체 실패를 구분한다 |
| Keep context | 사용자가 질문과 기존 답변 맥락을 잃지 않게 한다 |

---

## 3. 오류 레벨

| 레벨 | 상태 | 예시 | UI |
|---|---|---|---|
| Notice | 단순 안내 | 답변 생성이 지연 중 | subtle notice |
| Warning | 부분 문제 | 일부 모델 응답 지연 | inline warning |
| Partial Failure | 일부 실패 | Claude 실패, GPT/Gemini 성공 | failed card + retry |
| Blocking Error | 전체 실패 | 네트워크 끊김 | full error card |
| Recoverable Error | 재시도 가능 | 출처 로딩 실패 | retry action |
| Terminal Error | 재시도 불가 | 권한 없음 | explanation + fallback |

---

## 4. Multi-agent 오류 케이스

| 케이스 | 설명 | UI 처리 |
|---|---|---|
| All agents loading | 모든 모델 응답 대기 | global thinking |
| One agent loading | 일부 모델만 지연 | 해당 AgentAnswerCard loading |
| One agent failed | 한 모델 실패 | failed card + retry this agent |
| All agents failed | 전체 실패 | 전체 error state |
| Summary failed | 모델 답변은 있는데 종합 실패 | raw answers 유지 + summary retry |
| Source failed | 답변은 있는데 출처 실패 | source unavailable |
| Chart failed | 답변은 있는데 차트 실패 | chart error + fallback table |
| Connection lost | 연결 끊김 | reconnect notice + preserve existing content |
| Timeout | 응답 시간 초과 | partial answer + retry |

---

## 5. 캡처 기반 케이스: 연결 끊김 / 전체 답변 대기

### 현재 상태 예시

```txt
분석 중
잘 생각하기
연결이 끊어졌습니다. 전체 답변을 기다리는 중입니다
```

### 필요한 UX 판단

| 항목 | 고려 |
|---|---|
| 사용자는 지금 기다려야 하는지 알아야 함 | “기다리는 중” 상태 명확화 |
| 재시도 가능한지 알아야 함 | retry action 필요 |
| 기존 partial content가 있으면 보존 | 삭제하지 않음 |
| 전체 답변이 나중에 도착할 수 있는지 표시 | reconnect / waiting 상태 |
| 모바일/데스크톱 노출 차이 | 모바일은 compact, 데스크톱은 detail 가능 |

### 추천 UI

```txt
[분석 중]
연결이 불안정해요. 완료된 답변은 유지하고, 나머지 답변을 기다리고 있어요.
[다시 시도] [완료된 답변만 보기]
```

### 상태 변형

| 상태 | 문구 방향 |
|---|---|
| reconnecting | 연결을 다시 시도하고 있어요 |
| waiting | 전체 답변을 기다리고 있어요 |
| partial available | 완료된 답변을 먼저 볼 수 있어요 |
| failed | 답변을 불러오지 못했어요 |
| recovered | 연결이 복구됐어요 |

---

## 6. Error Component 구조

```txt
ErrorNotice
├─ status icon
├─ title
├─ description
├─ optional progress/context
├─ primary action
├─ secondary action
└─ detail toggle
```

---

## 7. 오류 문구 톤

### 권장

- “연결이 불안정해요. 완료된 답변은 유지하고 있어요.”
- “일부 에이전트의 답변을 불러오지 못했어요.”
- “출처를 불러오지 못했지만, 답변은 계속 볼 수 있어요.”
- “차트를 만들 수 없어 표로 대신 보여드릴게요.”

### 지양

- “오류 발생”
- “실패했습니다”
- “다시 하세요”
- “알 수 없는 에러”

---

## 8. 컴포넌트 / Storybook 필요 항목

### Components

| 컴포넌트 | 설명 |
|---|---|
| ErrorNotice | 기본 오류 안내 |
| InlineError | 카드 내부 오류 |
| PartialFailureCard | 특정 에이전트 실패 |
| RetryAction | 재시도 버튼 |
| ConnectionLostNotice | 연결 끊김 상태 |
| SourceErrorState | 출처 실패 |
| ChartErrorState | 차트 실패 |
| EmptyFallback | 데이터 없음 |

### Storybook Stories

```txt
QA/ErrorStates
- ConnectionLostWaiting
- PartialAgentFailure
- AllAgentsFailed
- SummaryFailed
- SourceFailed
- ChartFailed
- TimeoutWithPartialAnswer
- RetryInProgress
- RecoveredState
```

---

## 9. FE 검증 체크

| 체크 | 확인 |
|---|---|
| 네트워크 끊김 상태를 감지할 수 있는가 |  |
| 모델별 실패를 분리해서 받을 수 있는가 |  |
| source 실패와 answer 실패가 분리되는가 |  |
| chart 실패 시 fallback table을 만들 수 있는가 |  |
| retry this agent가 가능한가 |  |
| 전체 retry만 가능한가 |  |
| partial answer를 보존할 수 있는가 |  |
| timeout 기준은 어디서 정하는가 |  |
| streaming 중 연결 복구 처리가 가능한가 |  |

---

## 10. 디자인 검수 기준

| 체크 | 질문 |
|---|---|
| 오류가 과하게 무섭지 않은가 | 사용자가 불안하지 않게 표현되는가 |
| 다음 행동이 보이는가 | 기다리기/다시 시도/부분 답변 보기 |
| 완료된 내용이 보존되는가 | 진행 상황을 잃지 않는가 |
| 모바일에서 간결한가 | 좁은 화면에서 지나치게 크지 않은가 |
| 다크모드에서 보이는가 | border/text contrast |
| 다국어에서 문구가 넘치지 않는가 | ko/en/ja |
