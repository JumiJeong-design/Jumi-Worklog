# Component Doc Template

Socra Storybook 컴포넌트 문서는 `components/*.md`의 공통 구조를 따른다.
새 컴포넌트 문서를 만들 때는 아래 섹션을 유지하고, 실제 `riiid/prism` 코드 구조를 확인한 뒤 props와 story 이름을 구체화한다.

## 1. Purpose

- 이 컴포넌트가 해결하는 제품 UX 문제를 적는다.
- 단순 UI 설명보다 Socra의 multi-agent / compare / source / chart 흐름에서 맡는 역할을 먼저 쓴다.

## 2. Usage

### Use when

- 컴포넌트를 써야 하는 조건을 적는다.

### Do not use when

- 다른 컴포넌트나 패턴을 써야 하는 조건을 적는다.

## 3. Anatomy

| Part | Description |
|---|---|
| Root | 전체 container |
| Header | 제목, 상태, 메타 정보 |
| Body | 주요 콘텐츠 |
| Footer | 보조 정보, 액션, source |

## 4. Props 초안

```ts
type ComponentNameProps = {
  // 실제 repo의 타입/토큰/slot 패턴 확인 후 조정
};
```

## 5. Variants / States

| State | Description |
|---|---|
| default | 기본 상태 |
| loading | 데이터 로딩 중 |
| error | 데이터/응답 실패 |
| longContent | 긴 텍스트 |
| dark | 다크모드 |
| mobile | 모바일 레이아웃 |

## 6. Responsive

- Mobile 390: 정보량, 줄바꿈, touch target, overflow를 우선 확인한다.
- Desktop 1280: 비교, 확장, side-by-side 구성이 가능한지 확인한다.

## 7. Theme

- light / dark 대표 story를 둔다.
- semantic token을 우선 사용하고 hard-coded color를 피한다.

## 8. Locale

- ko / en / ja fixture를 둔다.
- 긴 영어/일본어 문자열에서 clipping, wrapping, ellipsis 계약을 확인한다.

## 9. Storybook Stories

```txt
Docs
Default
Matrix
LongContent
Mobile
DarkMode
Korean
English
Japanese
Error
Loading
```

## 10. Edge Cases

- 데이터 없음
- 일부 실패
- 긴 텍스트
- 모바일 overflow
- 다국어 overflow
- source 없음 / 실패
- chart empty / error / fallback table
