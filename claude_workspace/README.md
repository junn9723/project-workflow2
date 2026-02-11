# claude_workspace - 開発ワークスペース

> 開発プロセスの全中間成果物・ログ・レポート・エビデンスを保存する共有ディレクトリ。
> どのエージェントでも現在の状況を即座に理解し、作業を引き継げるようにする。

## 構成

| ファイル/ディレクトリ | 内容 | 作成フェーズ |
|---------------------|------|------------|
| `development-completion-report.md` | 開発完了レポート | Phase 2 |
| `e2e-test-plan.md` | E2Eテスト計画（毎ループ更新） | Phase 3 |
| `e2e-test-result.md` | E2Eテスト結果（毎ループ更新） | Phase 3 |
| `correction-report.md` | 修正レポート（毎ループ更新） | Phase 4 |
| `downloads/` | エビデンス格納 | Phase 2〜4 |
| `downloads/screenshots/` | Playwright スクリーンショット | Phase 3 |
| `downloads/logs/` | テスト実行ログ | Phase 2〜4 |
| `downloads/loop-N/` | ループN回目のアーカイブ | Phase 3&4 |

## ルール
- 各ループの成果物はループ番号付きディレクトリにアーカイブする
- レポートからエビデンスファイルへの相対パスで参照する
- エラーログがある場合は必ず確認する
