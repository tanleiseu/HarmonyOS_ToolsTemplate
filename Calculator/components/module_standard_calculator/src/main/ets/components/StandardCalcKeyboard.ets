import { BUTTON_TYPE, CalcConstants, Symbol } from '../common/Constant';
import { CalcButtonItemModel } from '../model/CalcButtonItemModel'
import { HistoryUtils, Logger } from 'lib_foundation';
import CheckEmptyUtil from '../common/CheckEmptyUtil';
import CalculateUtil from '../common/CalculateUtil';

@ComponentV2
export struct StandardCalcKeyboard {
  @Local firstClickC: boolean = true;
  @Local inputValue: string = '';
  @Local calValue: string = '';
  private expressions: Array<string> = [];
  @Local arr: string[] = []
  @Local lastBtnIsEqu: boolean = false
  @Local isClickEquBtn: boolean = false
  @Event changeResult: (result:string, expression: string) => void = (result:string, expression: string) => {}
  calcButtonItemModel: CalcButtonItemModel[] = [
    new CalcButtonItemModel($r('app.media.ic_standard_delete'), 'del', BUTTON_TYPE.LETTERS, 0),
    new CalcButtonItemModel($r('app.media.ic_standard_clear'), 'C', BUTTON_TYPE.LETTERS, 2),
    new CalcButtonItemModel($r('app.media.ic_standard_percent'), '%', BUTTON_TYPE.LETTERS, 1),
    new CalcButtonItemModel($r('app.media.ic_standard_plus'), '+', BUTTON_TYPE.ICON, 2),

    new CalcButtonItemModel($r('app.media.ic_standard_7'), '7', BUTTON_TYPE.NUMBER, 1),
    new CalcButtonItemModel($r('app.media.ic_standard_8'), '8', BUTTON_TYPE.NUMBER, 1),
    new CalcButtonItemModel($r('app.media.ic_standard_9'), '9', BUTTON_TYPE.NUMBER, 1),
    new CalcButtonItemModel($r('app.media.ic_standard_divide'), '÷', BUTTON_TYPE.ICON, 2),

    new CalcButtonItemModel($r('app.media.ic_standard_4'), '4', BUTTON_TYPE.NUMBER, 1),
    new CalcButtonItemModel($r('app.media.ic_standard_5'), '5', BUTTON_TYPE.NUMBER, 1),
    new CalcButtonItemModel($r('app.media.ic_standard_6'), '6', BUTTON_TYPE.NUMBER, 1),
    new CalcButtonItemModel($r('app.media.ic_standard_times'), '×', BUTTON_TYPE.ICON, 2),

    new CalcButtonItemModel($r('app.media.ic_standard_1'), '1', BUTTON_TYPE.NUMBER, 1),
    new CalcButtonItemModel($r('app.media.ic_standard_2'), '2', BUTTON_TYPE.NUMBER, 1),
    new CalcButtonItemModel($r('app.media.ic_standard_3'), '3', BUTTON_TYPE.NUMBER, 1),
    new CalcButtonItemModel($r('app.media.ic_standard_minus'), '-', BUTTON_TYPE.ICON, 2),
    new CalcButtonItemModel($r('app.media.ic_standard_0'), '0', BUTTON_TYPE.NUMBER, 1),
    new CalcButtonItemModel($r('app.media.ic_standard_point'), '.', BUTTON_TYPE.NUMBER, 1),
    new CalcButtonItemModel($r('app.media.ic_standard_equal'), '=', BUTTON_TYPE.ICON, 3),
  ]
  layoutOptions: GridLayoutOptions = {
    regularSize: [1, 1],
    onGetRectByIndex: (index: number) => {
      if (index === 16) { // key2是“=”按键对应的index
        return [5, 0, 1, 2]
      }
      return [0, 0, 0, 0]
    }
  }

  @Monitor('inputValue')
  inputValueChange() {
    if (this.inputValue !== null || this.inputValue !== undefined) {
      this.inputValue = this.resultFormat((this.inputValue))
      this.arr = Array.from(this.inputValue);
    }
  }

  build() {
    Column() {
      this.GridBuilder();
    }
  }

