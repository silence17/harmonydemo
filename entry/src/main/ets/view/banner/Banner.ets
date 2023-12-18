import router from '@ohos.router';
import { CommonConstants } from './CommonConstants';
import { PictureType } from './PictureConstants';
import { PictureItem } from './PictureItem';
import { initializePictures, startPlay, stopPlay } from './PictureViewModel';



@Extend(Text) function textStyle(fontSize: number, fontWeight: number) {
  .fontSize(fontSize)
  .fontColor($r('app.color.start_window_background'))
  .fontWeight(fontWeight)
}

/**
 * Carousel banner.
 */
@Component
export struct Banner {
  @State index: number = 0;
  private imageArray: Array<PictureItem> = [];
  private swiperController: SwiperController = new SwiperController();

  aboutToAppear() {
    // Data Initialization.
    this.imageArray = initializePictures(PictureType.BANNER);
    // Turn on scheduled task.
    startPlay(this.swiperController);
  }

  aboutToDisappear() {
    stopPlay();
  }

  build() {
    Swiper(this.swiperController) {
      ForEach(this.imageArray, item => {
        Stack({ alignContent: Alignment.TopStart }) {
          Image(item.image)
            .objectFit(ImageFit.Fill)
            .height(CommonConstants.FULL_HEIGHT)
            .width(CommonConstants.FULL_WIDTH)
            .borderRadius(CommonConstants.BORDER_RADIUS)
            .align(Alignment.Center)
            .onClick(() => {
              console.log("点击事件 item"+item.id)
            })

          Column() {
            Text('测试')
              .textStyle(CommonConstants.FONT_SIZE_DESCRIPTION, CommonConstants.FONT_WEIGHT_LIGHT)
              .margin({ bottom: CommonConstants.BOTTOM_TEXT })
            Text(item.name)
              .textStyle(CommonConstants.FONT_SIZE_TITLE, CommonConstants.FONT_WEIGHT_BOLD)
          }
          .alignItems(HorizontalAlign.Start)
          .height(CommonConstants.HEIGHT_CAROUSEL_TITLE)
          .margin({ top: CommonConstants.TOP_ADS, left: CommonConstants.ADS_LEFT })
        }
        .height(CommonConstants.FULL_HEIGHT)
        .width(CommonConstants.FULL_WIDTH)
      }, item => JSON.stringify(item))
    }
    .width(CommonConstants.PAGE_WIDTH)
    .height('100%')
    .index(this.index)
    .indicatorStyle({ selectedColor: $r('app.color.start_window_background') })
    .indicator(true)
    .duration(CommonConstants.DURATION_ADS)
  }
}