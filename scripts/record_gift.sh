#!/bin/bash
# 记录礼物脚本
# 用法: ./record_gift.sh "礼物内容" "年份" ["花费"] ["备注"] ["对方反馈"] ["纪念日ID"]

set -e

CONTENT="$1"
YEAR="${2:-$(date +"%Y")}"
COST="$3"
NOTE="$4"
FEEDBACK="$5"
ANNIVERSARY_ID="$6"

if [ -z "$CONTENT" ]; then
    echo "用法: ./record_gift.sh \"礼物内容\" [\"年份\"] [\"花费\"] [\"备注\"] [\"对方反馈\"] [\"纪念日ID\"]"
    echo "示例: ./record_gift.sh \"花+蛋糕\" \"2026\" \"200\" \"妈妈生日礼物\" \"很喜欢\" \"recvgMLxxxx\""
    exit 1
fi

BASE_TOKEN="T0ZQb1e25acfizsowUycm1Jan0c"
TABLE_ID="tblHGcHO4PAfmtJz"

export LARK_CLI_NO_PROXY=1

# 构建JSON
JSON_PARTS=()
JSON_PARTS+=("\"礼物内容\":\"$CONTENT\"")
JSON_PARTS+=("\"年份\":$YEAR")
[ -n "$COST" ] && JSON_PARTS+=("\"花费\":$COST")
[ -n "$NOTE" ] && JSON_PARTS+=("\"备注\":\"$NOTE\"")
[ -n "$FEEDBACK" ] && JSON_PARTS+=("\"对方反馈\":\"$FEEDBACK\"")
[ -n "$ANNIVERSARY_ID" ] && JSON_PARTS+=("\"纪念日\":[\"$ANNIVERSARY_ID\"]")

JSON="{"$(IFS=,; echo "${JSON_PARTS[*]}")"}"

# 写入飞书多维表格
lark-cli base +record-upsert \
  --base-token "$BASE_TOKEN" \
  --table-id "$TABLE_ID" \
  --json "$JSON" \
  --as user > /dev/null 2>&1

echo "✅ 礼物已记录: $CONTENT ($YEAR年)"
[ -n "$COST" ] && echo "   花费: $COST元"
[ -n "$NOTE" ] && echo "   备注: $NOTE"
[ -n "$ANNIVERSARY_ID" ] && echo "   关联纪念日ID: $ANNIVERSARY_ID"