  @Builder
  GridBuilder() {
    Grid(undefined, this.layoutOptions) {
      ForEach(this.calcButtonItemModel, (item: CalcButtonItemModel) => {
        GridItem() {
          Column() {
            Image(item.iconUrl).objectFit(ImageFit.Contain).height(70).width(item.value === '0' ? 155: 70)
          }
        }
        .onClick(() => {
          // 根据flag判断是数字还是符号
          if (item.flag === 0 || item.flag === 2 || item.flag === 3) {
            this.inputSymbol(item.value);
          } else {
            if (this.lastBtnIsEqu) {
              this.expressions = []
            }
            this.lastBtnIsEqu = false;
            this.inputNumber(item.value);
          }
          this.changeResult(this.resultFormat(this.calValue), this.expressions.join(''));
        })
      }, (item: CalcButtonItemModel) => JSON.stringify(item))
    }
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .rowsTemplate('1fr 1fr 1fr 1fr 1fr')
    .columnsGap(16)
    .rowsGap(16)
    .height(420)
  }

  /**
   * Input Symbols.
   * 输入
   *
   * @param value Input Operators.
   */
  inputSymbol(value: string) {
    if (CheckEmptyUtil.isEmpty(value)) {
      return;
    }
    let len = this.expressions.length;
    this.lastBtnIsEqu = false;
    switch (value) {
      case Symbol.CLEAN:
        this.expressions = [];
        this.calValue = '0';
        break;
      case Symbol.DEL:
        this.inputDelete(len);
        break;
      case Symbol.EQU:
        if (len === 0) {
          return;
        }
        this.getResult().then((result: boolean) => {
          if (!result) {
            return;
          }
          HistoryUtils.updateHistoryResult(`${this.expressions.join('')}=${this.calValue}`)
          this.inputValue = this.calValue;
          this.calValue = '';
          this.expressions = [];
          this.lastBtnIsEqu = true;
          this.changeResult(this.inputValue, '');
        })
        break;
      default:
        this.inputOperators(len, value);
        break;
    }
    this.formatInputValue();
  }

  /**
   * Enter numbers.
   * 结果
   *
   * @param value Enter numbers.
   */
  inputNumber(value: string) {
    if (CheckEmptyUtil.isEmpty(value) || (!this.expressions.length && value === '.')) {
      return;
    }
    if (value === '.' && CalculateUtil.isSymbol(this.expressions[this.expressions.length - 1])) {
      return;
    }
    let len = this.expressions.length;
    let last = len > 0 ? this.expressions[len - 1] : '';
    let secondLast = len > 1 ? this.expressions[len - CalcConstants.TWO] : undefined;
    if (!this.validateEnter(last, value)) {
      return;
    }
    if (!last) {
      this.expressions.push(value);
    } else if (!secondLast) {
      this.expressions[len - 1] += value;
    }
    if (secondLast && CalculateUtil.isSymbol(secondLast)) {
      this.expressions[len -1] += value;
    }
    if (secondLast && !CalculateUtil.isSymbol(secondLast)) {
      this.expressions.push(value);
    }
    this.formatInputValue();
    if (value !== CalcConstants.DOTS) {
      this.getResult();
    }
  }

  /**
   * Verify that you can enter.
   *
   * @param last Value of the last element.
   * @param value Current input value.
   * return Indicates whether to allow input.
   */
  validateEnter(last: string, value: string) {
    if (!last && value === CalcConstants.PERCENT_SIGN) {
      return false;
    }
    if ((last === CalcConstants.MIN) && (value === CalcConstants.PERCENT_SIGN)) {
      return false;
    }
    if (last.endsWith(CalcConstants.PERCENT_SIGN)) {
      return false;
    }
    if ((last.indexOf(CalcConstants.DOTS) !== -1) && (value === CalcConstants.DOTS)) {
      return false;
    }
    if ((last === '0') && (value !== CalcConstants.DOTS) &&
      (value !== CalcConstants.PERCENT_SIGN)) {
      return false;
    }
    return true;
  }

