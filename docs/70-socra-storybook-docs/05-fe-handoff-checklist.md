# 05. FE Handoff Checklist

## 1. 목적

이 문서는 Storybook에 구현된 Socra AI 컴포넌트가 실제 프론트 화면에서 정상적으로 적용 가능한지 검증하기 위한 체크리스트다.

---

## 2. 기본 확인

| 체크 | 확인 |
|---|---|
| Storybook 컴포넌트 import path가 실제 앱 구조와 맞는가 |  |
| props 구조가 실제 API / state 구조와 맞는가 |  |
| Figma token과 코드 token이 연결되어 있는가 |  |
| light/dark theme이 실제 앱 theme와 연결되는가 |  |
| locale fixture가 실제 i18n 구조와 연결 가능한가 |  |

---

## 3. Agent / Model 데이터

| 필드 | 설명 | 확인 |
|---|---|---|
| agentId | 에이전트 고유 ID |  |
| agentName | 사용자에게 보이는 이름 |  |
| agentRole | 전략가 / 리서처 / 현실주의자 등 |  |
| modelName | GPT / Claude / Gemini 등 기반 모델 |  |
| avatar | 에이전트 또는 모델 아이콘 |  |
| capabilities | 출처 강함 / 리스크 분석 / 창의적 등 |  |
| status | loading / complete / failed |  |

---

## 4. Answer 데이터

| 필드 | 설명 | 확인 |
|---|---|---|
| answerId | 답변 ID |  |
| agentId | 답변 주체 |  |
| markdown | 답변 본문 |  |
| summary | 짧은 요약 |  |
| stance | 추천 / 보류 / 반대 / 조건부 |  |
| confidence | 신뢰도 또는 근거 충분도 |  |
| sources | 출처 목록 |  |
| chartData | 차트 데이터 |  |
| status | loading / complete / failed |  |

---

## 5. Source 데이터

| 필드 | 설명 | 확인 |
|---|---|---|
| sourceId | 출처 ID |  |
| title | 출처 제목 |  |
| url | 링크 |  |
| type | web / file / history / model / manual |  |
| publishedAt | 발행일 |  |
| summary | 출처 요약 |  |
| reliability | 공식 / 뉴스 / 블로그 / 추론 등 |  |

---

## 6. Chart 데이터

| 필드 | 설명 | 확인 |
|---|---|---|
| chartType | metric / score / bar / line 등 |  |
| title | 차트 제목 |  |
| description | 차트 설명 |  |
| data | 차트 데이터 배열 |  |
| series | 여러 데이터 시리즈 |  |
| source | 차트 근거/출처 |  |
| note | 산식 또는 기준 설명 |  |
| emptyState | 데이터 없을 때 문구 |  |

---

## 7. 화면 검증

| 체크 | 확인 |
|---|---|
| 모바일 390px에서 비교 UX가 무너지지 않는가 |  |
| 데스크톱 1280px에서 grid/split view가 자연스러운가 |  |
| 긴 유저 질문이 화면을 과도하게 차지하지 않는가 |  |
| 긴 모델 답변 여러 개가 동시에 있을 때 피로도가 과하지 않은가 |  |
| 일부 모델 실패 상태가 자연스러운가 |  |
| 출처가 없을 때 어색하지 않은가 |  |
| 차트 데이터가 없을 때 fallback이 있는가 |  |
| BottomSheet/Drawer를 실제 앱 구조에서 쓸 수 있는가 |  |

---

## 8. 구현 리스크

| 리스크 | 확인 방식 |
|---|---|
| Storybook에서는 되지만 실제 앱 layout에서 깨짐 | 실제 페이지에 적용해보기 |
| mock data와 API data shape 불일치 | FE와 data contract 확인 |
| Figma token과 코드 token 불일치 | token mapping 확인 |
| 다크모드 색상 깨짐 | light/dark 실제 전환 확인 |
| 다국어 문자열 overflow | ko/en/ja fixture 적용 |
| streaming 상태 미정 | loading / partial state 우선 |
| chart library 영향 | bundle / mobile / tooltip 확인 |

---

## 9. FE 피드백 기록

| 날짜 | 이슈 | 담당 | 상태 |
|---|---|---|---|
|  |  |  |  |
