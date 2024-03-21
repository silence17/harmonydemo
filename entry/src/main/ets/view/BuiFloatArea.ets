export interface BuiFloatAreaController{
  /**
   * 触发 隐藏
   */
  trigger:()=>void
}
@Builder function empty(){}
/**
 * 一个靠右(当前默认是右下角)
 * 需要放到Entry上
 */
@Component
export struct BuiFloatArea{
  controller:BuiFloatAreaController={} as BuiFloatAreaController

  /**
   * 内容区域,外部自定义
   */
  @BuilderParam slot:()=>void =empty

  /**
   * 初始x坐标 不要超过350,你懂得
   */
  @State x:number = 350
  /**
   * 初始y坐标 这里可以计算当前屏幕高度来动态设置
   */
  @State y:number = 600
  /**
   * 可拖拽的最大高度,外部传吧,可传屏幕高度
   */
  @State maxTop:number = 800
  /**
   * 可拖拽最大宽度,外部传吧,可传屏幕宽度
   */
  @State maxRight:number = 360
  //以下是内部封装属性 都是需要页面响应的,所以都需要@State修饰
  @State private initX:number = this.x;
  @State private startX:number = 0
  @State private startY:number = 0
  @State private timer:number = 0
  @State private duration:number = 100
  @State private myWidth:number = 50

  build(){
    Column(){
        this.slot();
    }.position({
      x: this.x,
      y:this.y
    }).constraintSize({
      minWidth:50,
      minHeight:50
    })
    .animation({
      duration: this.duration,
      curve:Curve.Linear
    })
    .onTouch((e:TouchEvent)=>{
      if(!e)return;
      e.stopPropagation()
      let touch = e.changedTouches?.[0]
      if(!touch)return;
        if(e.type == TouchType.Down){ //按下
          this.startX = touch.screenX
          this.startY = touch.screenY
          this.duration = 0 //动画速度归零,否则拖拽时感觉不跟手
        }else if(e.type == TouchType.Up){ //抬起
          this.startX=0;
          this.startY=0;
          this.x = this.initX; //让横坐标复位
          this.duration = 100 //动画速度,否则复位时闪现
          console.log("坐标",this.x,this.y)
        }else if(e.type == TouchType.Move){ //移动
          let t = e.target;
          let pos:Position =t.area.globalPosition;
          let x = touch.screenX
          let y = touch.screenX
          let xDirection = x-this.startX  // 大于0 向右
          let yDirection = y-this.startY  //大于0 向下
          this.x+= xDirection
          this.y+= yDirection
          let posX = pos.x as number
          let posY = pos.y as number
          let tW = t.area.width as number
          let tH = t.area.height as number
          if(xDirection>=0){
            if(posX+tW>=this.maxRight){ //右边界
              this.x=this.maxRight - tW
            }
          }else{
            if(posY<10){
              this.x=10
            }
          }
          if(yDirection>0){ //下边界,这里660显然不是屏幕高度, 可以根据需要设置
            if(posY+tH>this.maxTop-10) {
              this.y = this.maxTop - tH - 10
            }
          }else{
            if(posY<50){
              this.y=50
            }
          }

          this.startX=x;
          this.startY=y;
          console.log("",this.startX,this.startY)
        }
    }).onAreaChange((o:Area,n:Area)=>{
      this.myWidth = n.width as number
    })


  }

  aboutToAppear(){
    this.controller.trigger = ()=>{
      this.x = 365+this.myWidth; //让横坐标复位
      if(this.timer)clearTimeout(this.timer)
      this.timer = setTimeout(()=>{
        this.duration = 300
        this.x = this.initX
      },1000)
    }

  }

}