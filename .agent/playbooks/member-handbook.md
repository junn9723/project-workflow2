# メンバーハンドブック — 実行メンバー共通ガイド

> **本ドキュメントは実行メンバー（Architect / Developer / Reviewer / Tester）専用。**
> 共通ルールは `CLAUDE.md` を参照。

---

## 1. メンバー行動規範

1. `.agent/tasks/` から自分のタスクを確認する
2. `.agent/knowledge/` で関連知見を確認する
3. `docs/specs/` で仕様を確認する
4. TDDでテスト→実装の順で作業する
5. セルフレビューを実施する
6. タスクファイルのステータスを更新する
7. **成果物は必ず指定のディレクトリ/ワークスペースに保存する**

---

## 2. タスクライフサイクル

### 2.1 ステータス遷移
```
[PM] タスク作成 → アサイン
  ↓
[担当者] 実行 → セルフレビュー → セルフテスト
  ↓
[レビュアー] 設計レビュー (設計タスクの場合)
  ↓ 合格
[担当者] 実装
  ↓
[担当者] セルフレビュー → ユニットテスト
  ↓
[テスター] テスト実行
  ↓ 合格 → 完了
  ↓ 不合格 → 担当者に差し戻し (3回不合格 → PM差し戻し → 再アサイン)
```

### 2.2 タスクファイル連携
- タスクは `.agent/tasks/` にMarkdownファイルとして管理
- テンプレート: `.agent/templates/task.md`
- ステータス: `CREATED` → `IN_PROGRESS` → `SELF_REVIEW` → `IN_REVIEW` → `TESTING` → `DONE` / `REJECTED`
- 差し戻し回数はタスクファイル内で追跡

---

## 3. ロール別作業手順

### 3.1 Architect（設計者）

**Phase 1: 仕様策定**

#### STEP 1: 要求仕様 (Requirements)
- inbox/ のユーザー要件を分析し、必要に応じてWeb検索で類似サービスを調査する
- ベストプラクティス（UI/UX、機能セット）を設計の基礎とする
- 以下を含む要求仕様書を `docs/specs/requirements.md` に作成:
  - ペルソナ設定
  - コア機能（3〜5つ）
  - ユーザーストーリー
  - 画面一覧と画面遷移図（Mermaid記法）
  - 画面別機能要件

#### STEP 2: 技術設計 (Design)
- 要求仕様に基づき `docs/specs/design.md` を作成:
  - データベース設計（ER図 Mermaid記法）
  - API設計（エンドポイント、メソッド、リクエスト/レスポンス）
  - ディレクトリ構成設計
- **重要な設計判断では think hard / ultrathink で品質を高める**

#### STEP 3: 実装タスク一覧 (Tasks)
- 設計に基づきPhase 2で実行する全開発ステップを `.agent/tasks/` にチェックリスト形式で作成

**成果物:** `docs/specs/requirements.md`, `docs/specs/design.md`, `.agent/tasks/` タスクファイル群

---

### 3.2 Developer（実装者）

#### Phase 2: 実装

##### TDD開発サイクル
1. **RED**: 失敗するテストを `tests/` に先に書く
2. **GREEN**: テストをパスする最小限の実装を `app/` に書く
3. **REFACTOR**: コードを整理する（テストはグリーン維持）
4. セルフレビューを実施する
5. 全ユニットテストがパスすることを確認する
6. タスクファイルのステータスを更新する

##### 実装ステップ（技術スタック非依存）
- データモデル/スキーマの実装
- API/バックエンドロジックの実装
- ユニットテスト/フィーチャーテストの作成と全パス確認
- フロントエンド/UIの実装
- E2E初期検証（開発者自身による基本動作確認）
- セルフレビューと修正

##### 開発完了レポート
実装が全て完了したら `claude_workspace/development-completion-report.md` を作成:
- 実装した機能一覧
- アプリケーションのアクセス情報（URL、テスト用アカウント等）
- 既知の問題点
- テスト結果サマリー（ユニットテスト合格率等）

**Phase 2 成果物:** `app/` アプリコード, `tests/unit/` ユニットテスト, `claude_workspace/development-completion-report.md`

#### Phase 4: 修正

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

---

### 3.3 Reviewer（レビュアー）

- レビュー対象の成果物を精読する
- テンプレート (`.agent/templates/review.md`) に基づきレビュー記録を作成する
- 指摘事項を CRITICAL / MAJOR / MINOR に分類する
- 総合判定（APPROVED / REJECTED）を出す
- レビュー記録を `.agent/reviews/` に保存する
- タスクファイルのステータスを更新する

**重要**: 設計レビューは **担当者以外** が実施すること

---

### 3.4 Tester（テスター）

#### STEP A: E2Eテスト計画の策定
- **[Input]** `development-completion-report.md`, `docs/specs/requirements.md`, `docs/specs/design.md`
- **[Output]** `claude_workspace/e2e-test-plan.md`
- **ループ再実行時にも、ゼロベースでテスト計画を再策定する**（前回の修正を反映した新鮮な視点）
- ルーティング定義を元に全機能を一覧し、漏れなくテスト対象に含める
- まず各機能の正常系が動作するか検証し、Internal Server Error等の基本的な実装漏れがないことを担保する
- ユーザーストーリーを網羅する詳細なテストシナリオ（正常系、準正常系、異常系）を策定する

#### STEP B: E2Eテストの実行と結果報告
- **[Input]** `e2e-test-plan.md`
- **[Output]** `claude_workspace/e2e-test-result.md`
- Playwright MCPを用いてテストを体系的に実行する
- テスト結果のサマリーを `claude_workspace/e2e-test-result.md` に記録する
- エビデンス（スクリーンショット、コンソールログ、動画等）を `claude_workspace/downloads/` に保存し、レポートから参照できるようにする
- 不合格項目は**具体的な再現手順、期待される挙動、実際のエラー内容**を明記する

#### 判定
- **全テスト成功** → ループ終了、Phase 5 へ移行。PMに完了報告
- **不合格あり** → Phase 4（修正フェーズ）へ自動移行。PMに報告

#### テスト記録
- テスト結果: `.agent/reviews/` にテストレポートとして保存
- テンプレート: `.agent/templates/test-report.md`
- テスト不合格時は具体的な失敗理由と再現手順を記録

---

## 4. チーム重要ルール（メンバー向け）

- **設計は担当者以外のレビュアーが必ずレビューしてからFIX**
- **実装は必ずテスターによるテストを経て完了**
- **不合格3回で PM に差し戻し → 別担当者をアサイン**
- **タスクファイルは自己完結的に記述し、どのメンバーでも単独で作業開始できるようにする**
- **E2Eテストの省略・手抜きはプロジェクト失敗に直結する重大違反**
- 品質を左右する重要な場面では **think hard** / **ultrathink** で品質を高める
- 各段階で **TODO** マークを使用して作業漏れを防ぐ
- 知見があれば `.agent/knowledge/lessons-learned.md` に記録する
