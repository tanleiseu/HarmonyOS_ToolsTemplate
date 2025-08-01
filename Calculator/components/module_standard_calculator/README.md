# 标准计算器组件快速入门

## 目录

- [简介](#简介)
- [使用](#使用)
- [API参考](#API参考)
- [示例代码](#示例代码)

## 简介

本组件提供了标准计算器能力。

<img src="./screenshot/StandardCalcKeyboard.png" width="300">

## 使用

1. 组件依赖

   由于StandardCalcKeyboard组件依赖**lib_foundation** har包，所以需要将模板根目录的commons下**lib_foundation** 目录拷贝至您的工程相应目录

   ```typescript
   // module_standard_calculator har包依赖情况
   "dependencies": {
    "lib_foundation": "file:../../commons/lib_foundation"
   }
   ```

2. 安装组件。

   ```typescript
   // 在项目根目录build-profile.json5填写module_standard_calculator路径
     "modules": [
       {
         "name": "lib_foundation",
         "srcPath": "./lib_foundation",
       },
       {
         "name": "module_standard_calculator",
         "srcPath": "./module_standard_calculator",
       }
     ]
   ```

   ```typescript
   // entry/oh-package.json5
   "dependencies": {
     "module_standard_calculator": "file:../module_standard_calculator"
   }
   ```

3. 引入组件。

   ```typescript
   import { CalculatorType, StandardCalcKeyboard } from 'module_standard_calculator';
   ```


## API参考

StandardCalcKeyboard(funciton?: (result, expression) => void)

标准计算器功能。

**参数：**

| 参数名  | 类型                           | 是否必填 | 说明                            |
| ------- |------------------------------|----|-------------------------------|
| funciton | (result, expression) => void | 是  | result:计算结果，expression：输入的计算式 |


## 示例代码

   ```typescript
      import { StandardCalcKeyboard } from 'module_standard_calculator';

      @Entry
      @ComponentV2
      struct Index {
         @Local result: string = '0'
         @Local expression: string = '0'
         build() {
            Column() {
               Text(this.expression);
               Text(this.result)
               StandardCalcKeyboard({
                  changeResult: (result, expression) => {
                     this.result = result;
                     this.expression = expression;
                  }
               })
            }
         }
      }
   ```