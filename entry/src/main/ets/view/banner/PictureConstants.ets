import { PictureItem } from './PictureItem';

/**
 * Pictures of banner.
 */
export const PICTURE_BANNER: PictureItem[] = [
  { 'id': '1', 'name': '怒海', 'description': '怒海波涛', 'image': $r('app.media.media1') },
  { 'id': '2', 'name': '大山深处', 'description': '大山深处感人的亲情之歌', 'image': $r('app.media.media2') },
  { 'id': '3', 'name': '荒漠', 'description': '荒漠的亲情之歌', 'image': $r('app.media.media3') }
];

/**
 * type of pictures.
 */
export enum PictureType {
  BANNER = 'banner',
}