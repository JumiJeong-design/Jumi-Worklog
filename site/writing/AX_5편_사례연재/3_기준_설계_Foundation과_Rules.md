# 3편. AI를 통제한 두 개의 기준 — Figma Foundation과 Git Rules

## 한 줄 요약

AI를 디자인 시스템에 안전하게 넣으려면 좋은 프롬프트만으로는 부족했다. 두 개의 기준이 필요했다. **Figma Foundation**은 "어떤 시각 값이 맞는가"를, **Git Rules**는 "AI가 무엇을 어디까지 고쳐도 되는가"를 통제했다. 이 둘은 사실상 두 개의 디자인 시스템이었다.

---

## AI 활용의 핵심은 산출물보다 기준이었다

이번 실험에서 가장 많이 바뀐 생각은 이것이다.

```text
(전) AI를 잘 쓰면 화면을 빨리 만들 수 있다.
(후) AI를 잘 쓰려면, AI가 움직일 수 있는 기준과 멈춰야 할 조건을 먼저 설계해야 한다.
```

디자인 시스템 작업에서는 빠른 결과보다 기준이 중요했다. AI가 빠르게 움직일수록, 어디까지 해도 되는지와 어디서 멈춰야 하는지가 더 명확해야 했다.

---

## 기준 1. Figma Foundation — 시각 값을 통제한다

Figma Foundation은 AI가 임의로 시각 값을 만들지 못하게 하는 기준이었다.

Foundation은 color, typography, spacing, radius만 뜻하지 않았다. 실제 제품 품질을 좌우하는 상태값까지 포함했다.

- light/dark mode
- semantic alpha
- disabled / pressed / loading / error
- shadow / elevation
- icon stroke
- long text
- locale
- table head / column / body cell 구조

Figma Foundation이 약하면 AI는 매번 그럴듯한 값을 새로 만든다. disabled 상태를 opacity로 처리할지 semantic token으로 처리할지, dark mode shadow를 어떻게 보여줄지, 브랜드 컬러를 몇 군데까지 쓸지 판단이 흔들린다.

그래서 Figma는 "예쁜 화면을 만드는 곳"을 넘어, AI가 디자인 시스템 안에서만 움직이게 하는 시각 기준이 됐다.

---

## 기준 2. Git Rules — AI의 행동 범위를 통제한다

Git은 Figma에서 승인된 기준을 언어화하는 곳이었다.

AI가 실제 repo를 만지기 시작하면 룰이 필요하다. 특히 Codex는 로컬 repo를 읽고 파일을 고칠 수 있어서 실행력이 좋다. 동시에 본인이 판단했을 때 더 나은 방향으로 개선하려는 경향도 있었다.

이 경향은 코드 작업에서는 장점이지만, 디자인 시스템에서는 위험할 수 있다. Storybook에서 보이는 Button이 Figma와 다르다고 해서 바로 package token이나 component implementation을 고치면 안 된다.

먼저 분류해야 한다.

```text
Figma source 문제인가?
Git contract 문제인가?
Package source 문제인가?
Storybook QA surface 문제인가?
사용자 시각 판단이 필요한가?
```

그래서 Git 안에 룰을 만들었다.

- Figma source가 불명확하면 구현을 멈춘다.
- Figma에 없는 컴포넌트는 package나 Storybook에서 먼저 만들지 않는다.
- package source, public props, DOM semantics, ARIA, keyboard behavior는 승인 없이 바꾸지 않는다.
- 차이가 보이면 바로 수정하지 않고 원인을 분류한다.
- Storybook은 source of truth가 아니라 QA surface로 본다.
- 사용자의 시각 판단이 필요한 항목은 완료 처리하지 않는다.

Git Rules는 개발 문서 정리가 아니라, AI가 팀 프로세스 안에서 안전하게 움직이도록 만드는 두 번째 디자인 시스템이었다.

---

## 기준 2-1. 프롬프트보다 "멈춤 조건"

이번 실험에서 프롬프트는 "무엇을 해줘"보다 "언제 멈춰야 하는가"가 더 중요해졌다.

AI는 요청을 받으면 결과를 만들려고 한다. 특히 Codex처럼 repo를 읽고 수정까지 할 수 있는 도구는, 현재 상태에서 더 나아 보이는 방향을 찾아 바로 실행하려는 경향이 있다.

그래서 프롬프트와 룰에는 아래 조건을 같이 넣어야 했다.

- Figma source가 불명확하면 멈춘다.
- package-sensitive 항목이면 contract부터 확인한다.
- Figma에 없는 variant는 만들지 않는다.
- AI가 만든 candidate를 approved처럼 기록하지 않는다.
- 사용자의 시각 판단이 필요한 항목은 완료 처리하지 않는다.

이 멈춤 조건이 있어야 AI의 실행력이 디자인 시스템을 앞질러가지 않는다.

---

## 이 편의 결론

Figma Foundation이 시각 값을 통제했다면, Git Rules는 AI가 무엇을 읽고, 어디까지 고치고, 어디서 멈춰야 하는지를 통제했다.

이 두 기준이 있어야 AI의 실행력이 디자인 시스템을 앞질러가지 않는다. 좋은 프롬프트 하나보다, AI가 움직일 수 있는 경계를 먼저 설계하는 일이 중요했다.

다음 편(4편)에서는 기준을 세운 뒤에도 작업이 흩어지지 않게 잡아준 **운영 설계** — Worklog, Wiki, 문서 레벨, 모바일/데스크톱 분업 — 을 정리한다.
