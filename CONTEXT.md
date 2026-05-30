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
- [ ] 코드 기반 컴포넌트 라이브러리 관리 방식 확정 (design-system 폴더 기반)

## 최근 주요 결정

- 디자이너 주도 원칙: Figma 결정은 주미님이, Claude는 구현 지원
- `design-system/` = 구현 자산 (컴포넌트·토큰·파운데이션)
- `docs/` = 판단 근거 문서 (UX 원칙·의사결정·가이드)
- 세션 자동화: SessionStart 훅으로 이 파일 자동 로드 (2026-05-30 구축)

## 현재 진행 상황

### socra-ai-product-design
- 파운데이션 문서 4종 작성 완료 (color, typography, spacing, shadow)
- docs/ux-principles.md 작성 완료
- Figma 리디자인 대기 중

### socra-ai-workflow-guide
- v0.4 배포 완료
- Figma AI 스킬 가이드 섹션 추가됨

### jumi-worklog
- SessionStart 훅 구축 완료 — GitHub API로 이 파일 자동 로드
- AGENTS.md 도구별 진입점 정비 완료

## 다음 작업 예정

- Figma 리디자인 완료 후 디자인시스템 코드 sync
- 컴포넌트 라이브러리 관리 방식 확정
