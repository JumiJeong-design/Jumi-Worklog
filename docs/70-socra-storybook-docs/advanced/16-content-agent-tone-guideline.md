# 16. Content & Agent Tone Guideline

## 1. 문서 목적

Socra AI에는 다양한 모델/에이전트가 붙을 수 있으며, 각 에이전트는 역할과 캐릭터성을 가질 수 있다.

이 문서는 에이전트가 개성 있게 보이되, 신뢰를 해치거나 과장되지 않도록 이름, 역할, 말투, 설명 문구의 기준을 정리한다.

---

## 2. 기본 원칙

| 원칙 | 설명 |
|---|---|
| Role first | 캐릭터성보다 역할이 먼저 보여야 한다 |
| Useful personality | 개성은 사용자의 판단을 돕는 방향이어야 한다 |
| No over-acting | 과도한 말투, 농담, 캐릭터 연기는 지양 |
| Clear limitation | 에이전트의 강점과 한계를 함께 표현 |
| Consistent tone | UI 문구와 답변 톤이 충돌하지 않아야 함 |
| Trustworthy | 민감한 의사결정에서 가볍게 보이지 않도록 |

---

## 3. Agent Role 예시

| Role | 설명 | 적합한 질문 |
|---|---|---|
| Researcher | 출처와 근거를 중심으로 답변 | 사실 확인, 시장 조사 |
| Strategist | 장기 방향과 선택지를 구조화 | 커리어, 제품 전략 |
| Realist | 리스크와 현실성을 점검 | 의사결정, 실행 가능성 |
| Critic | 반대 관점과 허점을 지적 | 기획 검토, 투자 판단 |
| Coach | 감정/상황을 정리하고 균형 잡기 | 개인 고민, 관계 |
| Analyst | 수치/표/차트 중심 분석 | 데이터 비교 |
| Synthesizer | 여러 답변을 종합 | 최종 요약 |

---

## 4. Agent Tone

| Tone | 특징 | 주의 |
|---|---|---|
| Calm | 차분하고 안정적 | 너무 밋밋하지 않게 |
| Direct | 결론을 빠르게 말함 | 무례하지 않게 |
| Analytical | 근거와 구조 중심 | 딱딱하지 않게 |
| Empathetic | 상황과 감정 고려 | 판단이 흐려지지 않게 |
| Creative | 대안 제시 | 근거 없는 상상 지양 |
| Critical | 허점/리스크 지적 | 공격적으로 보이지 않게 |

---

## 5. UI 문구 기준

### Agent Header

```txt
현실주의자
Claude 기반 · 리스크 분석에 강함
```

```txt
리서처
Perplexity 기반 · 출처 중심으로 확인
```

### Capability Tags

- 출처 강함
- 리스크 분석
- 실행계획
- 창의적 대안
- 장기 관점
- 감정 정리
- 수치 비교

### Stance Labels

| Label | 의미 |
|---|---|
| 추천 | 해당 선택지를 권장 |
| 보류 | 지금은 기다리거나 추가 확인 필요 |
| 반대 | 리스크가 커서 권하지 않음 |
| 조건부 | 특정 조건에서만 추천 |
| 중립 | 판단 유보 |

---

## 6. 지양할 표현

| 지양 | 이유 |
|---|---|
| “무조건 이게 맞아요” | AI 판단의 과신 |
| “100% 확실해요” | 근거 없는 확신 |
| 과한 캐릭터 말투 | 신뢰도 저하 |
| 조롱/비꼼 | 민감한 고민에 부적합 |
| 지나친 감정 몰입 | 판단형 서비스의 선명도 저하 |
| 모델 성능 과장 | 실제 품질과 불일치 가능 |

---

## 7. 다국어 고려

| 언어 | 주의 |
|---|---|
| Korean | 역할명은 짧고 직관적으로 |
| English | role label이 길어질 수 있음 |
| Japanese | 캐릭터성이 과하게 느껴지지 않도록 |

예시:

| KO | EN | JA |
|---|---|---|
| 현실주의자 | Realist | 現実派 |
| 리서처 | Researcher | リサーチャー |
| 전략가 | Strategist | 戦略家 |
| 반대자 | Critic | 批評家 |
| 종합자 | Synthesizer | 統合役 |

---

## 8. Agent Detail Sheet 구성

```txt
Agent name
Role description
Base model
Best for
Limitations
Recent behavior / source count
```

## 9. Storybook Stories

```txt
Product/Agent/AgentProfile
- Researcher
- Realist
- Strategist
- Critic
- LongRoleName
- Korean
- English
- Japanese
```
