import { FailLayoutBean } from '../../bean/FailLayoutBean';
import { RefreshLoadLayoutBean } from '../../bean/RefreshLoadLayoutBean'

@Component
export struct RefreshFailLayout {
  //状态变化监听
  @ObjectLink
  failBean: FailLayoutBean;

  build() {
    Column() {
      Image(this.failBean.imageSrc)
        .width(248)
        .height(198)

      Text(this.failBean.textValue)
        .margin({ left: 20, right: 20, top: 10 })
        .fontSize(17)
        .textAlign(TextAlign.Center)

      Button(this.failBean.btnStr)
        .width('65%')
        .height(44)
        .margin({ top: 25 })
        .onClick((event) => {
          this.failBean.onClick(event)
        })
    }
    //boolean类型时，设置是否按照父容器边缘轮廓进行裁剪。
    .clip(true)
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}