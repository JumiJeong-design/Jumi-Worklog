---
name: bump-version
description: "socra-ai-workflow-wiki 버전을 올린다. 콘텐츠 4파일 + 캐시 토큰 16파일을 함께 갱신해야 라이브에 반영된다. '버전 올려줘', 'v0.X 배포해줘', '/bump-version' 시 실행."
disable-model-invocation: false
---

# bump-version

`socra-ai-workflow-wiki`(로컬: `~/Desktop/AI_product design_guide`) 버전 bump.

**핵심 함정:** 콘텐츠 4파일만 고치면 라이브에 안 보인다. 사이드바는 `ai-workflow-guide.js`가 `fetch('sidebar.html?v=<토큰>')`로 불러오고, 그 js도 전 페이지에서 `?v=<토큰>`로 로드된다. 토큰을 안 올리면 캐시된 방문자는 옛 사이드바를 계속 본다.

---

## 대상

**콘텐츠 (4파일)**

| 파일 | 수정 내용 |
|------|-----------|
| `site/sidebar.html` | 버전 텍스트 `v0.X` |
| `site/ai-workflow-guide.html` | 상단 버전 배지 + 인라인 changelog 항목 |
| `site/changelog.html` | 신규 버전 섹션 (최신순 — 맨 위 삽입) |
| `site/index.html` | 신규 기능 카드 (사용자에게 보이는 변경일 때만) |

**캐시 토큰 (16파일)** — Step 4에서 일괄 처리

- `ai-workflow-guide.js?v=<토큰>` — `site/*.html` 전체 + `scripts/build-guide.py`, `scripts/build-wiki.py`
- `sidebar.html?v=<토큰>` — `site/ai-workflow-guide.js` 안
- `ai-workflow-guide.css?v=<토큰>` — **CSS를 실제로 고쳤을 때만** 올린다 (js 토큰과 별개 카운터)

> ⚠️ `?v=`를 무조건 치환하지 말 것. `site/guide-*.html`의 Notion URL에도 `?v=3425…`가 있다. 반드시 `ai-workflow-guide.js?v=` / `sidebar.html?v=` / `ai-workflow-guide.css?v=` 처럼 **자산명을 포함**해 치환한다.

---

## Step 1 — 정보 수집  [Confirm]

1. 사용자에게 확인: 새 버전 번호(`v0.X`), 이번 변경 내용
2. 날짜는 `currentDate` 컨텍스트에서 `YYYY.MM`으로 추출 (직접 입력 금지 — 연도 오타 주의)
3. 현재 상태 측정:
   ```bash
   grep -rn 'ai-workflow-guide\.js?v=' site/ scripts/ | head -1   # 현재 토큰
   grep -o 'v0\.[0-9]*' site/sidebar.html | head -1               # 현재 버전
   ```
4. 새 토큰을 정한다: `<새버전>-<한단어 슬러그>` (예: `0.21-storybook-qa`)

**Self-check:** 날짜가 올해인가? 변경 내용이 1줄 이상인가?

---

## Step 2 — 콘텐츠 4파일 수정  [Write]

각 파일의 before/after를 채팅에 출력하고 진행한다.

- `sidebar.html` — `v0.X` 문자열 교체
- `ai-workflow-guide.html` — 배지 교체 + changelog 인라인 항목 추가
- `changelog.html` — 기존 최신 섹션 **위에** 새 섹션 삽입 (`## v0.X — YYYY.MM` + 불릿)
- `index.html` — 신규 기능 카드 (단순 수정/버그픽스면 생략)

---

## Step 3 — 캐시 토큰 일괄 갱신  [Write]

```bash
OLD="0.20-build-pilot"; NEW="0.21-<슬러그>"
grep -rl "guide\.js?v=$OLD\|sidebar\.html?v=$OLD" site/ scripts/ \
  | xargs sed -i '' "s/guide\.js?v=$OLD/guide.js?v=$NEW/g; s/sidebar\.html?v=$OLD/sidebar.html?v=$NEW/g"
```

CSS를 고쳤다면 CSS 토큰도 같은 방식으로 별도 갱신한다.

**검증 (필수):**
```bash
grep -rn "$OLD" site/ scripts/          # 0건이어야 함
grep -rc "guide\.js?v=$NEW" site/*.html scripts/*.py | grep -v ':0'   # 16파일 확인
```

---

## Step 4 — 빌드 · 배포 · 측정  [Verify]

1. 빌드 스크립트 재실행: `python3 scripts/build-guide.py && python3 scripts/build-wiki.py`
2. 로컬 확인 후 **한 번에** 커밋·푸시 — `feat: v0.X 배포 — <한 줄 요약>`
3. 배포 확인은 `gh run list`에서 "Deploy Wiki Site" success 여부로 본다.
   GitHub Pages API의 `status`는 옛 "errored"를 계속 보여주니 **무시한다**.
4. 라이브를 cache-bust로 측정:
   ```bash
   curl -s "https://jumijeong-design.github.io/socra-ai-workflow-wiki/sidebar.html?cb=$RANDOM" | grep -o 'v0\.[0-9]*'
   ```
   새 버전이 나와야 완료. **측정 전에 "됐다"고 보고하지 않는다.**

---

## 운영 규칙

- 작은 변경마다 커밋·배포 반복 금지 — 모아서 로컬 검증 후 1회 배포
- 콘텐츠 4파일 중 하나라도 실패하면 중단하고 에러 보고
- changelog는 최신순 (새 항목이 맨 위)
- CSS 토큰은 js 토큰과 별개 — 동반 상승시키지 않는다
