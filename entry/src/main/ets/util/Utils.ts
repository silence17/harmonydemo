import EventBus, { MyEventData } from '@app/common_lib/src/main/ets/utils/EventBus';
import display from '@ohos.display';
import router from '@ohos.router';


export interface IConfig {
  //当前发布环境
  env: string;
}

let AppConfig: IConfig;

class Utils {
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


  showLoading(p?: { [key: string]: any }) {
    let r = router.getState();
    if (!p) p = {} as MyEventData;
    p["pathName"] = r.path + r.name;
    p["eventName"] = 'showLoading';
    EventBus.emit(p);
  }

  hideLoading(p?: { [key: string]: any }) {
    let r = router.getState();
    if (!p) p = {} as MyEventData;
    p["pathName"] = r.path + r.name;
    p["eventName"] = 'hideLoading';
    EventBus.emit(p);
  }

  toast(p?: { [key: string]: any }) {
    let r = router.getState();
    if (!p) p = {} as MyEventData;
    p["pathName"] = r.path + r.name;
    p["eventName"] = 'showToast';
    EventBus.emit(p);
  }
}

export default new Utils();