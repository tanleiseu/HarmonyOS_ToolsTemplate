import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

const DOMAIN = 0x0000;

export default class EntryAbility extends UIAbility {
  private widgetMessage: string = '';
  private currentWindowStage: window.WindowStage | null = null;
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onCreate');
    // 获取卡片router事件中传递的targetPage参数
    if (want?.parameters?.params) {
      let params: Record<string, string> = {}
      // want.parameters.params 对应 postCardAction() 中 params 内容
      try {
        params = JSON.parse(want.parameters.params as string);
      } catch (e) {
        console.log('want parameters params error')
      }
      this.widgetMessage = params.message as string;
    }
  }

  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    // 获取卡片router事件中传递的targetPage参数
    if (want?.parameters?.params) {
      let params: Record<string, string> = {}
      // want.parameters.params 对应 postCardAction() 中 params 内容
      try {
        params = JSON.parse(want.parameters.params as string);
      } catch (e) {
        console.log('want parameters params error')
      }
      this.widgetMessage = params.message as string;
      if (this.currentWindowStage !== null) {
        this.onWindowStageCreate(this.currentWindowStage);
      }
    }
  }

  onDestroy(): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    let sysBarProps: window.SystemBarProperties = {
      statusBarColor: '#000000',
      statusBarContentColor: '#ffffff'
    };
    windowStage.getMainWindowSync().setWindowSystemBarProperties(sysBarProps);
    // Main window is created, set main page for this ability
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    AppStorage.setOrCreate('widget_router', this.widgetMessage)
    if (this.currentWindowStage === null) {
      this.currentWindowStage = windowStage;
    }
    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(DOMAIN, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err));
        return;
      }
      hilog.info(DOMAIN, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
