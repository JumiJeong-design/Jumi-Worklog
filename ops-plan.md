# Socra AI 운영 아키텍처 — 고도화 로드맵

> 기획 · 디자인 · 프론트 · AI 협업 · 업무 데이터 전 관점을 통합한 초기 구축 계획서  
> 작성: 2026-05-30 | 갱신 시 날짜 업데이트

---

## 핵심 원칙

**"AI가 언제나 지금 상태를 알고 있어야 한다"**

- 모든 레이어(기획/디자인/코드)는 각자의 **단일 진실 공급원(Single Source of Truth)**을 가진다
- Claude는 세션이 바뀌어도 컨텍스트가 끊기지 않는다
- 사람이 반복하는 일은 자동화한다 — 단, 판단은 사람이 한다
- 초기 구조가 정교할수록 나중 고도화 비용이 낮아진다

---

## 시스템 레이어 구조

```
┌─────────────────────────────────────────────────────┐
│  Tier 3: Intelligence Layer (고도화 단계)             │
│  자동 변경 감지 · 스킬 라이브러리 · 멀티에이전트      │
├─────────────────────────────────────────────────────┤
│  Tier 2: Data Pipeline (다음 단계)                   │
│  Figma REST API · 토큰 자동생성 · Code Connect        │
├─────────────────────────────────────────────────────┤
│  Tier 1: Foundation (현재 구축 완료)                  │
│  CONTEXT.md · SessionStart hook · Stop hook          │
│  워크로그 · Figma 5페이지 구조 · 문서 체계            │
└─────────────────────────────────────────────────────┘
```

---

## 8개 관점별 현재 상태 & 고도화 방향

---

### 1. 기획 (Product Planning)

**현재**
- `docs/product-context.md` — 제품 비전, 타겟, 핵심 기능 정의
- 5번째 AI 모델 미확정(TBD), 화면 흐름 미설계

**한계**
- Claude가 유저 스토리, 기능 우선순위, 화면 플로우를 모른다
- 기획 변경이 문서에 반영되는 타이밍이 불규칙하다

**개선 방향**
- `docs/product-context.md`에 **화면 맵(Screen Map)** 섹션 추가 — Figma Pages 페이지와 1:1 대응
- `docs/decisions.md`에 날짜·배경·대안·결론 구조화 → Claude가 "왜 이렇게 됐는지" 추적 가능
- 세션 시작 시 CONTEXT.md에 "미결 기획 이슈" 섹션 유지

**핵심 블로커**: 5번째 AI 모델 확정, Latin 폰트 결정

---

### 2. 디자인 (Design)

**현재**
- Figma 5페이지 구조 완성 (Components 35개, Foundation, Icons, Pages, Image reference)
- Foundation: Color · Typography · Spacing · Shadow · Markdown 렌더링 정의됨
- 화면 디자인(Pages 페이지)은 비어 있음

**한계**
- Figma MCP `get_metadata`가 3개 페이지를 못 읽음 (lazy loading 버그)
- 브랜드 컬러 미확정 → 전체 리디자인 대기 중
- Components가 Figma Variables에 실제로 바인딩 되어 있는지 audit 미실시

**개선 방향**

| 개선 항목 | 방법 | 우선순위 |
|-----------|------|----------|
| Figma REST API 접근 | `FIGMA_TOKEN` 환경변수 등록 → 전체 페이지 접근 | 🔴 즉시 |
| Variables 바인딩 audit | REST API로 Variables 값 읽어 컴포넌트 연결 확인 | 🔴 즉시 |
| 브랜드 컬러 확정 | 주미님 결정 → 토큰 업데이트 → 리디자인 | 🔴 블로커 |
| Latin 폰트 확정 | Font Comparison 프레임(node: 388:513) 참고 결정 | 🟠 빠른 결정 필요 |
| dark mode 검증 | Variables에 light/dark mode 바인딩 전수 확인 | 🟠 리디자인 전 |

---

### 3. 프론트 (Frontend)

**현재**
- 코드 파일 없음 — `.md` 문서만 존재
- 기술 스택 미결정

**한계**
- Code Connect 설정 불가 (코드 없음)
- Figma Variables → CSS 토큰 자동 생성 불가 (스택 미결정)

**개선 방향**

기술 스택 결정이 전제조건. 결정 시 고려 사항:

| 선택지 | 장점 | 단점 |
|--------|------|------|
| Next.js + Tailwind | 생산성 높음, 커뮤니티 풍부 | 토큰 시스템 설계 필요 |
| Next.js + CSS Modules | 스코프 명확, 디자인 토큰 직결 | 보일러플레이트 많음 |
| Next.js + CSS Variables | Figma Variables와 1:1 대응 최적 | IE 지원 없음 (문제 없음) |

