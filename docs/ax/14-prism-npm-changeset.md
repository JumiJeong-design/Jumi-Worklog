# 14. 프리즘 npm 발행과 changeset 게이트

상태: ✅ 완료 · 기간: 2026-08 ~ 09

## 문제 정의 / 도입 배경

디자이너가 패키지를 굴리면서 npm 발행까지 했다. 게이트가 있는데도 빠지는 것이 있었다. changeset 검사가 PR별로 안 보고, 브랜치의 package.json이 배포 상태처럼 보였다.

## 목표

- [x] 발행 절차를 문구로 고정한다
- [x] 게이트가 못 잡는 것을 손으로 잰다
- [x] 발행 확인 방법을 정한다

## 사용한 툴

- GitHub Actions(release) · changesets · npm · `gh`

## 작업 과정

- changeset 게이트는 `.changeset/`에 옆 PR 파일이 있으면 통과한다. 내 PR이 냈는지는 `git diff --name-only origin/main...HEAD -- packages/prism/src`와 `-- .changeset`을 둘 다 찍어서 본다. 9/8에 pre-commit으로도 막았다.
- `gh pr merge --delete-branch`는 옆 워크트리가 main을 점유하면 머지하고도 에러로 끝난다. 다시 머지하지 말고 state부터 잰다.
- 머지 뒤 origin/main에서 내 변경 문자열을 grep한다. 남의 낡은 base PR이 되돌린다.
- npm 발행은 Version PR 머지로만. 브랜치 package.json은 배포 상태가 아니다.
- 발행 확인은 로그인 상태에서 `npm view @riiid/prism version`. restricted라 무인증 404는 정상.
- 제품 레포가 `"@riiid/prism": "0.43.0"`을 물고 src 55개 파일이 import한다.

## 트러블슈팅

**문제**: 누가 머지했는지 `merged_by`로 못 가린다
- 원인: 세션 둘과 주미님이 같은 토큰.
- 해결: 시각과 내용으로 본다.

## 결과

- 발행 절차가 문구 4로 고정됐다. 게이트 셋(changeset 손 검사 · delete-branch 금지 · 머지 뒤 grep).

## AI가 잘한 것 / 디자이너가 보정한 것

- AI: 게이트가 못 잡는 케이스를 재현하고 절차로 만든 것.
- 디자이너: 「확정」은 내가 명시한 것만이라고 선을 그은 것.

## 아쉬운 점 · 리스크

- 디자이너가 발행 권한을 가진 구조는 FE와의 경계가 흐려질 수 있다. 계약과 체인지셋으로 경계를 지킨다.

## 공유할 만한 사항

```
머지 전에 git diff --name-only origin/main...HEAD -- packages/prism/src와 -- .changeset을 둘 다 찍어서 내 PR이 changeset을 냈는지 보고해줘.
```

## 한 줄 평

게이트가 통과했다는 건 게이트가 본 것만 통과했다는 뜻이다.
