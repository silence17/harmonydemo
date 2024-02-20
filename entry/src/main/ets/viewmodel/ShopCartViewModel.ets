import http from '@ohos.net.http';
import { Log, PreferencesUtil, ResponseResult, ToastUtil, UserInfoBean } from '@app/common_lib';
import { ShopCartList } from '../bean/ShopCartBean';
import { UserUtil } from '../util/UserUtil';

/**
 * 购物车
 */
export class ShopCartViewModel {
  public shopCartBean?: ShopCartList
  public title: string = '购物车'

  public init() {
    this.title = '个人购物车'
  }


  public getShopCartList() {
    let httpRequest = http.createHttp();

    httpRequest.on('headersReceive', (header) => {
      Log.debug('header: ' + JSON.stringify(header))
    })
    httpRequest.request("https://test.beeselect.net/j/api/cart/syn", {
      method: http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json',
        "token": UserUtil.getInstance().getUserInfo().token,
        "Authorization": "",
        "platform": "2",
        "applicationCode": "3",
        "version": "3.2.1",
        "fromSource": "",
        "businessType": "1",
      },
      extraData: {
        "enterpriseId": "",
      },
      expectDataType: http.HttpDataType.STRING, // 可选，指定返回数据的类型
      usingCache: true, // 可选，默认为true
      priority: 1, // 可选，默认为1
      connectTimeout: 60000, // 可选，默认为60000ms
      readTimeout: 60000, // 可选，默认为60000ms
      usingProtocol: http.HttpProtocol.HTTP1_1, // 可选，协议类型默认值由系统自动指定
    }, (err, data) => {

      if (data.responseCode === http.ResponseCode.OK) {
        console.info('Result:' + data.result);
        console.info('code:' + data.responseCode);

        let resultJson: ResponseResult = JSON.parse(`${data.result}`);
        if (!err && resultJson.status == 1) {
          this.shopCartBean = (resultJson.data as any)
        } else {
          Log.info('error:' + JSON.stringify(err));
          ToastUtil.showToast(JSON.stringify(err))
        }
      } else {
        ToastUtil.showToast('网络异常')
      }
      // 取消订阅HTTP响应头事件
      httpRequest.off('headersReceive');
      // 当该请求使用完毕时，调用destroy方法主动销毁
      httpRequest.destroy();
    })

  }
}