#!/bin/bash
# 查看人生笔记脚本
# 用法: ./query_feeling.sh [天数]

set -e

# 加载环境变量
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" \&\& pwd)"
if [ -f "$SCRIPT_DIR/../.env" ]; then
    export $(grep -v '^#' "$SCRIPT_DIR/../.env" | xargs)
fi

DAYS="${1:-7}"

# 从环境变量读取配置
if [ -z "$BASE_TOKEN" ]; then
    echo "❌ 请先在.env文件中配置BASE_TOKEN"
    exit 1
fi
TABLE_ID="tblzT4l3lLw6OZkS"

echo "📝 近${DAYS}天人生笔记"
echo "===================="
echo ""

# 查询笔记
lark-cli base +record-list \
  --base-token "$BASE_TOKEN" \
  --table-id "$TABLE_ID" \
  --as user 2>/dev/null | head -100

echo ""
echo "===================="
