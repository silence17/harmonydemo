import { Log } from '@app/common_lib/src/main/ets/utils/Log/Log'
import media from '@ohos.multimedia.media'
import common from '@ohos.app.ability.common';
import { UserUtil } from '../util/UserUtil';
import { UserInfoBean } from '@app/common_lib/src/main/ets/bean/UserInfoBean';


@Component
export struct UserInfoComponent {
  @Link @Watch('onChange') userInfo: UserInfoBean
  @State nickName: string = '登陆/注册'

  onChange() {
    if (UserUtil.getInstance().isLogin()) {
      this.nickName = this.userInfo.nickName
    } else {
      this.nickName = '登陆/注册';
    }
    Log.debug("UserInfoComponent.onChange ", this.userInfo.nickName)
  }

  build() {
    //用户信息
    Row() {
      Image($r('app.media.ic_user'))
        .objectFit(ImageFit.Contain)
        .height('100%')
        .margin({ left: 10 })
        .width(66)

      Text(this.nickName)
        .fontSize(18)
        .fontColor('#000000')
        .margin({ left: 12 })
        .height('100%')
        .align(Alignment.Center)
        .onClick((event) => {
          this.jumpToLoginAbility()
        })
      Blank().layoutWeight(1)
      Image($r('app.media.icon_setting'))
        .size({ width: 53, height: 53 })
        .padding(15)
    }
    .size({ width: '100%', height: 150 })
    .backgroundBlurStyle(BlurStyle.Thin)
    .alignItems(VerticalAlign.Top)
  }

  jumpToLoginAbility() {
    let wantInfo = {
      bundleName: 'com.example.rankdemo',
      //待启动的UIAbility
      abilityName: 'LoginAbility',
      //moduleName在待启动的UIAbility属于不同的Module时添加
      parameters: {
        info: '来自EntryAbility Index页面'
      },
    }
    //context为调用方UIAbility的AbilityContext
    let context = getContext(this) as common.UIAbilityContext;
    context.startAbility(wantInfo).then(() => {
      Log.debug('%{public}s' + 'startAbility');
    }).catch((err) => {

    });
  }
}