# 日历计算组件快速入门

## 目录

- [简介](#简介)
- [使用](#使用)
- [API参考](#API参考)
- [示例代码](#示例代码)

## 简介

本组件提供了日期计算的相关能力，包括日期间隔、日期计算功能。

<img src="./screenshot/DateToolsCalculate.png" width="300">

## 使用

1. 组件依赖

   由于DateCalculation组件依赖**base_apis** har包以及**lunar、dayjs**三方库，所以需要将模板根目录的components下**base_apis** 目录拷贝至您的工程相应目录

   ```typescript
   // date_calculation har包依赖情况
   "dependencies": {
       "lunar": "^1.0.0",
       "dayjs": "^1.11.13",
       "base_apis": "file:../base_apis",
   }
   ```

2. 安装组件。

   ```typescript
   // 在项目根目录build-profile.json5填写date_calculation和base_apis路径
     "modules": [
       {
         "name": "date_calculation",
         "srcPath": "./date_calculation",
       },
       {
         "name": "base_apis",
         "srcPath": "./base_apis",
       }
     ]
   ```

   ```typescript
   // entry/oh-package.json5
   "dependencies": {
     "date_calculation": "file:../date_calculation"
   }

3. 引入组件。

   ```typescript
   import { DateToolsCalculate } from 'date_calculation';
   ```

4. 调用组件，详细参数配置说明参见[API参考](#API参考)。

      ```typescript
   import { DateToolsCalculate } from 'date_calculation';
   
   @Entry
   @Component
   struct Index {
     build() {
       Column() {
         DateToolsCalculate({
           startDate: new Date('2025-5-28'),
           buttonColor: '#317AF7',
           textColor: '#ffffff',
         })
       }.backgroundColor('#000000')
     }
   }
   ```

## API参考

### 子组件

无

### 接口

DateToolsCalculate({startDate: string, buttonColor: string,  textColor: string })

日期计算的相关能力，包括日期间隔、日期计算功能。

**参数：**

| 参数名        | 类型                                                         | 是否必填 | 说明     |
| ----------- | ------------------------------------------------------------ | -------- | -------- |
| buttonColor | [ResourceStr](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#resourcestr) | 否       | 按钮颜色 |
| textColor   | [ResourceStr](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#resourcestr) | 否       | 文字颜色 |
| startDate   | [ResourceStr](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#resourcestr)\| number | 否       | 开始日期 |

### 事件

支持以下事件：

#### onIntervalSearch

onIntervalSearch(callback: betweenDates: number)) => void)

日期间隔查询事件，返回日期间隔

#### onCalculateSearch

onCalculateSearch(callback: calculateInfo: [LuckyDays](#LuckyDays对象说明))) => void)

日期计算查询事件，返回查询日期计算详情

**参数：**

| 参数名        | 类型                            | 是否必填 | 说明                         |
| ------------- | ------------------------------- | ---- | ---------------------------- |
| calculateInfo | [LuckyDays](#LuckyDays对象说明) | 是   | 根据时间条件查询到的日期信息 |


### CALCULATION_TYPE对象说明

| 参数名   | 类型   | 是否必填 | 说明 |
| -------- | ------ | ---- | ---- |
| FORWARD  | string | 是   | 向前 |
| BACKWARD | string | 是   | 向后 |

### LuckyDays对象说明

| 名称    | 类型   | 是否必填 | 说明      |
| ------- | ------ |------|---------|
| daysFromNow    | string | 是    | 距离今天的天数 |
| solarDate   | string | 是    | 阳历日期    |
| lunarDate     | string | 是    | 农历日期    |
| ganZhiYear | string | 是    | 天干地支年   |
| ganZhiMonth | string | 是    | 天干地支月   |
| forwardOrBack | string | 是    | 向前向后查询  |
| ganZhiDay | string | 是    | 天干地支日   |
| weekday | string | 是    | 星期      |
