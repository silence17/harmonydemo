import { UserInfo } from '@app/common_lib/src/main/ets/bean/UserInfo';
import { MineMenusComponents } from '../view/MineMenusComponent';
import { UserInfoComponent } from '../view/UserInfoComponent';
import { MineViewModel } from '../viewmodel/MineViewModel';
import { ToastUtil } from '@app/common_lib/src/main/ets/utils/ToastUtil';


@Preview
@Component
export struct MinePage {
  @Provide viewModel: MineViewModel = new MineViewModel()
  @StorageLink('cache_user_info_json') @Watch('onLoginChange') userJson: string = ''
  @State userInfo: number = 0

  onLoginChange() {

    ToastUtil.showToast("==== " + this.userJson)

  }

  /**
   * 仅首次创建的时候执行
   */
  aboutToAppear() {
    this.viewModel.initData()
  }

  build() {
    Column() {

      Text('text:' + this.userInfo).fontSize(30)

      //用户信息
      UserInfoComponent({ userInfo: $userJson })
      //菜单
      MineMenusComponents()
    }.width('100%')
    .height('100%')
    .align(Alignment.Top)
    .backgroundColor($r('app.color.background_page'))
  }
}