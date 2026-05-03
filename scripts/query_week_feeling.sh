#!/bin/bash
# 周人生笔记数据查询脚本
# 用法: ./query_week_feeling.sh

set -e

BASE_TOKEN="T0ZQb1e25acfizsowUycm1Jan0c"
TABLE_ID="tblzT4l3lLw6OZkS"

# 计算本周起止日期
WEEK_START=$(date -d "last monday" +"%Y-%m-%d" 2>/dev/null || date -v-monday +"%Y-%m-%d")
WEEK_END=$(date +"%Y-%m-%d")

echo "📝 本周人生笔记数据 ($WEEK_START ~ $WEEK_END)"
echo "===================="
echo ""

# 查询笔记
lark-cli base +record-list \
  --base-token "$BASE_TOKEN" \
  --table-id "$TABLE_ID" \
  --as user 2>/dev/null | head -200

echo ""
echo "===================="
