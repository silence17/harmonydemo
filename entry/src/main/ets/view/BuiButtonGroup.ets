import Constants from '@app/common_lib/src/main/ets/app/Constants';
/**
 * 实现一个 有滑动效果的按钮组
 */

export interface BuiButtonAttribute{
  label:string
  value?:number|string


}


@Component
export default struct BuiButtonGroup {

  @State buttons:Array<BuiButtonAttribute> = [];
  /**
   * 容器背景
   */
  background_color:string=Constants.Color._d7d7d7;
  /**
   * 按钮点击事件
   */
  click:(btn:BuiButtonAttribute,index:number)=>void=()=>{};
  /**
   * 点击前触发
   * return false 则不改变,也不会触发click
   */
  preClick:(btn:BuiButtonAttribute,index:number)=>boolean=()=>{return true};

  @BuilderParam slot:(btn:BuiButtonAttribute,index:number)=>void=this.defaultSlot;

  color:ResourceColor = Constants.Color._85919c
  font_size:number = 12
  activityColor:ResourceColor = Constants.Color._005fbe
  activityFontSize:number = 16
  activityFontWeight:number = FontWeight.Bold


  @State currentIndex:number=0;

  @State currentX:number=0;
  @State currentY:number=0;
  @State currentWidth:number=0;
  @State currentHeight:number=0;

  // 不可点击状态,如果要动态改变,可能需要改成@Link  暂时没有这个需求,只需要初始化的时候设置就好
  @State disable:boolean=false;

  /**
   * 默认样式实现
   * @param btn
   */
  @Builder defaultSlot(btn:BuiButtonAttribute,index:number){
      Column() {
        Text(btn.label)
          .fontColor(this.currentIndex!=index?this.color:this.activityColor)
          .fontSize(this.currentIndex!=index?this.font_size:this.activityFontSize)
          .fontWeight(this.currentIndex!=index?FontWeight.Normal: this.activityFontWeight)
      }.onClick((event:ClickEvent)=>{
        if(this.disable)return;
        if(this.preClick(btn,index)){
          this.currentIndex=index;
          this.currentX=event.target.area.position.x as number;
          this.currentY=event.target.area.position.y as number;
          this.currentWidth=event.target.area.width as number;
          this.currentHeight=event.target.area.height as number;
          this.click(btn,index);
        }
      }).onAreaChange((o:Area,n:Area)=>{
        if(this.currentIndex==index){
            this.currentX=n.position.x as number;
            this.currentY=n.position.y as number;
          this.currentWidth=n.width as number;
          this.currentHeight=n.height as number;
          console.log("btn onAreaChange" , JSON.stringify(n))
        }
      }).padding({top:4,bottom:4,left:10,right:10})
      .layoutWeight(1).alignItems(HorizontalAlign.Center)

  }

  build(){
    Column() {
      //滑动背景层
      if(this.currentWidth) {
        Column() {

        }.position({ x: this.currentX, y: this.currentY })
        .width(this.currentWidth).height(this.currentHeight)
        .borderRadius(8)
        .animation({
          duration: 100,
          curve: Curve.Linear
        }).backgroundColor(Color.White)
      }
      //按钮容器层
      Row({space:5}) {
        ForEach(this.buttons,(item:BuiButtonAttribute,index)=>{
            this.slot(item,index);
        },(item:BuiButtonAttribute,index)=>(item.label+index))
      }

    }
    .backgroundColor(this.background_color)
    .width('100%')
    .padding({top:10,bottom:10,left:10,right:10})
    .borderRadius(4).clip(true)
  }


}