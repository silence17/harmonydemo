/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
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

import hilog from '@ohos.hilog';
import UIAbility from '@ohos.app.ability.UIAbility';
import Window from '@ohos.window';
import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import AbilityStage from '@ohos.app.ability.AbilityStage';
import { Log } from '@app/common_lib/src/main/ets/utils/Log/Log';
import { PreferencesUtil } from '@app/common_lib/src/main/ets/utils/PreferencesUtil';
import dataPreferences from '@ohos.data.preferences';
import preferences from '@ohos.data.preferences';
import deviceInfo from '@ohos.deviceInfo';
import promptAction from '@ohos.promptAction';
import TreeMap from '@ohos.util.TreeMap';

/**
 * UIAbility 相当于Android Activity
 *
 * 一个UIAbility组件中可以通过多个页面来实现一个功能模块。每一个UIAbility组件实例，都对应于一个最近任务列表中的任务。
 */
export default class EntryAbility extends UIAbility {
  public TAG: string = "EntryAbility";


  /**
   * Create状态为在应用加载过程中，UIAbility实例创建完成时触发，系统会调用onCreate()回调。
   * 可以在该回调中进行应用初始化操作，例如变量定义资源加载等，用于后续的UI界面展示。
   * @param want
   * @param launchParam
   */
  onCreate(want, launchParam) {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    hilog.info(0x0000, 'testTag', '%{public}s', 'want param:' + JSON.stringify(want) ?? '');
    hilog.info(0x0000, 'testTag', '%{public}s', 'launchParam:' + JSON.stringify(launchParam) ?? '');

    //设备类型
    Log.debug('deviceInfo: ' + deviceInfo.deviceType)
    //设备厂家名称
    Log.debug('deviceInfo: ' + deviceInfo.manufacture)

    //事件通知机制，同一个UIAbilityContext内发送事件，可以接受到
    this.context.eventHub.on('myEvent', (...data) => {
      // 触发事件，完成相应的业务操作
      console.debug(this.TAG, 'json:  ' + JSON.stringify(data));
    })
    //全局可跨UIAbility
    globalThis.entryAbilityStr = 'TestAbility'

    ///promise
    //Promise和async/await提供异步并发能力，适用于单次I/O任务的开发场景
    //TaskPool和Worker提供多线程并发能力，适用于CPU密集型任务、I/O密集型任务和同步任务等并发场景.
    //Promise有三种状态：pending（进行中）、fulfilled（已完成）和rejected（已拒绝）
    //Promise对象创建后处于pending状态，并在异步操作完成后转换为fulfilled或rejected状态。
    const promise = new Promise((resolve, reject) => {

      setTimeout(() => {
        const randomNumber = Math.random();
        Log.debug('Random number' + randomNumber + "thread current is main: ")
        if (randomNumber > 0.5) {
          resolve(randomNumber)
        } else {
          reject(new Error("Random number is too small"))
        }
      }, 1000)
    }).then(result => {
      // Promise对象创建后，可以使用then方法和catch方法指定fulfilled状态和rejected状态的回调函数。
      // then方法可接受两个参数，一个处理fulfilled状态的函数，另一个处理rejected状态的函数。只传一个参数则表示状态改变就执行，不区分状态结果。
      // 使用catch方法注册一个回调函数，用于处理“失败”的结果，即捕获Promise的状态改变为rejected状态或操作失败抛出的异常
      Log.debug(`Random number is ${result}`);
    }).catch(error => {
      Log.error(error.message);
    })
  }


  /**
   * UIAbility实例创建完成之后，在进入Foreground之前，系统会创建一个WindowStage。
   * WindowStage创建完成后会进入onWindowStageCreate()回调，可以在该回调中设置UI界面加载、设置WindowStage的事件订阅。
   * @param windowStage
   */
  onWindowStageCreate(windowStage: Window.WindowStage) {
    // Main window is created, set main page for this ability
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    //为当前WindowStage的主窗口加载具体页面。
    //在onWindowStageCreate()回调中通过loadContent()方法设置应用要加载的页面并根据需要订阅WindowStage的事件（获焦/失焦、可见/不可见）。
    windowStage.loadContent('pages/MainPage', (err, data) => {
      if (err.code) {
        hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.ERROR);
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });

    //模拟器会导致顶部留白。待真机验证
    // windowStage.getMainWindow((error, window) => {
    //   // 全屏样式
    //   window.setWindowLayoutFullScreen(true, (err) => {
    //     if (err.code) {
    //       console.error('Failed to set the window layout to full-screen mode. Cause:' + JSON.stringify(err));
    //       return;
    //     }
    //     console.info('Succeeded in setting the window layout to full-screen mode.');
    //   })
    //   // 设置导航栏、状态栏不显示，从而达到沉浸式效果
    //   window.setWindowSystemBarEnable(['navigation'])
    // })
  }


  /**
   * 在UIAbility实例销毁之前，则会先进入onWindowStageDestroy()回调，可以在该回调中释放UI界面资源。
   * 例如在onWindowStageDestroy()中注销获焦/失焦等WindowStage事件
   */
  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  /**
   * 在UIAbility的UI界面可见之前，如UIAbility切换至前台时触发。
   * 可以在onForeground()回调中申请系统需要的资源，或者重新申请在onBackground()中释放的资源。
   */
  onForeground() {
    // Ability has brought to foreground
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  /**
   * onBackground()回调，在UIAbility的UI界面完全不可见之后，如UIAbility切换至后台时候触发。
   * 可以在onBackground()回调中释放UI界面不可见时无用的资源，或者在此回调中执行较为耗时的操作，例如状态保存等。
   */
  onBackground() {
    // Ability has back to background
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }

  /**
   * Destroy状态在UIAbility实例销毁时触发。可以在onDestroy()回调中进行系统资源的释放、数据的保存等操作
   */
  onDestroy() {
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');

    //取消订阅指定事件。 - 传入callback：取消指定的callback对指定事件的订阅，当该事件触发后，将不会回调该callback。 - 不传callback：取消所有callback对指定事件的订阅。
    this.context.eventHub.off('myEvent')
  }

  /**
   *
   * @param level 回调返回内存微调级别，显示当前内存使用状态。
   */
  onMemoryLevel(level: AbilityConstant.MemoryLevel) {
    console.log('onMemoryLevel, level:' + JSON.stringify(level));
  }
}
