import { Log } from '@app/common_lib';
import router from '@ohos.router';
import window from '@ohos.window';

/**
 * 闪屏页
 */
@Entry
@Component
struct SplashPage {
  onPageShow() {
    //模拟器会导致顶部留白。待真机验证
    window.getLastWindow(getContext(this), (err, window) => {
      // 全屏样式
      window.setWindowLayoutFullScreen(true)
      // 设置导航栏、状态栏不显示，从而达到沉浸式效果
      window.setWindowSystemBarEnable([])
    })
    setTimeout(() => {
      //调用 router.replaceUrl() 方法，跳转到 Ability 内的指定页面
      //目标页面会替换当前页，并销毁当前页
      router.replaceUrl({
        url: 'pages/MainPage',
        params: {
          src: 'SplashPage'
        }
      }, router.RouterMode.Single)
    }, 2000)
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
      .id('conteiner')
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