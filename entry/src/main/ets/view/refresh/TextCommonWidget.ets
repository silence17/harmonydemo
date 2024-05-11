@Component
export default struct TextCommonWidget {
  @Link content: string;
  private textImage?: Resource;
  private title?: Resource;
  onItemClick = () => {};

  build() {
    Row() {
      Image(this.textImage !== undefined ? this.textImage : '')
        .width($r('app.float.text_image_size'))
        .height($r('app.float.text_image_size'))
        .margin({ left: $r('app.float.image_left_distance') })
      Text(this.title)
        .fontSize($r('app.float.text_size'))
        .margin({ left: $r('app.float.image_left_distance') })
        .height("100%")
      Text(this.content)
        .fontSize($r('app.float.text_size'))
        .textAlign(TextAlign.End)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .maxLines(1)
        .margin({
          left: $r('app.float.content_left_distance'),
          right: $r('app.float.content_right_distance')
        })
        .layoutWeight(1)
        .width("100%")
      Image($r('app.media.ic_arrow'))
        .width($r('app.float.arrow_image_width'))
        .height($r('app.float.arrow_image_height'))
        .margin({ right: $r('app.float.arrow_right_distance') })
    }
    .margin({ top: $r('app.float.row_top_distance') })
    .borderRadius($r('app.float.row_radius'))
    .backgroundColor(Color.White)
    .width('93.3%')
    .height($r('app.float.row_height'))
    .onClick(this.onItemClick)
  }
}