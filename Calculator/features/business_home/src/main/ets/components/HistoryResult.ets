import { HistoryUtils, RouterModule, HistoryItem } from 'lib_foundation';
import { BaseNavTitle } from 'base_apis';
import { CalcConstants } from 'module_standard_calculator';
import { promptAction } from '@kit.ArkUI';

@Builder
export function HistoryResultBuilder() {
  HistoryResult()
}


@ComponentV2
export struct HistoryResult {
  @Local calcHistory: Array<HistoryItem> = [];

  build() {
    NavDestination() {
      BaseNavTitle({
        title: '历史记录',
        routerModule: RouterModule.getStack()
      }).margin({ bottom: 20 })
      if (this.calcHistory.length) {
        Stack({ alignContent: Alignment.Bottom }) {
          List() {
            ForEach(this.calcHistory, (item: HistoryItem) => {
              ListItem() {
                this.ResultItem(item.value);
              }
            }, (item: HistoryItem) => item.id.toString())
          }.height('calc(100% - 68vp)')

          Row() {
            Image($r('app.media.ic_public_trash_active')).height(40).width(40).onClick(() => {
              this.calcHistory = [];
              HistoryUtils.clearHistoryResult();
              promptAction.showToast({
                message: '历史记录已清空！',
              })
            })
          }
        }
      } else {
        Row() {
          Column() {
            Image($r('app.media.no_result')).height(120).width(120)
            Text('暂无记录~~')
              .fontSize($r('sys.float.Body_L'))
              .fontColor($r('sys.color.ohos_id_color_text_secondary_dark'))
              .margin({ top: 24 })
          }
        }.height('calc(100% - 108vp)')

        Row() {
          Image($r('app.media.ic_public_trash')).height(40).width(40);
        }
      }
    }.hideTitleBar(true).padding({ left: 16, right: 16 })
    .backgroundColor('#000000')
    .onReady(() => {
      this.calcHistory = HistoryUtils.getHistoryResult().reverse();
    })
  }

  getFirstEx(str: string): string {
    if (typeof str === 'undefined' || str === null || str === '') {
      return '';
    }
    return CalcConstants.OPERATORS_ARY.some(item => str.endsWith(item)) ? str.slice(0, str.length - 1) : str;
  }

  @Builder
  ResultItem(record: string) {
    Column() {
      Row() {
        Text(this.getFirstEx(record?.split('=')[0]))
          .fontSize($r('sys.float.Body_L'))
          .textAlign(TextAlign.Start)
          .width('100%')
          .fontColor($r('sys.color.ohos_id_color_text_secondary_dark'))
          .lineHeight(21)
      }
      .padding({ left: 10 })
      .justifyContent(FlexAlign.Start)

      Row() {
        Text(`=${record?.split('=')[1]}`)
          .fontSize($r('sys.float.Subtitle_M'))
          .width('100%')
          .lineHeight(21)
          .textAlign(TextAlign.Start)
          .fontColor($r('sys.color.ohos_id_color_text_primary_dark'))
      }
      .justifyContent(FlexAlign.Start)
      .padding({ left: 10 })
      .margin({ bottom: 13 });

      Divider().color('rgba(255, 255, 255, 0.2)').margin({ bottom: 12 })
    }
  }
}