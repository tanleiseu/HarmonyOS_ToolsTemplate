import { BaseSliderSwitch, LuckyDays, ToggleItem } from 'base_apis'
import { DateCalculation } from '../components/dateCalculation/DateCalculation'
import { DateInterval } from '../components/dateInterval/DateInterval'
import { YinYangConversion } from '../components/yinYangConversion/YinYangConversion'
import { LunarInfo } from '../model/model'

@ComponentV2
export struct DateToolsCalculate {
  /**
   * 按钮颜色
   */
  @Param buttonColor: ResourceStr = '#c4272b'
  /**
   * 文本颜色
   */
  @Param textColor: ResourceStr = '#ffffff'
  /**
   * 起始时间
   */
  @Param startDate: Date = new Date()

  /**
   * 日期计算查询事件
   */
  @Event onSearch: (calculateInfo: LuckyDays) => void = () => {}

  /**
   * 日期间隔查询事件
   */
  @Event onIntervalSearch: (betweenDates: number) => void = () => {}

  /**
   * 日期计算查询事件
   */
  @Event onCalculateSearch: (calculateInfo: LuckyDays) => void = () => {}

  /**
   * 阴阳转换查询事件
   */
  @Event onConvertSearch: (lunarDateInfo: LunarInfo) => void = () => {}

  @Local currentIndex: number = 0
  @Local toggleList: ToggleItem [] = [
    {
      name: '日期间隔',
      id: 'interval',
    },
    {
      name: '日期计算',
      id: 'calculation',
    },
  ]
  build() {
    List() {
      ListItem() {
        BaseSliderSwitch({
          toggleList: this.toggleList,
          selectedBg: '#DB6B42',
          currentIndex: this.currentIndex,
          onChooseChange: (index: number) => {
            this.currentIndex = index
          },
        })
      }
      .margin({ top: 16 })
      .padding({ left: 16, right: 16 })

      ListItem() {
        Tabs({ index: this.currentIndex }) {
          TabContent() {
            DateInterval({
              startDate: this.startDate,
              buttonColor: this.buttonColor,
              textColor: this.textColor,
              onSearch:(betweenDates: number) => {
                this.onIntervalSearch(betweenDates)
              }
            })
          }

          TabContent() {
            DateCalculation({
              startDate: this.startDate,
              buttonColor: this.buttonColor,
              textColor: this.textColor,
              onSearch:(calculateInfo: LuckyDays) => {
                this.onCalculateSearch(calculateInfo)
              }
            })
          }
        }
        .onChange((value) => {
          this.currentIndex = value
        })
        .barHeight(0)
      }.height('calc(100% - 108vp)')
    }
    .height('100%')
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.None)
  }
}