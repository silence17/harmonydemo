import { Log } from '@app/common_lib';
import router from '@ohos.router';
import window from '@ohos.window';
import bundleManager from '@ohos.bundle.bundleManager';
import { GlobalConstant } from '@app/common_lib/src/main/ets/app/GlobalConstant';
import { service } from '@app/common_lib/src/main/ets/utils/axios/RequestTask';

/**
 * 闪屏页
 */
@Entry
@Component
struct SplashPage {
  onPageShow() {
    //todo 模拟器会导致顶部留白。待真机验证
    //Window：当前窗口实例，窗口管理器管理的基本单元。
    //WindowStage：窗口管理器。管理各个基本窗口单元。
    //获取当前应用内最后显示的窗口，使用callback异步回调。ctx:当前应用上下文信息。callback:回调函数。返回当前应用内最后显示的窗口对象。
    window.getLastWindow(getContext(this), (err, window) => {
      // 全屏样式
      window.setWindowLayoutFullScreen(true)
      // 设置导航栏、状态栏不显示，从而达到沉浸式效果
      window.setWindowSystemBarEnable([])
    })

    new Promise<string>(function (resolve, reject) {
      //获取系统基本信息,注意 bundleFlags 不同,获取的信息不同,不要随意改变这里的flag
      let bundleFlags = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION;
      bundleManager.getBundleInfoForSelf(bundleFlags).then((bundleInfo) => {
        GlobalConstant.appInfo = bundleInfo

        Log.info('versionName:' + bundleInfo.versionName + ', versionCode:' + bundleInfo.versionCode + ',packageName:' + bundleInfo.name)
        const appInfo = bundleInfo.appInfo
        Log.info('packageName:' + appInfo.name + ', label:' + appInfo.label + ', description:' + appInfo.description + ', icon:' + appInfo.icon + ', process:' + appInfo.process + ', codePath:' + appInfo.codePath)

        resolve(GlobalConstant.getBaseUrl())
      })
    }).then(result => {
      service.defaults.baseURL = result


      setTimeout(() => {
        //调用 router.replaceUrl() 方法，跳转到 Ability 内的指定页面
        //目标页面会替换当前页，并销毁当前页
        router.replaceUrl({
          url: 'pages/MainPage',
          params: {
            src: 'SplashPage'
          }
        }, router.RouterMode.Single)
      }, 500)
    })
  }

  onPageHide() {
  }

  /**
   * 在自定义组件即将析构销毁时执行。
   */
  aboutToDisappear() {
    window.getLastWindow(getContext(this), (err, window) => {
      // 全屏样式
      window.setWindowLayoutFullScreen(false)
      // 设置导航栏、状态栏不显示，从而达到沉浸式效果
      window.setWindowSystemBarEnable(['navigation', 'status'])
    })
  }

  onBackPress() {
    return true;
  }

  build() {
    RelativeContainer() {
      Column() {
        Image($r('app.media.app_logo'))
          .width(90)
          .height(90)
          .id('logo')

        Text('蜂采优选')
          .id('fengcai')
          .fontColor('#333333')
          .margin({ top: 5 })
      }
      .id('container')
      .margin({ bottom: 120 })
      .alignRules({
        bottom: { anchor: '__container__', align: VerticalAlign.Bottom },
        middle: { anchor: '__container__', align: HorizontalAlign.Center },
      })
    }.width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}