# AI Product / Design Ops Research Backlog

마지막 갱신: 2026-06-11

이 문서는 주미님이 Medium 글감과 workflow wiki에 더 추가하고 싶다고 남긴 아이디어를 연구 후보로 정리한다.

## 원본 메모

세션 중 추가된 아이디어:

- AI로 브랜딩 구축 프로세스
- AI로 캐릭터/모션 생성 프로세스
- Q&A 자주 묻는 질문
- 이 문서를 기반으로 움직이는 챗봇
- 현재 제품이 어느 단계이고 어떤 기준을 적용하면 좋을지 확인하는 간단 테스트
- 문서에 의견 넣기 / 댓글 기능
- 디자인 as-is/to-be 테스트, A/B 테스트 기준
- UT나 데이터 기반 판단 기준
- PoC와 라이브 제품 유저 데이터 연동
- 디자인 실험 기록
- 코드와 피그마 양방향 연동 결과 비고
- 이미지/텍스트 학습 결과 비교
- 피그마에 이미 있는 디자인과 시스템을 AI가 잘 반영하고 학습하는 방법
- AI에게 업무시킬 때 업무 흐름이 끊기지 않도록 모바일로 제어하거나 자동으로 이어가게 하는 방법

## Notion 링크 싱크 기준

관련 Notion 문서를 추가로 받으면 아래 기준으로 붙인다.

| 링크 유형 | 붙일 위치 | 용도 |
| --- | --- | --- |
| 원본 아이데이션 / 메모 | 이 파일의 각 글감 묶음 아래 `Notion sources` | 글감의 원문 맥락 보존 |
| 이미 정리된 PRD / 기획서 | workflow wiki note 또는 guide 후보 | 실제 제품 판단 기준으로 승격 |
| 과거 실험 결과 | `wiki/cases/` 후보 | 사례 글과 재사용 교훈으로 전환 |
| 발행용 문장 초안 | `writing/글감_리스트.md` 또는 연재 초안 | Medium rewrite 재료 |

주의:

- Notion 링크는 원본 위치로 남기고, Medium 글에는 공개 가능한 내용만 요약한다.
- 제품/유저 데이터가 포함된 문서는 내부 wiki와 외부 발행 글을 분리한다.
- 챗봇이나 Q&A에 연결할 링크는 최신성, 접근 권한, 인용 가능 여부를 함께 표시한다.
- `소크라 튜터 프로덕트 디자인` 같은 상위 허브는 전체 본문을 한 번에 긁지 않는다. 필요할 때 데이터베이스의 제목/URL/업무 속성/제품 단계만 먼저 인벤토리화하고, 그중 글감이 될 문서만 본문을 읽는다.

## 글감 묶음

### 1. AI로 브랜드 시스템을 만드는 과정

Notion sources:

