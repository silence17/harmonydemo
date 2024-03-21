import BuiText, { TextColor } from './BuiText';
import router from '@ohos.router';
import Constants from '../../app/Constants';
import Log from '../../utils/Log';
import EventBus from '../../utils/EventBus';


export interface BuiLoadingAttributes {
  /**
   * loading 图标
   */
  icon?: string;

  /**
   * Loading 文本
   */
  text?: string;

  /**
   * Loading样式
   */
  theme?: number
  /**
   * 请求来自哪个页面路径
   */
  pathName: string;
  duration?: number;
}


@Component
export default struct BuiLoading {
  defaultText: string = "努力加载中";
  @State show: boolean = false;
  @State angle: number = 0;
  @State text: string = this.defaultText;
  //图标地址
  icon: string = "";
  defaultIcon: Resource = $r("app.media.common_loading")
  @State theme: number = 0;
  @State textTop: number = 10;
  /**
   * 打开请求次数
   */
  @State openCount: number = 1000;
  /**
   * 当前页面路径, 只有当前页面中的loading才会响应,其他页面的事件不响应
   */
  @State currentPagePath: string = ""
  @State duration: number = 2000;
  closeTime: number = 0;

  /**
   * 渲染主题0
   */
  @Builder
  renderTheme0() {
    Column() {
      Image(this.icon || this.defaultIcon)
        .rotate({ angle: this.angle })

        .width(50)
        .height(50)
        .alignSelf(ItemAlign.Center)
        .animation({
          duration: 2000,
          iterations: -1, //无限播放
          curve: Curve.Linear,
        })
      if (this.text && this.show) {
        BuiText({ text: this.text.toString(), color: TextColor.Color_gray, fontSize: 14 }).margin({ top: this.textTop })
      }
    }.translate({ y: -100 })
  }

  build() {
    Column() {
      if (this.theme == 0) {
        this.renderTheme0();
      }
    }
    .justifyContent(FlexAlign.Center)
    .backgroundColor(Constants.Color.rgba_249_252_255_0_1)
    .alignItems(HorizontalAlign.Center)
    .align(Alignment.Center)
    .width('100%')
    .height('100%')
    .position({
      x: 0,
      y: 0,
    })
    .zIndex(9999)
    .visibility(this.show ? Visibility.Visible : Visibility.None);
  }


  /**
   * 组件即将出现时回调该接口，具体时机为在创建自定义组件的新实例后，在执行其build()函数之前执行。
   * https://docs.openharmony.cn/pages/v4.0/zh-cn/application-dev/reference/arkui-ts/ts-custom-component-lifecycle.md/#abouttoappear
   */
  aboutToAppear() {
    try {
      let r = router.getState();
      this.currentPagePath = r.path + r.name; //记录当前页面路径, 响应所有来自当前地址发来的事件
      EventBus.on({
        eventName: "showLoading",
        target: this,
        //接收订阅事件时的回调处理
        callback: (data) => {
          data = data || {};
          let pathName = data["pathName"] as string;
          let text = data["text"] as string;
          let icon = data["icon"] as string;
          let duration = data["duration"] as number;
          let theme = data["theme"] as number;
          if (pathName != this.currentPagePath) return; //不是我这个页面地址发来的,不处理
          if (text || text == '') {
            this.text = text;
          } else {
            this.text = this.defaultText;
          }
          if (icon) {
            this.icon = icon;
          } else {
            this.icon = ""
          }
          if (duration != undefined) {
            this.duration = duration;
          } else {
            this.duration = 6000;
          }


          if (theme != undefined) {
            this.theme = theme;
          } else {
            this.theme = 0
          }

          this.changeCount(1);
          this.show = true;
          this.angle = 360;
          this.senderClose();
        }
      })
      EventBus.on({
        eventName: "hideLoading",
        target: this,
        callback: (data) => {
          this.changeCount(-1);
        }
      })
    } catch (e) {
      Log.error("BuiLoading aboutToAppear 异常", e)
    }
  }

  /**在自定义组件即将析构销毁时执行。
   * https://docs.openharmony.cn/pages/v4.0/zh-cn/application-dev/reference/arkui-ts/ts-custom-component-lifecycle.md/#abouttodisappear
   */
  aboutToDisappear() {
    try {
      EventBus.off({
        eventName: "showLoading",
        target: this
      });
      EventBus.off({
        eventName: "hideLoading",
        target: this
      });
    } catch (e) {
      Log.error("BuiLoading aboutToDisappear 异常", e)
    }
  }

  senderClose() {
    if (this.closeTime) {
      clearTimeout(this.closeTime);
    }
    this.closeTime = setTimeout(() => {
      this.changeCount(-100)
    }, this.duration)
  }

  __doChange() {
    if (this.openCount <= 1000) {
      this.openCount = 1000;
      this.angle = 0; //恢复位置
      this.show = false;
      this.icon = "";
      this.text = this.defaultText;
      this.textTop = 10;
      return;
    } else {
      setTimeout(() => {
        this.__doChange();
      }, 500)
    }
  }

  changeCount(seed: number) {
    this.openCount += seed
    this.__doChange();
  }
}