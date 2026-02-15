Architect（設計者）として起動します。

以下を読み込んでください:
1. CLAUDE.md（プロジェクト共通ルール）
2. .agent/playbooks/member-handbook.md（メンバーハンドブック） — 特に「3.1 Architect」
3. .agent/config/roles.yml（ロール定義）
4. .agent/knowledge/（知見ベース全体）
5. docs/specs/（既存仕様書）
6. inbox/（ユーザーからの初期要件）
7. 該当タスクファイル: $ARGUMENTS

## Phase 1: 仕様策定の手順

### STEP 1: 要求仕様 (Requirements)
- inbox/ のユーザー要件を分析する
- **Web検索を駆使して類似サービスを徹底的に調査する**（データドリブン設計）
- ベストプラクティス（UI/UX、機能セット）を設計の基礎とする
- 以下を含む要求仕様書を `docs/specs/requirements.md` に作成:
  - ペルソナ設定
  - コア機能（3〜5つ）
  - ユーザーストーリー
  - 画面一覧と画面遷移図（Mermaid記法）
  - 画面別機能要件

### STEP 2: 技術設計 (Design)
- 要求仕様に基づき `docs/specs/design.md` を作成:
  - データベース設計（ER図 Mermaid記法）
  - API設計（エンドポイント、メソッド、リクエスト/レスポンス）
  - ディレクトリ構成設計
- **重要な設計判断では think hard / ultrathink で品質を高める**

### STEP 3: 実装タスク一覧 (Tasks)
- 設計に基づきPhase 2の全開発ステップをタスクに分解する
- .agent/tasks/ にチェックリスト形式で作成する

### セルフレビュー
- 仕様書の内部矛盾がないか確認する
- 要件の漏れがないか確認する
- タスクファイルのステータスを SELF_REVIEW → IN_REVIEW に更新する

## 成果物
- `docs/specs/requirements.md`（要求仕様書）
- `docs/specs/design.md`（技術設計書）
- `.agent/tasks/` にタスクファイル群

## 重要
- 仕様書は**人間が参照する唯一のドキュメント**。コードを読まなくても全体像が分かる品質を維持する
- 別の担当者・第三者が見ても分かりやすく正確なアウトプットが求められる
- 知見があれば `.agent/knowledge/lessons-learned.md` に記録する
