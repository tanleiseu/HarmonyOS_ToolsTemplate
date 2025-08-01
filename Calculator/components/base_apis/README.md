# 集成能力组件快速入门

## 简介

本组件提供调用模态框的功能。

<img src="./screenshot/BaseActionSheet.png" width="300">

### 使用
1. 安装组件。 将模板根目录的components下**base_apis**目录拷贝至您的工程相应目录。
   ```typescript
   // 在项目根目录build-profile.json5填写base_calendar和base_apis路径
     "modules": [
       {
         "name": "base_apis",
         "srcPath": "./base_apis",
       }
     ]
   ```

   ```typescript
   "dependencies": {
     "base_apis": "file:../base_apis"
   }
   ```
2. 调用组件   
 ```typescript
   import {baseActionSheet } from 'base_apis';
   
   @Entry
   @ComponentV2
   struct Index {
   
     @Builder
     themePickerBuilder() {
       Column(){
         Text('自定义内容')
       }
     }
   
     build() {
       Column(){
         Button('调用')
           .onClick(() => {
             baseActionSheet.show({
               id: "ThemeToggle",
               detents:[300,301],
               title: {
                 title: "主题切换",
               },
               customContent: () => {
                 this.themePickerBuilder();
               },
             });
           })
       }
     }
   }
 ```

## 接口

### BaseActionSheet(options: ActionSheetOption)

**ActionSheetOption对象说明**

| <div style="width:200px" align="left" >参数名</div> | <div style="width:200px" align="left" >类型</div>            | <div style="width:80px" align="left" >必填</div> | <div style="width:200px" align="left" >说明</div> |
| :-------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------- | :------------------------------------------------ |
| id                                                  | string                                                       | 否                                               | 模态框id                                          |
| height                                              | SheetSize \| Length                                          | 否                                               | 模态框高度                                        |
| detents                                             | [(SheetSize \| Length), (SheetSize \| Length)?, (SheetSize \| Length)?] | 否                                               | 半模态页面的切换高度档位                          |
| title                                               | SheetTitleOptions \| CustomBuilder                           | 否                                               | 原生标题                                          |
| preferType                                          | SheetType                                                    | 否                                               | 半模态页面的样式                                  |
| showClose                                           | boolean                                                      | 否                                               | 是否显示原生关闭图标                              |
| closeable                                           | boolean                                                      | 否                                               | 是否显示关闭图标                                  |
| backgroundColor                                     | ResourceStr                                                  | 否                                               | 背景                                              |
| customContent                                       | () => void = () => { }                                       | 否                                               | 自定义内容                                        |

## 事件

| <div style="width:300px" align="left" >名称</div> | <div style="width:300px" align="left" >功能描述</div> |
| :------------------------------------------------ | :---------------------------------------------------- |
| onOpen: () => void                                | 打开回调                                              |
| onCancel: () => void                              | 点击取消回调                                          |
| onClose: () => void                               | 关闭回调                                              |

## 实例方法

| <div style="width:300px" align="left" >名称</div> | <div style="width:300px" align="left" >功能描述</div> |
| :------------------------------------------------ | :---------------------------------------------------- |
| close(id:string)                                  | 根据id关闭模态框，不传默认关闭最新打开的模态框        |



# BaseToast

## 简介

本组件提供调用弹窗的功能。

 对话框  

 <img src="./screenshot/BaseToast_dialog.png">

进度

<img src="./screenshot/BaseToast_loading.png"> 

### 使用
1. 安装组件。 将模板根目录的components下**base_apis**目录拷贝至您的工程相应目录。
   ```typescript
   // 在项目根目录build-profile.json5填写base_calendar和base_apis路径
     "modules": [
       {
         "name": "base_apis",
         "srcPath": "./base_apis",
       }
     ]
   ```

   ```typescript
   "dependencies": {
     "base_apis": "file:../base_apis"
   }
   ```
2. 调用组件
 ```typescript
   import { baseToast } from 'base_apis';
   
   @Entry
   @ComponentV2
   struct Index {
     @Builder
     themePickerBuilder() {
       Column() {
         Text('自定义内容')
       }
     }
   
     build() {
       Column() {
         Button('调用')
           .onClick(() => {
             baseToast.show({
               type: 'dialog',
               hasTitle: '标题',
               message: '对话框内容',
               confirmAction: () => {
                 baseToast.hide();
               },
             });
           })
       }
     }
   }
 ```

