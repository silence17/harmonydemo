import EventBus, { MyEventData } from './EventBus';
import display from '@ohos.display';
import router from '@ohos.router';
import bundleManager from '@ohos.bundle.bundleManager';
import { Log } from './Log/Log';


export class Utils {
  getUserInfoForRequestHeader() {
    return {}
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