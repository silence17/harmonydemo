import { Log } from '@app/common_lib/src/main/ets/utils/Log/Log'
import media from '@ohos.multimedia.media'
import common from '@ohos.app.ability.common';
import { UserUtil } from '../util/UserUtil';
import { UserInfoBean } from '@app/common_lib/src/main/ets/bean/UserInfoBean';
import { StringUtil } from '@app/common_lib/src/main/ets/utils/StringUtil';


@Component
export struct UserInfoComponent {
  @Link @Watch('onChange') userInfo: UserInfoBean

  onChange() {
    Log.debug("UserInfoComponent.onChange " + this.userInfo.nickName)
  }

  build() {
    //用户信息
    Row() {
      Image($r('app.media.ic_user'))
        .objectFit(ImageFit.Contain)
        .height(58)
        .width(58)
        .margin({ left: 10 })
        .width(66)

      if (StringUtil.isEmpty(this.userInfo.token)) {
        this.notLoginView()
      } else {
        this.loginView()
      }

      Blank().layoutWeight(1)
      Image($r('app.media.icon_setting'))
        .size({ width: 53, height: 53 })
        .padding(15)
        .align(Alignment.Top)
      // .alignRules({
      //   right: { anchor: '__container__', align: HorizontalAlign.End },
      //   top: { anchor: '__container__', align: VerticalAlign.Top }
      // })
    }
    .size({ width: '100%', height: 120 })
    .padding({ top: 20, bottom: 20 })
    .backgroundBlurStyle(BlurStyle.Thin)
    .alignItems(VerticalAlign.Center)
  }


  /**
   * 登陆状态
   */
  @Builder loginView() {
    Text(this.userInfo.nickName)
      .fontSize(18)
      .fontColor('#000000')
      .margin({ left: 12 })
      .align(Alignment.Center)
  }

  /**
   * 未登陆状态
   */
  @Builder notLoginView() {
    Text('登陆/注册')
      .fontSize(18)
      .fontColor('#000000')
      .margin({ left: 12 })
      .align(Alignment.Center)
      .onClick((event) => {
        this.jumpToLoginAbility()
      })
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