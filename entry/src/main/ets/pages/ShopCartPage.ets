import { ShopCartViewModel } from '../viewmodel/ShopCartViewModel'

@Preview
@Component
export struct ShopCartPage {
  @State viewModel: ShopCartViewModel = new ShopCartViewModel()

  build() {
    Column() {



      Image($r('app.media.bg_shopcart'))
        .width('100%')
        .height(70)



    }.width('100%')
    .height('100%')
    .backgroundColor('#fff6f6f6')
  }
}