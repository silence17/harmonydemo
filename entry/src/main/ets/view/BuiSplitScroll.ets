import BuiPage from './BuiPage'

export interface BuiSplitScrollData{

}

@Builder function empty(){}

/**
 * 分左右2栏纵向可滚动容器
 */
@Component
export default struct BuiSplitScroll  {

  /**
   * 左侧宽度
   */
  @State left_width:number = 100;

  @BuilderParam slot_left: () => void =empty;

  @BuilderParam slot_right: () => void =empty;

  build(){
    Row(){
      Column() {
        BuiPage({
          defaultPadding:false,
          slot:()=>{
            this.slot_left()
          }
        })
      }.height('100%').width(this.left_width)
      Column() {
        BuiPage({
          defaultPadding:false,
          slot:()=>{
            this.slot_right()
          }
        })
      }.height('100%').layoutWeight(1)
    }.layoutWeight(1)
  }





}