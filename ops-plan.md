# Socra AI — 글로벌 서비스 운영 아키텍처

> **핵심 명제**: 올바른 제품을 빠르게 찾아가는 시스템  
> 작성: 2026-05-30 | 갱신 시 날짜 업데이트

---

## 왜 초기 구조가 결정적인가

글로벌 서비스에서 초기 아키텍처 결정은 나중에 바꾸기 매우 어렵습니다.

- **토큰 이름**: 코드에 박히면 리네이밍이 대규모 리팩토링
- **i18n 구조**: 처음부터 설계 안 하면 나중에 전체 컴포넌트 재설계
- **컴포넌트 API**: Code Connect 연결 후 변경 시 매핑 전부 재작업
- **검증 루프 부재**: 잘못된 방향으로 쌓인 디자인/코드는 모두 버려야 함

지금 정교하게 잡는 게 6개월 후 기술부채를 막습니다.

---

## 두 개의 트랙이 동시에 돌아야 한다

대부분의 초기 서비스가 실패하는 이유는 **빌드는 열심히 하는데 검증을 안 하기 때문**입니다.

```
빌드 트랙 (Build)                 학습 트랙 (Learn)
─────────────────                 ─────────────────
기획 → 디자인 → 코드 → 배포        유저 → 인사이트 → 가설 → 검증
        ↑                                              ↓
        └──────────── 두 트랙이 여기서 만나야 함 ─────────┘
```

현재 구조는 빌드 트랙만 있습니다. 학습 트랙이 없으면 아무리 빠르게 만들어도 방향이 틀릴 수 있습니다.

---

## 1. 일본 시장 설계 원칙 (Japan-First Architecture)

일본은 "1차 타겟"이 아니라 **설계의 기준**이 되어야 합니다. 나중에 일본용으로 조정하는 게 아니라, 일본 기준으로 설계하고 다른 시장에 확장하는 구조입니다.

### 일본 사용자의 구조적 차이

| 영역 | 일본 패턴 | 설계 함의 |
|------|-----------|-----------|
| 정보 밀도 | 더 많은 정보를 한 화면에 선호 | 컴포넌트 내 텍스트 허용량 넉넉하게 설계 |
| 신뢰 형성 | 시각적 품질이 신뢰도와 직결 | 완성도 낮은 UI는 이탈 유발. 와이어프레임 수준 절대 불가 |
| 에러 대응 | 에러에 매우 민감, 명확한 해결 경로 요구 | 에러 상태 디자인을 Foundation 레벨에서 정의 |
| 다크모드 | 야간 사용률 높음, 다크모드 선호 | 다크모드는 옵션이 아닌 필수 |
| 프라이버시 | 개인정보에 매우 민감 (APPI) | AI 쿼리 처리 방식 명시적 고지 필요 |
| 모바일 패턴 | 세로 화면, 엄지 탐색, 스크롤 중심 | 주요 액션은 하단 배치, 드래그 대신 탭 |
| 폰트 | CJK 특유의 가독성 요구 | Noto Sans JP (Korean이 아닌 Japanese 전용) |

### 디자인 시스템에 반영해야 할 것

**지금 당장:**
- Foundation의 Typography 토큰에 Japanese-specific line-height, letter-spacing 값 필요
- 현재 Noto Sans KR → Noto Sans JP로 변경 검토 (한국어/일본어 글리프 차이)
- 에러 상태 디자인 Foundation 레벨에서 정의 (현재 없음)
- 신뢰 신호 컴포넌트 계획 (프라이버시 배지, 처리 현황 표시 등)

**APPI 준수를 위한 UI 요구사항:**
- 개인정보 수집·이용 목적 명시 UI
- AI 처리 데이터 범위 공지 컴포넌트
- 동의 철회 경로 접근 가능성

---

## 2. 제품 검증 루프 (Validation Loop)

이게 없으면 나머지 전부 의미 없습니다.

### 루프 구조

```
① 가설 설정     → product-context.md의 "현재 검증 중인 가설" 섹션
② 설계          → Figma Pages 페이지에 프로토타입
③ 검증          → 유저 테스트 / 베타 사용자 피드백
④ 인사이트 기록  → research/ 폴더 or Notion
⑤ 반영          → 가설 업데이트 → 디자인 수정 → CONTEXT.md 갱신
```

### 운영 체계에 추가할 것

