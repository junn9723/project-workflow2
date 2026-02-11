#!/bin/bash
# 新しいタスクファイルを作成するヘルパースクリプト
# Usage: ./scripts/new-task.sh TASK-001 "タスクの説明"

TASK_ID="${1:?Usage: $0 TASK-ID description}"
DESCRIPTION="${2:?Usage: $0 TASK-ID description}"
SLUG=$(echo "$DESCRIPTION" | tr ' ' '-' | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9-]//g')
DATE=$(date +%Y-%m-%d)

FILENAME=".agent/tasks/${TASK_ID}-${SLUG}.md"
TEMPLATE=".agent/templates/task.md"

if [ ! -f "$TEMPLATE" ]; then
  echo "Error: Template not found at $TEMPLATE"
  exit 1
fi

if [ -f "$FILENAME" ]; then
  echo "Error: Task file already exists: $FILENAME"
  exit 1
fi

cp "$TEMPLATE" "$FILENAME"
sed -i "s/TASK-XXX/$TASK_ID/g" "$FILENAME"
sed -i "s/タスクタイトル/$DESCRIPTION/g" "$FILENAME"
sed -i "s/YYYY-MM-DD/$DATE/g" "$FILENAME"

echo "Created: $FILENAME"
