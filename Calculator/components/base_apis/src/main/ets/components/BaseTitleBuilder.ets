@Builder
export function BaseTitleBuilder(title: string) {
  Row() {
    Text(title).fontColor('rgba(255, 255, 255, 0.9)')
      .fontSize(24)
      .fontWeight(700)
  }
  .constraintSize({ maxWidth: '100%' })
  .margin({ top: 10, left: 16 })
  .padding({ left: 8 })
  .height(36)
  .width('100%')
}