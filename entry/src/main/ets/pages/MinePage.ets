import { UserInfoBean } from '@app/common_lib/src/main/ets/bean/UserInfoBean';
import { UserInfoComponent } from '../view/UserInfoComponent';
import { MineMenusComponent } from '../view/MineMenusComponent';
import { MineViewModel } from '../viewmodel/MineViewModel';
import { StringUtil } from '@app/common_lib/src/main/ets/utils/StringUtil';
import { CACHE_USER_INFO, GlobalConstant } from '@app/common_lib/src/main/ets/app/GlobalConstant';
import { Log, UserUtil } from '@app/common_lib';

/**
 * @Provide和@Consume可以通过相同的变量名或者相同的变量别名绑定，变量类型必须相同。
 */
@Preview
@Component
export struct MinePage {
  @StorageProp(CACHE_USER_INFO) @Watch('onLoginChange') userJson: string = ''
  @State viewModel: MineViewModel = new MineViewModel()
  @State userInfo: UserInfoBean = new UserInfoBean()

  onLoginChange() {
    Log.debug('login change info: ' + this.userJson)
    if (StringUtil.isEmpty(this.userJson)) {
      this.userInfo = new UserInfoBean()
    } else {
      this.userInfo = (JSON.parse(this.userJson)) as UserInfoBean
    }
    UserUtil.getInstance().setUserInfo(this.userInfo)
  }

  /**
   * 组件的声明周期 @Component
   * 仅首次创建的时候执行
   */
  aboutToAppear() {
    setTimeout(() => {
      this.onLoginChange()
    }, 1500);
    this.viewModel.initData()
  }

  build() {

    Stack() {
      Image($r('app.media.bg_top_bg'))
        .width('100%')

      Column() {
        //用户信息
        UserInfoComponent({ userInfo: $userInfo })
        //菜单
        MineMenusComponent({ viewModel: $viewModel })
      }.width('100%')
      .height('100%')
      .align(Alignment.TopStart)
    }.width('100%')
    .height('100%')
    .backgroundColor('#F3F4F5')
    .alignContent(Alignment.TopStart)
  }
}