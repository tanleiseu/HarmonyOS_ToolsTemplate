/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


/**
 * 常量类
 */
export class CommonConstants {
  // Font weight
  static readonly DIALOG_TITLE_FONT_WEIGHT: number = 700;
  static readonly DIALOG_BUTTON_FONT_WEIGHT: number = 500;
  static readonly NORMAL_FONT_WEIGHT: number = 400;
  // Opacity
  static readonly FIRST_LEVEL_OPACITY: number = 0.9;
  static readonly SECOND_LEVEL_OPACITY: number = 0.6;
  static readonly HALF_OPACITY: number = 0.5;
  static readonly THIRD_LEVEL_OPACITY: number = 0.3;
  // Blur
  static readonly REGULAR_BLUR: number = 250;
  // Space
  static readonly SPACE_4: number = 4;
  static readonly SPACE_8: number = 8;
  static readonly SPACE_12: number = 12;
  static readonly SPACE_16: number = 16;
  // MaxLines
  static readonly MAX_LINE_TWO: number = 2;
  // Column count
  static readonly SM_COLUMN_COUNT: number = 1;
  static readonly MD_COLUMN_COUNT: number = 2;
  static readonly LG_COLUMN_COUNT: number = 3;
  // Percent
  static readonly FULL_PERCENT: string = '100%';
  static readonly SIX_PERCENT: string = '60%';
  static readonly HALF_PERCENT: string = '50%';
  static readonly NAVI_BAR_WIDTH: string = '40%';// 绿色

  public static readonly FONT_COLOR_BLACK = $r('sys.color.ohos_id_color_text_primary');
  public static readonly FONT_COLOR_WHITE = $r('sys.color.ohos_id_color_text_primary_contrary');
  public static readonly FONT_COLOR_GRAY = $r('sys.color.ohos_id_color_text_tertiary');
  public static readonly FONT_COLOR_GREEN = '#0A554A';
  public static readonly DIVIDER_GRAY = $r('sys.color.ohos_id_color_list_separator');
  public static readonly BG_COLOR_GRAY = $r('sys.color.ohos_id_color_sub_background');
  public static readonly BG_COLOR_WHITE = $r('sys.color.ohos_id_color_background');
  public static readonly BG_COLOR_GREEN = $r('sys.color.ohos_id_color_palette_aux3');
  public static readonly FONT_SIZE_L = $r('sys.float.ohos_id_text_size_body1');
  public static readonly FONT_SIZE_M = $r('sys.float.ohos_id_text_size_body2');
  public static readonly FONT_SIZE_S = $r('sys.float.ohos_id_text_size_body3');
  public static readonly FONT_SIZE_XS = $r('sys.float.ohos_id_text_size_caption');
  public static readonly DISABLE_OPACITY = $r('sys.float.ohos_id_alpha_disabled');
}

export enum AppStorageMap {
  HISTORY_RESULT = 'historyResult',
}
