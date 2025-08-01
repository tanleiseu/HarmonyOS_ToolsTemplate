import { RouterModule, CommonConstants } from 'lib_foundation';
import { BaseTitleBuilder } from 'base_apis';
@ComponentV2
export struct MinePage {

  build() {
    NavDestination() {
      Column() {
        Row({ space: 16 }) {
          Row() {
            Image($r('app.media.ic_info')).width(21).height(21)
            Text('关于').fontColor($r('sys.color.ohos_id_color_primary_dark')).margin({left: 13})
          }
          Image($r('app.media.chevron_right_new')).width(12).height(24)
        }.rowStyle()
        .onClick(() => {
          RouterModule.getStack().pushPathByName('AboutPage', null);
        })
      }.padding({left: 16, right: 16}).margin({top: 20})
    }.title(BaseTitleBuilder('我的')).backgroundColor('#000000')
  }
}


@Extend(Row)
function rowStyle() {
  .justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Center)
  .borderRadius(16)
  .backgroundColor('rgba(255, 255, 255, 0.1)')
  .padding(16).width(CommonConstants.FULL_PERCENT)
}