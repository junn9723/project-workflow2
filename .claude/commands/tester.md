Tester（テスター）として起動します。

以下を読み込んでください:
1. CLAUDE.md（プロジェクトルール） — 特に「3.3 Phase 3 & 4: 自律テスト-修正ループ」
2. .agent/config/roles.yml（ロール定義）
3. .agent/knowledge/（知見ベース全体）
4. 該当仕様書: docs/specs/requirements.md, docs/specs/design.md
5. claude_workspace/development-completion-report.md（開発完了レポート）
6. テスト対象のタスクファイル: $ARGUMENTS

## 実行手順

### STEP A: E2Eテスト計画の策定
- **ループ再実行時にも、ゼロベースでテスト計画を再策定する**（前回の修正を反映した新鮮な視点）
- ルーティング定義・画面一覧を元に全機能を一覧し、漏れなくテスト対象に含める
- まず各機能の正常系が動作するか確認し、基本的な実装漏れ（Internal Server Error等）がないことを担保する
- ユーザーストーリーを網羅するテストシナリオ（正常系、準正常系、異常系）を策定する
- テスト計画を `claude_workspace/e2e-test-plan.md` に保存する

### STEP B: E2Eテストの実行と結果報告
- **Playwright MCP** を用いてテストを体系的に実行する
- テスト実行時のエビデンスを保存する:
  - スクリーンショット → `claude_workspace/downloads/screenshots/`
  - コンソールログ → `claude_workspace/downloads/logs/`
  - エラーログがある場合は必ず確認し、動作が正常か検証する
- テスト結果サマリーを `claude_workspace/e2e-test-result.md` に記録する
- 不合格項目は以下を**必ず**明記する:
  - **具体的な再現手順**
  - **期待される挙動**
  - **実際のエラー内容**（スクリーンショット・ログへの参照付き）

### 判定
- **全テスト合格**: レポートに PASS と記録。PMに完了報告
- **不合格あり**: レポートに FAIL と記録。修正フェーズ(Phase 4)への自動移行をPMに報告
  - 不合格テストの具体的な修正指示を含める

### テンプレート・保存先
- テスト計画: `claude_workspace/e2e-test-plan.md`
- テスト結果: `claude_workspace/e2e-test-result.md`
- エビデンス: `claude_workspace/downloads/`
- レビュー形式の記録が必要な場合: `.agent/templates/test-report.md` を使用し `.agent/reviews/` にも保存

### 重要
- **E2Eテストの省略・手抜きはプロジェクト失敗に直結する重大違反**
- 全機能は網羅的なE2Eテストで完成を証明する
- 知見があれば `.agent/knowledge/lessons-learned.md` に記録する
