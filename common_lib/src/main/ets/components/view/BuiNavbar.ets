/**
 * 页面顶部导航条
 */
import router from '@ohos.router'
import Constants from '../../app/Constants'
import BuiTopPlaceHolder from './BuiTopPlaceHolder'

//这种所谓的全局,只在当前文件全局,如何定义App级的全局
@Builder function empty() {}



@Component
export struct BuiNavbar{
  //默认带有后退按钮
  @BuilderParam slot_left:()=>void = this.myLeft

  @BuilderParam slot_title:()=>void= empty

  @BuilderParam slot_right:()=>void=empty

  /**
   * 左边点击默认后退事件, false则需要自定义left
   */
  @State tapLeftBack:boolean=true
  /**
   * 如果不传自定义left ,默认展示后退按钮
   */
  @State showDefaultLeftBtn:boolean=true

  /**
   * 标题字段 ,日过自定义了 center
   */
  @State titleStr?:string="";

  @State bgColor?:string= Constants.Color.white


  /**
   *  后退前的事件,返回false则不响应后退
   */
  onBeforeLeft?:()=>boolean;

  @Builder myLeft(){
      Column(){
        Image($r("app.media.navbar_back")).width(24).height(24).interpolation(ImageInterpolation.Low)
      }.justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center).offset({y:-1})
  }


  build() {
    Column() {
      BuiTopPlaceHolder();
      Column() {
        Row() {
          Column() {
            if (this.slot_left != this.myLeft) {
              this.slot_left()
            } else if (this.showDefaultLeftBtn) {
              this.myLeft()
            }
          }.onClick(() => {
            if (this.tapLeftBack) {
              if (this.onBeforeLeft) {
                if(this.onBeforeLeft()===false){
                  return;
                }
              }
              router.back();
            }
          }).justifyContent(FlexAlign.Center).constraintSize({ maxWidth: 100, minHeight: 56})
          .alignItems(HorizontalAlign.Start)

          Column() {
            if (this.slot_title != empty) {
              this.slot_title();
            } else {
              Text(this.titleStr)
                .align(Alignment.Center)
                .fontSize(18)
                .fontWeight(500)
                .fontColor(Constants.Color._292e33)
                .fontFamily("n")//下面3个属性, 限制为 一行 ellipses
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .maxLines(1)
                .constraintSize({ maxWidth: 300 });
            }
          }.justifyContent(FlexAlign.Center).layoutWeight(1)

          if (this.slot_right) {
            Column() {
              this.slot_right();
            }.justifyContent(FlexAlign.Center)
          }
        }
      }.alignItems(HorizontalAlign.Center).align(Alignment.Center)

    }.backgroundColor(this.bgColor)
    .padding({
      top: 0,
      bottom: 0,
      left: 16,
      right: 16
    })
    .shadow({
      radius: 10,
      color: Constants.Color.rgba_204_210_215_0_10,
      offsetX: 0,
      offsetY: -1
    })
  }
}