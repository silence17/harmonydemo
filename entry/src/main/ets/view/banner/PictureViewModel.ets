import { CommonConstants } from './CommonConstants';
import { PictureType, PICTURE_BANNER } from './PictureConstants';
import { PictureItem } from './PictureItem';

/**
 * Initialize picture data according to type.
 *
 * @param initType Init type.
 */
export function initializePictures(initType: string): Array<PictureItem> {
  let imageDataArray: Array<PictureItem> = [];
  switch (initType) {
    case PictureType.BANNER:
      PICTURE_BANNER.forEach((item) => {
        imageDataArray.push(new PictureItem(item.id, item.name, item.description, item.image));
      })
      break;
    default:
      break;
  }
  return imageDataArray;
}

let timerIds: number[] = [];

/**
 * start scheduled task.
 *
 * @param swiperController Controller.
 */
export function startPlay(swiperController: SwiperController) {
  let timerId = setInterval(() => {
    swiperController.showNext();
  }, CommonConstants.SWIPER_TIME);
  timerIds.push(timerId);
}

/**
 * stop scheduled task.
 */
export function stopPlay() {
  timerIds.forEach((item) => {
    clearTimeout(item);
  })
}