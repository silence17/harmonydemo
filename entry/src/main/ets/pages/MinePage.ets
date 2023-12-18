import { UserInfoBean } from '@app/common_lib/src/main/ets/bean/UserInfoBean';
import { MineMenusComponents } from '../view/MineMenusComponent';
import { UserInfoComponent } from '../view/UserInfoComponent';
import { MineViewModel } from '../viewmodel/MineViewModel';
import { StringUtil } from '@app/common_lib/src/main/ets/utils/StringUtil';
import { CACHE_USER_INFO, GlobalConstant } from '@app/common_lib/src/main/ets/app/GlobalConstant';
import { Log } from '@app/common_lib';

@Preview
@Component
export struct MinePage {
  @Provide viewModel: MineViewModel = new MineViewModel()
  @StorageProp(CACHE_USER_INFO) @Watch('onLoginChange') userJson: string = ''
  @State userInfo: UserInfoBean = new UserInfoBean()

  onLoginChange() {
    Log.debug('login change info: ' + this.userJson)
    if (StringUtil.isEmpty(this.userJson)) {
      this.userInfo = new UserInfoBean()
    } else {
      this.userInfo = (JSON.parse(this.userJson)) as UserInfoBean
    }
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
        MineMenusComponents()
      }.width('100%')
      .height('100%')
      .align(Alignment.TopStart)
    }.width('100%')
    .height('100%')
    .backgroundColor('#F3F4F5')
    .alignContent(Alignment.TopStart)
  }
}