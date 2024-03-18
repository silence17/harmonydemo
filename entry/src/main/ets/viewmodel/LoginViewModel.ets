import { Log, PreferencesUtil, ResponseResult, ToastUtil, UserInfoBean } from '@app/common_lib';
import http from '@ohos.net.http';
import common from '@ohos.app.ability.common';
import AppContext from '@ohos.app.ability.common';
import { UserUtil } from '../util/UserUtil';


/**
 * 1.导入http模块
 * 2.常见http请求对象
 * 3.发起请求
 * 4.处理结果
 */
export class LoginViewModel {
  public initData() {
  }


  // 使用 callback: Function 亦可
  login(phone: string, pwd: string, callback: (userInfo: UserInfoBean) => void) {
    let httpRequest = http.createHttp();

    httpRequest.on('headersReceive', (header) => {
      Log.debug('header: ' + JSON.stringify(header))
    })
    httpRequest.request("https://test.beeselect.net/j/api/member/login", {
      method: http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json',
        "token": "",
        "Authorization": "",
        "platform": "2",
        "applicationCode": "3",
        "version": "3.2.1",
        "fromSource": "3.2.1",
        "businessType": "1",
      },
      extraData: {
        "cellphone": phone,
        "password": pwd,
        "type": "1",
      },
      expectDataType: http.HttpDataType.STRING, // 可选，指定返回数据的类型
      usingCache: true, // 可选，默认为true
      priority: 1, // 可选，默认为1
      connectTimeout: 60000, // 可选，默认为60000ms
      readTimeout: 60000, // 可选，默认为60000ms
      usingProtocol: http.HttpProtocol.HTTP1_1, // 可选，协议类型默认值由系统自动指定
    }, (err, data: http.HttpResponse) => {

      if (!err) {
        // data.result为HTTP响应内容，可根据业务需要进行解析
        Log.debug('Result:', JSON.stringify(data.result));
        // Obtains the returned data.
        let resultJson: ResponseResult = JSON.parse(`${data.result}`);

        //{"status":-1,"msg":"请填写正确的手机号格式","data":null,"ok":false}
        if (resultJson.status === -1) {
          ToastUtil.showToast(resultJson.msg)
        } else {
          let userInfo = UserInfoBean.toUserBeanTransition(resultJson.data)
          UserUtil.getInstance().setUserInfo(userInfo)
          PreferencesUtil.getInstance().putString('cellphone', phone)
          callback(userInfo)
        }
      } else {
        ToastUtil.showToast(JSON.stringify(err))
      }
      // 取消订阅HTTP响应头事件
      httpRequest.off('headersReceive');
      // 当该请求使用完毕时，调用destroy方法主动销毁
      httpRequest.destroy();
    })
  }
}