```typescript
// 引入组件
import { baseToast } from 'apis';

baseToast.show({
  type: "dialog",
  hasTitle: '提示',
  message: '对话框内容',
  confirmAction: () => {
    baseToast.hide();
  },
});

```
```typescript
   import { baseToast } from 'base_apis';
   
   @Entry
   @ComponentV2
   struct Index {
     @Builder
     themePickerBuilder() {
       Column() {
         Text('自定义内容')
       }
     }
   
     build() {
       Column() {
         Button('调用')
           .onClick(() => {
             baseToast.show({
               type: "loading",
             });
           })
       }
     }
   }
```


## 接口

### BaseToast(options: BaseToastSheetOption)

**BaseToastSheetOption对象说明**

| <div style="width:200px" align="left" >参数名</div> | <div style="width:200px" align="left" >类型</div> | <div style="width:80px" align="left" >必填</div> | <div style="width:200px" align="left" >说明</div> |
| :-------------------------------------------------- | :------------------------------------------------ | :----------------------------------------------- | :------------------------------------------------ |
| type                                                | 'loading' \| 'dialog' = 'loading'                 | 否                                               | toast类型                                         |
| message                                             | ResourceStr                                       | 否                                               | dialog类型时提示语                                |
| hasTitle                                            | ResourceStr                                       | 否                                               | 是否显示标题                                      |

## 事件

| <div style="width:300px" align="left" >名称</div> | <div style="width:300px" align="left" >功能描述</div> |
| :------------------------------------------------ | :---------------------------------------------------- |
| confirmAction: () => void = () => {}              | 弹窗确认回调                                          |
| cancelAction: () => void = () => {}               | 弹窗取消回调                                          |

## 实例方法

| <div style="width:300px" align="left" >名称</div> | <div style="width:300px" align="left" >功能描述</div> |
| :------------------------------------------------ | :---------------------------------------------------- |
| hide                                              | 关闭弹窗                                              |



# BaseDatePicker

## 简介

本组件提供弹出时间选择框的功能。

<img src="./screenshot/BaseDatePicker.png" width="300">

### 使用

1. 安装组件。 将模板根目录的components下**base_apis**目录拷贝至您的工程相应目录。
   ```typescript
   // 在项目根目录build-profile.json5填写base_calendar和base_apis路径
     "modules": [
       {
         "name": "base_apis",
         "srcPath": "./base_apis",
       }
     ]
   ```

   ```typescript
   "dependencies": {
     "base_apis": "file:../base_apis"
   }
   ```
2. 调用组件
```typescript
   import { BaseDatePicker } from 'base_apis';
   
   @Entry
   @ComponentV2
   struct Index {
     build() {
       Column() {
         BaseDatePicker({
           confirm: (date: Date) => {
             console.log("confirm",JSON.stringify(date));
           },
           cancel: () => {
             console.log("cancel");
           },
         });
       }
     }
   }
```

## 接口

### BaseDatePicker(options: BaseDatePickerOption)

**BaseDatePickerOption对象说明**

| <div style="width:200px" align="left" >参数名</div> | <div style="width:200px" align="left" >类型</div> | <div style="width:80px" align="left" >必填</div> | <div style="width:200px" align="left" >说明</div> |
| :-------------------------------------------------- | :------------------------------------------------ | :----------------------------------------------- | :------------------------------------------------ |
| datePicker                                          | Date                                              | 否                                               | 当前传入的日期值                                  |
| datePickerLocal                                     | Date                                              | 否                                               | 当前日期值                                        |

## 事件

| <div style="width:300px" align="left" >名称</div>       | <div style="width:300px" align="left" >功能描述</div> |
| :------------------------------------------------------ | :---------------------------------------------------- |
| cancel: () => void = () => {}                           | 弹窗取消回调                                          |
| confirm: (datePicker: Date) => void = () => {}          | 弹窗确定回调                                          |
| datePickerChange: (datePicker: Date) => void = () => {} | 切换选择回调                                          |



# BaseTextPicker

## 简介
本组件提供弹出文本选择框的功能。

<img src="./screenshot/BaseTextPicker.png" width="300">

### 使用

1. 安装组件。 将模板根目录的components下**base_apis**目录拷贝至您的工程相应目录。
```typescript
   // 在项目根目录build-profile.json5填写base_calendar和base_apis路径
     "modules": [
       {
         "name": "base_apis",
         "srcPath": "./base_apis",
       }
     ]
```

```typescript
   "dependencies": {
     "base_apis": "file:../base_apis"
   }
```
2. 调用组件

