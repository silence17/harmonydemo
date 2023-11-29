import { UserInfoBean } from '@app/common_lib/src/main/ets/bean/UserInfoBean';
import { MineMenusComponents } from '../view/MineMenusComponent';
import { UserInfoComponent } from '../view/UserInfoComponent';
import { MineViewModel } from '../viewmodel/MineViewModel';
import { ToastUtil } from '@app/common_lib/src/main/ets/utils/ToastUtil';
import { StringUtil } from '@app/common_lib/src/main/ets/utils/StringUtil';

@Preview
@Component
export struct MinePage {
  @Provide viewModel: MineViewModel = new MineViewModel()
  @StorageProp('cache_user_info_json') @Watch('onLoginChange') userJson: string = ''
  @State userInfo: UserInfoBean = new UserInfoBean()

  onLoginChange() {
    if (!StringUtil.isEmpty(this.userJson)) {
      this.userInfo = JSON.parse(this.userJson)
    }
  }

  /**
   * 仅首次创建的时候执行
   */
  aboutToAppear() {
    setTimeout(() => {
      this.onLoginChange()
    }, 1500);
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