**product-context.md에 추가할 섹션:**
```
## 현재 검증 중인 가설
- 가설: [무엇을 검증하고 있는가]
- 검증 방법: [어떻게 확인할 것인가]
- 성공 지표: [무엇을 보면 맞다고 판단하는가]
- 현황: [진행 중 / 검증됨 / 기각됨]
```

**인사이트 → CONTEXT.md 흐름:**
- 유저 인터뷰 후 → `research/YYYY-MM-DD-interview.md` 생성
- 핵심 인사이트 → CONTEXT.md "학습한 것" 섹션에 1-2줄 반영
- 기획 변경으로 이어지면 → decisions.md에 근거 기록

**Notion MCP 활용 (장기):**
- 유저 리서치, 경쟁사 분석, 피드백 데이터베이스를 Notion에서 관리
- Claude가 Notion MCP로 최신 리서치 데이터를 읽어 설계에 반영

---

## 3. 디자인 시스템 — 글로벌 기준

### 지금 당장 잡아야 할 토큰 원칙

**토큰은 계약(Contract)입니다.**

토큰 이름이 바뀌면 코드 전체가 깨집니다. 처음부터 **의미 중심(Semantic)** 으로 이름을 지어야 합니다.

```
❌ color-gray-700          → 값이 바뀌면 이름이 거짓말이 됨
✅ color-text-secondary    → 어디에 쓰이는지 명확, 브랜드 변경에 강함

❌ spacing-16              → 픽셀 값이 이름에 박힘
✅ spacing-component-gap   → 쓰임새 중심, 반응형에서도 의미 유지
```

**3단계 토큰 레이어:**
```
Primitive (원시값)    →  Semantic (의미)      →  Component (쓰임)
──────────────────       ──────────────────       ──────────────────
color-blue-500           color-ai-accent          button-primary-bg
size-16px                spacing-content-gap      card-padding
weight-600               font-weight-heading      badge-font-weight
```

Figma Variables 구조도 이 3단계로 재정리되어야 합니다.

### Foundation 페이지 — 현재 vs 필요

| 항목 | 현재 상태 | 글로벌 기준 |
|------|-----------|-------------|
| Color | light/dark 정의됨 | ✅ 방향 맞음. Semantic 레이어 명확화 필요 |
| Typography | 정의됨 | ⚠️ Noto Sans JP 검토, CJK line-height 조정 필요 |
| Spacing | 정의됨 | ✅ Semantic 이름 확인 필요 |
| Shadow | 정의됨 | ✅ |
| Markdown | 정의됨 | ✅ AI 응답 렌더링에 중요 |
| Error states | **없음** | 🔴 일본 시장에서 필수. 즉시 추가 필요 |
| Motion/Animation | **없음** | 🔴 AI 로딩 스피너, 타이핑 인디케이터 필수 |
| Accessibility tokens | **없음** | 🟠 최소 터치 타겟(44px), 대비율 토큰 필요 |
| Breakpoints | **없음** | 🟠 모바일 퍼스트. 375/390/768/1280px 정의 |

### Variables 바인딩 Audit (FIGMA_TOKEN 등록 즉시 실행)

```bash
# REST API로 Variables 전체 추출
curl "https://api.figma.com/v1/files/DcYgJjGAfObOIM4IyrQjgj/variables/local" \
  -H "X-Figma-Token: $FIGMA_TOKEN"
```

