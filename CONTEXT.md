# 현재 상태 스냅샷

> 세션 시작 시 자동 로드되는 파일. 세션 종료 전 반드시 업데이트.
> Last updated: 2026-05-31

---

## 레포 구조

| 레포 | 역할 |
|------|------|
| jumi-worklog | 공동 기록 허브 — 공통 스킬 + 날짜별 워크로그 (`logs/YYYY/MM/`) |
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
- [ ] PR #3 머지 — `socra-ai-product-design` Rule 18 추가 브랜치, CI 통과 후 머지 판단

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
| 워크로그 경로 `logs/YYYY/MM/`로 통일 | write-worklog는 루트, CI는 logs/만 검증 → 6일치가 검증 사각지대에 쌓임. 스킬·AGENTS 경로 수정으로 재발 차단 |
| Figma-first → Storybook 검증 모델 채택 | 컴포넌트 구현 전 Figma 추출 필수, 임의 스타일링 금지를 가이드 규칙으로 |
| rules.md Rule 18 Auto Layout 필수 | 다국어 텍스트 길이(KR/JA/EN) 변화에 레이아웃이 깨지지 않게 |
| write-worklog에 SHA 무결성 검증(Step 2.5) 추가 | 세션 간 히스토리 충돌로 5/29 rules.md 17규칙이 고아 커밋으로 유실됐다가 복구된 사고 재방지 |
| write-worklog에 worklog.html 자동 동기화(Step 4.6) 추가 | jumi-worklog private이라 GitHub Pages 뷰어와 수동 동기화 필요 → 자동화 |
| 폰트 스택 확정 (UI=Geist, KR=Pretendard, Code=Noto Sans Mono) | 5/29 결정. Japanese는 M PLUS 2 vs Pretendard JP 테스트 중 |
| ops-plan.md 전면 재작성 | 빌드 트랙만 있고 검증 루프·일본 설계 원칙·품질 게이트가 누락됐었음 |
| Figma REST API 전환 추진 | Plugin API가 5페이지 중 2개만 반환하는 lazy loading 버그 |
| Japan-First 설계 원칙 채택 | 일본을 "조정 대상"이 아닌 "설계 기준"으로 삼아야 나중 현지화 비용 최소화 |
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
- docs/ux-principles.md 완료 + a11y 체크리스트 (WCAG 2.1 AA, 터치타겟, 스크린리더)
- design-system/components.md — 35개 컴포넌트 전면 싱크 완료
- design-system/decisions.md — 5/29 폰트 스택 결정 + 브랜드 방향 항목 추가
- **design-system/rules.md — 18규칙** (17규칙 복구 + Rule 18 Auto Layout 필수 추가, **PR #3 브랜치에 있고 main 미머지**)
- design-system/screens.md — 5개 화면 스캐폴딩
- design-system/foundation/typography.md — 5/29 결정 반영 (Geist/Pretendard 확정, JP 테스트 중)
- docs/product-context.md · model-registry.md · agent-rules.md 완료
- Model Profile: 브랜드 아이콘 이미지 fill 완료 (5모델 × 3사이즈)
- Figma 리디자인 대기 중

### socra-ai-workflow-guide
- v0.4 배포 완료
- **4채널 운영 모델 + Figma-Git sync 가이드 체계 구축** (Codex) — Figma Git sync / Screen·Component 플레이북 / AI design review / Daily worklog 가이드
- **GitHub 인프라** — 가이드 검증 CI, PR·이슈 템플릿 3종, 추천 라벨
- **Figma-first 규칙 강화** — 컴포넌트 구현 전 Figma 추출 필수, 임의 스타일링 금지
- worklog.html — 5/30·5/31 엔트리 반영

### jumi-worklog
- SessionStart hook (CONTEXT.md 자동 로드) + Stop hook 완료
- write-worklog 스킬 — Step 2.5 SHA 무결성 + Step 4.6 뷰어 동기화
- **워크로그 계층 `logs/YYYY/MM/`로 통일** — 루트 6개 이전 + 5/29 복원 + 스킬/AGENTS 경로 수정
- ops-plan.md 전면 재작성 완료 (글로벌 서비스 아키텍처)
- 2026-05-31 워크로그까지 작성 완료

---

## 다음 작업 예정

1. **새 세션**: REST API 전환 테스트 → 5페이지 node ID 전체 확인 → Variables dark mode audit → SessionStart hook 업그레이드
2. PR #3 CI 통과 확인 → 머지 판단 (Rule 18)
3. Japanese 폰트 Figma 렌더링 비교 → M PLUS 2 vs Pretendard JP 최종 결정 (주미님)
4. Figma Foundation에 Error states / Motion / Breakpoints 추가 (주미님)
5. 브랜드 컬러 + Latin 폰트 확정 (주미님) → 리디자인 시작
6. 기술 스택 확정 → Code Connect + 토큰 파이프라인
