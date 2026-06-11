# 07. Data Contract & State Model

## 1. 문서 목적

Socra AI의 Storybook 컴포넌트가 실제 프론트 화면과 API 데이터에 문제 없이 연결되려면, Agent / Answer / Source / Chart / State 데이터 구조가 먼저 정리되어야 한다.

---

## 2. Agent Data

```ts
type Agent = {
  id: string;
  name: string;
  role: string;
  description?: string;
  baseModel: 'gpt' | 'claude' | 'gemini' | 'grok' | 'perplexity' | string;
  avatarUrl?: string;
  tone?: 'calm' | 'direct' | 'empathetic' | 'analytical' | 'creative';
  capabilities?: AgentCapability[];
  status?: 'idle' | 'loading' | 'complete' | 'failed';
};
```

## 3. Answer Data

```ts
type AgentAnswer = {
  id: string;
  agentId: string;
  status: 'loading' | 'streaming' | 'complete' | 'failed' | 'empty';
  markdown?: string;
  summary?: string;
  stance?: 'recommend' | 'hold' | 'oppose' | 'conditional' | 'neutral';
  confidence?: 'high' | 'medium' | 'low';
  reasonPreview?: string;
  sources?: Source[];
  chartBlocks?: ChartBlock[];
  errorMessage?: string;
  createdAt?: string;
};
```

## 4. Source Data

```ts
type Source = {
  id: string;
  title: string;
  url?: string;
  type: 'web' | 'file' | 'history' | 'model' | 'manual';
  domain?: string;
  publishedAt?: string;
  summary?: string;
  reliability?: 'official' | 'report' | 'news' | 'blog' | 'inference' | 'unknown';
  freshness?: 'recent' | 'old' | 'unknown';
};
```

## 5. Chart Data

```ts
type ChartBlock = {
  id: string;
  type: 'metric' | 'score' | 'bar' | 'line' | 'composition';
  title?: string;
  description?: string;
  data: Array<Record<string, string | number>>;
  series?: Array<{
    key: string;
    label: string;
    tone?: 'neutral' | 'positive' | 'negative' | 'warning';
  }>;
  source?: Source;
  note?: string;
  status?: 'default' | 'loading' | 'empty' | 'error';
};
```

## 6. Multi-agent State

| 상태 | 설명 | UI |
|---|---|---|
| allLoading | 모든 모델 응답 대기 | 전체 loading |
| partialLoading | 일부 모델만 응답 완료 | 완료 카드 + loading 카드 |
| partialFailed | 일부 모델 실패 | failed card + retry |
| allComplete | 모든 모델 완료 | 비교 완료 |
| allFailed | 전체 실패 | error state |
| noConsensus | 결론 불일치 | DisagreementBlock |
| consensus | 결론 일치 | ConsensusBlock |

## 7. FE와 확인할 핵심 질문

1. 실제 API 응답에 agent 개념이 있는가?
2. model과 agent를 분리할 수 있는가?
3. 여러 모델 응답은 동시에 오는가, 순차적으로 오는가?
4. streaming을 지원하는가?
5. source는 각 모델별로 분리되는가?
6. chart data는 실제로 내려오는가, 프론트가 만들어야 하는가?
7. Socra summary는 별도 응답인가, 후처리인가?
8. 실패/재시도 상태를 모델별로 관리할 수 있는가?
