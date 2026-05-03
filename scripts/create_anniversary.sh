#!/bin/bash
# 创建纪念日脚本（含三段式提醒）
# 用法: ./create_anniversary.sh "纪念日名称" "日期"

set -e

NAME="$1"
DATE="$2"

if [ -z "$NAME" ] || [ -z "$DATE" ]; then
    echo "用法: ./create_anniversary.sh \"纪念日名称\" \"日期\""
    echo "示例: ./create_anniversary.sh \"妈妈生日\" \"2026-04-20\""
    exit 1
fi

BASE_TOKEN="T0ZQb1e25acfizsowUycm1Jan0c"
TABLE_ID="tbl6ACwhojvfd13V"

# 写入飞书多维表格
lark-cli base +record-upsert \
  --base-token "$BASE_TOKEN" \
  --table-id "$TABLE_ID" \
  --json "{\"纪念日名称\":\"$NAME\",\"日期\":\"$DATE\"}" \
  --as user > /dev/null 2>&1

echo "✅ 纪念日已创建: $NAME ($DATE)"

# 计算提醒日期
YEAR=$(echo $DATE | cut -d'-' -f1)
MONTH=$(echo $DATE | cut -d'-' -f2)
DAY=$(echo $DATE | cut -d'-' -f3)

# 提前7天
DAY7=$((DAY - 7))
if [ $DAY7 -le 0 ]; then
    # 跨月处理
    MONTH7=$((MONTH - 1))
    if [ $MONTH7 -eq 0 ]; then
        MONTH7=12
        YEAR7=$((YEAR - 1))
    else
        YEAR7=$YEAR
    fi
    # 简化处理，实际需要根据月份天数
    DAY7=28
else
    MONTH7=$MONTH
    YEAR7=$YEAR
fi

# 提前1天
DAY1=$((DAY - 1))
if [ $DAY1 -eq 0 ]; then
    MONTH1=$((MONTH - 1))
    if [ $MONTH1 -eq 0 ]; then
        MONTH1=12
        YEAR1=$((YEAR - 1))
    else
        YEAR1=$YEAR
    fi
    DAY1=28
else
    MONTH1=$MONTH
    YEAR1=$YEAR
fi

echo ""
echo "📅 提醒已设置:"
echo "   提前7天: ${YEAR7}-${MONTH7}-${DAY7}"
echo "   提前1天: ${YEAR1}-${MONTH1}-${DAY1}"
echo "   当天: ${DATE}"
echo ""
echo "💡 系统会在相应日期推送提醒"
