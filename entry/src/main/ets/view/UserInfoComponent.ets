import { Log } from '@app/common_lib/src/main/ets/utils/Log/Log'
import media from '@ohos.multimedia.media'
import common from '@ohos.app.ability.common';
import { UserInfoBean } from '@app/common_lib/src/main/ets/bean/UserInfoBean';
import { StringUtil } from '@app/common_lib/src/main/ets/utils/StringUtil';

// @Preview
@Component
export struct UserInfoComponent {
  @Link @Watch('onChange') userInfo: UserInfoBean
  // private userInfo: UserInfoBean = new UserInfoBean()

  onChange() {
    Log.debug("UserInfoComponent.onChange " + this.userInfo.nickName)
  }

  build() {
    //用户信息
    RelativeContainer() {
      Image($r('app.media.ic_user'))
        .objectFit(ImageFit.Contain)
        .height(58)
        .width(58)
        .margin({ left: 10, top: 30 })
        .alignRules({
          top: { anchor: "__container__", align: VerticalAlign.Top },
          left: { anchor: "__container__", align: HorizontalAlign.Start }
        })
        .id("header_img")

      RelativeContainer() {
        if (StringUtil.isEmpty(this.userInfo.token)) {
          this.notLoginView()
        } else {
          this.loginView()
        }
      }
      .height('100%')
      .alignRules({
        top: { anchor: "__container__", align: VerticalAlign.Top },
        bottom: { anchor: "__container__", align: VerticalAlign.Bottom },
        left: { anchor: "header_img", align: HorizontalAlign.End },
        right: { anchor: "icon_setting", align: HorizontalAlign.Start },
      })
      .id('change_container')

      Image($r('app.media.icon_setting'))
        .size({ width: 40, height: 40 })
        .padding(9)
        .align(Alignment.Top)
        .id('icon_setting')
        .alignRules({
          right: { anchor: '__container__', align: HorizontalAlign.End },
          top: { anchor: '__container__', align: VerticalAlign.Top }
        })
    }
    .size({ width: '100%', height: 120 })
    .backgroundBlurStyle(BlurStyle.Thin)
  }


  /**
   * 登陆状态
   */
  @Builder loginView() {
    Text(this.userInfo.nickName)
      .fontSize(18)
      .fontColor('#333333')
      .margin({ left: 12, top: 46 })
      .fontWeight(FontWeight.Medium)
      .align(Alignment.Center)
      .alignRules({
        left: { anchor: '__container__', align: HorizontalAlign.Start },
        top: { anchor: '__container__', align: VerticalAlign.Top },
      })
      .id('login_nickname')
  }

  /**
   * 未登陆状态
   */
  @Builder notLoginView() {
    Row() {
      Text('登陆/注册')
        .fontSize(16)
        .fontColor('#333333')
        .margin({ left: 12 })
        .align(Alignment.Center)
        .onClick((event) => {
          this.jumpToLoginAbility()
        })
      Image($r('app.media.icon_right_arrow'))
        .width(7)
        .height(11)
        .margin({ left: 5 })
    }.alignRules({
      left: { anchor: '__container__', align: HorizontalAlign.Start },
      top: { anchor: '__container__', align: VerticalAlign.Top },
    })
    .margin({ top: 46 })
    .id('not_login')
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