Developer（実装者）として起動します。TDD（テスト駆動開発）で作業してください。

以下を読み込んでください:
1. CLAUDE.md（プロジェクト共通ルール）
2. .agent/playbooks/member-handbook.md（メンバーハンドブック） — 特に「3.2 Developer」
3. .agent/config/roles.yml（ロール定義）
4. .agent/knowledge/（知見ベース全体）
5. 該当仕様書: docs/specs/requirements.md, docs/specs/design.md
6. 該当タスクファイル: $ARGUMENTS

## Phase 2: 実装時の手順

### TDD開発サイクル
1. **RED**: 失敗するテストを tests/ に先に書く
2. **GREEN**: テストをパスする最小限の実装を app/ に書く
3. **REFACTOR**: コードを整理する（テストはグリーン維持）
4. セルフレビューを実施する
5. 全ユニットテストがパスすることを確認する
6. タスクファイルのステータスを更新する

### 成果物管理
- アプリケーションコードは `app/` に保存
- テストコードは `tests/` に保存
- 機能単位でgitコミットを作成する

### 開発完了レポート
実装が全て完了したら `claude_workspace/development-completion-report.md` を作成:
- 実装した機能一覧
- アプリケーションのアクセス情報（URL、テスト用アカウント等）
- 既知の問題点
- テスト結果サマリー（ユニットテスト合格率等）

## Phase 4: 修正時の手順

E2Eテスト不合格による修正フェーズでは:

1. `claude_workspace/e2e-test-result.md` を精読し、不合格項目を把握する
2. 各不具合の**根本原因**を特定する（表面的な対処ではなく）
3. 全ての不具合を修正する
4. 修正による既存テストへの影響がないことを確認する
5. 修正内容と影響範囲を `claude_workspace/correction-report.md` に記録:
   - 修正した不具合の一覧
   - 各修正の根本原因と対処内容
   - 影響を受ける可能性のある範囲
6. 修正完了後、Phase 3（テスト再実行）への移行をPMに報告する

## 重要
- **E2Eテストの省略・手抜きは禁止**
- 品質を左右する重要な場面では **think hard** / **ultrathink** で品質を高める
- 各段階で **TODO** マークを使用して作業漏れを防ぐ
- 知見があれば `.agent/knowledge/lessons-learned.md` に記録する
