import bundleManager from '@ohos.bundle.bundleManager'

export const CACHE_USER_INFO: string = 'cache_user_info_json'

// 客服电话
export const SERVICE_PHONE = "010-65915326"

export class GlobalConstant {
  //BundleInfo 应用信息
  static appInfo: bundleManager.BundleInfo

  //The delay time.
  static readonly DELAY_TIME: number = 1000;

  // 网络请求超时.
  static readonly HTTP_READ_TIMEOUT: number = 10000;

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

  //app全局是否全屏  即 是否 畅享全屏模式, 目前 没有多试 , 仅知道 启动时可以设置, 页面是否可以独立设置,暂未深入
  public static FULL_SCREEN: boolean = true;

  //system bar height
  public static system_bar_height = 0

  //nav bar height
  public static system_nav_bar_height = 0

  public static getBaseUrl() {
    let baseURL = ''
    let devModel = this.appInfo.appInfo.appProvisionType

    if (devModel == undefined) {
      baseURL = GlobalConstant.base_url_product
    } else {
      switch (devModel) {
        case 'release':
          baseURL = GlobalConstant.base_url_product
          break
        case 'debug':
          baseURL = GlobalConstant.base_url_test
          break
      }
    }
    return baseURL;
    // return GlobalConstant.base_url_test
  }
}

///export default 关键字来默认导出一个变量、函数或类。每个文件只能有一个默认导出。
// export default new GlobalConstant();
