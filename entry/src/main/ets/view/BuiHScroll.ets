@Builder function empty(){}
/**
 * 一横能横向滚动的 组件
 */
@Component
export default struct BuiHScroll {
  /**
   * 各子项之间的距离
   */
  @State space:number = 1;

  scroller:Scroller = new Scroller();

  @BuilderParam slot: () => void =empty;


  build(){
    Scroll(this.scroller){
      Row({space:this.space}){
        this.slot();
      }.constraintSize({minWidth:'100%'})
    }
    .scrollable(ScrollDirection.Horizontal) // 滚动方向纵向
    .edgeEffect(EdgeEffect.None)
    .width('100%')
    .scrollBarWidth(1)
    .scrollBarColor("rgba(0,0,0,0.01)")
  }

}
