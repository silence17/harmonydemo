import { UserInfo } from '@app/common_lib/src/main/ets/bean/UserInfo';
import { MineMenusComponents } from '../view/MineMenusComponent';
import { UserInfoComponent } from '../view/UserInfoComponent';
import { MineViewModel } from '../viewmodel/MineViewModel';


@Preview
@Component
export struct MinePage {
  @Provide viewModel: MineViewModel = new MineViewModel()
  @StorageLink('cache_user_info_json') userInfo: string = ''

  /**
   * 仅首次创建的时候执行
   */
  aboutToAppear() {
    this.viewModel.initData()
  }

  build() {
    Column() {
      //用户信息
      UserInfoComponent({ userInfo: $userInfo })
      //菜单
      MineMenusComponents()
    }.width('100%')
    .height('100%')
    .align(Alignment.Top)
    .backgroundColor($r('app.color.background_page'))
  }
}