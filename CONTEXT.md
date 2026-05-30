# 현재 상태 스냅샷

> 세션 시작 시 자동 로드되는 파일. 세션 종료 전 반드시 업데이트.
> Last updated: 2026-05-30

---

## 레포 구조

| 레포 | 역할 |
|------|------|
| jumi-worklog | 공동 기록 허브 — 공통 스킬 + 날짜별 워크로그 |
| socra-ai-product-design | 제품 채널 — 디자인시스템/컴포넌트 → 전체 화면 |
| socra-ai-workflow-guide | 위키 채널 — AI 워크플로우·프로세스·시행착오 |

## 미해결 항목

- [ ] Figma 디자인 전체 리디자인 (주미님 직접 진행) → 완료 후 코드 sync 재진행
- [ ] 코드 기반 컴포넌트 라이브러리 관리 방식 확정 → 확정 후 Code Connect 설정

## 최근 주요 결정

- 디자이너 주도 원칙: Figma 결정은 주미님이, Claude는 구현 지원
- `design-system/` = 구현 자산 (컴포넌트·토큰·파운데이션)
- `docs/` = 판단 근거 문서 (UX 원칙·의사결정·가이드)
- 세션 자동화: SessionStart 훅으로 이 파일 자동 로드 (2026-05-30 구축)
- 공통 스킬 정본 위치: jumi-worklog/skills/ (각 레포 로컬 사본 제거)
- 세션 종료 자동화: Stop hook이 오늘 worklog 없으면 블로킹 리마인더 출력
- Figma 파일 키: `DcYgJjGAfObOIM4IyrQjgj` (페이지 5개 — Components/Foundation/Icons 확인됨)

## Figma 파일 페이지 구조

총 5개 페이지 (Figma MCP `get_metadata`는 2개만 반환하는 버그 있음):
- `0:1` Components — 컴포넌트 35개
- Foundation — Color(light/dark), Typography, Spacing, Shadow 프레임 (node ID 미확인)
- `74:10109` Icons — Lucide 전체 + In Use 24개
- `---` 구분선 + 추가 페이지 (참조 이미지 등)

## 현재 진행 상황

### socra-ai-product-design
- 파운데이션 문서 4종 작성 완료 (color, typography, spacing, shadow)
- docs/ux-principles.md 작성 완료
- Figma 리디자인 대기 중
- AGENTS.md 세션 시작 절차·AI 도구별 진입점 추가 (main 반영 완료)
- 중복 skills/write-worklog 삭제 완료
- **design-system/components.md — Figma 실제 상태로 전면 싱크 완료 (35개 컴포넌트)**
- **design-system/decisions.md — Model Profile 아이콘 완료 상태 반영**
- **docs/agent-rules.md — Figma 파일 키 + 페이지 구조 (Foundation 포함 5개) 반영 완료**
- Model Profile: 브랜드 아이콘 이미지 fill로 내장 완료 (Claude/GPT/Gemini/Grok/Perplexity × sm/md/lg)

### socra-ai-workflow-guide
- v0.4 배포 완료
- Figma AI 스킬 가이드 섹션 추가됨
- AGENTS.md 세션 시작 절차·AI 도구별 진입점 추가 (main 반영 완료)
- product-context.md → site-context.md 이름 변경 (충돌 해결)

### jumi-worklog
- SessionStart 훅 구축 완료 — GitHub API로 이 파일 자동 로드
- Stop hook 강화 — 오늘 worklog 없으면 세션 종료 블로킹
- write-worklog 스킬 — Step 4.5 추가 (worklog push 후 CONTEXT.md 자동 갱신)
- AGENTS.md AI 도구별 진입점 테이블 추가 (main 반영 완료)
- README.md 내용 보강 완료

## 다음 작업 예정

- Figma 리디자인 완료 후 → Code Connect 설정 + 코드 컴포넌트 생성
- 컴포넌트 라이브러리 관리 방식 확정
