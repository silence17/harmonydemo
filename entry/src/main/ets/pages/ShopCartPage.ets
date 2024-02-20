import { UserUtil } from '../util/UserUtil'
import { ShopCartViewModel } from '../viewmodel/ShopCartViewModel'
import { ShopBean } from '../bean/ShopCartBean'

@Preview
@Component
export struct ShopCartPage {
  @State viewModel: ShopCartViewModel = new ShopCartViewModel()

  aboutToAppear() {
    this.viewModel.init()
    if (UserUtil.getInstance().isLogin()) {
      this.viewModel.getShopCartList()
    }
  }

  build() {
    Column() {
      Image($r('app.media.bg_shopcart'))
        .width('100%')
        .height(70)
        .onClick(() => {
          this.viewModel.getShopCartList()
        })

      List() {
        //List ForEach 循环加载
        LazyForEach(this.viewModel.shopCartBean, (item: ShopBean) => {
          ListItem() {

            Text('======' + item.shopName)

          }.backgroundColor('#F6F6F6')
        })

      }.width('100%')
      .layoutWeight(1)
    }.width('100%')
    .height('100%')
    .backgroundColor('#fff6f6f6')
  }
}