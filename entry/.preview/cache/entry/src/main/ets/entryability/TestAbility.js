import UIAbility from '@ohos:app.ability.UIAbility';
import hilog from '@ohos:hilog';
import { Log } from '@bundle:com.example.rankdemo/entry@common_lib/index';
export default class TestAbility extends UIAbility {
    onCreate(want, param) {
        var _a;
        let funAbilityWant = want;
        hilog.debug(0x0000, 'testTag', '%{public}s', (_a = funAbilityWant.parameters) === null || _a === void 0 ? void 0 : _a.info);
        Log.debug('globalThis.entryAbilityStr:' + globalThis.entryAbilityStr);
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
        };
        let applicationContext = this.context.getApplicationContext();
        this.lifecycleId = applicationContext.on("abilityLifecycle", abilityLifecycleCallback);
    }
    onWindowStageCreate(windowStage) {
        // Main window is created, set main page for this ability
        hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
        hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
        // windowStage.loadContent('pages/TestPage', (err, data) => {
        windowStage.loadContent('pages/NavigationExamplePage', (err, data) => {
            var _a, _b;
            if (err.code) {
                hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', (_a = JSON.stringify(err)) !== null && _a !== void 0 ? _a : '');
                return;
            }
            hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', (_b = JSON.stringify(data)) !== null && _b !== void 0 ? _b : '');
        });
    }
    onDestroy() {
        this.context.getApplicationContext().off("abilityLifecycle", this.lifecycleId, (error, data) => {
            Log.info("unregister callback success, err: " + JSON.stringify(error));
        });
    }
}
//# sourceMappingURL=TestAbility.js.map