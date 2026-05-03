# 飞书多维表格配置

## 表格信息

**表格名称**：Faye的成长计划
**Base Token**：T0ZQb1e25acfizsowUycm1Jan0c
**表格地址**：https://lcn6itdxogbg.feishu.cn/base/T0ZQb1e25acfizsowUycm1Jan0c

---

## 表1：心情感悟

**Table ID**：tblzT4l3lLw6OZkS

### 字段配置

| 字段名 | 类型 | 说明 |
|--------|------|------|
| 时间 | 日期时间 | 记录时间 |
| 内容 | 文本 | 感悟内容 |
| 情绪标签 | 多选 | 开心、焦虑、平静、疲惫、困惑、感恩、释然、委屈、愤怒、期待... |
| 场景标签 | 多选 | 人际、工作、生活、成长、关系、独处、家庭... |

### 操作命令

#### 记录感悟

```bash
lark-cli base +record-upsert \
  --base-token "T0ZQb1e25acfizsowUycm1Jan0c" \
  --table-id "tblzT4l3lLw6OZkS" \
  --json '{"时间":"2026-04-17 22:00:00","内容":"感悟内容","情绪标签":["焦虑"],"场景标签":["人际"]}' \
  --as user
```

---

## 表2：纪念日

**Table ID**：tbl6ACwhojvfd13V

### 字段配置

| 字段名 | 类型 | 说明 |
|--------|------|------|
| 纪念日名称 | 文本 | 纪念日名称 |
| 日期 | 日期 | 纪念日日期 |
| 提醒状态 | 文本 | 已提醒/未提醒 |

### 操作命令

#### 添加纪念日

```bash
lark-cli base +record-upsert \
  --base-token "T0ZQb1e25acfizsowUycm1Jan0c" \
  --table-id "tbl6ACwhojvfd13V" \
  --json '{"纪念日名称":"妈妈生日","日期":"2026-04-20"}' \
  --as user
```

---

## 表3：礼物记录

**Table ID**：tblHGcHO4PAfmtJz

### 字段配置

| 字段名 | 类型 | 说明 |
|--------|------|------|
| 礼物名称 | 文本 | 礼物名称 |
| 对象 | 文本 | 送/收对象 |
| 场合 | 文本 | 生日、节日、日常... |
| 日期 | 日期 | 记录日期 |

### 操作命令

#### 记录礼物

```bash
lark-cli base +record-upsert \
  --base-token "T0ZQb1e25acfizsowUycm1Jan0c" \
  --table-id "tblHGcHO4PAfmtJz" \
  --json '{"礼物名称":"花","对象":"妈妈","场合":"生日","日期":"2026-04-20"}' \
  --as user
```

---

## 注意事项

- 心情感悟的情绪标签是**多选**，可以同时有多种情绪
- 场景标签也是**多选**
- 纪念日提醒需要创建3个日程事件（提前7天、提前1天、当天）
- 礼物记录不单独提醒，在纪念日提醒时汇总展示
