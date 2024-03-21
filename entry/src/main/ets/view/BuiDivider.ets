import Constants from '@app/common_lib/src/main/ets/app/Constants';

@Preview
@Component
export default struct BuiDivider {
  @State color:string=Constants.Color._85919c;
  build() {
    Column().margin({top:2,bottom:2}).shadow({
      color:this.color,
      radius:180,
      offsetY:10
    }).width('100%').height("1px").backgroundColor(this.color).opacity(0.3)
      .scale({y:0.3})
  }
}