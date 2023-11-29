import { ToastUtil } from '@app/common_lib/src/main/ets/utils/ToastUtil'
import promptAction from '@ohos.promptAction'
import { ItemBean } from '../bean/ItemBean'
import { MineViewModel } from '../viewmodel/MineViewModel'
import { CACHE_USER_INFO } from '@app/common_lib/src/main/ets/app/GlobalConstant'
import { UserUtil } from '../util/UserUtil'
import { UserInfoBean } from '@app/common_lib/src/main/ets/bean/UserInfoBean'

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
          switch (item.id) {
            case 3:
            //登陆成功回调
              UserUtil.getInstance().setUserInfo(new UserInfoBean())
              AppStorage.Set<string>(CACHE_USER_INFO, '');
              ToastUtil.showToast('退出登陆成功')
              break;
            default:
              ToastUtil.showToast("===== " + item.title)
              break;
          }
        })
      }, (item: ItemBean) => JSON.stringify(item))
    }
    .width('100%')
    .height('50%')
  }
}