  /**
   * Delete Key Trigger.
   *
   * @param len Expression Length.
   */
  inputDelete(len: number) {
    if (len === 0) {
      this.calValue = '0';
      return;
    }
    let last = this.expressions[len - 1];
    let lastLen = last.length;
    if (lastLen === 1) {
      this.expressions.pop();
      len = this.expressions.length;
    } else {
      this.expressions[len - 1] = last.slice(0, last.length - 1);
    }
    if (len === 0) {
      this.inputValue = '';
      this.calValue = '0';
      return;
    }
    this.getResult();
  }

  /**
   * Triggered when input is added, subtracted, multiplied, and divided.
   *
   * @param len Expression Length.
   * @param value Current Input Value.
   */
  inputOperators(len: number, value: string) {
    let last = len > 0 ? this.expressions[len - 1] : undefined;
    let secondLast = len > 1 ? this.expressions[len - CalcConstants.TWO] : undefined;
    if (!last && (value === Symbol.MIN)) {
      this.expressions.push(this.getSymbol(value));
      return;
    }
    if (!last) {
      return;
    }
    if (!CalculateUtil.isSymbol(last)) {
      this.expressions.push(this.getSymbol(value));
      return;
    }
    if ((value === Symbol.MIN) &&
      (last === CalcConstants.MIN || last === CalcConstants.ADD)) {
      this.expressions.pop();
      this.expressions.push(this.getSymbol(value));
      return;
    }
    if (!secondLast) {
      return;
    }
    if (value !== Symbol.MIN) {
      this.expressions.pop();
    }
    if (CalculateUtil.isSymbol(secondLast)) {
      this.expressions.pop();
    }
    this.expressions.push(this.getSymbol(value));
  }

  /**
   * Get Operator.
   *
   * @param value.
   * @return Operators.
   */
  getSymbol(value: string) {
    if (CheckEmptyUtil.isEmpty(value)) {
      return '';
    }
    let symbol = '';
    switch (value) {
      case Symbol.ADD:
        symbol = CalcConstants.ADD;
        break;
      case Symbol.MIN:
        symbol = CalcConstants.MIN;
        break;
      case Symbol.MUL:
        symbol = CalcConstants.MUL;
        break;
      case Symbol.DIV:
        symbol = CalcConstants.DIV;
        break;
      default:
        break;
    }
    return symbol;
  }

  /**
   * Make a deep copy of an expression.
   *
   * @return deep copy expression.
   */
  deepCopy(): Array<string> {
    let copyExpressions: Array<string> = Array.from(this.expressions);
    return copyExpressions;
  }

  /**
   * Obtaining Results.
   *
   * @return Whether the result is incorrect.
   */
  async getResult() {
    let calResult = CalculateUtil.parseExpression(this.deepCopy());
    if (calResult === 'NaN' || calResult === 'null' || CalculateUtil.isSymbol(calResult)) {
      this.calValue = this.resourceToString($r('app.string.error'));
      return false;
    }
    this.calValue = calResult;
    return true;
  }

  /**
   * Number Formatting.
   *
   * @param value Formatting parameters.
   * @return Thousand percentile data.
   */
  resultFormat(value: string) {
    let reg = (value.indexOf('.') > -1) ? new RegExp('/(\d)(?=(\d{3})+\.)/g') : new RegExp('/(\d)(?=(?:\d{3})+$)/g');
    return value.replace(reg, '$1,');
  }

  /**
   * Convert a resource file to a string.
   *
   * @param resource Resource file.
   * @return Character string converted from the resource file.
   */
  resourceToString(resource: Resource): string {
    if (CheckEmptyUtil.isEmpty(resource)) {
      return '';
    }
    let result = '';
    try {
      result = getContext(this).resourceManager.getStringSync(resource.id);
    } catch (error) {
      Logger.error('[CalculateModel] getResourceString fail: ' + JSON.stringify(error))
    }
    return result;
  }

  /**
   * Thousands in the formatting result.
   */
  formatInputValue() {
    let deepExpressions: Array<string> = [];
    this.deepCopy().forEach((item: string, index: number) => {
      deepExpressions[index] = this.resultFormat(item);
    });
    this.inputValue = deepExpressions.join('');
  }
}