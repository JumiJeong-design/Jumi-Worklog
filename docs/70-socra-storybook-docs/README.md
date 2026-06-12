# Socra AI Storybook 확장 문서 패키지

작성일: 2026-06-11  
목표 기간: 2026-06-11 ~ 2026-06-30  
작업 방식: Claude Pro + Codex Pro 병행

## 문서 구성

| 파일 | 목적 |
|---|---|
| `01-socra-storybook-expansion-plan.md` | 전체 전략 / 방향 / 확인 범위 |
| `02-june-execution-plan.md` | 6월 주간 실행 일정 |
| `03-june-task-breakdown.md` | Codex/Claude에 넘길 수 있는 작업 티켓 |
| `04-storybook-guidelines.md` | Storybook IA, Story 작성 기준, QA 기준 |
| `05-fe-handoff-checklist.md` | 프론트 개발자 연동 검증 체크리스트 |
| `component-doc-template.md` | 컴포넌트 문서 공통 템플릿 |
| `components/*.md` | 핵심 P0 컴포넌트별 스펙 |
| `qa/10-design-qa-checklist.md` | 디자인 QA 기준 |
| `qa/14-accessibility-checklist.md` | 접근성, 키보드, 차트 fallback 기준 |

## 핵심 방향

Socra AI의 Storybook은 단순 컴포넌트 전시장이 아니라, 아래 제품 UX를 검증하는 공간으로 운영한다.

```txt
Multi-agent answer
→ Agent identity
→ Stance comparison
→ Socra summary
→ Long text handling
→ Source evidence
→ Chart/score visualization
→ Responsive/theme/locale QA
→ FE integration loop
```

| `advanced/12-responsive-web-mobile-design-rules.md` | 웹 PC / 웹 모바일 디자인 구분점과 반응형 규칙 |
| `advanced/13-error-exception-case-guidelines.md` | 연결 끊김, 부분 실패, 출처/차트 실패 등 오류/예외 케이스 UX |
| `advanced/15-analytics-event-plan.md` | 사용자 행동 분석 이벤트 설계 초안 |
| `advanced/16-content-agent-tone-guideline.md` | 에이전트 역할/말투/캐릭터성 가이드 |
| `advanced/17-performance-loading-budget.md` | 여러 답변/차트/마크다운 렌더링 성능 기준 |
