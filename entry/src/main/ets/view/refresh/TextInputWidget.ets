@Component
export default struct TextInputWidget {
  private inputImage?: Resource;
  private hintText?: ResourceStr;
  @Link textVal: string;
  @Prop state: boolean;

  onChange(val) {
    this.textVal = val
  }

  build() {
    Row() {
      Image(this.inputImage !== undefined ? this.inputImage : '')
        .width($r('app.float.input_image_size'))
        .height($r('app.float.input_image_size'))
        .margin({ left: $r('app.float.input_image_left') })
      if(this.state) {
        Text(this.textVal).textAlign(TextAlign.End).padding({ left: $r('app.float.input_left_inside') })
      } else {
        TextInput({ placeholder: this.hintText, text: this.textVal })
          .fontSize($r('app.float.input_text_size'))
          .padding({ left: $r('app.float.input_left_inside') })
          .placeholderColor("#99000000")
          .backgroundColor(Color.White)
          .fontWeight(FontWeight.Normal)
          .fontStyle(FontStyle.Normal)
          .fontColor(Color.Black)
          .margin({ right: $r('app.float.input_right_inside') })
          .layoutWeight(1)
          .height($r('app.float.text_input_height'))
          .onChange((val: string) => this.onChange(val))
      }
    }
    .margin({ top: $r('app.float.input_row_top') })
    .borderRadius($r('app.float.input_row_radius'))
    .backgroundColor(Color.White)
    .width('93.3%')
    .height($r('app.float.input_row_height'))
  }
}