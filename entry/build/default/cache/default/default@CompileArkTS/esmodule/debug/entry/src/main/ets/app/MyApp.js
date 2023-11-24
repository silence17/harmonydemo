import AbilityStage from '@ohos:app.ability.AbilityStage';
import { Log } from '@bundle:com.example.rankdemo/entry@common_lib/index';
import { PreferencesUtil } from '@bundle:com.example.rankdemo/entry@common_lib/index';
/**
 * AbilityStage是一个 Module 级别的组件容器，应用的HAP在首次加载时会创建一个AbilityStage实例，可以对该Module进行初始化等操作。
 * AbilityStage与Module一一对应，即一个Module拥有一个AbilityStage。
 * 相当于Android Application
 */
export default class MyApp extends AbilityStage {
    /**
     * 应用的HAP在首次加载的时，为该Module初始化操作
     */
    onCreate() {
        Log.init({
            tag: "HarmonyOSLog",
            domain: 0x0000,
            close: false,
            isHilog: true,
            showLogLocation: true,
            logSize: 800 //日志每次输出大小，最大1024字节
        });
        PreferencesUtil.getInstance().init(this.context);
    }
    onAcceptWant(want) {
        // 仅specified模式下触发
        return "MyAbilityStage";
    }
    /**
     * 根据系统可用内存的变化情况，释放不必要的内存。减小应用被杀死的可能性
     * @param level
     */
    onMemoryLevel(level) {
    }
}
//# sourceMappingURL=MyApp.js.map