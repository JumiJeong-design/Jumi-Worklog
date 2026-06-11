# 문서 역할맵

> 목적: AI와 사람이 문서를 덜 읽고도 현재 기준, 규칙, 절차, 기록을 구분하게 만든다.
> 원칙: 새 문서를 늘리기보다 기존 문서를 역할별로 정리하고, 중복 문서는 병합/삭제/아카이브한다.
> 작성일: 2026-06-11

---

## 번호 체계

| 번호 | 역할 | 설명 |
| --- | --- | --- |
| `00-09` | Entry / Index | 사람이든 AI든 처음 보는 문서. 짧고 링크 중심. |
| `10-19` | Current State | 현재 상태, active plan, 이번 주 기준. 오래된 내용은 남기지 않음. |
| `20-29` | Rules / Guardrails | 반드시 지키는 canonical rule. 중복 금지. |
| `30-39` | Playbooks / Workflows | 특정 상황에서 실행하는 절차. |
| `40-49` | QA / Eval / Harness Checks | 자동/반자동 검증, 회귀 케이스, 하네스 리뷰. |
| `50-59` | Source of Truth / Contracts | 컴포넌트, 토큰, 패키지, 제품 계약. |
| `60-69` | Templates / Prompts / Skill Entrypoints | 사용자가 기억할 진입 스킬, 템플릿, 프롬프트. |
| `70-79` | Logs / Raw Records | 날짜별 raw 기록. 현재 판단 기준으로 직접 쓰지 않음. |
| `80-89` | External / Shareable Docs | 외부 공유용 정제 문서. 내부명/경로/보안 정보 제거. |
| `90-99` | Archive / Deprecated | 과거 자료. 기본 진입 경로에서 제외. |

Root의 `README.md`, `AGENTS.md`, `CLAUDE.md`는 도구가 자동으로 찾는 진입 파일이라 파일명을 유지한다. 단, 내부에서 이 번호 체계의 canonical 문서로 링크한다.

---

## 운영 원칙

- 먼저 역할맵을 만들고, 링크 영향도를 확인한 뒤 repo별로 rename한다.
- `skills/` 내부 파일은 도구/스킬 discovery 경로와 연결될 수 있으므로 1차 rename 대상에서 제외한다.
- `site/*.html`, 배포 산출물, Storybook artifact는 문서 체계 번호화 대상이 아니다.
- 과거 계획 문서는 새 계획의 source가 아니면 `90-99 Archive`로 이동하거나 Notion/worklog에만 남긴다.
- 새 문서부터 번호 체계를 적용하되, 기존 문서는 아래 매핑표 기준으로 단계적으로 정리한다.

---

## jumi-worklog 매핑

| 현재 문서 | 역할 번호 | 목표/처리 | 비고 |
| --- | --- | --- | --- |
| `README.md` | `00` | Keep root entry | repo 역할과 SOT 구분 유지. |
| `AGENTS.md` | `00` | Keep root entry | 세션 시작 규칙. `docs/00-document-role-map.md` 링크 추가 후보. |
| `CONTEXT.md` | `10` | Keep root current snapshot | 이미 100줄로 축소. freshness check 기준 유지. |
| `docs/00-document-role-map.md` | `00` | New canonical map | 이 문서. |
| `docs/80-external-prompt-architecture-notes.md` | `80` | New external reference note | Every 글, 비공식 prompt architecture 자료를 구조 참고용으로만 관리. |
| `ops-plan.md` | `10` 또는 `90` | Review | 현재 active plan인지, 과거 계획인지 확인 필요. |
| `hooks/README.md` | `40` | Keep | git push guard 등 local hook 검증/설치 안내. |
| `scripts/check-context-freshness.sh` | `40` | Keep check | `CONTEXT.md` stale 방지. |
| `scripts/validate-worklogs.sh` | `40` | Keep check | worklog path + context freshness 검증. |
| `skills/README.md` | `60` | Keep skill index | 사용자가 기억할 진입 스킬 중심으로 재정리 후보. |
| `skills/*/SKILL.md` | `60` | Keep paths | rename 금지. 스킬 경로 안정성 우선. |
| `templates/*.md` | `60` | Keep templates | 필요 시 `60-templates` index만 추가. |
| `logs/YYYY/MM/*.md` | `70` | Keep raw logs | 날짜 기록. 현재 상태 판단은 `CONTEXT.md`와 최신 worklog 교차 확인. |
| `plans/YYYY/MM/*.md` | `70` 또는 `90` | Review | active plan인지 과거 plan인지 분류 필요. |

### jumi-worklog 1차 작업 후보

