@ComponentV2
export struct BaseNavTitle {
  @Param title: ResourceStr = ''
  @Param routerModule: NavPathStack = new NavPathStack()

  build() {
    Row({ space: 8 }) {
      Column() {
        Image($r('app.media.left')).height(24).width(24)
          .objectFit(ImageFit.Contain).onClick(() => {
          this.routerModule.pop()
        })
      }.borderRadius('50%').padding(8)
      .backgroundColor('rgba(255, 255, 255, 0.1)')
      .justifyContent(FlexAlign.Center)

      Text(this.title).fontColor('rgba(255, 255, 255, 0.9)').fontSize(20).fontWeight(700)
        .lineHeight(27)
    }
    .height(36)
    .constraintSize({maxWidth : '100%'})
    .margin({ top: 10, right: 100 })
    .width('100%')
    .onClick(() => {
      this.routerModule.pop()
    })
  }
}