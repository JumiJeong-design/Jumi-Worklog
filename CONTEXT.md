# 현재 상태 스냅샷

> 세션 시작 시 자동 로드되는 파일. 세션 종료 전 반드시 업데이트.
> Last updated: 2026-05-31

---

## 레포 구조

| 레포 | 역할 |
|------|------|
| jumi-worklog | 공동 기록 허브 — 공통 스킬 + 날짜별 워크로그 |
| socra-ai-product-design | 제품 채널 — 디자인시스템/컴포넌트 → 전체 화면 |
| socra-ai-workflow-guide | 위키 채널 — AI 워크플로우·프로세스·시행착오 |

---

## 미해결 항목

- [ ] Figma 디자인 전체 리디자인 (주미님 직접) → 완료 후 코드 sync
- [ ] 코드 기반 컴포넌트 라이브러리 기술 스택 확정 → 확정 후 Code Connect
- [ ] FIGMA_TOKEN 등록 완료 + 네트워크 정책 `api.figma.com` 추가 완료 → **새 세션에서 REST API 전환 테스트 필요**
- [ ] 브랜드 컬러 확정 (리디자인 전제조건)
- [ ] Japanese 폰트 최종 확정 — M PLUS 2 vs Pretendard JP (Figma 렌더링 비교 필요, 주미님)
- [ ] Foundation에 Error states · Motion · Breakpoints 추가 (주미님)

---

## 현재 검증 중인 가설

| 가설 | 현황 |
|------|------|
| 일본 유저는 멀티 AI 비교에서 신뢰를 더 높게 느낀다 | 🔄 검증 전 |
| 고민 도메인이 명확할수록 재방문률이 높다 | 🔄 검증 전 |
| 일본 유저는 UI 완성도에서 신뢰를 먼저 형성한다 | 🔄 검증 전 |

---

## 주요 결정 + 이유 (최근순)

| 결정 | 이유 한 줄 |
|------|------------|
| write-worklog에 SHA 무결성 검증(Step 2.5) 추가 | 세션 간 히스토리 충돌로 5/29 rules.md 17규칙이 고아 커밋으로 유실됐다가 복구된 사고 재방지 |
| write-worklog에 worklog.html 자동 동기화(Step 4.6) 추가 | jumi-worklog private이라 GitHub Pages 뷰어와 수동 동기화 필요 → 자동화 |
| 폰트 스택 확정 (UI=Geist, KR=Pretendard, Code=Noto Sans Mono) | 5/29 결정. Japanese는 M PLUS 2 vs Pretendard JP 테스트 중 |
| ops-plan.md 전면 재작성 | 빌드 트랙만 있고 검증 루프·일본 설계 원칙·품질 게이트가 누락됐었음 |
| Figma REST API 전환 추진 | Plugin API가 5페이지 중 2개만 반환하는 lazy loading 버그 |
| 토큰 Semantic 이름 원칙 | `color-gray-700`은 브랜드 변경 시 이름이 거짓말이 됨 |
| Japan-First 설계 원칙 채택 | 일본을 "조정 대상"이 아닌 "설계 기준"으로 삼아야 나중 현지화 비용 최소화 |
| Figma 이미지 fill로 모델 아이콘 내장 | MCP vectorPaths API가 브랜드 SVG 소수점 좌표 미지원 |
| 블랙앤화이트 플랫폼 톤 | 브랜드 컬러 미확정 상태에서 컴포넌트 작업 진행 가능하게 |

---

## Figma 파일 페이지 구조

파일 키: `DcYgJjGAfObOIM4IyrQjgj` | MCP Plugin API는 lazy loading으로 2개만 반환 → REST API 필요

| 페이지 | node ID | 내용 |
|--------|---------|------|
| Components | `0:1` | 컴포넌트 35개 |
| Foundation | 미확인 | Color(light/dark) · Typography · Spacing · Shadow · Markdown · Error states 예정 |
| Icons | `74:10109` | Lucide 전체 + In Use 24개 |
| Pages | 미확인 | 화면 디자인 (준비 중) |
| Image reference | 미확인 | 참조 이미지 모음 |

> node ID 미확인 항목은 REST API 전환 후 다음 세션에서 확인 예정

---

## AI 모델 현황

`docs/model-registry.md` 참고. 현재 5개 활성 (Claude/GPT/Gemini/Grok/Perplexity), 6번째 TBD.

---

## 현재 진행 상황

### socra-ai-product-design
- 파운데이션 문서 4종 완료 (color, typography, spacing, shadow)
- docs/ux-principles.md 완료 + **a11y 체크리스트 추가 (WCAG 2.1 AA, 터치타겟, 스크린리더)**
- **design-system/components.md — 35개 컴포넌트 전면 싱크 완료**
- **design-system/decisions.md — 5/29 폰트 스택 결정 + 브랜드 방향 항목 추가**
- **design-system/rules.md — 17규칙 복구 완료** (5/29 고아 커밋 `b93d8db`에서 복구. Rule 13 SVG 금지 ~ Rule 17 폰트 역할 분리 포함)
- **design-system/screens.md — 신규 생성** (5개 화면 스캐폴딩: Onboarding/Chat/Compare/History/Settings)
- **design-system/foundation/typography.md — 5/29 결정 반영** (Geist/Pretendard 확정, M PLUS 2 vs Pretendard JP 테스트 중)
- docs/product-context.md — 검증 가설 테이블 + 화면 맵 추가 완료
- docs/model-registry.md — 신규 생성 완료
- docs/agent-rules.md — Figma 5페이지 구조 + MCP 주의사항 완료
- Model Profile: 브랜드 아이콘 이미지 fill 완료 (5모델 × 3사이즈)
- Figma 리디자인 대기 중

### socra-ai-workflow-guide
- v0.4 배포 완료
- AGENTS.md 업데이트 완료
- product-context.md → site-context.md 이름 변경 완료
- **worklog.html — 5/30 엔트리 전체 반영** (오전 자동화+Figma+ops-plan, 오후 rules복구+a11y+screens+SHA무결성)

### jumi-worklog
- SessionStart hook 완료 (CONTEXT.md 자동 로드)
- Stop hook 완료 (워크로그 없으면 블로킹)
- **write-worklog 스킬 — Step 2.5 SHA 무결성 검증 추가** (고아 커밋 재방지)
- **write-worklog 스킬 — Step 4.6 worklog.html 자동 동기화 추가**
- ops-plan.md 전면 재작성 완료 — 글로벌 서비스 아키텍처
- 2026-05-30 워크로그 작성 완료

---

## 다음 작업 예정

1. **새 세션**: REST API 전환 테스트 → 5페이지 node ID 전체 확인 → Variables dark mode audit → SessionStart hook 업그레이드
2. Japanese 폰트 Figma 렌더링 비교 → M PLUS 2 vs Pretendard JP 최종 결정 (주미님)
3. Figma Foundation에 Error states / Motion / Breakpoints 추가 (주미님)
4. 브랜드 컬러 + Latin 폰트 확정 (주미님) → 리디자인 시작
5. 기술 스택 확정 → Code Connect + 토큰 파이프라인
