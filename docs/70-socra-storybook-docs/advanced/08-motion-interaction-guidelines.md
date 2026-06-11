# 08. Motion & Interaction Guidelines

## 1. 문서 목적

Socra AI는 여러 모델/에이전트가 동시에 사고하고 답변하는 서비스이므로, 모션과 인터랙션은 단순 장식이 아니라 상태 이해와 신뢰 형성에 영향을 준다.

이 문서는 thinking, streaming, multi-agent reply, collapse/expand, source/chart interaction 등 제품 완성도에 필요한 모션/인터랙션 기준을 정리한다.

---

## 2. 모션 원칙

| 원칙 | 설명 |
|---|---|
| Meaningful | 모션은 상태 변화나 정보 구조를 설명해야 한다 |
| Calm | AI 서비스 특성상 과한 효과보다 차분한 리듬이 적합하다 |
| Responsive | 사용자의 조작에는 즉각적인 피드백이 있어야 한다 |
| Lightweight | 긴 답변/여러 모델 환경에서 성능을 해치지 않아야 한다 |
| Accessible | reduce motion 설정을 고려한다 |

---

## 3. Thinking Motion

### 목적

- 사용자가 “멈춘 것인지, 분석 중인지, 비교 중인지” 이해하게 한다.
- 여러 모델/에이전트가 동시에 작동하는 느낌을 준다.
- 반짝이는 motion, glow, pulse 등은 AI의 생동감을 줄 수 있지만 정보 상태와 연결되어야 한다.

### 상태별 표현

| 상태 | 표현 방향 |
|---|---|
| 질문 분석 중 | 작고 차분한 pulse |
| 에이전트 응답 생성 중 | Agent card 내부 shimmer / dot |
| 여러 답변 비교 중 | Socra Summary 영역의 subtle glow |
| 출처 찾는 중 | Source section skeleton |
| 차트 생성 중 | ChartContainer skeleton + axis placeholder |
| 완료 | motion 종료 후 안정 상태 |

### 주의

- 무한 반짝임은 피로감을 줄 수 있다.
- loading이 길어질 때는 단계 문구가 motion보다 중요하다.
- 모션만으로 상태를 전달하지 않는다. 텍스트 label도 함께 제공한다.

---

## 4. Multi-agent Reply Interaction

| 케이스 | 인터랙션 |
|---|---|
| 한 에이전트 답변 완료 | 해당 AgentAnswerCard fade/slide in |
| 일부 에이전트 로딩 | loading card 유지 |
| 일부 에이전트 실패 | failed card로 전환 |
| 모든 에이전트 완료 | SocraSummaryCard 활성화 |
| 답변 비교 완료 | Consensus / Disagreement 등장 |

추천 순서:

```txt
Agent cards loading
→ individual answers appear
→ stance rows update
→ Socra summary generated
→ source/chart sections become available
```

---

## 5. Collapse / Expand

### 적용 대상

- 긴 AI 답변
- 긴 유저 질문
- SourceSection
- RawAnswerDrawer
- Chart detail
- AgentDetailSheet

### 원칙

| 원칙 | 설명 |
|---|---|
| Preview first | 긴 내용은 핵심 preview를 먼저 보여준다 |
| Smooth height transition | 펼침/접힘은 자연스럽게 |
| Scroll position 유지 | 펼친 뒤 사용자가 위치를 잃지 않게 |
| Mobile first | 모바일에서는 기본 collapsed가 안전 |
| Expand all 주의 | 여러 긴 답변을 동시에 펼치면 피로도가 높음 |

---

## 6. Source Interaction

| 액션 | UI |
|---|---|
| Citation tap | SourcePreview 또는 BottomSheet |
| SourceSection expand | 출처 목록 펼침 |
| SourceCard tap | 원문 링크 또는 detail |
| Source unavailable | 출처 없음 note |
| File source | 권한/파일명/요약 표시 |

---

## 7. Chart Interaction

| 액션 | UI |
|---|---|
| Chart loading | skeleton 또는 placeholder |
| Tooltip hover/tap | Desktop hover / Mobile tap |
| Legend toggle | MVP에서는 선택사항 |
| Empty data | fallback message |
| Error | chart error + 표 보기 |
| Long label | wrap, truncate, horizontal scroll 중 선택 |

---

## 8. Feedback Micro-interaction

| 액션 | 피드백 |
|---|---|
| Copy | “복사됨” 상태 |
| Like / Dislike | selected state |
| Retry | loading state로 전환 |
| Regenerate | 이전 답변 보존 여부 결정 필요 |
| View sources | SourceSection scroll 또는 sheet open |

---

## 9. Storybook Stories

```txt
QA/Motion
- ThinkingPulse
- AgentReplyEntrance
- SocraSummaryGenerating
- CollapseExpandAnswer
- SourceSectionExpand
- ChartLoadingToComplete
- FeedbackSelected
- ReduceMotion
```

## 10. Figma에서 미리 잡을 것

- Thinking motion 방향
- 답변 등장 순서
- Collapse/Expand 구조
- Source sheet open/close
- Mobile tab/sheet transition
- Chart loading/empty/error 상태

## 11. Storybook에서 검증할 것

- 실제 click interaction
- animation duration/easing
- mobile touch behavior
- reduce motion mode
- long content performance
- chart tooltip behavior
