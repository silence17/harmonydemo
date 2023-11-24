/**
 * {"status":-1,"msg":"请填写正确的手机号格式","data":null,"ok":false}
 */
export class ResponseResult {
  /**
   * Code returned by the network request: success, fail.
   */
  status: number;

  /**
   * Message returned by the network request.
   */
  msg: string;

  /**
   * Data returned by the network request.
   */
  data: string | Object | ArrayBuffer;

  constructor() {
    this.status = 1;
    this.msg = '';
    this.data = '';
  }
}