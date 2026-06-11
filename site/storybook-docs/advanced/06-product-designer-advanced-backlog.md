# 06. Product Designer Advanced Backlog

## 1. 문서 목적

이 문서는 6월 P0 작업 이후, 프로덕트 디자이너 관점에서 Socra AI 서비스를 고도화하기 위해 계속 챙겨야 할 작업을 분류한 백로그다.

6월 목표가 Storybook 기반의 핵심 UX 구조 검증이라면, 이후 목표는 서비스 완성도, 신뢰도, 확장성, 운영 가능성을 높이는 것이다.

---

## 2. 고도화 작업 분류

| 분류 | 목적 | 우선순위 |
|---|---|---|
| UX Architecture | 답변 구조와 비교 경험 고도화 | P0 |
| Agent Experience | 에이전트 캐릭터와 역할 구분 강화 | P0 |
| Motion / Interaction | 생성형 AI다운 생동감과 조작 피드백 강화 | P0 |
| Data / Contract | 실제 데이터 구조와 UI 연결 | P0 |
| Streaming / State | 생성 중/부분 실패/재시도 경험 | P0 |
| Source / Trust | 출처 신뢰도와 근거 표현 고도화 | P0 |
| Chart / Decision Visualization | 판단/점수/비교 시각화 고도화 | P0 |
| Feedback / Evaluation | 답변 품질 평가와 학습 루프 | P1 |
| Analytics | 사용자가 무엇을 보고 선택했는지 추적 | P1 |
| Accessibility | 접근성, 키보드, 스크린리더 대응 | P1 |
| Internationalization | ko/en/ja 실제 서비스 품질 검증 | P1 |
| Design QA | UX/UI 완성도 검수 체계 | P0 |
| Competitive Benchmark | 레퍼런스/경쟁사 대비 품질 비교 | P1 |
| Product Ops | 문서/Storybook/FE 루프 운영 | P1 |

---

## 3. UX Architecture 고도화

| 작업 | 설명 |
|---|---|
| Answer Mode 정의 | Single / Compare / Decision / Research / Data 답변 모드 정리 |
| Compare UX 상세화 | Summary → Stance → Detail → Source/Chart 흐름 고도화 |
| Mobile / Desktop 정보 구조 분리 | 모바일은 요약 우선, PC는 병렬 비교 중심 |
| Raw Answer 접근 방식 정의 | 원문을 언제, 어디서, 어떻게 보여줄지 |
| 답변 밀도 조절 | 간단히 / 자세히 / 원문 보기 옵션 검토 |
| 사용자 질문 재구성 | 긴 질문을 요약하거나 조건/선택지로 파싱하는 UX |

---

## 4. Agent Experience 고도화

| 작업 | 설명 |
|---|---|
| Agent Role 정의 | 리서처, 현실주의자, 전략가, 반대자 등 역할 정의 |
| Agent Tone 정의 | 차분함, 직설적, 데이터 중심, 공감형 등 |
| Model vs Agent 구분 | 기반 모델과 사용자-facing agent를 분리 |
| Agent Capability Tags | 출처 강함, 창의적, 리스크 분석, 실행계획 등 |
| Agent Detail Sheet | 에이전트의 역할, 강점, 한계, 기반 모델 설명 |
| 에이전트별 답변 톤 가이드 | 캐릭터성은 드러나되 과장되지 않도록 기준화 |

---

## 5. Motion / Interaction 고도화

| 작업 | 설명 |
|---|---|
| Thinking motion | 질문 분석/모델 응답 생성/종합 중 상태를 섬세하게 표현 |
| Agent reply entrance | 여러 에이전트 답변이 순차적으로 등장하는 모션 |
| Streaming text behavior | 답변이 생성되는 중의 텍스트 표시 리듬 |
| Collapse / Expand motion | 긴 답변, 출처, 원문 펼침/접힘 |
| Source preview transition | citation 탭 → source preview/sheet 연결 |
| Chart reveal motion | 차트가 생성/업데이트될 때 과하지 않게 등장 |
| Feedback micro-interaction | 좋아요, 복사 완료, 재시도 클릭 후 피드백 |
| Reduce motion 대응 | 모션 민감 사용자에 대한 최소 애니메이션 모드 |

