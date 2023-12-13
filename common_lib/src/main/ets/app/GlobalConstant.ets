export const CACHE_USER_INFO: string = 'cache_user_info_json'

export class GlobalConstant {

  /**
   * The delay time.
   */
  static readonly DELAY_TIME: number = 1000;

  /**
   * The animation duration.
   */
  static readonly ANIMATION_DURATION: number = 2000;

  /**
   * The http timeout duration.
   */
  static readonly HTTP_READ_TIMEOUT: number = 10000;

  /**
   * Http request success status code.
   */
  static readonly HTTP_CODE_200: number = 200;

  /**
   * The request success status code.
   */
  static readonly SERVER_CODE_SUCCESS: number = 1;
}

export enum PageState {
  Loading = 0,
  Normal = 1,
  Fail = 2,
}