- `AGENTS.md`에 이 문서 링크 추가.
- `skills/README.md`를 "모든 스킬 목록"보다 "핵심 진입점" 중심으로 줄일지 검토.
- `.DS_Store` 제거 및 `.gitignore` 추가 검토.

---

## Prism / socraAI_product design 매핑

| 현재 문서 | 역할 번호 | 목표/처리 | 비고 |
| --- | --- | --- | --- |
| `README.md` | `00` | Keep root entry | package repo 설명. |
| `AGENTS.md` | `00` | Keep root entry | agent 진입점. 상세 규칙은 `design-system/rules.md`로 위임. |
| `CLAUDE.md` | `00` | Keep root entry | Claude Code 진입점. |
| `docs/workflows.md` | `30` | Keep workflow | 실행 절차. 상세 rule 반복 금지. |
| `docs/agent-rules.md` | `20` | Keep rules | agent 행동 규칙. `design-system/rules.md`와 중복 점검 필요. |
| `design-system/rules.md` | `20` | Keep canonical rule | 디자인 시스템 핵심 guardrail. |
| `docs/checklist.md` | `40` | Keep QA checklist | 검증 체크리스트로 분류. |
| `docs/release.md` | `30` | Keep release workflow | 배포 절차. |
| `docs/prompts.md` | `60` | Keep prompts | prompt/template 분류. |
| `templates/*.md` | `60` | Keep templates | PR/spec 템플릿. |
| `docs/product-context.md` | `50` | Keep product contract | 제품 맥락 SOT 후보. |
| `docs/ux-principles.md` | `50` | Keep UX contract | UX 판단 기준. |
| `docs/brand-style.md` | `50` | Keep brand contract | 브랜드 판단 기준. |
| `docs/model-registry.md` | `50` | Keep product/data contract | 모델 목록/정체성. |
| `packages/prism/token-contract.md` | `50` | Keep contract | token SOT. |
| `packages/prism/component-contracts/*.md` | `50` | Keep contracts | package/component SOT. |
| `design-system/foundation/*.md` | `50` | Keep foundation evidence | Foundation 근거. |
| `design-system/components/*.md` | `50` | Keep Figma evidence | package 계약 아님. evidence로 분류. |
| `design-system/sync/*.md` | `40` 또는 `50` | Review | sync checklist/log/map 성격이 섞임. 분리 후보. |
| `design-system/decisions/*.md` | `50` 또는 `90` | Review | 현재 ADR인지 historical decision인지 분류. |
| `docs/00-document-role-map.md` | `00` | Added | Prism 내부 문서 역할맵. |
| `docs/plans/10-design-system-followup-2026-06-06.md` | `10` | Renamed | 현재 인수인계 기준 active plan. |
| `docs/plans/90-direction-2026-05-27.md` | `90` | Renamed | 과거 MVP 방향 메모. |
| `docs/plans/90-figma-mcp-deferred-2026-05-27.md` | `90` | Renamed | 피그마 MCP 후순위 메모. |
| `apps/storybook/*.md` | `40` | Keep QA/use docs | Storybook 사용/visual QA. |
| `apps/demo/README.md` | `00` 또는 `30` | Keep local app guide | demo app entry. |
| `skills/**` | `60` | Keep paths | Figma/plugin skills 경로 안정성 때문에 rename 제외. |
| `templates/*.md`, `.github/*.md`, `.changeset/*.md` | `60` | Keep supporting templates | 템플릿/릴리즈 보조 문서. |

### Prism 1차 rename 결과

- `docs/plans/*` 문서의 active/archive 여부 확정 완료.
- `AGENTS.md`, `README.md`, `design-system/sync/sync-log.md`의 plan 참조 갱신 완료.
- `scripts/validate-design-system.sh`에 `docs/plans/*.md` 역할 번호 접두어 검증 추가 완료.
- `design-system/sync/`의 map/checklist/log를 `40` 검증과 `50` 근거로 나눌지 결정.
- `design-system/decisions/`의 ADR 중 현재 기준과 과거 이력을 분리할지 검토.
- rename 전 `rg`로 링크 참조 확인.

---

## socra-ai-workflow-wiki 매핑

