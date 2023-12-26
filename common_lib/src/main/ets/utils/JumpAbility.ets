import common from '@ohos.app.ability.common';
import { Log } from './log/Log';

export class JumpAbility {

  /**
   * 跳转登陆页面
   */
  static jumpToLoginAbility() {
    let wantInfo = {
      bundleName: 'com.example.rankdemo',
      //待启动的UIAbility
      abilityName: 'LoginAbility',
      //moduleName在待启动的UIAbility属于不同的Module时添加
      parameters: {
        info: '来自EntryAbility Index页面'
      },
    }
    //context为调用方UIAbility的AbilityContext
    let context = getContext(this) as common.UIAbilityContext;
    context.startAbility(wantInfo).then(() => {
      Log.debug('%{public}s' + 'startAbility');
    }).catch((err) => {

    });
  }
}