**권장**: Next.js + CSS Custom Properties — Figma Variables(색상/타이포/스페이싱)를 CSS 변수로 1:1 자동 생성 가능하여 Figma → 코드 파이프라인이 가장 직결됨

기술 스택 확정 후 즉시:
1. `src/components/` 구조 생성
2. Code Connect 설정 (`figma-code-connect` 스킬)
3. Figma Variables → `tokens.css` 자동 생성 스크립트

---

### 4. 기획 운영관점 (Product Operations)

**현재**
- CONTEXT.md의 "미해결 항목"이 기획 이슈 추적 역할

**한계**
- 의사결정 히스토리가 decisions.md에 비정형으로 쌓임
- 유저 리서치, 경쟁사 분석 등 외부 인풋이 Claude 컨텍스트에 없음

**개선 방향**
- `decisions.md` 포맷 구조화: `날짜 | 주제 | 배경 | 결정 | 대안 검토 | 결과`
- 스프린트/마일스톤 개념 도입: "이번 세션에서 결정해야 할 것" 명시
- Notion MCP 활용 검토: 유저 인터뷰, 피드백, 경쟁사 분석을 Notion에서 관리하고 Claude가 읽을 수 있게

---

### 5. 디자인 운영관점 (Design Operations)

**핵심 문제**: Figma 변경이 Claude에게 자동으로 전달되지 않는다

**현재 플로우 (수동)**
```
주미님이 Figma 수정 → Claude에게 알려줌 → Claude가 문서 업데이트
```

**목표 플로우 (자동화)**
```
주미님이 Figma 수정 → SessionStart hook이 REST API로 변경 감지 → CONTEXT.md 자동 반영
```

**구체적 자동화 계획**

| 자동화 항목 | 구현 방법 | 단계 |
|-------------|----------|------|
| 전체 페이지 접근 | `FIGMA_TOKEN` + REST API | Tier 2 |
| 컴포넌트 수 변경 감지 | REST API로 컴포넌트 개수 비교 | Tier 2 |
| Variables 값 추출 | `/v1/files/:key/variables` | Tier 2 |
| 화면 추가/변경 감지 | Pages 페이지 노드 diff | Tier 3 |

**가장 먼저 할 것**: `FIGMA_TOKEN` 환경변수 등록 → SessionStart hook에 Figma REST API 호출 추가 → Foundation/Pages 페이지 구조를 CONTEXT.md에 자동 반영

---

### 6. 프론트 운영관점 (Frontend Operations)

**현재**: 코드 없음이므로 준비 단계

**코드 생성 후 필요한 운영 체계**

| 항목 | 도구/방법 |
|------|-----------|
| Figma ↔ 코드 매핑 추적 | Code Connect (`figma-code-connect` 스킬) |
| 구현 커버리지 추적 | components.md에 "코드 구현 상태" 컬럼 추가 |
| 디자인 토큰 동기화 | Figma Variables → `tokens.css` 자동 생성 스크립트 |
| 컴포넌트 변경 알림 | Figma webhook → GitHub Action (장기) |

**핵심 지표 (KPI)**
- Figma 컴포넌트 대비 코드 구현률 (현재 0%)
- 디자인 토큰 싱크 지연 시간

---

### 7. Claude 협업 운영관점 (AI Collaboration Operations)

**현재 구축된 것**

```
SessionStart hook → CONTEXT.md 로드 (작업 기억)
Stop hook → 워크로그 체크 (에피소딕 기억)
write-worklog 스킬 → 기록 + CONTEXT.md 갱신
docs/ 문서 → 의미 기억 (규칙, 결정, 원칙)
```

**컨텍스트 압축 문제**
- 세션이 길어지면 앞부분 압축됨 → 핵심 판단 근거가 사라질 수 있음
- CONTEXT.md가 이를 완화하지만, 현재는 "상태"만 있고 "이유"는 없음
- **개선**: CONTEXT.md에 "최근 주요 결정 이유" 섹션 추가 (1-2줄씩)

**스킬 라이브러리 확장 계획**

| 스킬 | 기능 | 단계 |
|------|------|------|
| `write-worklog` | 워크로그 작성 + CONTEXT.md 갱신 | ✅ 완료 |
| `figma-sync` | Figma REST API로 컴포넌트/변수 상태 읽어 문서 자동 갱신 | Tier 2 |
| `design-to-code` | 선택 Figma 노드 → 코드 컴포넌트 생성 | Tier 2 (코드 스택 확정 후) |
| `sprint-plan` | 현재 CONTEXT 기반 다음 우선순위 제안 | Tier 2 |
| `token-sync` | Figma Variables → tokens.css 자동 생성 | Tier 2 |
| `design-review` | Figma 변경사항 → 코드 영향 범위 분석 | Tier 3 |

