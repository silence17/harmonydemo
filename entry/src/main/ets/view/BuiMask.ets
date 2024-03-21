/**
 * 全局遮罩层 , 用于BuiPage, BuiPaging 等全局容器类
 * 起因是因为制作BuiPopup , 使用Panel ,但是Panel不支持固定高度,拖拽效果无法禁止
 * 且ArkUI有个致命缺点,不支持组件内的全局absolute ,仅支持当前parent内的absolute
 * 这和网页有很大差别
 * Maskz-index 99 ,其他在此基础上的UI,z-index必须100以上
 *
 */
import EventHub from '../../common/EventHub';

@Component
export default struct BuiMask {
  @State visible:boolean=false;


  build(){
    Column() {

    }.position({x:0,y:0}).zIndex(this.visible?99:-1)
    .width('100%').height('100%').backgroundColor("rgba(0,0,0,00.3)")
    .opacity(this.visible?1:0).
      animation({
        duration: 50,
        curve: Curve.Linear
    })
  }

  onMaskShow(){
    this.visible = true;
  }

  onMaskHide(){
    this.visible = false
  }

  aboutToAppear(){
    // EventHub.getInstance().on("showMask",this.onMaskShow);
    // EventHub.getInstance().on("hideMask",this.onMaskHide);

  }

  aboutToDisappear(){
    // EventHub.getInstance().off("showMask",this.onMaskShow);
    // EventHub.getInstance().off("hideMask",this.onMaskHide);
  }

}