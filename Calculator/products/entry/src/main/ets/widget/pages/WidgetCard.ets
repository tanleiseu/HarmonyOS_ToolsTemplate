import { HistoryUtils } from 'lib_foundation';

@Entry
@Component
struct WidgetCard {
  /*
   * The title.
   */
  readonly title: string = 'Hello World';
  /*
   * The action type.
   */
  readonly actionType: string = 'router';
  /*
   * The ability name.
   */
  readonly abilityName: string = 'EntryAbility';
  /*
   * The message.
   */
  readonly message: string = 'add detail';
  /*
   * The width percentage setting.
   */
  readonly fullWidthPercent: string = '100%';
  /*
   * The height percentage setting.
   */
  readonly fullHeightPercent: string = '100%';

  build() {
    Column() {
      Row() {
        Image($r('app.media.calculator_select')).height(20).width(20)
        Text('计算器模板').margin({left: 6}).fontSize(14).fontSize($r('sys.float.Body_L')).fontColor($r('sys.color.ohos_id_color_primary'))
      }
      .width(this.fullWidthPercent).margin({bottom: 9})
      Text('支持快速展示计算结果、日期计算等各种实用小功能').fontSize($r('sys.float.Caption_M')).fontColor($r('sys.color.ohos_id_color_primary'))
      .width(this.fullWidthPercent)
      Row(){
        Column() {
          Image($r('app.media.calculator_small')).height(52).width(56).margin({bottom: 4})
        }.onClick(() => {
          postCardAction(this, {
            action: this.actionType,
            abilityName: this.abilityName,
            params: {
              message: 'calculator'
            }
          });
        })
        Column() {
          Image($r('app.media.calculator_date')).height(52).width(56).margin({bottom: 4})
        }.onClick(() => {
          postCardAction(this, {
            action: this.actionType,
            abilityName: this.abilityName,
            params: {
              message: 'date'
            }
          });
        })
      }.justifyContent(FlexAlign.SpaceBetween).width(this.fullWidthPercent)
      .margin({top: 11})
    }.padding(12)
    .linearGradient({
      colors: [
        [0xfffafa, 0.0],
        [0xcde3ff, 1.0],
      ],
      angle: 153.43
    })
    .height(this.fullHeightPercent)
    .onClick(() => {
      postCardAction(this, {
        action: this.actionType,
        abilityName: this.abilityName,
        params: {
          message: 'calculator'
        }
      });
    })
  }
}