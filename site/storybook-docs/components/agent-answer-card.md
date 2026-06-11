# AgentAnswerCard

## 1. Purpose

각 모델/에이전트의 답변을 카드 단위로 표시한다.

## 2. Usage

### Use when

- 여러 에이전트 답변을 비교해야 할 때

### Do not use when

- 단일 AI 답변만 필요한 일반 채팅일 때

## 3. Anatomy

| Part | Description |
|---|---|
| Root | 전체 container |
| Header | 제목/상태/메타 정보 |
| Body | 주요 콘텐츠 |
| Footer | 부가 정보/액션 |

## 4. Props 초안

```ts
type AgentAnswerCardProps = {
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
