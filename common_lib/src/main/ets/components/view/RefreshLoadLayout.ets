import { RefreshLoadLayoutBean } from '../../bean/RefreshLoadLayoutBean'

@Component
export struct RefreshLoadLayout {
  //状态变化监听
  @ObjectLink
  loadBean: RefreshLoadLayoutBean;

  build() {
    Row() {
      Image(this.loadBean.imageSrc)
        .width(18)
        .height(18)

      Text(this.loadBean.textValue)
        .margin({ left: 5 })
        .fontSize(17)
        .textAlign(TextAlign.Center)
    }
    //boolean类型时，设置是否按照父容器边缘轮廓进行裁剪。
    .clip(true)
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}