import { Log, PreferencesUtil, ResponseResult, ToastUtil, UserInfoBean } from '@app/common_lib';
import http from '@ohos.net.http';
import common from '@ohos.app.ability.common';
import AppContext from '@ohos.app.ability.common';
import { UserUtil } from '../util/UserUtil';
import promptAction from '@ohos.promptAction';
import List from '@ohos.util.List';
import ArrayList from '@ohos.util.ArrayList';
import { RecommendBean } from '../bean/RecommendBean';


/**
 * 1.导入http模块
 * 2.常见http请求对象
 * 3.发起请求
 * 4.处理结果
 */
export class HomeViewModel {
  private recommendList: Array<RecommendBean>

  public initData() {
  }

  getRecommendProducts(callback: Function) {
    let httpRequest = http.createHttp();

    httpRequest.on('headersReceive', (header) => {
      Log.debug('header: ' + JSON.stringify(header))
    })
    httpRequest.request("https://test.beeselect.net/j/api/product/searchList", {
      method: http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json'
      },
      extraData: {
        "pageSize": 20,
        "sort": 1,
        "pageNum": 1,
        "token": "",
        "Authorization": "",
        "platform": "2",
        "applicationCode": "3",
        "version": "3.2.1",
        "fromSource": "3.2.1",
        "businessType": "1",
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
      }
      if (!err) {
        // data.result为HTTP响应内容，可根据业务需要进行解析
        Log.info('Result:' + JSON.stringify(data.result));
        // data.header为HTTP响应头，可根据业务需要进行解析
        Log.info('header:' + JSON.stringify(data.header));
        Log.info('cookies:' + JSON.stringify(data.cookies)); // 8+

        let resultJson: ResponseResult = JSON.parse(`${data.result}`);
        this.recommendList = ((resultJson.data as any).list) //as List<RecommendBean>
        callback(this.recommendList)
      } else {
        Log.info('error:' + JSON.stringify(err));
        promptAction.showToast({
          message: JSON.stringify(err),
          duration: 2000
        })
      }
      // 取消订阅HTTP响应头事件
      httpRequest.off('headersReceive');
      // 当该请求使用完毕时，调用destroy方法主动销毁
      httpRequest.destroy();
    })
  }
}