```typescript
   import { BaseTextPicker } from 'base_apis';
   
   @Entry
   @ComponentV2
   struct Index {
     @Local dayList:string[] = ['周一','周二','周三','周四','周五']
     build() {
       Column() {
         BaseTextPicker({
           textList: this.dayList,
           confirm: (value: number) => {
             console.log("confirm",JSON.stringify(value));
           },
           cancel: () => {
             console.log("cancel");
           },
         });
       }
     }
   }
```

## 接口

### BaseDatePicker(options: BaseTextPickerOption)

**BaseTextPickerOption对象说明**

| <div style="width:200px" align="left" >参数名</div> | <div style="width:200px" align="left" >类型</div> | <div style="width:80px" align="left" >必填</div> | <div style="width:200px" align="left" >说明</div> |
| :-------------------------------------------------- | :------------------------------------------------ | :----------------------------------------------- | :------------------------------------------------ |
| textList                                            | string[]                                          | 是                                               | 当前传入的日期值                                  |
| select                                              | number                                            | 否                                               | 当前选择值                                        |
| selected                                            | number                                            | 否                                               | 传入默认选择值                                    |

## 事件

| <div style="width:300px" align="left" >名称</div>            | <div style="width:300px" align="left" >功能描述</div> |
| :----------------------------------------------------------- | :---------------------------------------------------- |
| cancel: () => void = () => {}                                | 弹窗取消回调                                          |
| confirm: (datePicker: Date) => void = () => {}               | 弹窗确定回调                                          |
| textPickerChange: (value: string \| string[]) => void = () => {} | 切换选择回调                                          |

# BaseSliderSwitch

## 简介

本组件提供了滑块切换的相关功能。

<img src="./screenshot/BaseSliderSwitch.png">

## 使用

1. 安装组件。 将模板根目录的components下**base_apis**目录拷贝至您的工程相应目录。
```typescript
   // 在项目根目录build-profile.json5填写base_calendar和base_apis路径
     "modules": [
       {
         "name": "base_apis",
         "srcPath": "./base_apis",
       }
     ]
```

```typescript
   "dependencies": {
     "base_apis": "file:../base_apis"
   }
```

2. 调用组件
 ```typescript
   import { BaseSliderSwitch } from 'base_apis';
   
   @Entry
   @ComponentV2
   struct Index {
     build() {
       Column() {
         BaseSliderSwitch({
           toggleList: [
             { id: "1", name: "日期间隔" },
             { id: "2", name: "日期计算" },
             { id: "3", name: "日期转换" },
           ],
           currentIndex: 1,
           onChooseChange: (index: number) => {
             console.log("当前选择的索引是" + index);
           },
         });
       }
     }
   }
 ```

<img src="./screenshot/BaseSliderSwitch_1.png">


# YiJiCell

## 简介

本组件提供了今天宜、今天忌，卡片展示的相关功能。

<img src="./screenshot/YiJiCell.png">

## 使用

1. 安装组件。 将模板根目录的components下**base_apis**目录拷贝至您的工程相应目录。
```typescript
   // 在项目根目录build-profile.json5填写base_calendar和base_apis路径
     "modules": [
       {
         "name": "base_apis",
         "srcPath": "./base_apis",
       }
     ]
```

```typescript
   "dependencies": {
     "base_apis": "file:../base_apis"
   }
```
2. 调用组件

   ```typescript
   import { YiJiCell } from 'base_apis';
   
   @Entry
   @ComponentV2
   struct Index {
     build() {
       Column() {
         YiJiCell({
           yiText: ["沐浴", "平治道涂", "扫舍", "入殓", "破土", "安葬", "除服", "成服"],
           jiText: ["嫁娶", "移徙", "伐木", "作梁", "安床", "祭祀", "祈福", "盖屋"],
           isEllipsis: false,
         });
       }
     }
   }
   ```

## API参考

###  接口

YiJiCell (options?: YiJiCell Options)

今天宜，今天忌，卡片展示组件。

**参数：**

