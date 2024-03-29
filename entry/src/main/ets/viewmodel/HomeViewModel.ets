import {
  Log,
  PreferencesUtil,
  ResponseResult,
  StringUtil,
  ToastUtil,
  UserInfoBean,
  UserUtil,
  HttpClient,
  RequestParam
} from '@app/common_lib';
import http from '@ohos.net.http';
import common from '@ohos.app.ability.common';
import AppContext from '@ohos.app.ability.common';
import promptAction from '@ohos.promptAction';
import List from '@ohos.util.List';
import ArrayList from '@ohos.util.ArrayList';
import { RecommendBean } from '../bean/RecommendBean';
import { IconBean } from '../bean/IconBean';
import { BasicDataSource } from '../util/BasicDataSource';


/**
 * 1.导入http模块
 * 2.常见http请求对象
 * 3.发起请求
 * 4.处理结果
 */
export class HomeViewModel extends BasicDataSource<RecommendBean> {
  private recommendList: Array<RecommendBean> = []

  public initData() {
  }

  totalCount(): number {
    return this.recommendList.length
  }

  getData(index: number): RecommendBean {
    return this.recommendList[index]
  }

  addData(index: number, data: RecommendBean) {
    this.recommendList.splice(index, 0, data)
    this.notifyDataAdd(index)
  }

  pushData(data: RecommendBean) {
    this.recommendList.push(data)
    this.notifyDataAdd(this.recommendList.length - 1)
  }


  getIcons(): Array<IconBean> {
    let icons = new Array<IconBean>()

    icons.push(new IconBean('1', $r('app.media.icon_1'), '做保养'))
    icons.push(new IconBean('1', $r('app.media.icon_1'), '换轮胎'))
    icons.push(new IconBean('1', $r('app.media.icon'), '洗车美容'))
    icons.push(new IconBean('1', $r('app.media.icon_1'), '精品加油'))
    return icons
  }

  getRecommendProducts2() {

    var map = new Map<string, any>();
    map["pageSize"] = 5;
    map["sort"] = 1;
    map["pageNum"] = 1;

    let request: RequestParam<string> = {
      url: "/j/api/product/searchList",
      params: map,
      success: (response => {
        ToastUtil.showToast("请求成功")
      }),
      fail: (err => {
        ToastUtil.showToast("请求失败")
      })
    }

    new HttpClient<String>().post(request)
  }

  getRecommendProducts(callback: Function) {
    let httpRequest = http.createHttp();

    httpRequest.on('headersReceive', (header) => {
      Log.debug('header: ' + JSON.stringify(header))
    })
    httpRequest.request("https://test.beeselect.net/j/api/product/searchList", {
      method: http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json',
        "token": UserUtil.getInstance().getUserInfo() == null ? '' : UserUtil.getInstance().getUserInfo().token,
        "Authorization": "",
        "platform": "2",
        "applicationCode": "3",
        "version": "3.2.1",
        "fromSource": "",
        "businessType": "1",
      },
      extraData: {
        "pageSize": 20,
        "sort": 1,
        "pageNum": 1,
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

        if (!err) {
          // data.result为HTTP响应内容，可根据业务需要进行解析
          Log.info('Result:' + JSON.stringify(data.result));
          // data.header为HTTP响应头，可根据业务需要进行解析
          Log.info('header:' + JSON.stringify(data.header));
          Log.info('cookies:' + JSON.stringify(data.cookies)); // 8+

          let resultJson: ResponseResult = JSON.parse(`${data.result}`);
          let recommendList = ((resultJson.data as any).list) //as List<RecommendBean>
          for (var index = 0; index < recommendList.length; index++) {
            this.pushData(recommendList[index])
          }
          callback(this.recommendList)
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


  /**
   * 添加购物车
   * @param productId product id
   * @param quantity 数量
   * @param skuId sku id
   */
  addCart(productId: string, quantity: number, skuId: string) {
    let httpRequest = http.createHttp();

    httpRequest.on('headersReceive', (header) => {
      Log.debug('header: ' + JSON.stringify(header))
    })
    httpRequest.request("https://test.beeselect.net/j/api/cart/add", {
      method: http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json',
        "token": UserUtil.getInstance().getUserInfo().token,
        "Authorization": "",
        "platform": "2",
        "applicationCode": "3",
        "version": "3.2.1",
        "fromSource": "3.2.1",
        "businessType": "1",
      },
      //{addQuantity: 1, pageFromCode: 3, productId: "942", skuId: "942_2876_0_0"}
      extraData: {
        "productId": productId,
        "addQuantity": quantity,
        "pageFromCode": 3,
        "skuId": skuId,
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
        ToastUtil.showToast("加车成功")
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