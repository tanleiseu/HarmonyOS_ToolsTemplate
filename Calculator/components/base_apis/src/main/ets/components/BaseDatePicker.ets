import dayjs from 'dayjs'
import { BasePickerOperation } from './BasePickerOperation'
import { getWeekday } from '../utils/Utils'


@ComponentV2
export struct BaseDatePicker {
  /**
   * 当前传入的日期值
   */
  @Param datePicker: Date = new Date()
  /**
   * 是否显示操作栏
   */
  @Param isOperationShow: boolean = true
  /**
   * 是否显示操作栏
   */
  @Param isLunarDate: boolean = false
  /**
   * 是否显示农历
   */
  @Param isLunar: boolean = false
  /**
   * 操作栏是否在底部
   */
  @Param isBottom: boolean = false
  /**
   * 是否显示时间标题
   */
  @Param isShowDateTitle: boolean = false
  /**
   * 当前日期值
   */
  @Local datePickerLocal: Date = new Date()
  /**
   * 关闭回调
   */
  @Event cancel: () => void = () => {}
  /**
   * 确认选择回调
   */
  @Event confirm: (datePicker: Date) => void = () => {}
  /**
   * 切换选择回调
   */
  @Event onDatePickerChange: (datePicker: Date) => void = () => {}
  /**
   * 切换选择回调
   */
  @Event onLunarChange: (value: boolean) => void = () => {}

  aboutToAppear(): void {
    this.datePickerLocal = this.datePicker ?? new Date()
  }

  build() {
    Column() {
      Row(){
        Text(dayjs(this.datePickerLocal).format('YYYY年MM月DD日') + getWeekday(this.datePickerLocal)).fontWeight(FontWeight.Bold)
          .fontSize(20)
      }
      .margin({top:16,bottom:16})
      .visibility(this.isOperationShow && this.isBottom ? Visibility.Visible : Visibility.None)
      BasePickerOperation({
        currentDate: dayjs(this.datePickerLocal).format('YYYY年MM月DD日') + getWeekday(this.datePickerLocal),
        isShowTitle: this.isShowDateTitle,
        cancel: () => {
          this.cancel()
        },
        confirm: () => {
          this.confirm(this.datePickerLocal)
        },
      })
        .visibility(this.isOperationShow && !this.isBottom ? Visibility.Visible : Visibility.None)
      DatePicker({
        start: new Date('1970-1-1'),
        end: new Date('2050-1-1'),
        selected: this.datePickerLocal,
      })
        .lunar(this.isLunarDate)
        .layoutWeight(1)
        .disappearTextStyle({ color: Color.Gray, font: { size: $r('sys.float.Body_M'), weight: FontWeight.Bold } })
        .textStyle({ color: '#FFFFFFE5', font: { size: $r('sys.float.Body_M'), weight: FontWeight.Normal } })
        .selectedTextStyle({
          color: '#5291FF',
          font: { size: 20, weight: FontWeight.Medium },
        })
        .onDateChange((value: Date) => {
          this.datePickerLocal = value
          this.onDatePickerChange(value)
        })
        .backgroundColor('#2e3033')
        .padding({
          top: 20,
          bottom: 20,
        })
    }
    .justifyContent(FlexAlign.End)
    .backgroundColor('#2e3033')
    // .transition(TransitionEffect.translate({ y: 500 }))
  }
}