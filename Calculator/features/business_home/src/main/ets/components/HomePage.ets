/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { CalculatorType, StandardCalcKeyboard } from 'module_standard_calculator';
import { CommonConstants, RouterModule } from 'lib_foundation';
import { BaseTitleBuilder } from 'base_apis';

@ComponentV2
export struct HomePage {
  @Local text: string = '标准计算器';
  @Local result: string = '0'
  @Local expression: string = '0'
  @Local calculatorType: CalculatorType = CalculatorType.StandardCalc;
  @Local showResultDialog: boolean = false;
  scrollerResult: Scroller = new Scroller();
  scrollerExpression: Scroller = new Scroller();

  build() {
    NavDestination() {
      Column() {
        this.HeaderInfo();
        this.ResultBuilder();
        if (this.calculatorType === CalculatorType.StandardCalc) {
          StandardCalcKeyboard({
            changeResult: (result, expression) => {
              this.result = result || '0';
              this.expression = expression;
            }
          })
        }
      }
      .height(CommonConstants.FULL_PERCENT)
      .padding({ left: 16, right: 16 })
    }.title(BaseTitleBuilder('计算器'))
    .backgroundColor('#000000')
  }



  @Monitor('result')
  resultChange() {
    if (this.result !== null || this.result !== undefined) {
      this.scrollerResult.scrollEdge(Edge.End)
    }
  }

  @Monitor('expression')
  expressionChange() {
    if (this.expression !== null || this.expression !== undefined) {
      this.scrollerExpression.scrollEdge(Edge.End)
    }
  }

  @Builder
  ResultBuilder() {
    Row() {
      Column() {
        Scroll(this.scrollerExpression) {
          Text(this.expression)
            .textStyle()
            .fontSize(38).onSizeChange(() => {
            this.scrollerExpression.scrollEdge(Edge.End)
          })
        }.margin({ bottom: 10 }).width(CommonConstants.FULL_PERCENT)
        .scrollBar(BarState.Off)
        .align(Alignment.End).scrollable(ScrollDirection.Horizontal)

        Scroll(this.scrollerResult) {
          Text(this.result)
            .textStyle()
            .fontSize(30)
        }.width(CommonConstants.FULL_PERCENT).alignSelf(ItemAlign.End)
        .scrollBar(BarState.Off)
        .align(Alignment.End).scrollable(ScrollDirection.Horizontal)
      }
      .width(CommonConstants.FULL_PERCENT)
      .height(CommonConstants.FULL_PERCENT)
      .alignItems(HorizontalAlign.End)
      .justifyContent(FlexAlign.End)
    }
    .height(122)
    .backgroundColor('#202224')
    .padding({
      top: 12,
      bottom: 12,
      left: 16,
      right: 16
    })
    .borderRadius(16)
    .width(CommonConstants.FULL_PERCENT)
    .margin({ bottom: 12 })
  }

  @Builder
  HeaderInfo() {
    Row() {
      Row() {
        Image($r('app.media.ic_calculations_record')).height(24).width(24)
          .onClick(() => {
            RouterModule.getStack().pushPathByName('HistoryResult', null)
          })
      }
      .width(40)
      .height(40)
      .borderRadius('50%')
      .backgroundColor('rgba(255, 255, 255, 0.1)')
      .justifyContent(FlexAlign.Center)
      .alignSelf(ItemAlign.End)
    }.justifyContent(FlexAlign.Center)
    .alignSelf(ItemAlign.End).height(60).padding({ top: 10, bottom: 10 })
  }
}

@Extend(Text)
function textStyle() {
  .fontColor('rgba(255, 255, 255, 0.9)')
  .maxLines(1)
}
