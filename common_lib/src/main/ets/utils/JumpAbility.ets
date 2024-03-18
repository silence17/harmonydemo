import common from '@ohos.app.ability.common';
import Want from '@ohos.app.ability.Want';
import { Log } from './log/Log';

export class JumpAbility {

  /**
   * 跳转登陆页面
   */
  static jumpToLoginAbility() {
    let wantInfo = {
      //可跨设备调用, '':当前设备
      deviceId: '',
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


  static jumpToTestAbility(code: number) {
    let wantInfo: Want = {
      bundleName: 'com.example.rankdemo',
      //待启动的UIAbility
      abilityName: 'TestAbility',
      moduleName: 'entry',
      //moduleName在待启动的UIAbility属于不同的Module时添加
      parameters: {
        instanceKey: code
      },
    }
    //context为调用方UIAbility的AbilityContext
    let context = getContext(this) as common.UIAbilityContext;
    context.startAbility(wantInfo)
  }
}