**모델 선택 전략**

| 작업 유형 | 권장 모델 | 이유 |
|-----------|-----------|------|
| 아키텍처 설계, 전략적 판단 | Opus (최고 성능) | 깊은 추론 필요 |
| 코드 생성, 문서 작성 | Sonnet | 속도·품질 균형 |
| 단순 파일 수정, 검색 | Haiku | 비용 효율 |

---

### 8. 업무 데이터 운영관점 (Work Data Operations)

**현재 데이터 구조**

```
jumi-worklog/
├── CONTEXT.md          ← 현재 상태 (자동 로드)
├── YYYY-MM-DD.md       ← 날짜별 워크로그 (에피소딕)
├── skills/             ← 재사용 워크플로우
└── docs/ops-plan.md    ← 이 파일 (전략)

socra-ai-product-design/
├── docs/               ← 판단 근거 (의미 기억)
└── design-system/      ← 구현 자산

socra-ai-workflow-guide/ ← AI 워크플로우 위키
```

**한계**
- 워크로그가 날짜별 파일로 쌓이지만 **검색/집계 불가**
- decisions.md가 비정형이라 "특정 주제 결정 이력" 추적 어려움
- 작업 데이터와 제품 데이터가 분리돼 있어 "이 결정이 어떤 기획 맥락에서 나왔는지" 연결이 약함

**개선 방향**

| 개선 항목 | 방법 |
|-----------|------|
| 워크로그 구조화 | 태그 시스템 추가 (`#design`, `#decision`, `#blocker`) |
| decisions.md 정형화 | 테이블 포맷 표준화 |
| Notion MCP 연동 검토 | 풍부한 데이터베이스 쿼리가 필요한 경우 |
| 주간 회고 스킬 | 워크로그 집계 → 이번 주 완료/미완/결정 요약 자동 생성 |

---

## 우선순위 로드맵

### 🔴 Phase 1 — 즉시 (이번 주)

| 항목 | 담당 | 비고 |
|------|------|------|
| Figma PAT 발급 + `FIGMA_TOKEN` 환경변수 등록 | 주미님 + Claude | REST API 전체 잠금 해제 |
| SessionStart hook에 Figma REST API 호출 추가 | Claude | Foundation/Pages node ID 자동 파악 |
| 브랜드 컬러 확정 | 주미님 결정 | 리디자인 전제조건 |
| Latin 폰트 결정 | 주미님 결정 | Font Comparison 프레임 참고 |

### 🟠 Phase 2 — 단기 (리디자인 후)

| 항목 | 담당 |
|------|------|
| 기술 스택 결정 (Next.js + CSS Variables 권장) | 주미님 결정 |
| `src/components/` 구조 생성 + Code Connect 초기 설정 | Claude |
| Figma Variables → `tokens.css` 자동 생성 스크립트 | Claude |
| `figma-sync` 스킬 구현 | Claude |
| components.md에 "코드 구현 상태" 컬럼 추가 | Claude |

### 🟡 Phase 3 — 중기 (코드 기반 완성 후)

| 항목 |
|------|
| `design-to-code` 스킬 — Figma 노드 선택 → 코드 컴포넌트 자동 생성 |
| `sprint-plan` 스킬 — 현재 상태 기반 우선순위 제안 |
| decisions.md 정형화 + 주간 회고 스킬 |
| dark mode 전수 audit + 검증 |

### 🟢 Phase 4 — 장기

| 항목 |
|------|
| Figma webhook → 변경 감지 → 자동 코드 업데이트 트리거 |
| `design-review` 스킬 — 변경 범위 자동 분석 |
| 멀티에이전트 워크플로우 — 기획/디자인/코드 에이전트 병렬 실행 |
| Notion MCP 연동 — 유저 리서치, 경쟁사 분석 컨텍스트화 |

---

## 핵심 블로커 (Claude가 대신 결정 불가)

| 결정 사항 | 이유 | Phase |
|----------|------|-------|
| 브랜드 컬러 확정 | Figma 리디자인 전제조건 | 1 |
| Latin 폰트 선택 | typography.md 업데이트 + 컴포넌트 적용 | 1 |
| 기술 스택 결정 | Code Connect + 토큰 파이프라인 전제조건 | 2 |
| 5번째 AI 모델 확정 | product-context 완성, 컴포넌트 최종 확정 | 2 |

---

## 지금 당장 Claude가 할 수 있는 것

`FIGMA_TOKEN` 등록되면 즉시:
1. Figma REST API로 전체 페이지 + node ID 확인
2. Foundation 페이지 Variables 추출 → `design-system/tokens.md` 생성
3. SessionStart hook 업그레이드 — Figma 상태 자동 로드 추가
4. `figma-sync` 스킬 초안 작성
