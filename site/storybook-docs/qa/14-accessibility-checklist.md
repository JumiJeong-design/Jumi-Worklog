# 14. Accessibility Checklist

## 1. 문서 목적

이 문서는 Socra AI의 Storybook / Figma / 실제 프론트 구현 단계에서 접근성을 검수하기 위한 체크리스트다.

Socra는 긴 텍스트, 여러 에이전트 답변, 출처, 차트, 다크모드, 모바일 웹을 모두 다루기 때문에 접근성 기준을 초기에 잡아두는 것이 중요하다.

---

## 2. 기본 원칙

| 원칙 | 설명 |
|---|---|
| Perceivable | 텍스트, 상태, 차트, 출처가 시각 외 방식으로도 이해 가능해야 함 |
| Operable | 키보드, 터치, 스크린리더 환경에서도 조작 가능해야 함 |
| Understandable | 오류, 로딩, 부분 실패 상태가 명확해야 함 |
| Robust | Storybook / 실제 앱 / 브라우저 환경에서 일관되어야 함 |

---

## 3. Keyboard Navigation

| 체크 항목 | 기준 |
|---|---|
| Tab 순서 | 화면의 정보 흐름과 일치해야 함 |
| Focus visible | 모든 interactive element에 명확한 focus ring 필요 |
| Enter / Space | 버튼, 토글, 탭에서 작동해야 함 |
| Escape | BottomSheet, Dialog, Drawer 닫기 |
| Arrow keys | Tabs / segmented control에서 사용 가능하면 좋음 |
| Focus trap | Dialog / BottomSheet 내부에서 포커스가 빠져나가지 않도록 처리 |
| Focus return | Sheet/Dialog 닫은 뒤 트리거 버튼으로 focus 복귀 |

---

## 4. Touch Target

| 대상 | 권장 |
|---|---|
| Button | 최소 44x44px |
| Icon button | 최소 44x44px hit area |
| Citation | 너무 작으면 주변 hit area 확대 |
| SourceCard | 카드 전체 또는 명확한 링크 영역 |
| Chart tooltip trigger | 모바일 tap 영역 충분히 확보 |
| Tabs | 손가락으로 누르기 쉬운 간격 유지 |

---

## 5. Color & Contrast

| 항목 | 체크 |
|---|---|
| 본문 텍스트 | light/dark 모두 충분한 contrast |
| Secondary text | 너무 흐리지 않게 |
| Disabled | 비활성 상태와 읽을 수 없음 구분 |
| Error / Warning | 색상만으로 의미 전달하지 않음 |
| Chart color | 색맹/저시력 사용자도 구분 가능 |
| Focus ring | 배경과 충분히 대비 |
| Border | dark mode에서 사라지지 않게 |

---

## 6. Screen Reader

| 컴포넌트 | 필요한 label |
|---|---|
| AgentProfile | 에이전트 이름, 역할, 기반 모델 |
| AgentAnswerCard | 어느 에이전트의 답변인지 |
| ModelStanceRow | 입장, 신뢰도, 이유 |
| Citation | 몇 번째 출처인지, 누르면 출처 상세 열림 |
| SourceCard | 출처 제목, 타입, 날짜 |
| Chart | 차트 제목, 요약 설명, fallback table |
| ErrorNotice | 오류 상태와 가능한 액션 |
| CollapsibleAnswer | 펼침/접힘 상태 |
| BottomSheet | 제목, 닫기 버튼, focus trap |

---

## 7. Chart Accessibility

차트는 시각 정보에 의존하기 쉬우므로 반드시 fallback을 고려한다.

| 체크 | 기준 |
|---|---|
| Chart title | 무엇을 보여주는지 명확해야 함 |
| Chart description | 차트 해석에 필요한 맥락 제공 |
| Fallback table | 주요 차트는 데이터 표로 대체 가능해야 함 |
| Tooltip | hover뿐 아니라 keyboard/tap 접근 고려 |
| Legend | 색상만이 아니라 label 필요 |
| Source note | 수치의 출처/산식 표시 |
| Empty / Error | 차트 데이터 없음/실패 상태 명확화 |

---

## 8. Motion Accessibility

| 체크 | 기준 |
|---|---|
| Reduce motion | prefers-reduced-motion 대응 |
| Infinite animation | 무한 반복은 최소화 |
| Thinking motion | 상태 label과 함께 제공 |
| Flashing | 빠른 점멸/강한 깜빡임 지양 |
| Collapse/expand | 모션 없이도 상태 이해 가능 |
| Loading shimmer | 과한 shimmer 지양 |

---

## 9. Long Text Accessibility

| 체크 | 기준 |
|---|---|
| Collapsed state | 접힌 상태가 명확해야 함 |
| Read more label | “전체 답변 보기”처럼 명확한 문구 |
| Expanded state | 펼친 뒤 접기 가능 |
| Screen reader | 접힘/펼침 상태 읽힘 |
| Heading structure | 긴 답변은 제목 구조 유지 |
| Markdown | 목록/표/코드블록 의미 유지 |

---

## 10. Error State Accessibility

| 오류 | 기준 |
|---|---|
| Connection lost | 연결이 끊겼고 어떤 상태인지 읽힘 |
| Partial failure | 어떤 에이전트가 실패했는지 명확 |
| Retry | 재시도 버튼 label 명확 |
| Source failed | 출처 실패와 답변 실패 구분 |
| Chart failed | 차트 실패 시 표/텍스트 대체 제공 |

---

## 11. Storybook Accessibility Stories

```txt
QA/Accessibility
- KeyboardFocus
- ScreenReaderLabels
- ChartFallbackTable
- DarkModeContrast
- MobileTouchTargets
- ReduceMotion
- ErrorStateA11y
- CollapsibleAnswerA11y
```

---

## 12. 6월 최소 기준

6월에는 완전한 accessibility QA가 아니라 아래만 우선 확인한다.

- P0 컴포넌트 focus visible
- light/dark contrast
- 모바일 touch target
- CollapsibleAnswer aria-expanded
- Source/Citation label
- Chart fallback table 구조 초안
- ErrorNotice action label