확인 항목:
- 35개 컴포넌트가 Variables를 실제로 참조하고 있는가?
- light/dark 모드 전환 시 모든 컴포넌트가 올바르게 반응하는가?
- Hardcoded 색상값(#FFFFFF 등)이 컴포넌트에 남아 있지 않은가?

### 품질 게이트 (Quality Gates)

글로벌 서비스는 일관성 없는 UI를 허용하지 않습니다.

| 레벨 | 게이트 | 도구 |
|------|--------|------|
| Figma | Variables 없이 컬러 직접 사용 금지 | Figma Lint 플러그인 |
| Figma | 컴포넌트 아닌 요소 화면에 사용 금지 | 디자인 리뷰 체크리스트 |
| 코드 | 토큰 외 하드코딩 색상/크기 금지 | ESLint custom rule |
| 코드 | 접근성 자동 검사 | axe-core, Lighthouse CI |
| 코드 | 시각 회귀 검사 | Storybook + Chromatic |
| 배포 | 성능 예산 초과 시 차단 | Lighthouse CI (LCP < 2.5s) |

---

## 4. Figma 운영 고도화

### REST API 전환 (즉시 — FIGMA_TOKEN 등록 후)

```
현재: Figma MCP Plugin API → 2/5 페이지만 보임 (lazy loading 버그)
목표: Figma REST API → 전체 페이지 + Variables + 변경 이력 완전 접근
```

**FIGMA_TOKEN 등록 즉시 가능해지는 것:**

| 기능 | API 엔드포인트 |
|------|----------------|
| 전체 페이지 + node ID 확인 | `/v1/files/:key` |
| Variables 전체 추출 | `/v1/files/:key/variables/local` |
| 컴포넌트 목록 | `/v1/files/:key/components` |
| 버전 히스토리 | `/v1/files/:key/versions` |
| 특정 노드 이미지 | `/v1/images/:key?ids=:nodeId` |

**SessionStart hook 업그레이드 계획:**

```python
# 현재: GitHub API → CONTEXT.md 로드
# 추가: Figma REST API → 컴포넌트 수 변경 감지 → CONTEXT.md에 반영

figma_data = requests.get(
    f"https://api.figma.com/v1/files/{FIGMA_FILE_KEY}/components",
    headers={"X-Figma-Token": os.environ["FIGMA_TOKEN"]}
)
component_count = len(figma_data.json().get("meta", {}).get("components", []))
# 이전 CONTEXT.md의 컴포넌트 수와 다르면 → 경고 출력
```

---

## 5. 코드 파이프라인 — 기술 스택 결정 가이드

### 권장: Next.js App Router + CSS Custom Properties

이유:
- **Figma Variables → CSS 변수 1:1 대응**: `--color-text-primary` 형태로 자동 생성 가능
- **일본 시장 성능**: Edge Runtime + Vercel Japan 리전으로 낮은 레이턴시
- **AI 스트리밍**: App Router의 Streaming이 AI 응답 실시간 표시에 최적
- **i18n**: next-intl 라이브러리로 일본어/영어 전환 구조적 지원
- **Server Components**: SEO + 초기 로드 성능 (일본 모바일 환경에서 중요)

### 토큰 아키텍처 (코드 확정 즉시 생성)

```
design-system/
├── tokens/
│   ├── primitive.css      ← Figma Variables에서 자동 생성
│   ├── semantic.css       ← 의미 레이어 (수동 정의)
│   └── component.css      ← 컴포넌트 레이어 (수동 정의)
└── components/
    ├── Button/
    │   ├── Button.tsx
    │   ├── Button.figma.tsx  ← Code Connect 매핑
    │   └── Button.test.tsx
```

### i18n 아키텍처 (처음부터 설계)

```
messages/
├── ja.json    ← 일본어 (primary)
└── en.json    ← 영어 (secondary)
```

컴포넌트 레벨에서 텍스트 하드코딩 완전 금지. 모든 사용자 노출 텍스트는 i18n key로만 관리.

---

## 6. AI 모델 운영 (Model Operations)

Socra의 제품 자체가 AI 모델입니다. 모델은 매달 바뀝니다. 이걸 운영 시스템에서 관리해야 합니다.

### 모델 레지스트리

`docs/model-registry.md` — 항상 최신 상태 유지:

```markdown
| 모델 | 현재 버전 | 상태 | Figma 컴포넌트 | 마지막 업데이트 |
|------|-----------|------|----------------|----------------|
| Claude | claude-opus-4-8 | ✅ 활성 | Model Profile ✅ | 2026-05-30 |
| GPT | gpt-4.1 | ✅ 활성 | Model Profile ✅ | 2026-05-30 |
| Gemini | gemini-2.0-flash | ✅ 활성 | Model Profile ✅ | 2026-05-30 |
| Grok | grok-3 | ✅ 활성 | Model Profile ✅ | 2026-05-30 |
| Perplexity | sonar-pro | ✅ 활성 | Model Profile ✅ | 2026-05-30 |
| TBD | - | 🔄 검토 중 | - | - |
```

### 모델 변경이 제품에 미치는 영향 추적

모델이 업데이트될 때 체크해야 할 것:
- 모델 아이콘/로고 변경 여부 → Model Profile 컴포넌트 업데이트
- 새 기능(멀티모달, 음성 등) → Answer Card 컴포넌트 변경 필요?
- 가격 변경 → 비즈니스 모델 반영
- 성능 변화 → 프로덕트 포지셔닝 영향

---

## 7. Claude 협업 아키텍처 고도화

### 현재 메모리 구조와 한계

```
작업 기억 (Working Memory): CONTEXT.md ← 현재 세션에 로드됨
에피소딕 기억 (Episodic): YYYY-MM-DD.md ← 날짜별 워크로그
의미 기억 (Semantic): docs/*.md ← 규칙, 결정, 원칙
절차 기억 (Procedural): skills/*.md ← 반복 워크플로우
```

**현재 한계:**
- CONTEXT.md에 "무엇을 했는지"는 있지만 "왜 그랬는지"가 없음
- 워크로그가 쌓이지만 검색/집계가 안 됨
- 팀이 생기면 이 구조 전체가 무너짐

### CONTEXT.md 구조 개선

현재 없는 섹션을 추가해야 합니다:

```markdown
## 현재 검증 중인 가설
[제품 검증 루프와 연결]

## 최근 주요 결정 + 이유
[결정뿐 아니라 왜 그 결정을 했는지 1-2줄]

## AI 모델 레지스트리 현황
[지금 어떤 모델이 어떤 상태인지]

## 품질 게이트 현황
[어떤 체크가 통과되고 있는지]
```

### 스킬 라이브러리 로드맵

| 스킬 | 기능 | 단계 |
|------|------|------|
| `write-worklog` | 워크로그 + CONTEXT.md 갱신 | ✅ 완료 |
| `figma-sync` | REST API로 Figma 전체 상태 읽기 + 문서 갱신 | Phase 2 |
| `token-sync` | Figma Variables → tokens.css 자동 생성 | Phase 2 |
| `design-to-code` | Figma 노드 → 코드 컴포넌트 | Phase 2 |
| `model-update` | 모델 레지스트리 갱신 + 영향 범위 분석 | Phase 2 |
| `sprint-plan` | 현재 상태 기반 우선순위 제안 | Phase 2 |
| `research-log` | 유저 인터뷰 → 구조화된 인사이트 기록 | Phase 2 |
| `design-review` | Figma 변경 → 코드 영향 범위 + 품질 체크 | Phase 3 |
| `weekly-retro` | 워크로그 집계 → 주간 회고 자동 생성 | Phase 3 |

### 모델 선택 원칙

| 작업 | 모델 | 이유 |
|------|------|------|
| 전략 설계, 아키텍처 결정, 이 문서 작성 | Opus | 추론 깊이 필요 |
| 코드 생성, 문서 초안, 컴포넌트 구현 | Sonnet | 속도·품질 균형 |
| 파일 수정, 검색, 단순 반복 작업 | Haiku | 비용 효율 |

### 팀 스케일 전환 계획

지금은 주미님 + Claude 구조. 팀이 생기면 달라지는 것:

| 항목 | 현재 (1인) | 팀 규모 (3-5인) |
|------|-----------|-----------------|
| CONTEXT.md | 1개 파일 공유 | 역할별 컨텍스트 분리 필요 |
| 워크로그 | 주미님만 | 팀원별 워크로그 + 집계 |
| decisions.md | 1인 결정 기록 | 의사결정 참여자 명시 필요 |
| 브랜치 전략 | main 직접 반영 | PR 리뷰 프로세스 필요 |
| Claude 세션 | 1개 | 역할별 세션 분리 (디자인/개발/기획) |

팀 규모가 되기 전에 지금 구조를 문서화해두면 온보딩 비용이 크게 줄어듭니다.

---

## 8. 업무 데이터 아키텍처

### 지식 계층 구조

```
전략 (Strategy)        ops-plan.md              ← 이 파일
    ↓
제품 (Product)         docs/product-context.md  ← 방향, 가설, 모델 레지스트리
    ↓
설계 (Design)          Figma + design-system/   ← 컴포넌트, 토큰, 화면
    ↓
구현 (Implementation)  src/ (코드)              ← 실제 동작하는 것
    ↓
기록 (Record)          CONTEXT.md + worklogs    ← 현재 상태 + 과거 기록
```

### 워크로그 구조화

현재 비정형. 태그 시스템 도입:

```markdown
## 2026-05-30

#decision 기술 스택 → Next.js + CSS Variables로 확정
#design Foundation 페이지 Variables 바인딩 audit 완료
#blocker 브랜드 컬러 미확정으로 리디자인 대기
#research 일본 사용자 인터뷰 3건 — 다크모드 선호 확인
```

이렇게 하면 나중에 `#decision`만 모아서 의사결정 히스토리 재구성 가능.

### decisions.md 표준 포맷

```markdown
| 날짜 | 주제 | 배경 | 결정 | 대안 검토 | 결과/회고 |
|------|------|------|------|-----------|-----------|
```

---

## 우선순위 로드맵

### 🔴 Phase 1 — 지금 바로 (이번 주)

| 항목 | 담당 | 중요한 이유 |
|------|------|-------------|
| Figma PAT + `FIGMA_TOKEN` 환경변수 등록 | 주미님 + Claude | 이후 모든 자동화의 전제조건 |
| REST API로 Variables 전체 추출 + 바인딩 audit | Claude | dark mode 작동 여부 확인 |
| Foundation에 Error states 추가 | 주미님 | 일본 시장 필수, 리디자인 전 확정 |
| product-context.md에 "현재 가설" 섹션 추가 | Claude | 검증 루프 시작점 |
| docs/model-registry.md 생성 | Claude | 모델 운영 기반 |
| CONTEXT.md에 "결정 이유" 섹션 추가 | Claude | 컨텍스트 압축 대응 |

### 🟠 Phase 2 — 리디자인 + 스택 확정 후

| 항목 | 담당 |
|------|------|
| 브랜드 컬러 확정 | 주미님 결정 |
| Latin 폰트 결정 (Noto Sans JP 포함 재검토) | 주미님 결정 |
| 기술 스택 확정 | 주미님 결정 |
| `figma-sync` 스킬 구현 (REST API 기반) | Claude |
| `token-sync` 스킬 — Variables → tokens.css | Claude |
| components.md에 "코드 구현 상태" 컬럼 | Claude |
| Code Connect 초기 설정 | Claude |
| Breakpoint 토큰 Foundation에 추가 | 주미님 |
| Motion/Animation 토큰 Foundation에 추가 | 주미님 |

### 🟡 Phase 3 — 코드 기반 안정화 후

| 항목 |
|------|
| `design-to-code` 스킬 |
| `research-log` 스킬 + 유저 인터뷰 체계 |
| Storybook + 시각 회귀 테스트 |
| Lighthouse CI 성능 게이트 |
| Accessibility audit (axe-core) |
| `sprint-plan` 스킬 |

### 🟢 Phase 4 — 팀 + 글로벌 확장

| 항목 |
|------|
| 멀티에이전트 워크플로우 |
| Figma webhook → 자동 코드 업데이트 트리거 |
| Notion MCP 연동 (리서치 데이터베이스) |
| 영어 i18n 추가 (2번째 시장) |
| `weekly-retro` 스킬 |
| 팀 온보딩 문서 + Claude 협업 가이드 |

---

## 핵심 결정 사항 (Claude가 대신 결정 불가)

| 결정 사항 | 왜 지금 해야 하는가 | Phase |
|----------|---------------------|-------|
| 브랜드 컬러 확정 | 전체 디자인 시스템의 전제. 지금 못 정하면 모든 컴포넌트가 임시 상태 | 1 |
| Latin + Japanese 폰트 확정 | typography 토큰 확정 → 컴포넌트 패딩/행간 전부 영향 | 1 |
| 기술 스택 | 토큰 아키텍처, Code Connect 구조, i18n 전략이 전부 여기서 파생 | 2 |
| 5번째 AI 모델 | 모델 레지스트리 완성 + Model Profile 컴포넌트 최종 확정 | 2 |
| 유저 검증 방식 | 타겟이 일본이라면 일본 사용자 접근 방법이 필요 (베타 모집, 인터뷰 채널 등) | 1 |

---

## 지금 당장 Claude가 할 수 있는 것

FIGMA_TOKEN 등록 전:
1. `docs/model-registry.md` 생성
2. CONTEXT.md 구조 개선 (결정 이유 + 현재 가설 섹션)
3. `product-context.md`에 검증 가설 섹션 추가
4. `decisions.md` 포맷 정형화

FIGMA_TOKEN 등록 후 즉시:
1. REST API로 전체 페이지 node ID 확인
2. Variables 전체 추출 + 바인딩 audit 실행
3. SessionStart hook에 Figma 상태 자동 로드 추가
4. `figma-sync` 스킬 구현 시작
