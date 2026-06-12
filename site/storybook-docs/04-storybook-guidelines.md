# 04. Storybook 운영 가이드라인

## 1. 목적

Socra AI Storybook은 단순 컴포넌트 전시장이 아니라, Multi-model / Multi-agent 비교 UX가 다양한 조건에서도 유지되는지 검증하는 공간이다.

---

## 2. Storybook IA

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

---

## 3. Component vs Pattern vs Screen

| 레이어 | 목적 | 예시 |
|---|---|---|
| Primitive | 기본 UI 단위 | Button, Chip, Toggle |
| Chat | 채팅 기본 구조 | MessageBubble, ChatInputBar |
| Product Component | Socra 특화 UI 단위 | AgentAnswerCard, SourceCard |
| Pattern | 여러 컴포넌트 조합 | MultiAgentComparison |
| Screen | 실제 화면 레이아웃 | MobileCompareAnswer |
| QA | 조건별 검증 | Theme, Locale, Viewport |

---

## 4. Story 기본 세트

| Story | 적용 기준 |
|---|---|
| Docs | 모든 컴포넌트 |
| Default | 모든 컴포넌트 |
| Matrix | variant/state가 2개 이상 |
| Long Content | 텍스트가 들어가는 컴포넌트 |
| Interactive | 클릭/선택/접기/펼치기 등 |
| Responsive | 레이아웃 변화가 있는 컴포넌트 |
| Theme | P0 컴포넌트 |
| Locale | 텍스트 길이 영향을 받는 컴포넌트 |
| Edge Cases | Product / Pattern / Screen |

6월 우선 적용 세트는 `Docs`, `Default`, `Matrix`, `Long Content`, `Theme`, `Locale`, `Edge Cases`다.
클릭/접기/펼치기 같은 상호작용이 제품 이해에 직접 영향을 줄 때만 `Interactive`를 추가한다.
모든 조합을 늘리지 말고 mobile 390 / desktop 1280, light / dark, ko / en / ja의 대표 케이스만 먼저 만든다.

---

## 5. Responsive 기준

| Viewport | 용도 |
|---|---|
| 360 | mobile small |
| 390 | mobile default |
| 430 | mobile large |
| 834 | tablet |
| 1280 | desktop |
| 1440 | wide desktop |

6월에는 390과 1280을 우선한다.

---

## 6. Theme 기준

| Theme | 필요 |
|---|---|
| light | 필수 |
| dark | 필수 |

P0 컴포넌트는 light/dark 대표 Story를 가진다.

---

## 7. Locale 기준

| Locale | 목적 |
|---|---|
| ko | 기본 |
| en | 글로벌 |
| ja | 일본어 대응 |

실제 번역 완성이 아니라, 텍스트 길이와 줄바꿈 검증을 위한 fixture를 우선한다.

---

## 8. Long Content 기준

긴 텍스트는 아래 케이스를 포함한다.

- 긴 에이전트 이름
- 긴 모델 답변
- 긴 유저 질문
- 긴 출처 제목
- 긴 차트 라벨
- 일본어 긴 문장
- 영어 긴 버튼/설명 문구

---

## 9. Multi-agent 상태 기준

| 케이스 | Story 필요 |
|---|---|
| 모든 에이전트 완료 | O |
| 일부 에이전트 로딩 | O |
| 일부 에이전트 실패 | O |
| 결론 일치 | O |
| 결론 갈림 | O |
| 긴 답변 여러 개 | O |
| 출처 일부만 있음 | O |
| 차트 포함 | O |

---

## 10. Story 과다 방지

모든 조합을 만들지 않는다.  
대표 케이스만 만든다.

예: AgentAnswerCard

```txt
Default / Desktop / Light / KO
Mobile / Light / KO
Desktop / Dark / KO
Desktop / Light / EN
Desktop / Light / JA
LongText / Mobile / KO
Loading
Error
Partial
```

---

## 11. Naming 권장

```txt
Primitives/Button
Chat/ChatInputBar
Product/Agent/AgentProfile
Product/Compare/SocraSummaryCard
Product/Source/SourceCard
Product/Chart/ChartContainer
Patterns/MultiAgentComparison
Screens/MobileCompareAnswer
QA/Locale
```
