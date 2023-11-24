import promptAction from '@ohos.promptAction'
import { ItemBean } from '../bean/ItemBean'
import { MineViewModel } from '../viewmodel/MineViewModel'

@Component
export struct MineMenusComponents {
  @Consume viewModel: MineViewModel

  build() {

    List({ space: 10 }) {
      ForEach(this.viewModel.listSource, (item: ItemBean) => {

        ListItem() {
          Row() {
            if (item.icon != null) {
              Image(item?.icon).width(23).height(23).margin({ right: 6 })
            }
            Text(item.title).fontSize(12).fontColor('#333333')
            Blank().layoutWeight(1)
            if (item.rightIcon != null) {
              Image(item.rightIcon).width(7).height(11)
            }
          }
          .width('100%')
          .height(45)
          .padding({ left: 10, right: 10 })
        }
        .borderRadius(12)
        .margin({ left: 10, right: 10 })
        .backgroundColor(Color.White)
        .onClick((event) => {
          promptAction.showToast({
            message: "List Item Click",
            duration: 2000
          })
        })
      }, (item: ItemBean) => JSON.stringify(item))
    }
    .width('100%')
    .height('50%')
  }
}