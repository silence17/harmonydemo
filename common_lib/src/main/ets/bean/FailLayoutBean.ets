@Observed
export class FailLayoutBean {
  imageSrc: Resource;
  textValue: Resource | string;
  btnStr: Resource | string;
  //定义回调函数
  onClick?: Function

  constructor(imageSrc: Resource, textValue: Resource | string, btnStr: Resource | string, onClick?: Function) {
    this.imageSrc = imageSrc;
    this.textValue = textValue;
    this.btnStr = btnStr
    this.onClick = onClick
  }
}