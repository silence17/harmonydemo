import { ToastUtil } from '@app/common_lib/src/main/ets/utils/ToastUtil'
import { ItemBean } from '../bean/ItemBean'
import { MineViewModel } from '../viewmodel/MineViewModel'
import { CACHE_USER_INFO } from '@app/common_lib/src/main/ets/app/GlobalConstant'
import { UserUtil } from '../util/UserUtil'
import { UserInfoBean } from '@app/common_lib/src/main/ets/bean/UserInfoBean'
import display from '@ohos.display'
import { IconBean } from '../bean/IconBean'

/**
 * 我的， 菜单组件
 */
@Component
export struct MineMenusComponent {
  @Link viewModel: MineViewModel
  private screenWidth: number = px2vp(display.getDefaultDisplaySync().width)

  aboutToAppear() {
  }

  build() {
    List({ space: 10 }) {
      ListItem() {
        Column() {
          Row() {
            Text('企业会员中心')
              .fontSize(15)
              .fontColor('#8C7111')
              .layoutWeight(1)
              .constraintSize({ minHeight: 22 })

            Text('全部')
              .fontWeight(FontWeight.Medium)
              .fontSize(15)
              .fontColor('#999999')
              .constraintSize({ minHeight: 22 })
            Image($r('app.media.icon_arrow2'))
              .width(12)
              .height(22)
              .margin({ left: 5 })
                // 保持原有尺寸显示。
              .objectFit(ImageFit.None)
          }
          .backgroundImage($r('app.media.bg_mine_svip'))
          .backgroundImageSize({ width: '100%', height: '100px' })
          .justifyContent(FlexAlign.SpaceBetween)
          .width('100%')
          .padding({ left: 10, right: 10, top: 4 })
          .height(50)
          .alignItems(VerticalAlign.Top)

          this.initOrderLayout()
        }
        .margin({ left: 10, right: 10 })
      }

      ForEach(this.viewModel.getMenusList(), (item: ItemBean) => {
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
    .margin({ left: 10, right: 10 })
    .width('100%')
    .height('100%')
  }

  @Builder initOrderLayout() {
    Column() {
      Row() {
        Text('企业订单')
          .fontWeight(FontWeight.Medium)
          .fontSize(15)
          .fontColor('#333333')
          .layoutWeight(1)

        Text('全部')
          .fontWeight(FontWeight.Medium)
          .fontSize(15)
          .fontColor('#999999')
        Image($r('app.media.icon_right_arrow'))
          .width(7)
          .height(11)
          .margin({ left: 5 })
      }.margin({ left: 10, right: 10 })

      List() {
        ForEach(this.viewModel.orderStatusList, (item: IconBean) => {
          ListItem() {
            Column() {
              Image(item.iconUrl)
                .width(28)
                .height(28)

              Text(item.content)
                .fontColor('#666666')
                .fontSize(12)
                .margin({ top: 4 })
            }
          }.width((1 / this.viewModel.orderStatusList.length) * 100 + '%')
        })
      }.listDirection(Axis.Horizontal)
      .height(50)
      .margin({ top: 10 })
      .width('100%')
    }
    .height(108)
    .border({ radius: 10 })
    .backgroundColor(Color.White)
    .margin({ top: -20 })
    .padding({ top: 14, bottom: 14 })
  }
}