### 참고 방향

- 반짝이는 thinking motion은 AI 서비스의 생동감을 줄 수 있으나, 장식으로 과해지지 않도록 정보 상태와 연결한다.
- 예: “분석 중”, “모델 답변 비교 중”, “종합 중” 상태별로 motion 강도/표현을 다르게 둔다.
- 모션은 예쁘기보다 상태를 이해시키는 역할이 우선이다.

---

## 6. Data / Contract 고도화

| 작업 | 설명 |
|---|---|
| Agent data shape | agentId, name, role, model, avatar, capabilities |
| Answer data shape | answerId, markdown, summary, stance, confidence, status |
| Source data shape | sourceId, title, url, type, date, reliability |
| Chart data shape | chartType, data, series, source, note |
| State data shape | loading, partial, failed, complete |
| FE/BE/API 협의 | 실제 응답 구조와 Storybook fixture 동기화 |

---

## 7. Streaming / State 고도화

| 작업 | 설명 |
|---|---|
| Agent별 loading 상태 | 각 모델/에이전트 응답 생성 중 표시 |
| Partial response | 일부 답변만 먼저 도착했을 때 UI |
| Failed response | 특정 모델 실패 시 카드 상태 |
| Retry UX | 실패한 모델만 다시 시도 |
| Stop generating | 생성 중단 버튼/상태 |
| Streaming text | 답변이 토큰 단위로 생성되는 경험 |
| 단계형 thinking | “자료 찾는 중 / 비교 중 / 요약 중” 등 |

---

## 8. Source / Trust 고도화

| 작업 | 설명 |
|---|---|
| Source reliability | 공식/리포트/뉴스/블로그/모델 추론 구분 |
| Source freshness | 최신/오래됨/날짜 없음 표시 |
| Citation interaction | 본문 citation 탭 시 preview/sheet |
| 모델별 출처 차이 | 어떤 모델이 어떤 출처를 썼는지 표시 |
| 출처 없는 답변 처리 | 출처 없음, 모델 추론, 확인 필요 문구 |
| 사용자 파일/히스토리 출처 | 권한/프라이버시 표시 기준 |

---

## 9. Chart / Decision Visualization 고도화

| 작업 | 설명 |
|---|---|
| Chart library 확정 | Recharts / shadcn charts / ECharts 중 결정. shadcn/ui radial chart는 Recharts 기반 참고로 본다 |
| ChartContainer 확장 | title, description, source, note, state 포함 |
| ScoreBar | 추천도/신뢰도/위험도 점수 |
| ComparisonBarChart | 선택지/모델 간 비교 |
| Radial chart 후보 | 추천도/신뢰도/진행률 같은 gauge형 metric에 한정해 검토. 기본 chart system으로 확장하지 않음 |
| MetricCard | 핵심 수치 강조 |
| Chart fallback | 데이터 없음, 로딩, 에러, 표 대체 |
| 모바일 차트 처리 | 긴 라벨, tooltip, horizontal scroll |
| 차트 출처/산식 표시 | 숫자가 어디서 왔는지 설명 |

---

## 10. Feedback / Evaluation 고도화

| 작업 | 설명 |
|---|---|
| 답변 평가 | 도움 됨/별로임/이유 선택 |
| 모델별 평가 | 어떤 에이전트 답변이 유용했는지 |
| Winner pick | 가장 도움 된 답변 선택 |
| 수정 요청 | “더 짧게”, “근거 더 보기”, “다시 비교” |
| 품질 개선 루프 | 어떤 피드백을 로그로 남길지 정의 |

---

## 11. Design QA 고도화

필수 산출물:

- `design-qa-checklist.md`
- `ux-review-scorecard.md`
- `ui-polish-checklist.md`
- `competitive-benchmark-template.md`
