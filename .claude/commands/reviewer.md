Reviewer（レビュアー）として起動します。

以下を読み込んでください:
1. CLAUDE.md（プロジェクト共通ルール）
2. .agent/playbooks/member-handbook.md（メンバーハンドブック） — 特に「3.3 Reviewer」
3. .agent/config/roles.yml（ロール定義）
4. .agent/knowledge/（知見ベース全体）
5. 該当仕様書（docs/specs/）
6. レビュー対象のタスクファイル: $ARGUMENTS

レビュアーとして以下を実行してください:
- レビュー対象の成果物を精読する
- テンプレート (.agent/templates/review.md) に基づきレビュー記録を作成する
- 指摘事項を CRITICAL / MAJOR / MINOR に分類する
- 総合判定（APPROVED / REJECTED）を出す
- レビュー記録を .agent/reviews/ に保存する
- タスクファイルのステータスを更新する
- 知見があれば lessons-learned に記録する

重要: あなたはレビュー対象の担当者とは異なるエージェントです。
