import bundleManager from '@ohos.bundle.bundleManager'
import Log from '../utils/Log'

export const CACHE_USER_INFO: string = 'cache_user_info_json'

export class GlobalConstant {
  //BundleInfo
  private appInfo: any

  //The delay time.
  static readonly DELAY_TIME: number = 1000;

  // 网络请求超时.
  readonly HTTP_READ_TIMEOUT: number = 10000;

  //Http request success status code.
  static readonly HTTP_CODE_200: number = 200;

  //The request success status code.
  static readonly SERVER_CODE_SUCCESS: number = 1;

  //测试环境
  static readonly base_url_test = "https://test.beeselect.net"
  static readonly base_url_test2 = "https://test2.beeselect.net"
  static readonly base_url_test3 = "https://test3.beeselect.net"

  //dev
  static readonly base_url_dev = "https://dev.beeselect.net"

  //预发
  static readonly base_url_pre = "https://pre.beeselect.net"

  //生产
  static readonly base_url_product = "https://www.beeselect.net"

  /**
   * app全局是否全屏  即 是否 畅享全屏模式, 目前 没有多试 , 仅知道 启动时可以设置, 页面是否可以独立设置,暂未深入
   */
  public static fullScreen: boolean = false;
  /**
   * app全局是否隐藏顶部系统栏
   */
  public static  readonly hideSystemBar: boolean = false;


  constructor() {
    //获取系统基本信息,注意 bundleFlags 不同,获取的信息不同,不要随意改变这里的flag
    let bundleFlags = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION;
    bundleManager.getBundleInfoForSelf(bundleFlags).then((bundleInfo) => {
      this.appInfo = bundleInfo

      Log.info('versionName:' + bundleInfo.versionName + ', versionCode:' + bundleInfo.versionCode + ',packageName:' + bundleInfo.name)
      const appInfo = bundleInfo.appInfo
      Log.info('packageName:' + appInfo.name + ', label:' + appInfo.label + ', description:' + appInfo.description + ', icon:' + appInfo.icon + ', process:' + appInfo.process + ', codePath:' + appInfo.codePath)
    })
  }

  public getBaseUrl() {
    // let baseURL = '';
    // if (this.appInfo.appProvisionType != undefined && this.appInfo.appProvisionType == 'debug') {
    //   baseURL = GlobalConstant.base_url_test
    // } else {
    //   baseURL = GlobalConstant.base_url_product
    // }
    // return baseURL;
    return GlobalConstant.base_url_test
  }

  /**
   * 获取版本号
   * @returns 3.2.1
   */
  public getVersionCode(): string {
    return this.appInfo.versionName;
  }
}

///export default 关键字来默认导出一个变量、函数或类。每个文件只能有一个默认导出。
export default new GlobalConstant();


export enum PageState {
  Loading = 0,
  Normal = 1,
  Fail = 2,
}