- [쏘냥이 만들기 26년ver](https://app.notion.com/p/35e5bc5f630780f6a1c7e09a6874edc0)
- [쏘냥이 세부 캐릭터 디자인 설정](https://app.notion.com/p/35f5bc5f630780aab915ee19a15f18eb)
- [쏘냥이 프롬프트 공통 요소 분석](https://app.notion.com/p/35f5bc5f63078063a2c0dabb0e772af7)
- [쏘냥이 일관성 유지용 프롬프트](https://app.notion.com/p/3605bc5f630780d2a294c6fa4fe1fcd1)

핵심 질문:

- AI가 만든 무드를 어떻게 브랜드 기준으로 승격할까?
- 캐릭터, 컬러, 말투, 모션이 각각 따로 놀지 않게 하려면 어떤 순서로 판단해야 할까?
- 생성 결과 중 어떤 것은 탐색으로 남기고, 어떤 것은 Foundation으로 남겨야 할까?

추천 글:

- AI로 브랜딩을 만들 때 먼저 정해야 하는 것
- AI가 만든 캐릭터를 제품 톤에 맞추는 과정
- 브랜드 탐색과 디자인 시스템 기준 사이에 필요한 단계

위키 승격 후보:

- `guide`: AI branding workflow
- `case`: PrismSpirit 캐릭터 탐색 사례
- `checklist`: brand fit review checklist

### 2. 캐릭터 / 모션 생성 프로세스

Notion sources:

- [쏘냥이 만들기 26년ver](https://app.notion.com/p/35e5bc5f630780f6a1c7e09a6874edc0)
- [쏘냥이 세부 캐릭터 디자인 설정](https://app.notion.com/p/35f5bc5f630780aab915ee19a15f18eb)
- [쏘냥이 프롬프트 공통 요소 분석](https://app.notion.com/p/35f5bc5f63078063a2c0dabb0e772af7)
- [쏘냥이 일관성 유지용 프롬프트](https://app.notion.com/p/3605bc5f630780d2a294c6fa4fe1fcd1)

핵심 질문:

- 캐릭터 생성은 이미지 생성으로 끝나는가, 아니면 제품 상태와 상호작용까지 이어져야 하는가?
- idle, loading, success, error, empty 상태별 모션 기준은 어떻게 나눌까?
- 귀여움, 불편함, 과한 장식성 같은 주관적 판단을 어떻게 리뷰 가능한 기준으로 바꿀까?

추천 글:

- AI로 캐릭터를 만들 때 이미지보다 먼저 봐야 할 것
- 캐릭터 모션을 제품 상태와 연결하는 법
- "귀엽다"를 디자인 리뷰 기준으로 바꾸기

위키 승격 후보:

- `playbook`: character and motion generation workflow
- `case`: PrismSpirit visual direction log
- `checklist`: motion state QA

### 3. 문서 기반 챗봇과 Q&A

Notion sources:

- [멀티 모델 UI](https://app.notion.com/p/31e5bc5f6307801c9400ee81c61443f5)

핵심 질문:

- 지금 쌓아둔 worklog/wiki/Notion 문서를 챗봇이 어떻게 읽게 할까?
- FAQ는 사람이 만든 문답이어야 할까, 아니면 실제 질문 로그에서 생성해야 할까?
- 챗봇이 답할 수 있는 것과 사람에게 넘겨야 하는 것을 어떻게 구분할까?

추천 글:

- 쌓아둔 문서를 챗봇이 읽게 만들려면
- AI workflow wiki를 Q&A로 바꾸는 법
- 문서가 많아질수록 검색보다 질문이 필요해지는 순간

위키 승격 후보:

- `guide`: document-to-chatbot source map
- `playbook`: Q&A freshness and citation check
- `checklist`: chatbot answer boundary

### 4. 제품 단계 진단과 기준 추천 테스트

Notion sources:

- [유저 설문 + 콜인터뷰 관련 PD논의](https://app.notion.com/p/3455bc5f630780399f64c9e8fb07154f)

핵심 질문:

- 현재 제품이 PoC, 베타, 라이브 중 어디에 가까운지 어떻게 판단할까?
- 단계에 따라 디자인 기준, 실험 기준, 데이터 기준은 어떻게 달라져야 할까?
- 간단한 테스트를 통해 "지금 필요한 기준"을 추천할 수 있을까?

추천 글:

- 우리 제품은 지금 어떤 기준으로 디자인해야 할까?
- PoC와 라이브 제품은 같은 UX 기준으로 볼 수 없다
- AI 제품 단계별 디자인 체크리스트 만들기

위키 승격 후보:

- `tool spec`: product stage diagnostic
- `checklist`: PoC / beta / live criteria
- `guide`: criteria selection by product maturity

### 5. 문서 댓글 / 의견 기능

핵심 질문:

- 문서에 남기는 의견은 comment, issue, worklog, wiki 중 어디에 둬야 할까?
- 의견이 많아질 때 무엇을 합의된 기준으로 승격할까?
- AI가 댓글을 읽고 다음 액션으로 정리하려면 어떤 구조가 필요할까?

추천 글:

- 문서에 댓글이 쌓일 때 기준으로 바꾸는 법
- AI와 함께 보는 문서에는 어떤 댓글 구조가 필요할까?
- 의견과 결정 기록을 분리해야 하는 이유

위키 승격 후보:

- `playbook`: comment to decision workflow
- `checklist`: document review triage
- `case`: design doc feedback loop

### 6. 디자인 실험과 A/B 테스트

Notion sources:

- [멀티 모델 UI](https://app.notion.com/p/31e5bc5f6307801c9400ee81c61443f5)
- [유저 설문 + 콜인터뷰 관련 PD논의](https://app.notion.com/p/3455bc5f630780399f64c9e8fb07154f)

핵심 질문:

- as-is/to-be 비교는 어떤 기준으로 해야 설득력이 생길까?
- A/B 테스트가 필요한 문제와 디자이너 판단으로 충분한 문제를 어떻게 나눌까?
- AI가 만든 여러 시안을 어떤 기준으로 먼저 걸러낼까?

추천 글:

- 디자인 as-is/to-be를 비교할 때 보는 기준
- A/B 테스트 전에 디자이너가 먼저 정해야 하는 것
- AI가 만든 시안을 실험 후보로 바꾸는 법

위키 승격 후보:

- `guide`: design experiment criteria
- `template`: experiment record
- `checklist`: A/B readiness check

### 7. UT와 데이터 기반 판단

Notion sources:

- [유저 설문 + 콜인터뷰 관련 PD논의](https://app.notion.com/p/3455bc5f630780399f64c9e8fb07154f)
- [멀티 모델 UI](https://app.notion.com/p/31e5bc5f6307801c9400ee81c61443f5)

핵심 질문:

- UT에서 나온 말과 실제 사용 데이터가 다를 때 무엇을 우선할까?
- AI 제품에서는 속도, 정확도, 이해 가능성, 신뢰를 어떤 지표로 봐야 할까?
- 정성 피드백을 다음 디자인 기준으로 바꾸는 최소 단위는 무엇일까?

추천 글:

- AI 제품의 UT에서는 무엇을 물어봐야 할까?
- 데이터가 있어도 디자이너 판단이 필요한 이유
- 이해 가능성, 선택 가능성, 활용 가능성을 지표로 바꾸기

위키 승격 후보:

- `guide`: AI UX evaluation criteria
- `template`: UT insight to design decision
- `checklist`: data-informed design review

### 8. PoC / 라이브 데이터 연동

핵심 질문:

- PoC에서 얻은 신호를 라이브 제품 판단으로 바로 가져와도 될까?
- 실제 유저 데이터가 들어오면 디자인 시스템이나 챗봇 기준은 무엇을 업데이트해야 할까?
- 민감한 데이터와 학습용 데이터를 어떻게 나눌까?

추천 글:

- PoC에서 라이브 제품으로 넘어갈 때 디자인 기준이 바뀌는 지점
- 유저 데이터를 디자인 시스템에 연결한다는 것
- AI 제품 실험이 실제 사용으로 이어질 때 확인할 것

위키 승격 후보:

- `playbook`: PoC to live signal handoff
- `checklist`: user data integration risk check
- `case`: live data feedback loop

### 9. 코드 <-> 피그마 양방향 연동

Notion sources:

- [쏘냥이 만들기 26년ver](https://app.notion.com/p/35e5bc5f630780f6a1c7e09a6874edc0)
- [웹사이트 디자인-개발 test](https://app.notion.com/p/3195bc5f6307804782f5c7b1154e83c2)

핵심 질문:

- 코드와 피그마가 서로 업데이트될 때 무엇이 source of truth인가?
- 연동 성공/실패 결과를 어디에 남겨야 다음 작업자가 믿을 수 있을까?
- Figma에 이미 있는 디자인과 시스템을 AI가 바로 반영하게 하려면 어떤 evidence가 필요할까?

추천 글:

- 코드와 피그마를 양방향으로 잇는다는 것의 현실
- AI에게 기존 디자인 시스템을 학습시키기 전에 해야 할 일
- Figma에 이미 있는 기준을 AI가 놓치지 않게 하는 법

위키 승격 후보:

- `guide`: code figma bidirectional sync notes
- `checklist`: Figma evidence package
- `case`: sync result comparison

### 10. 이미지 / 텍스트 학습 결과 비교

Notion sources:

- [쏘냥이 만들기 26년ver](https://app.notion.com/p/35e5bc5f630780f6a1c7e09a6874edc0)
- [쏘냥이 세부 캐릭터 디자인 설정](https://app.notion.com/p/35f5bc5f630780aab915ee19a15f18eb)
- [쏘냥이 프롬프트 공통 요소 분석](https://app.notion.com/p/35f5bc5f63078063a2c0dabb0e772af7)
- [쏘냥이 일관성 유지용 프롬프트](https://app.notion.com/p/3605bc5f630780d2a294c6fa4fe1fcd1)

핵심 질문:

- AI가 이미지 기준을 더 잘 따르는 경우와 텍스트 규칙을 더 잘 따르는 경우는 언제일까?
- 시각 기준을 screenshot, Figma node, token, rule 중 어떤 형태로 넘겨야 재현성이 높을까?
- 결과 비교를 감상평이 아니라 기록으로 남기려면 어떤 포맷이 필요할까?

추천 글:

- AI에게 디자인을 가르칠 때 이미지와 텍스트 중 무엇이 더 중요할까?
- 시각 기준을 AI가 놓치지 않게 전달하는 법
- 이미지 기반 학습과 문서 기반 학습의 차이

위키 승격 후보:

- `case`: image vs text instruction comparison
- `template`: generation result comparison
- `checklist`: visual instruction quality

### 11. 모바일로 AI 업무 흐름 제어하기

핵심 질문:

- 디자이너가 자리에서 벗어나도 AI 작업 흐름을 끊지 않으려면 무엇이 필요할까?
- 모바일에서는 승인, 리뷰, 우선순위 변경, 중단 지시 중 어디까지 가능해야 할까?
- Claude Code 모바일과 Git 연동이 가능할 때 어떤 작업 흐름을 만들 수 있을까?

추천 글:

- AI에게 일을 맡긴 뒤 흐름이 끊기지 않게 하는 법
- 모바일로 AI 작업을 승인하고 이어받는 디자인 운영
- 긴 AI 작업에서 사람이 개입해야 하는 순간만 남기기

위키 승격 후보:

- `playbook`: mobile agent control workflow
- `checklist`: long-running AI task control points
- `case`: Claude Code mobile and Git handoff

### 12. AI로 웹사이트 디자인-개발 프로세스 줄이기

Notion sources:

- [웹사이트 디자인-개발 test](https://app.notion.com/p/3195bc5f6307804782f5c7b1154e83c2)
- [소크라 튜터 프로덕트 디자인](https://app.notion.com/p/2345bc5f630780e7adadd523fc4e6141)

핵심 질문:

- AI 디자인-개발 툴은 팀 구성에 따라 어떻게 다르게 선택해야 할까?
- Figma Make, Framer, Cursor는 각각 어느 상황에서 유리하고 어디서 한계가 생길까?
- 속도가 빨라지는 것과 유지보수 가능한 결과물이 나오는 것은 어떻게 구분할까?

추천 글:

- AI로 웹사이트 디자인과 개발을 줄여보니 남은 것
- Figma Make, Framer, Cursor를 디자이너 관점에서 비교하기
- AI 툴을 팀 구성에 맞게 고르는 법

위키 승격 후보:

- `case`: website design development tool test
- `guide`: AI design-development tool selection
- `checklist`: design-to-web output QA

## 우선순위

1. `AI로 브랜딩/캐릭터를 제품 톤에 맞추는 과정`
2. `문서 기반 챗봇과 Q&A`
3. `제품 단계 진단과 기준 추천 테스트`
4. `디자인 실험 / UT / 데이터 기반 판단`
5. `코드 <-> 피그마 양방향 연동 결과 기록`
6. `AI로 웹사이트 디자인-개발 프로세스 줄이기`
7. `모바일로 AI 업무 흐름 제어하기`
