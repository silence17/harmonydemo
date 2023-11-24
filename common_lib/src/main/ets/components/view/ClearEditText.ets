//用@Preview装饰的自定义组件可以在DevEco Studio的预览器上进行实时预览，加载页面时，将创建并显示@Preview装饰的自定义组件。
@Preview
@Component
export struct ClearEditText {
  @Link content: string
  @State isEmpty: boolean = true
  //键盘类型
  inputType: InputType = InputType.Normal
  maxLength: number = 65535
  //默认文本
  hintText: string = ''
  //定义回调函数
  onChange?: Function = (value: string) => {
  }

  build() {
    Row() {
      TextInput({ text: this.content, placeholder: this.hintText })
        .height('100%')
        .placeholderColor('#CBCBCB')
        .fontSize(16)
        .type(this.inputType)
        .maxLength(this.maxLength)
        .showPasswordIcon(true)
        .backgroundColor(Color.Transparent)
        .layoutWeight(1)
        .padding({ left: 0, right: 10 })
        .onChange((value: string) => {
          this.isEmpty = (value === null || value.length === 0)
          if (this.onChange != null) {
            this.onChange(value)
          }
        })

      if (!this.isEmpty) {
        Image($r('app.media.icon_close'))
          .height('100%')
            //设置组建的宽高比，aspectRatio = width/height
          .aspectRatio(1)
          .padding(15)
          .onClick(() => {
            this.content = ''
          })
      }
    }
    .height(45)
    .width('100%')
  }
}