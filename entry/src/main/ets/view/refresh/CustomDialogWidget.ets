export interface HobbyBean {
  label: string;
  isChecked: boolean;
}

export type DataItemType = { value: string }

@Extend(Button) function dialogButtonStyle() {
  .fontSize(16)
  .fontColor("#007DFF")
  .layoutWeight(1)
  .backgroundColor(Color.White)
  .width(500)
  .height(40)
}

@CustomDialog
export default struct CustomDialogWidget {
  @State hobbyBeans: HobbyBean[] = [];

  @Prop title:string;
  @Link hobbyResult: Array<DataItemType>;
  @Link hobbies: string;
  private controller: CustomDialogController;

  setHobbiesValue(hobbyBeans: HobbyBean[]) {
    let hobbiesText: string = '';
    hobbiesText = hobbyBeans.filter((isCheckItem: HobbyBean) =>
    isCheckItem?.isChecked)
      .map((checkedItem: HobbyBean) => {
        return checkedItem.label;
      }).join(',');
    this.hobbies = hobbiesText;
  }

  aboutToAppear() {
    // let context: Context = getContext(this);
    // let manager = context.resourceManager;
    // manager.getStringArrayValue($r('app.strarray.hobbies_data'), (error, hobbyResult) => {
    // });
    this.hobbyResult.forEach(item => {
      const hobbyBean = {
        label: item.value,
        isChecked: this.hobbies?.includes(item.value)
      }
      this.hobbyBeans.push(hobbyBean);
    });
  }
  build() {
    Column() {
      Text(this.title || "兴趣爱好")
        .fontWeight(FontWeight.Bold)
        .alignSelf(ItemAlign.Start)
        .margin({ left: 24, bottom: 12 })
      List() {
        ForEach(this.hobbyBeans, (itemHobby: HobbyBean) => {
          ListItem() {
            Row() {
              Text(itemHobby.label)
                .fontSize(16)
                .fontColor("#182431")
                .layoutWeight(1)
                .textAlign(TextAlign.Start)
                .fontWeight(500)
                .margin({ left: 24 })
              Toggle({ type: ToggleType.Checkbox, isOn: itemHobby.isChecked })
                .margin({
                  right: 24
                })
                .onChange((isCheck) => {
                  itemHobby.isChecked = isCheck;
                })
            }
          }
          .height(36)
        }, itemHobby => itemHobby.label)
      }
      .margin({
        top: 6,
        bottom: 8
      })
      .divider({
        strokeWidth: 0.5,
        color: "#0D182431"
      })
      .listDirection(Axis.Vertical)
      .edgeEffect(EdgeEffect.None)
      .width("100%")
      .height('30%')

      Row({
        space: 20
      }) {
        Button("关闭")
          .dialogButtonStyle()
          .onClick(() => {
            this.controller.close();
          })
        Blank()
          .backgroundColor("#F2F2F2")
          .width(1)
          .opacity(1)
          .height(25)
        Button("保存")
          .dialogButtonStyle()
          .onClick(() => {
            this.setHobbiesValue(this.hobbyBeans);
            this.controller.close();
          })
      }
    }
    .width("93.3%")
    .padding({
      top: 14,
      bottom: 16
    })
    .borderRadius(32)
    .backgroundColor(Color.White)
  }
}

@Entry
@Component
struct HomePage {
  @State hobbies: string = '';
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

  build() {
    Column() {
      Button('打开自定义弹窗')
        .width('60%')
        .margin({top: 50})
        .zIndex(999)
        .onClick(()=>{
          if (this.customDialogController != undefined) {
            this.customDialogController.open()
          }
        })
      Text(this.hobbies).fontSize(16).padding(24)
    }
    .width('100%')
  }
}