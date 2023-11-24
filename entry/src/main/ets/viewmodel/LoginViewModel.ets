import { Log, PreferencesUtil, ResponseResult, ToastUtil, UserInfo } from '@app/common_lib';
import http from '@ohos.net.http';
import common from '@ohos.app.ability.common';
import AppContext from '@ohos.app.ability.common';

export class LoginViewModel {
  public initData() {
  }


  login(phone: string, pwd: string, callback?: Function) {
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
          let userInfo = UserInfo.toUserBeanTransition(resultJson.data)
          AppStorage.Set<string>('cache_user_info_json', JSON.stringify(userInfo));
          PreferencesUtil.getInstance().putString('cellphone', phone)
          this.jumpToMainAbility()
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

  jumpToMainAbility() {
    let wantInfo = {
      bundleName: 'com.example.rankdemo',
      //待启动的UIAbility
      abilityName: 'EntryAbility',
      //moduleName在待启动的UIAbility属于不同的Module时添加
      parameters: {
        info: '来自EntryAbility Index页面'
      },
    }
    //context为调用方UIAbility的AbilityContext
    let context = getContext(this) as common.UIAbilityContext;
    context.startAbility(wantInfo).then(() => {
      Log.debug('%{public}s' + 'startAbility');
    }).catch((err) => {

    });

    let handler = getContext(this) as AppContext.UIAbilityContext;
    handler.terminateSelf();
  }
}