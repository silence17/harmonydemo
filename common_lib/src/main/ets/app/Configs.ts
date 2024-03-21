import bundleManager from '@ohos.bundle.bundleManager';

export class Configs {
  /**
   * app全局是否全屏  即 是否 畅享全屏模式, 目前 没有多试 , 仅知道 启动时可以设置, 页面是否可以独立设置,暂未深入
   */
  public fullScreen: boolean = false;
  /**
   * app全局是否隐藏顶部系统栏
   */
  public readonly hideSystemBar: boolean = false;

  private appInfo

  public api_url: string = ''


  constructor() {
    this.getAppInfo();
  }

  getAppInfo() {
    if (this.appInfo) {
      return new Promise((res, rej) => {
        res(this.appInfo);
      });
    }
    //获取系统基本信息,注意 bundleFlags 不同,获取的信息不同,不要随意改变这里的flag
    let bundleFlags = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION;
    return new Promise((res, rej) => {
      bundleManager.getBundleInfoForSelf(bundleFlags).then((d) => {
        this.appInfo = d;
        res(this.appInfo);
      }).catch(rej);
    })
  }
}

export default new Configs();