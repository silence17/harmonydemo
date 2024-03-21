import router from '@ohos.router';
import Log from '../../utils/Log';
import EventBus from '../../utils/EventBus';
import { StringUtil } from '../../utils/StringUtil';


@Component
export default struct ErrorLayout {
  @State show: boolean = false;
  //图标地址
  @State imageSrc: Resource = $r("app.media.fail_img_layout")
  @State textValue: string = '请稍后再试';
  @State btnStr: string = '';
  @State clickListener: (event?: ClickEvent) => void = null


  /**
   * 当前页面路径, 只有当前页面中的loading才会响应,其他页面的事件不响应
   */
  @State currentPagePath: string = ""

  build() {
    Column() {
      Image(this.imageSrc)
        .width(248)
        .height(198)
      Text(this.textValue)
        .margin({ left: 20, right: 20, top: 10 })
        .fontSize(17)
        .textAlign(TextAlign.Center)

      if (!StringUtil.isEmpty(this.btnStr))
        Button(this.btnStr)
          .width('65%')
          .height(44)
          .margin({ top: 25 })
          .onClick((event) => {
            if (this.clickListener != null) {
              this.clickListener(event)
            }
          })
    }
    //boolean类型时，设置是否按照父容器边缘轮廓进行裁剪。
    .clip(true)
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#F7F7F7')
    .alignItems(HorizontalAlign.Center)
    .align(Alignment.Center)
    .width('100%')
    .height('100%')
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
        eventName: "showError",
        target: this,
        //接收订阅事件时的回调处理
        callback: (data) => {
          data = data || {};
          let pathName = data["pathName"] as string;
          let imageSrc = data["imageSrc"] as Resource;
          //异常说明文案
          let textValue = data["textValue"] as string;
          let btnStr = data["btnStr"] as string;
          let listener = data["listener"] as ((event?: ClickEvent) => void);

          if (pathName != this.currentPagePath) return; //不是我这个页面地址发来的,不处理
          if (imageSrc != null) {
            this.imageSrc = imageSrc;
          }
          if (!StringUtil.isEmpty(textValue)) {
            this.textValue = textValue;
          }
          if (!StringUtil.isEmpty(btnStr)) {
            this.btnStr = btnStr;
          }
          if (listener != null) {
            this.clickListener = listener
          }
          this.show = true;
        }
      })
      EventBus.on({
        eventName: "hideError",
        target: this,
        callback: (data) => {
          this.show = false;
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
}