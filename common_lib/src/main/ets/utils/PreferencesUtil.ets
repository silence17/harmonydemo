import dataPreferences from '@ohos.data.preferences';
import { Log } from './Log/Log';

/**
 * @author huchangjie
 * @date 2023.11.17
 * @description 首选项 存储工具类.文件持久化
 */
export class PreferencesUtil {
  private static readonly TAG: string = '[PreferencesUtil]';
  private static readonly PREFERENCES_NAME = 'myPreferences';
  private static instance: PreferencesUtil
  private getPreferences: Function

  private constructor() {
  }

  public static getInstance() {
    if (PreferencesUtil.instance == null) {
      PreferencesUtil.instance = new PreferencesUtil();

      //Promise：三个状态：pending(进行中),resolved(已完成，也称为fullfilled),rejected(已失败)
      //处理异步，解决回调地狱的问题，将回调地狱改造成了链式调用。Promise本身不是异步的，但是容器内部往往存放一个异步操作
      // .then的回调中，如果没有返回promise .then会默认返回一个promise
      // .then如果返回不是promise，会将返回值通过一个promise返回。
      // .then回调中返回一个promise，默认的promise就不生效了，下一个then就由返回这个promise实例去调用
      // new Promise<string>(function (resolved, reject) {
      //   //进行异步操作代码：
      //   // resolved("success")
      //   reject("fail")
      //   console.log("promise: Promise: " + resolved)
      // }).then((resolved) => {
      //   // resolve函数的作用是将这个promise对象的状态从 pending 变为 resolved。并将异步操作的结果value，作为参数传递出去。
      //   console.log("promise: resolved: " + resolved)
      // }, (rejected) => {
      //   // reject函数的作用是将这个promise对象的状态从 pending 变为 rejected。并将错误传递出去。
      //   console.log("promise: rejected: " + rejected)
      // }).catch()
    }
    return PreferencesUtil.instance
  }

  public init(context: Context) {

    let fun: Function = (() => {
      let preferences: Promise<dataPreferences.Preferences> =
      dataPreferences.getPreferences(context, PreferencesUtil.PREFERENCES_NAME)
      return preferences;
    });
    this.getPreferences = fun;
  }

  putString(key: string, value: string) {
    this.getPreferences().then(async function (preferences: dataPreferences.Preferences) {

      await preferences.put(key, value)
      preferences.flush()
    }).catch(function (err: Error) {
      Log.error(PreferencesUtil.TAG, 'put the preferences failed, err: ' + err);
    })
  }

  async getString(key: string, defaultValue?: string) {
    let value = ""
    value = await (await this.getPreferences()).get(key, defaultValue);
    return value;
  }
}