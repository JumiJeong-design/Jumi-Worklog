# 17. Performance & Loading Budget

## 1. 문서 목적

Socra AI는 여러 모델/에이전트 답변, 긴 마크다운, 출처, 차트, 모션을 동시에 다룰 수 있다.

따라서 초기부터 성능과 로딩 기준을 잡지 않으면 모바일에서 답변 비교 화면이 무거워질 수 있다.

---

## 2. 주요 성능 리스크

| 리스크 | 설명 |
|---|---|
| 여러 AgentAnswerCard 동시 렌더 | 모델 3~5개 답변이 동시에 표시됨 |
| 긴 Markdown | 표, 코드블록, 리스트, 링크 포함 |
| Chart library | Recharts/ECharts 등 번들 영향 |
| Motion / shimmer | loading animation 과다 사용 |
| Source list | 출처가 많을 때 카드 증가 |
| Mobile viewport | 작은 화면에서 layout thrashing |
| Dark mode/theme switch | theme token 전환 |
| Locale switch | 긴 텍스트 재렌더링 |

---

## 3. Loading Budget 기준 초안

| 항목 | 목표 |
|---|---|
| 초기 화면 표시 | 가능한 빠르게 shell 표시 |
| Agent loading card | 즉시 표시 |
| 첫 답변 표시 | 첫 완료된 답변부터 표시 |
| 전체 완료 | 모든 답변 대기하지 않고 partial 상태 허용 |
| Source loading | 답변과 분리 |
| Chart loading | chart skeleton / fallback 허용 |
| Long answer | 기본 collapsed로 렌더 부담 완화 |

---

## 4. 렌더링 전략

| 전략 | 설명 |
|---|---|
| Progressive rendering | 완료된 agent answer부터 표시 |
| Collapsed by default | 긴 답변은 기본 접힘 |
| Lazy detail | Raw answer/source/chart detail은 필요 시 렌더 |
| Virtualization 검토 | 출처/답변이 아주 많을 때 |
| Memoization | Agent card / chart / markdown block memo |
| Chart lazy loading | 차트 라이브러리 지연 로드 가능성 검토 |
| Reduce animation | 저성능/모바일에서 shimmer 최소화 |

---

## 5. Chart Performance

| 체크 | 설명 |
|---|---|
| 라이브러리 번들 크기 | Recharts/shadcn/ECharts 비교. shadcn/ui radial chart는 Recharts 기반으로 묶어 평가 |
| 모바일 tooltip 성능 | tap interaction 확인 |
| 긴 라벨 처리 | 렌더링/측정 비용 확인 |
| 데이터 양 제한 | MVP에서는 작은 데이터셋 우선 |
| fallback table | 차트 실패 시 표로 대체 |
| lazy import | chart section 도달 시 로드 검토 |
| radial/gauge 후보 | score형 metric에 한정하고, 모바일에서는 label/value/source가 표 대체와 함께 보이는지 확인 |

---

## 6. Motion Performance

| 체크 | 설명 |
|---|---|
| transform/opacity 우선 | layout 변경 모션 최소화 |
| shimmer 개수 제한 | 여러 카드 동시 shimmer 과다 사용 지양 |
| infinite animation 제한 | thinking 영역에만 제한적으로 |
| reduce motion | prefers-reduced-motion 대응 |
| mobile battery | 강한 glow/pulse 반복 지양 |

---

## 7. Storybook Performance Stories

```txt
QA/Performance
- ThreeAgentsLongAnswers
- FiveAgentsLoading
- LongMarkdownAnswer
- ManySources
- ChartSectionLoading
- Mobile390StressCase
- DarkModeSwitch
```

---

## 8. 6월 최소 기준

6월에는 실제 성능 측정보다 아래 기준을 우선한다.

- 긴 답변 기본 collapsed
- source/chart detail lazy 가능 구조
- chart library PoC에서 bundle/interaction 확인
- mobile 390에서 layout 깨짐 확인
- shimmer/glow motion 과다 사용 금지
- partial rendering UX 정의
