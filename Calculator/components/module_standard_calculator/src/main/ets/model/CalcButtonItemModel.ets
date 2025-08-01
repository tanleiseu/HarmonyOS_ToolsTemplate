import { BUTTON_TYPE } from '../common/Constant';

export class CalcButtonItemModel {
  iconUrl: Resource;
  value: string;
  type: BUTTON_TYPE;
  flag: number;

  constructor(iconUrl: Resource, value: string, type: BUTTON_TYPE, flag: number) {
    this.iconUrl = iconUrl;
    this.value = value;
    this.type = type;
    this.flag = flag;
  }
}