| 현재 문서 | 역할 번호 | 목표/처리 | 비고 |
| --- | --- | --- | --- |
| `README.md` | `00` | Keep root entry | wiki channel map. |
| `AGENTS.md` | `00` | Keep root entry | agent 진입점. |
| `CLAUDE.md` | `00` | Keep root entry | Claude Code 진입점. |
| `site/site-context.md` | `10` 또는 `00` | Review | site용 context인지 agent용 context인지 확인. |
| `wiki/guides/30-figma-git-sync.md` | `30` | Renamed | Figma/Git 운영 경계. |
| `wiki/guides/31-daily-worklog-to-wiki.md` | `31` | Renamed | Worklog를 wiki로 승격하는 절차. |
| `wiki/guides/40-ai-design-review.md` | `40` | Renamed | AI 디자인 리뷰/QA 기준. |
| `wiki/guides/80-designer-dev-terms.md` | `80` | Renamed | 외부 공유 가능한 개발 협업 용어. |
| `wiki/guides/90-figma-first-storybook-verified.md` | `90` | Renamed | 과거 Figma/Storybook 시행착오. |
| `wiki/playbooks/30-agent-handoff-playbook.md` | `30` | Renamed | 에이전트 handoff 절차. |
| `wiki/playbooks/31-component-update-playbook.md` | `31` | Renamed | 컴포넌트 업데이트 절차. |
| `wiki/playbooks/32-screen-design-playbook.md` | `32` | Renamed | 화면 디자인 절차. |
| `wiki/cases/README.md` | `80` 또는 `90` | Review | 사례 index 성격 확인. |
| `wiki/notes/*.md` | `90` | Archive candidate | 회의/메모성 기록. |
| `site/*.html` | N/A | Keep generated/static site | 번호화 대상 아님. 링크 깨짐 리스크 큼. |
| `site/worklog.html` | `70` surface | Keep public viewer | private worklog의 공개 surface. |
| `artifacts/**` | N/A | Keep artifact | 정리 대상 아님. |

### wiki 1차 rename 결과

| 현재 문서 | 목표 이름 후보 |
| --- | --- |
| `wiki/playbooks/agent-handoff-playbook.md` | `wiki/playbooks/30-agent-handoff-playbook.md` 완료 |
| `wiki/playbooks/component-update-playbook.md` | `wiki/playbooks/31-component-update-playbook.md` 완료 |
| `wiki/playbooks/screen-design-playbook.md` | `wiki/playbooks/32-screen-design-playbook.md` 완료 |
| `wiki/guides/figma-git-sync.md` | `wiki/guides/30-figma-git-sync.md` 완료 |
| `wiki/guides/daily-worklog-to-wiki.md` | `wiki/guides/31-daily-worklog-to-wiki.md` 완료 |
| `wiki/guides/ai-design-review.md` | `wiki/guides/40-ai-design-review.md` 완료 |
| `wiki/guides/designer-dev-terms.md` | `wiki/guides/80-designer-dev-terms.md` 완료 |
| `wiki/guides/figma-first-storybook-verified.md` | `wiki/guides/90-figma-first-storybook-verified.md` 완료 |

### wiki 1차 작업 후보

- playbooks부터 번호화하면 영향 범위가 작다.
- guides는 외부 공유용(`80`)과 내부 운영용(`30/40`)으로 먼저 분리한다.
- `site/*.html` 링크가 md 파일 경로를 직접 참조하는지 확인한 뒤 rename한다.

---

## 링크 영향도 확인 명령

Rename 전에는 각 repo에서 아래 패턴을 확인한다.

```bash
rg -n "agent-handoff-playbook|component-update-playbook|screen-design-playbook|figma-git-sync|daily-worklog-to-wiki|ai-design-review|designer-dev-terms|figma-first-storybook-verified|2026-06-06-socra-design-system-followup|figma-minor|direction.md"
```

Markdown 링크 깨짐 검사는 다음 하네스 개선 후보로 둔다.

```text
40-link-check: md/html 내부 상대 링크가 실제 파일을 가리키는지 검사
40-role-prefix-check: docs/wiki 문서가 역할 번호 prefix를 따르는지 검사
```

---

## 단계별 실행안

1. 이 역할맵을 `jumi-worklog`에 먼저 저장한다. 완료.
2. `AGENTS.md`와 `CONTEXT.md`에서 역할맵을 진입점으로 링크한다. 완료.
3. wiki playbooks 3개부터 번호화 rename을 시도한다. 완료.
4. rename 후 `rg`로 깨진 참조를 고친다. 완료: 옛 playbook 경로 참조 없음.
5. wiki guides는 내부 운영/외부 공유/과거 자료로 분류한 뒤 2차 정리한다. 완료.
6. Prism은 root/reference 문서와 `docs/plans`부터 정리한다. `skills/`는 제외한다. 1차 완료: `docs/plans` 번호화와 plan prefix 검증 추가.
7. 마지막에 link check / role prefix check 스크립트를 추가한다. role prefix check와 local markdown link check를 wiki validation에 추가 완료. Prism은 1차로 plan prefix check만 추가.
