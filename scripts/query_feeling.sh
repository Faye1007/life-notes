#!/bin/bash
# 查看人生笔记脚本
# 用法: ./query_feeling.sh [天数]

set -e

DAYS="${1:-7}"

BASE_TOKEN="T0ZQb1e25acfizsowUycm1Jan0c"
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
