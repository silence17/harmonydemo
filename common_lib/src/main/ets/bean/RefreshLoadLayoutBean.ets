@Observed
export class RefreshLoadLayoutBean {
  isVisible: boolean;
  imageSrc: Resource;
  textValue: Resource | string;

  constructor(isVisible: boolean, imageSrc: Resource, textValue: Resource | string) {
    this.isVisible = isVisible;
    this.imageSrc = imageSrc;
    this.textValue = textValue;
  }
}