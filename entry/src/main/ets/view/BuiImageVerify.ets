export interface VerifyParamObject{
  bigImage:string|Resource ;
  /**
   * 大图原图宽高  像素单位,由服务器给出
   */
  bigImageWidth:number;
  /**
   * 大图原图宽高  像素单位,由服务器给出
   */
  bigImageHeight:number;

  smallImage:string|Resource ;

  /**小图片X起点 边距调整, 并不是最终坐标 */
  smallX:number
  /**
   * 小图片Y起点 ,和阴影Y一致 服务端给出
   */
  smallY:number
  /**
   * 控件宽度
   */
  width:number|string
}
/**
 * 外部控制器
 */
export interface BuiImageVerifyController{
  /**
   * 执行逻辑
   * @param param json格式数据
   */
  start:(param:VerifyParamObject)=>void;
}

/**
 * 图片验证组件
 */
@Component
export default struct BuiImageVerify{

  controller:BuiImageVerifyController|undefined=undefined;

  /**
   * 展示参数,由controller控制传入
   */
  @State private param:VerifyParamObject|undefined = undefined;

  private myBigWidth:number=0;
  private mySmallWidth:number=0;
  /**
   * 缩放比
   */
 @State private myScale:number=1;
  @State myBigY:number = 0;
  @State currX:number=0;
  @State mySmallY:number=0;

  @State private startX:number=0;
  @State private duration:number=0;
  @State private x:number = 0;
  @State private initX:number = 0;


  build(){
    if(this.param) {
      Column() {
        Stack() {

          Image(this.param.bigImage).objectFit(ImageFit.Contain).constraintSize({minWidth:100,minHeight:20,maxWidth:"100%"}).height("auto")
            .onAreaChange((o: Area, n: Area) => {
                this.myBigWidth = vp2px(n.width as number);
                this.myScale =  this.myBigWidth/(this.param?.bigImageWidth||1)
                this.myBigY = n.position.y as number;
            })
          Image(this.param.smallImage).objectFit(ImageFit.Contain).constraintSize({minWidth:10,minHeight:10})
            .onAreaChange((o: Area, n: Area) => {
              this.mySmallWidth = vp2px(n.width as number);

          }).width((this.mySmallWidth*this.myScale)||"auto").margin({top: (this.myBigY + this.mySmallY)+"px",left: this.initX })
            .onTouch((e:TouchEvent)=>{
              this.onHandlerTouch(e)
            })


        }.width('100%').constraintSize({minWidth:100,minHeight:20,maxWidth:"100%"})
        Column(){
            Image($r("app.media.handler")).onTouch((e:TouchEvent)=>{
              this.onHandlerTouch(e)
            })
        }.width("100%")
      }.width(this.param.width||"90%")
    }
  }

  onHandlerTouch(e:TouchEvent){
    if(!e)return;
    e.stopPropagation()
    let touch = e.changedTouches?.[0]
    if(!touch)return;
    if(e.type == TouchType.Down){ //按下
      this.startX = touch.screenX
      this.duration = 0 //动画速度归零,否则拖拽时感觉不跟手
    }else if(e.type == TouchType.Up){ //抬起
      this.startX=0;
      this.x = this.initX; //让横坐标复位
      this.duration = 100 //动画速度,否则复位时闪现
    }else if(e.type == TouchType.Move){ //移动
      let t = e.target;
      let pos:Position =t.area.globalPosition;
      let x = touch.screenX
      let y = touch.screenY
      let xDirection = x-this.startX  // 大于0 向右
      this.x+= xDirection
      let posX = pos.x as number
      let posY = pos.y as number
      let tW = t.area.width as number
      let tH = t.area.height as number
      if(xDirection>=0){
        if(posX+tW>=330){ //右边界
          this.x=330- tW
        }
      }else{
        if(posY<10){
          this.x=10
        }
      }
      this.startX=x;
    }



  }

  aboutToAppear(){
    if(this.controller){
      this.controller.start = (p:VerifyParamObject)=>{
        this.param=p;
        this.currX = this.initX = this.param?.smallX * this.myScale
        this.mySmallY =  this.param?.smallY * this.myScale
      }
    }
  }


}