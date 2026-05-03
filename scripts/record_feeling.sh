#!/bin/bash
# 记录人生笔记脚本
# 用法: ./record_feeling.sh "具体事件" "思考感悟" "情绪" "类型" "下次怎么做"
# 示例: ./record_feeling.sh "今天和同事吵架了" "觉得自己太冲动了" "后悔" "人际" "下次先冷静10分钟再说话"

set -e

EVENT="$1"
THOUGHT="$2"
MOOD="$3"
TYPE="$4"
NEXT_ACTION="$5"

if [ -z "$EVENT" ] && [ -z "$THOUGHT" ]; then
    echo "用法: ./record_feeling.sh \"具体事件\" \"思考感悟\" [\"情绪\"] [\"类型\"] [\"下次怎么做\"]"
    echo "情绪: 开心、焦虑、平静、疲惫、困惑、感恩、释然、委屈、愤怒、期待..."
    echo "类型: 日常、工作、人际、学习、经验、教训、灵感、情绪..."
    exit 1
fi

BASE_TOKEN="T0ZQb1e25acfizsowUycm1Jan0c"
TABLE_ID="tblzT4l3lLw6OZkS"
NOW=$(date +"%Y-%m-%d %H:%M:%S")

export LARK_CLI_NO_PROXY=1

# 构建JSON
JSON_PARTS=()
JSON_PARTS+=("\"日期\":\"$NOW\"")
[ -n "$EVENT" ] && JSON_PARTS+=("\"具体事件\":\"$EVENT\"")
[ -n "$THOUGHT" ] && JSON_PARTS+=("\"内容\":\"$THOUGHT\"")
[ -n "$MOOD" ] && JSON_PARTS+=("\"情绪\":\"$MOOD\"")
[ -n "$TYPE" ] && JSON_PARTS+=("\"类型\":\"$TYPE\"")
[ -n "$NEXT_ACTION" ] && JSON_PARTS+=("\"下次怎么做\":\"$NEXT_ACTION\"")

JSON="{"$(IFS=,; echo "${JSON_PARTS[*]}")"}"

# 写入飞书多维表格
lark-cli base +record-upsert \
  --base-token "$BASE_TOKEN" \
  --table-id "$TABLE_ID" \
  --json "$JSON" \
  --as user > /dev/null 2>&1

echo "✅ 人生笔记已记录"
[ -n "$EVENT" ] && echo "   事件: $EVENT"
[ -n "$MOOD" ] && echo "   情绪: $MOOD"
[ -n "$TYPE" ] && echo "   类型: $TYPE"
[ -n "$NEXT_ACTION" ] && echo "   下次: $NEXT_ACTION"