| 参数名  | 类型                          | 必填 | 说明                                 |
| :------ | :---------------------------- | :--- | :----------------------------------- |
| options | [YiJiCell](#YiJiCell对象说明) | 否   | 今天宜，今天忌，卡片展示组件的参数。 |

### YiJiCell对象说明

| 名称       | 类型                                                         | 必填 | 说明               |
| :--------- | :----------------------------------------------------------- | :--- | :----------------- |
| yiText     | string[]                                                     | 否   | 宜文本             |
| jiText     | string[]                                                     | 否   | 忌文本             |
| isEllipsis | boolean                                                      | 否   | 是否超出省略号展示 |
| yiIcon     | [ResourceStr](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V14/ts-types-V14#resourcestr) | 否   | 宜图标             |
| jiIcon     | [ResourceStr](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V14/ts-types-V14#resourcestr) | 否   | 忌图标             |

### 事件

支持以下事件：

#### onYiJiCellClick

onYiJiCellClick(callback: () => void)

今天宜，今天忌，卡片点击事件

# BaseCell

## 简介

本组件提供了左右标题布局组件，开发可以根据业务自定义左右标题，并支持传入自定义组件作为卡片内容，可以快速组装成完整的业务区域卡片

<img src="./screenshot/BaseCell_4.png" >

## 使用

1. 安装组件。 将模板根目录的components下**base_apis**目录拷贝至您的工程相应目录。
```typescript
   // 在项目根目录build-profile.json5填写base_calendar和base_apis路径
     "modules": [
       {
         "name": "base_apis",
         "srcPath": "./base_apis",
       }
     ]
```

```typescript
   "dependencies": {
     "base_apis": "file:../base_apis"
   }
```
2. 调用组件

```typescript
   import { BaseCell } from 'base_apis';
   
   @Entry
   @ComponentV2
   struct Index {
     build() {
       Column() {
         BaseCell({
           cellTitle: '节日节气',
           titleColor: "#000000",
           titleSize:16,
           titleWeight:FontWeight.Bold,
           showRightText:false,
         });
       }
     }
   }
```

## API参考

### 子组件

无

###  接口

BaseCell(options?: BaseCellOptions)

左右标题布局组件。

**参数：**

| 参数名  | 类型                                        | 必填 | 说明                 |
| :------ | :------------------------------------------ | :--- | :------------------- |
| options | [BaseCellOptions](#BaseCellOptions对象说明) | 否   | 配置单元卡片的参数。 |

### BaseCellOptions对象说明

| 名称                    | 类型                                                                                                                                                         | 必填 | 说明       |
|:----------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------| :--- |:---------|
| cellTitle             | [ResourceStr](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#resourcestr)                                                      | 是   | 标题文本     |
| titleColor            | [ResourceStr](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#resourcestr)                                                      | 否   | 标题颜色     |
| titleSize             | [ResourceStr](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#resourcestr)                                                      | 否   | 标题大小     |
| titleWeight           | [FontWeight](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-appendix-enums#fontweight)                                               | 否   | 标题文本粗细   |
| customBuilderParam    | [CustomBuilder](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#custombuilder8)                                                 | 否   | 内容显示插槽   |
| rightTextBuilderParam | [CustomBuilder](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#custombuilder8)                                                 | 否   | 右侧显示插槽   |
| showRightText         | boolean                                                                                                                                                    | 否   | 是否显示右侧内容 |
| leftTextBuilderParam  | [CustomBuilder](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#custombuilder8)                                                 | 否   | 左侧显示插槽   |
| bgColor  | [ResourceStr](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#resourcestr)                                                       | 否   | 背景颜色     |
### 事件

支持以下事件：

#### onRightCellClick

onRightCellClick: () => void = () => {}

当存在右侧卡槽的时候，此事件会触发右侧侧插槽点击事件

## 示例代码

### 示例1（是否显示右侧内容）

本示例通过showRightText实现是否显示右侧内容
```typescript
   import { BaseCell } from 'base_apis';
   
   @Entry
   @ComponentV2
   struct Index {
     build() {
       Column() {
         BaseCell({
            cellTitle: "节日节气",
            titleColor: "#000000",
            titleSize: 16,
            titleWeight: FontWeight.Bold,
            showRightText: true,
         });
       }
     }
   }
```

<img src="./screenshot/BaseCell_1.png">

### 示例2（自定义内容显示插槽）

本示例通过customBuilderParam实现自定义内容显示插槽

```typescript
   import { BaseCell } from 'base_apis';

   @Entry
   @ComponentV2
   struct Index {
    @Builder 
    customBuilder() {
      Column(){
        Text('自定义内容显示插槽')
     }
    }
     build() {
       Column() {
         BaseCell({
            cellTitle: "节日节气",
            titleColor: "#000000",
            titleSize: 16,
            titleWeight: FontWeight.Bold,
            showRightText: true,
            customBuilderParam: (): void => this.customBuilder(),
         });
       }
     }
   }
```

<img src="./screenshot/BaseCell_2.png">