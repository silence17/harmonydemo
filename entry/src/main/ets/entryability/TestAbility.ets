import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import Window from '@ohos.window';
import Want from '@ohos.app.ability.Want';
import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import { Log } from '@app/common_lib';


export default class TestAbility extends UIAbility {
  lifecycleId: number

  onCreate(want: Want, param: AbilityConstant.LaunchParam) {

    hilog.debug(0x0000, 'testTag', '%{public}s', `TestAbility_: ${want.parameters.instanceKey}`);

    let abilityLifecycleCallback = {
      onAbilityCreate(ability) {
        Log.info("onAbilityCreate ability:" + JSON.stringify(ability));
      },
      onWindowStageCreate(ability, windowStage) {
        Log.info("onWindowStageCreate ability:" + JSON.stringify(ability));
        Log.info("onWindowStageCreate windowStage:" + JSON.stringify(windowStage));
      },
      onWindowStageActive(ability, windowStage) {
        Log.info("onWindowStageActive ability:" + JSON.stringify(ability));
        Log.info("onWindowStageActive windowStage:" + JSON.stringify(windowStage));
      },
      onWindowStageInactive(ability, windowStage) {
        Log.info("onWindowStageInactive ability:" + JSON.stringify(ability));
        Log.info("onWindowStageInactive windowStage:" + JSON.stringify(windowStage));
      },
      onWindowStageDestroy(ability, windowStage) {
        Log.info("onWindowStageDestroy ability:" + JSON.stringify(ability));
        Log.info("onWindowStageDestroy windowStage:" + JSON.stringify(windowStage));
      },
      onAbilityDestroy(ability) {
        Log.info("onAbilityDestroy ability:" + JSON.stringify(ability));
      },
      onAbilityForeground(ability) {
        Log.info("onAbilityForeground ability:" + JSON.stringify(ability));
      },
      onAbilityBackground(ability) {
        Log.info("onAbilityBackground ability:" + JSON.stringify(ability));
      },
      onAbilityContinue(ability) {
        Log.info("onAbilityContinue ability:" + JSON.stringify(ability));
      }
    }

    let applicationContext = this.context.getApplicationContext();
    this.lifecycleId = applicationContext.on("abilityLifecycle", abilityLifecycleCallback);
  }

  onNewWant(want: Want, launchParams: AbilityConstant.LaunchParam): void {
    hilog.debug(0x0000, 'testTag', '%{public}s', `TestAbility_onNewWant_: ${want.parameters.instanceKey}`);
  }


  onWindowStageCreate(windowStage: Window.WindowStage) {
    // Main window is created, set main page for this ability
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    // windowStage.loadContent('pages/TestPage', (err, data) => {
    windowStage.loadContent('pages/NavigationExamplePage', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onDestroy() {
    this.context.getApplicationContext().off("abilityLifecycle", this.lifecycleId, (error, data) => {
      Log.info("unregister callback success, err: " + JSON.stringify(error));
    })
  }
}