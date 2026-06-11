# 12. Responsive Web / Mobile Design Rules

## 1. 문서 목적

이 문서는 Socra AI의 웹 PC와 웹 모바일에서 달라져야 하는 디자인/UX 구분점을 정의한다.

Socra는 같은 컴포넌트를 사용하더라도 화면 크기에 따라 정보 배치, 노출 밀도, 인터랙션 방식이 달라져야 한다. 특히 Multi-agent 비교 UX, 긴 답변, 출처, 차트, 오류 상태는 PC와 모바일에서 동일하게 처리하면 사용성이 떨어질 수 있다.

---

## 2. 기본 원칙

| 원칙 | 설명 |
|---|---|
| Same component, different layout | 핵심 컴포넌트는 공유하되, 배치와 노출 방식은 화면별로 다르게 가져간다 |
| Mobile summary first | 모바일에서는 요약과 입장 비교를 먼저 보여준다 |
| Desktop comparison first | PC에서는 병렬 비교와 정보량을 적극 활용한다 |
| Progressive disclosure | 모바일에서는 출처/원문/차트를 접거나 sheet로 분리한다 |
| Avoid horizontal overload | 모바일에서 3개 이상 카드 병렬 노출을 피한다 |
| Preserve context | 펼침/상세 진입 후에도 사용자가 질문/요약 맥락을 잃지 않게 한다 |

---

## 3. Breakpoint 기준

| 구분 | Width | 우선순위 |
|---|---:|---:|
| Mobile small | 360px | P1 |
| Mobile default | 390px | P0 |
| Mobile large | 430px | P1 |
| Tablet | 768 / 834px | P1 |
| Desktop | 1280px | P0 |
| Wide desktop | 1440px | P1 |

6월 MVP에서는 `390px mobile`과 `1280px desktop`을 우선 검증한다.

---

## 4. Multi-agent Compare Layout

### Mobile

```txt
[User Prompt Summary]
[Socra Summary]
[Agent Stance List]
[Agent Tabs / Carousel]
[Selected Agent Answer]
[Source / Chart / Raw Answer via Bottom Sheet]
```

### Desktop

```txt
Left / Top:
- User Prompt Summary
- Socra Summary
- Model Stance Summary

Main:
- Agent Answer Grid
- Consensus / Disagreement
- Source Section
- Chart Section
```

---

## 5. 컴포넌트별 Responsive Rule

| 컴포넌트 | Mobile | Desktop |
|---|---|---|
| SocraSummaryCard | 상단 전체폭, 핵심만 | 좌측 고정 또는 상단 강조 |
| AgentAnswerCard | 탭/캐러셀에서 1개씩 | 2~3열 grid |
| ModelStanceRow | 리스트형, 짧은 reason | table/list 혼합 가능 |
| CollapsibleAnswer | 기본 collapsed | 카드 높이에 따라 collapsed |
| CollapsibleUserMessage | 요약 우선, 전체 보기 sheet | 상단 요약 + 펼침 |
| SourceSection | collapsed, bottom sheet detail | expanded 또는 accordion |
| ChartContainer | 높이 제한, tooltip tap | 넓은 chart + legend |
| ComparisonBarChart | vertical/horizontal label 조정 | full chart |
| ErrorNotice | compact message + retry | 설명 + recovery action |
| BottomSheet | 주요 상세 진입 | 보조. desktop은 popover/drawer 가능 |

---

## 6. 모바일에서 특히 주의할 것

| 리스크 | 대응 |
|---|---|
| 모델 답변 3개 이상이 너무 김 | tabs / carousel / collapsed default |
| 출처가 답변보다 길어짐 | SourceSection collapsed |
| 차트 라벨이 잘림 | vertical bar, label wrap, fallback table |
| 긴 유저 질문이 화면을 밀어냄 | UserPromptSummary + 전체 보기 |
| 오류 메시지가 눈에 안 띔 | compact but visible error card |
| bottom fixed input과 콘텐츠 충돌 | safe area / bottom spacing 확인 |
| 다크모드에서 border가 사라짐 | surface / border token 재검토 |

---

## 7. Desktop에서 특히 주의할 것

| 리스크 | 대응 |
|---|---|
| 공간이 넓어도 핵심이 흩어짐 | Summary / Stance를 고정적 위치에 둠 |
| 카드 3개가 높이 불균형 | card max-height + collapse |
| 출처/차트가 하단에 묻힘 | anchor / section nav 검토 |
| 정보가 너무 dashboard처럼 복잡해짐 | 우선 Summary → Compare → Detail 흐름 유지 |
| wide 화면에서 콘텐츠 폭 과도 | max-width / grid column 제한 |

---

## 8. Storybook Stories

```txt
QA/Viewport
- Mobile390_Default
- Mobile390_LongUserPrompt
- Mobile390_LongAgentAnswers
- Mobile390_WithSource
- Mobile390_WithChart
- Desktop1280_Default
- Desktop1280_AgentGrid
- Desktop1280_SourceExpanded
- Desktop1280_WithChart
```

## 9. FE 검증 체크

- 실제 모바일 브라우저에서 safe area 확인
- iOS Safari bottom bar 대응
- Android Chrome viewport 대응
- desktop window resize 대응
- Storybook viewport와 실제 앱 viewport 차이 확인
