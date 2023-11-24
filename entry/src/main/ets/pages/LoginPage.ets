import {
  ClearEditText,
  CommonTitleComponent,
  Log,
  PreferencesUtil,
  StringUtil,
  ToastUtil,
  UserInfo
} from '@app/common_lib'
import promptAction from '@ohos.promptAction'
import display from '@ohos.display'
import { LoginViewModel } from '../viewmodel/LoginViewModel'
import router from '@ohos.router'


@Entry
@Component
struct LoginPage {
  @State isRefreshData: boolean = false
  @State btnColor: string = '#991890FF'
  @State phone: string = '15204697356'
  @State pwd: string = ''
  //获取屏幕的宽度
  screenWidth: number = px2vp(display.getDefaultDisplaySync().width)
  @Provide viewModel: LoginViewModel = new LoginViewModel()

  /**
   * 每次可见时回调
   */
  onPageShow() {
    PreferencesUtil.getInstance().getString("cellphone").then((result) => {
      this.phone = result
    })
  }

  build() {
    Column() {
      //title
      CommonTitleComponent({ title: $r('app.string.login_title'), callback: () => {
        //todo
      } })

      Image($r('app.media.ic_user'))
        .objectFit(ImageFit.Contain)
        .height(60)
        .width(60)

      Text('欢迎使用蜂采优选')
        .fontColor('#333333')
        .fontSize(22)
        .margin({ top: 10 })

      Row() {
        Text('没有账号?')
          .fontColor('#333333')
          .fontSize(13)
        Text('立即注册')
          .fontColor('#1890FF')
          .fontSize(13)
          .margin({ left: 5 })
          .onClick(() => {
            promptAction.showToast({
              message: '立即注册',
              duration: 2000
            })
          })
      }.margin({ top: 5 })

      ClearEditText({
        content: $phone,
        inputType: InputType.PhoneNumber,
        maxLength: 11,
        hintText: '请输入手机号码',
        onChange: (value: string) => {
          this.phone = value
          this.getBtnBackground()
        }
      })
        .height(45)
        .width('100%')
        .margin({ top: 30 })
      Line()
        .height(0.5)
        .stroke('#D1D1D1')
        .startPoint([0, 0])
        .endPoint([Math.round((this.screenWidth) - 30), 0])
      ClearEditText({ content: $pwd, inputType: InputType.Password, hintText: '请输入密码',
        onChange: (value: string) => {
          this.pwd = value
          this.getBtnBackground()
        } })
        .height(45)
        .width('100%')
      Line()
        .height(0.5)
        .stroke('#D1D1D1')
        .startPoint([0, 0])
        .endPoint([Math.round((this.screenWidth) - 30), 0])

      Button('登陆')
        .width(this.screenWidth - 30)
        .height(44)
        .margin({ top: 15 })
        .backgroundColor(this.btnColor)
        .id('login')
        .onClick((event) => {
          this.viewModel.login(this.phone, this.pwd)
        })

      Text('忘记密码')
        .fontColor('#999999')
        .fontSize(13)
        .padding({ top: 5, bottom: 5 })
        .margin({ top: 5, bottom: 10 })
        .onClick(() => {
          ToastUtil.showToast('忘记密码')
        })

      Row() {
        Image($r('app.media.ic_selected_srm_style1'))
          .width(23)
          .height(23)
        Text('我已阅读并同意')
          .fontSize(13)
          .fontColor('#999999')
          .margin({ left: 5 })
        Text('服务协议、')
          .fontSize(13)
          .fontColor('#1890FF')
          .onClick(() => {
            promptAction.showToast({
              message: '服务协议',
              duration: 2000
            })
          })
        Text('隐私权政策')
          .fontSize(13)
          .fontColor('#1890FF')
          .onClick(() => {
            promptAction.showToast({
              message: '隐私权政策',
              duration: 2000
            })
          })
      }
    }
    .height('100%')
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding({ left: 15, right: 15 })
    .justifyContent(FlexAlign.Start)
  }

  getBtnBackground() {
    this.btnColor =
      (StringUtil.isEmpty(this.phone) || StringUtil.isEmpty(this.pwd)) ? '#991890FF' : '#1890FF'
  }
}