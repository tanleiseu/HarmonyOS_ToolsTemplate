@ComponentV2
export struct BaseMainTitle {
  @Param title: ResourceStr = ''

  build() {
    Row() {
      Text(this.title).fontColor($r('sys.color.ohos_id_color_primary_dark'))
        .fontSize($r('sys.float.Title_M'))
        .margin({ top: 20, left: 24 })
    }
  }
}