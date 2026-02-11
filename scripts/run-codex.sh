#!/bin/bash
# Codex CLI タスク実行スクリプト
# タスクファイルを指定して Codex CLI にタスクを実行させる
#
# Usage:
#   ./scripts/run-codex.sh <タスクファイルパス> [ロール]
#
# Example:
#   ./scripts/run-codex.sh .agent/tasks/TASK-001-backend-api.md Developer
#   ./scripts/run-codex.sh .agent/tasks/TASK-002-review.md Reviewer

set -euo pipefail

TASK_FILE="${1:?Usage: $0 <task-file-path> [role]}"
ROLE="${2:-Developer}"

if [ ! -f "$TASK_FILE" ]; then
  echo "Error: Task file not found: $TASK_FILE"
  exit 1
fi

# プロジェクトルートを取得
PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# コンテキストファイルの存在確認と読み込みパス構築
CONTEXT_FILES=(
  "CLAUDE.md"
  ".agent/config/roles.yml"
  ".agent/knowledge/lessons-learned.md"
  ".agent/knowledge/conventions.md"
)

# 仕様書の自動検出
SPEC_FILES=""
if [ -f "$PROJECT_ROOT/docs/specs/requirements.md" ]; then
  SPEC_FILES="$SPEC_FILES
   - docs/specs/requirements.md（要求仕様書）"
fi
if [ -f "$PROJECT_ROOT/docs/specs/design.md" ]; then
  SPEC_FILES="$SPEC_FILES
   - docs/specs/design.md（技術設計書）"
fi

# タスクファイルから概要を抽出
TASK_SUMMARY=$(grep -A2 "^## 概要" "$TASK_FILE" | tail -1 || echo "タスクファイルを参照してください")

echo "=== Codex CLI タスク実行 ==="
echo "タスクファイル: $TASK_FILE"
echo "ロール: $ROLE"
echo "概要: $TASK_SUMMARY"
echo "============================"

# Codex CLI 実行
cd "$PROJECT_ROOT"
codex --approval-mode full-auto \
  "あなたは ${ROLE} ロールとしてタスクを実行します。

【プロジェクトルール】
まず以下のファイルを順番に読み込んで、プロジェクトのルールと現在の状態を理解してください:
1. CLAUDE.md（プロジェクト全体のルール・ワークフロー定義）
2. .agent/config/roles.yml（ロール定義）
3. .agent/knowledge/lessons-learned.md（過去の失敗と学び ※必ず確認）
4. .agent/knowledge/conventions.md（コーディング規約）${SPEC_FILES}

【タスク】
以下のタスクファイルを読み込み、記載されたタスクを実行してください:
- ${TASK_FILE}

【重要ルール】
- タスクファイルの「詳細要件」と「受け入れ条件」を全て満たすこと
- 成果物は「成果物」セクションに記載されたパスに保存すること
- TDD: テストを先に書き、テストをパスさせる形で実装すること
- 作業完了後、タスクファイルのステータスを更新すること（ステータス履歴にコメント追記）
- 新しい知見があれば .agent/knowledge/lessons-learned.md に追記すること
- セルフレビューを実施し、品質を確認すること"
