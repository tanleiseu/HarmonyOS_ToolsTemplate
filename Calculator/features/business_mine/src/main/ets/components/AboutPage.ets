import { CommonConstants, RouterModule } from 'lib_foundation';
import { BaseNavTitle } from 'base_apis';

@Builder
export function AboutPageBuilder() {
  AboutPage()
}

@ComponentV2
export struct AboutPage {
  @Local title: string = '';

  build() {
    NavDestination() {
      BaseNavTitle({
        title: '关于',
        routerModule: RouterModule.getStack()
      }).margin({ bottom: 20, left: 16 })
      Column() {
        Row({ space: 16 }) {
          Text('用户协议与隐私政策').fontColor($r('sys.color.ohos_id_color_primary_dark')).margin({left: 13})
          Image($r('app.media.chevron_right_new')).width(12).height(24)
        }.rowStyle()
        .onClick(() => {
          const params: Record<string, string> = {
            'title': '用户协议与隐私政策',
            'type': 'agreement'
          }
          RouterModule.getStack().pushPathByName('AgreementPrivacy', params)
        })
      }.padding({left: 16, right: 16})
    }.hideTitleBar(true).backgroundColor('#000000')
  }
}


@Extend(Row)
function rowStyle() {
  .justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Center)
  .borderRadius(16)
  .backgroundColor('rgba(255, 255, 255, 0.1)')
  .padding(16).width(CommonConstants.FULL_PERCENT)
}