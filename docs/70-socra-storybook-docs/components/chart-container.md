# ChartContainer

## 1. Purpose

모든 차트의 공통 shell을 제공한다.

## 2. Usage

### Use when

- 차트 제목/설명/출처/상태를 함께 관리할 때
- ScoreBar, ComparisonBarChart, radial/gauge 후보처럼 숫자 근거와 상태가 함께 필요한 chart block을 감쌀 때

### Do not use when

- 단순 숫자 하나만 보여줄 때
- 시각 장식용 radial chart처럼 표 대체나 수치 설명 없이 그래픽만 필요한 경우

## 3. Anatomy

| Part | Description |
|---|---|
| Root | 전체 container |
| Header | 제목/상태/메타 정보 |
| Body | 주요 콘텐츠 |
| Footer | 부가 정보/액션 |

## 4. Props 초안

```ts
type ChartContainerProps = {
  // TODO: 실제 코드 구조에 맞게 조정
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

- Mobile 390: 정보량을 줄이고 필요한 경우 접기/펼치기 또는 sheet 사용
- Desktop 1280: 병렬 비교 또는 expanded view 허용

## 7. Theme

- light / dark 모두 확인
- semantic token 우선 사용
- hard-coded color 사용 지양

## 8. Locale

- ko / en / ja fixture 필요
- 긴 영어/일본어 문자열에서 줄바꿈 확인

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

- 긴 텍스트
- 데이터 없음
- 일부 실패
- 모바일 overflow
- 다국어 overflow
- radial/gauge chart가 과하게 장식적으로 보이지 않는지
- chart를 렌더하지 못할 때 동일 데이터를 표로 확인할 수 있는지
