
import router from '@ohos.router';
import EventBus from './EventBus';



/**
 * Toast 组件
 * Utils.toast({text:"提示信息"})
 * Utils.toast({text:"提示信息",duration:3000})
 *
 */
@Component
export default struct BuiToast{
  /**
   * 当前页面路径, 只有当前页面中 Toast 才会响应,其他页面的事件不响应
   */
  @State currentPagePath: string = ""

  @State visible:boolean = false;

  @State text: string = "";

  @State duration: number = 2000;

  @State color: string = "white";

  @State fontSize:number=16;

  closeTime:number = 0;

  build(){
      Column() { //外部容器

         Column() {
           //内容区域
            Text(this.text).fontColor(this.color).fontSize(this.fontSize).textAlign(TextAlign.Center)

         }.align(Alignment.Center).alignItems(HorizontalAlign.Center).alignSelf(ItemAlign.Center)
         .constraintSize({minWidth:100,maxWidth:340,minHeight:60})
         .padding({left:16,right:16,top:16,bottom:16})
         .borderRadius(8)
         .backgroundColor("rgba(0,0,0,0.3)")
         .backdropBlur(8)

        // .borderWidth(1).borderColor("red")

      }.width('100%').align(Alignment.Center).alignItems(HorizontalAlign.Center)
      .zIndex(999)
      .position({x:0,y:'40%'}) //位置也可设置为变量参数
      .visibility(this.visible ? Visibility.Visible : Visibility.None)
      .animation({duration:10})

  }

  aboutToAppear(){
    try {
      let r = router.getState();
      this.currentPagePath = r.path + r.name; //记录当前页面路径, 响应所有来自当前地址发来的事件
      EventBus.on({
        eventName: "showToast",
        target: this,
        callback: (data) => {
          let pathName = data["pathName"] as string;
          if (pathName != this.currentPagePath) return; //不是我这个页面地址发来的,不处理
          let text  = data["text"] as string;
          if (text) {
            this.text = text;
          } else{
            //没有文字,不展示
            return;
          }
          let duration = data["duration"] as number;
          if (duration) {
            this.duration = duration;
          }else{
            this.duration = 2000;
          }
          let color = data["color"] as string;
          if (color) {
            this.color = color;
          }else{
            this.color = "white";
          }
          let fontSize = data["fontSize"] as number;
          if (fontSize) {
            this.fontSize = fontSize;
          }else{
            this.fontSize = 16;
          }

          this.visible = true;
          this.senderClose();
        }
      })
      EventBus.on({
        eventName: "hideToast",
        target: this,
        callback: (data) => {
          this.visible = false;
        }
      })
    } catch (e) {
      console.error("BuiToast aboutToAppear 异常", e)
    }
  }

  aboutToDisappear(){
    try {
    EventBus.off({
      eventName: "showToast",
      target: this
    });
    EventBus.off({
      eventName: "hideToast",
      target: this
    });
    } catch (e) {
      console.error("BuiToast aboutToDisappear 异常", e)
    }
  }

  senderClose() {
    if (this.closeTime) {
      clearTimeout(this.closeTime);
    }
    this.closeTime = setTimeout(() => {
      this.visible = false;
    }, this.duration)
  }

}