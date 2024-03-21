/**
 * 可以展开和收缩内容区域的面板组件
 * 收缩状态下的面板内容区域会被隐藏, 展开状态下会显示
 * 面板分上下两部分, 上部分为面板标题, 下部分为面板内容区域
 */

@Builder function empty(){}

@Component
export default struct BuiTogglePanel{
  /**
   * 展示 箭头图标
   */
  @State showHandler:boolean = true;

  @State handlerIcon:Resource = $r("app.media.navbar_back");

  @State topBgColor:string = "#ccc";

  @State bottomBgColor:string = "#7c7c7c";

  @State duration:number = 10;
  /**
   * 默认状态 false 只展示面板标题
   */
  @State toggleState:boolean = false;
  /**
   * 标题区域
   */
  @BuilderParam slot_title:()=>void=empty ;
  /**
   * 内容区域
   */
  @BuilderParam slot_content:()=>void=empty ;

  build(){
    Column(){
      Row(){

        Column(){
          if(this.slot_title)this.slot_title();
        }.layoutWeight(1).align(Alignment.Center)

        Column(){
          Image(this.handlerIcon).interpolation(ImageInterpolation.Low).rotate({angle:this.toggleState?90:270}).width(20).height(20).animation({duration:20})
        }.visibility(this.showHandler?Visibility.Visible:Visibility.None).align(Alignment.Center)
        .alignItems(HorizontalAlign.Center)
        .constraintSize({maxHeight:100,maxWidth:100})
        .onClick(()=>{
          this.toggleState =!this.toggleState;
        })
      }
      .width('100%')
      .backgroundColor(this.topBgColor)
      .padding({
        top:4,
        bottom: 4,
        left: 16,
        right: 16
      })
      .constraintSize({maxHeight:100})
      .onClick(()=>{
        this.toggleState = !this.toggleState;
      })

      Column(){
        if(this.slot_content)this.slot_content();
      }.visibility(this.toggleState?Visibility.Visible:Visibility.None)
      .opacity(this.toggleState?1:0).animation({duration:this.duration})
      .width('100%')
      .backgroundColor(this.bottomBgColor)

    }.width('100%').borderRadius(2).clip(true)
  }

}