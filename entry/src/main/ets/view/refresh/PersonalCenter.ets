import Context from '@ohos.app.ability.common';
import router from '@ohos.router';
import CustomDialogWidget, { DataItemType } from './CustomDialogWidget';
import TextCommonWidget from './TextCommonWidget';
import TextInputWidget from './TextInputWidget';
import userInfoStrong from './preferencesStrong'
import { CommonUtils } from './DialogUtils';

interface userInfoType {
  name: string;
  sex: string;
  sign: string;
  date: string;
  hobbies: string;
}

@Entry
@Component
struct PersonalCenter {
  @State birthdate: string = '';
  @State sex: string = '';
  @State hobbies: string = '';
  private sexArray: Resource = $r('app.strarray.sex_array');
  @State hobbyResult: Array<DataItemType> = [
    {
      "value": "FaceBook"
    },
    {
      "value": "Google"
    },
    {
      "value": "Instagram"
    },
    {
      "value": "Twitter"
    },
    {
      "value": "Linkedin"
    }
  ]

  private userInfo: userInfoType = {
    name: 'Allin',
    sex: 'man',
    sign: '个性签名',
    date: '1993.06.08',
    hobbies: '',
  }
  @State private title: string = '常用网站'
  customDialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogWidget({
      hobbies: $hobbies,
      hobbyResult: $hobbyResult,
      title: this.title
    }),
    alignment: DialogAlignment.Bottom,
    customStyle: true,
    offset: { dx: 0,dy: -20 }
  });

  saveDataToStrong(key, value) {
    this.userInfo[key] = value;
    userInfoStrong.putPreference("userInfo", JSON.stringify(this.userInfo))
  }

  aboutToAppear() {
    let date = new Date();
    let year = date.getFullYear();
    let month = date.getMonth() + 1;
    let day = date.getDate();
    this.birthdate = CommonUtils.getBirthDateValue(year, month, day);

    // userInfoStrong.putPreference("userInfo", JSON.stringify(this.userInfo))

    this.userInfo = {
      name: this.nickname,
      sex: this.sex,
      sign: this.signature,
      date: this.birthdate,
      hobbies: this.hobbies,
    }

    userInfoStrong.getPreference('userInfo').then((res) => {
      // @ts-ignore
      this.userInfo = res && JSON.parse(res) as userInfoType

      this.nickname = this.userInfo.name;
      this.sex = this.userInfo.sex;
      this.signature = this.userInfo.sign;
      this.birthdate = this.userInfo.date;
      this.hobbies = this.userInfo.hobbies;
    })
  }
  @State isEdit: boolean = false
  @State nickname: string = '张三'
  @State signature: string = '个性签名'

  build() {
    Column() {
      Row() {
        Row() {
          Text("个人中心")
            .height($r('app.float.image_back_size'))
            .margin({
              left: '7.2%',
              top: '5.5%'
            })
            .onClick(() => {
              router.pushUrl({
                url: 'testPage/PerformanceStatistics'
              })
            })
        }
        Row() {
          if(!this.isEdit) {
            Image($r('app.media.ic_public_edit'))
              .width($r('app.float.image_back_size'))
              .height($r('app.float.image_back_size'))
              .margin({
                right: '7.2%',
                top: '5.5%'
              })
              .onClick(() => {
                this.isEdit = true
              })
          } else {
            Image($r('app.media.ic_public_ok'))
              .width($r('app.float.image_back_size'))
              .height($r('app.float.image_back_size'))
              .margin({
                right: '7.2%',
                top: '5.5%'
              })
              .onClick(() => {
                // let context = getContext(this) as Context.UIAbilityContext;
                // CommonUtils.alertDialog(context);
                this.isEdit = false

                this.userInfo = {
                  name: this.nickname,
                  sex: this.sex,
                  sign: this.signature,
                  date: this.birthdate,
                  hobbies: this.hobbies,
                }
                userInfoStrong.putPreference('userInfo', JSON.stringify(this.userInfo))
              })
          }
        }
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width("100%")
      Stack() {
        Image($r('app.media.bg'))
          .width("100%")
          .margin({
            left: -60,
            right: -60
          })
          .height(200)
          .alignSelf(ItemAlign.Center)
          .padding(12)
          .objectFit(ImageFit.Contain)
        Column() {
          Image($r('app.media.snowflake'))
            .width(96)
            .height(96)
            .alignSelf(ItemAlign.Center)
            .margin({ top: '5.5%' })
            .borderWidth(3)
            .borderRadius(80)
            .borderColor(Color.Pink)
            .padding(12)
            .backgroundColor(Color.White)
          Text($r('app.string.text_personal_title'))
            .fontColor(Color.Black)
            .fontSize($r('app.float.personal_font_size'))
            .margin({ top: '2.1%' })
            .alignSelf(ItemAlign.Center)
        }
      }
      TextInputWidget({
        inputImage: $r('app.media.ic_nickname'),
        hintText: '请输入昵称',
        textVal: $nickname,
        state: this.isEdit ? false : true
      })
      TextCommonWidget({
        textImage: $r('app.media.ic_birthdate'),
        title: $r('app.string.module_desc'),
        content: $birthdate,
        onItemClick: () => {
          this.isEdit && CommonUtils.datePickerDialog((birthValue: string) => {
            this.birthdate = birthValue;
          });
        }
      })
      TextCommonWidget({
        textImage: $r('app.media.ic_sex'),
        title: $r('app.string.title_sex'),
        content: $sex,
        onItemClick: () => {
          this.isEdit && CommonUtils.textPickerDialog(this.sexArray, (sexValue: string) => {
            this.sex = sexValue;
          });
        }
      })
      TextInputWidget({
        inputImage: $r('app.media.ic_signature'),
        textVal: $signature,
        hintText: $r('app.string.text_input_signature'),
        state: this.isEdit ? false : true,
      })
      TextCommonWidget({
        textImage: $r('app.media.ic_hobbies'),
        title: $r('app.string.title_hobbies'),
        content: $hobbies,
        onItemClick: () => {
          if(this.isEdit) {
            this.customDialogController.open()
          }
        }
      })
    }
    .backgroundColor('#F5F5F5')
    .width("100%")
    .height('100%')
  }
}

export {
  PersonalCenter
}