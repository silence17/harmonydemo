import AbilityStage from '@ohos.app.ability.AbilityStage';
import { Log, PreferencesUtil } from '@app/common_lib';
import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import preferences from '@ohos.data.preferences';
import Want from '@ohos.app.ability.Want';
import { Configuration } from '@ohos.app.ability.Configuration';
import bundleManager from '@ohos.bundle.bundleManager';
import { ToastUtil } from '@app/common_lib/src/main/ets/utils/ToastUtil';
import { GlobalConstant } from '@app/common_lib/src/main/ets/app/GlobalConstant';


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
    //初始化应用信息
    new GlobalConstant()
    Log.init({
      tag: "HarmonyOSLog", //打印的标签，默认为： HarmonyOSLog
      domain: 0x0000, //输出日志所对应的业务领域,默认为0x0000
      close: false, //是否关闭log，不打印
      isHilog: true, //打印类型，默认为true是hilog打印 ，false为console
      showLogLocation: true, //默认不打印，只要在error下才会打印行数
      logSize: 800 //日志每次输出大小，最大1024字节
    })

    PreferencesUtil.getInstance().init(this.context)
  }

  /**
   * 在AbilityStage 的生命周期回调中为目标UIAbility实例生成Key
   * onAcceptWant()事件回调：UIAbility指定实例模式（specified）启动时候触发的事件回调
   * @param want
   */
  onAcceptWant(want: Want): string {
    // 仅specified模式下触发
    if (want.abilityName === 'TestAbility') {
      //根据参数中的instanceKey 参数拼接生成一个Key值并返回
      return `TestAbility_${want.parameters.instanceKey}`
    }
    return ''
  }

  /**
   * 事件回调：当系统全局配置发生变更时触发的事件，系统语言、深浅色等，配置项目前均定义在Configuration类中。
   * @param newConfig
   */
  onConfigurationUpdate(newConfig: Configuration) {
  }

  /**
   * 根据系统可用内存的变化情况，释放不必要的内存。减小应用被杀死的可能性
   * @param level
   */
  onMemoryLevel(level: AbilityConstant.MemoryLevel) {
  }
}