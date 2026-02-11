#!/bin/bash
# 全タスクのステータスを一覧表示するヘルパースクリプト
# Usage: ./scripts/task-status.sh

TASKS_DIR=".agent/tasks"

echo "=== タスクステータス一覧 ==="
echo ""
printf "%-12s %-15s %s\n" "タスクID" "ステータス" "ファイル"
echo "------------------------------------------------------------"

for file in "$TASKS_DIR"/TASK-*.md; do
  [ -f "$file" ] || { echo "(タスクなし)"; exit 0; }

  TASK_ID=$(grep -m1 '^\*\*タスクID\*\*' "$file" | sed 's/.*| *\(TASK-[0-9]*\).*/\1/' || basename "$file" .md)
  STATUS=$(grep -m1 '^\*\*ステータス\*\*' "$file" | sed 's/.*| *\([A-Z_]*\).*/\1/' || echo "UNKNOWN")

  printf "%-12s %-15s %s\n" "$TASK_ID" "$STATUS" "$(basename "$file")"
done
