import EventBus, { MyEventData } from './EventBus';
import display from '@ohos.display';
import router from '@ohos.router';


export interface IConfig {
  //当前发布环境
  env: string;
}

let AppConfig: IConfig;

export class Utils {
  initConfig(jsonStr: string) {
    AppConfig = JSON.parse(jsonStr) as IConfig;
    console.log("AppConfig", AppConfig)
  }

  /**
   * 是否是生产环境
   * @returns
   */
  isProd() {
    return AppConfig.env == 'production';
  }


  getUserInfoForRequestHeader() {
    return {}
  }

  getWindowSize() {
    let dis = display.getDefaultDisplaySync();
    return {
      width: dis.width,
      height: dis.height
    }

  }


  static showLoading(p?: { [key: string]: any }) {
    let r = router.getState();
    if (!p) p = {} as MyEventData;
    p["pathName"] = r.path + r.name;
    p["eventName"] = 'showLoading';
    EventBus.emit(p);
  }

  static hideLoading(p?: { [key: string]: any }) {
    let r = router.getState();
    if (!p) p = {} as MyEventData;
    p["pathName"] = r.path + r.name;
    p["eventName"] = 'hideLoading';
    EventBus.emit(p);
  }


  /**
   * 展示错误页面
   * @param p  异常页面Bean
   */
  static showError(p?: { [key: string]: any }) {
    let r = router.getState();
    if (!p) p = {} as MyEventData;
    p["pathName"] = r.path + r.name;
    p["eventName"] = 'showError';
    EventBus.emit(p);
  }

  static hideError(p?: { [key: string]: any }) {
    let r = router.getState();
    if (!p) p = {} as MyEventData;
    p["pathName"] = r.path + r.name;
    p["eventName"] = 'hideError';
    EventBus.emit(p);
  }

  static toast(p?: { [key: string]: any }) {
    let r = router.getState();
    if (!p) p = {} as MyEventData;
    p["pathName"] = r.path + r.name;
    p["eventName"] = 'showToast';
    EventBus.emit(p);
  }
}

export default new Utils();