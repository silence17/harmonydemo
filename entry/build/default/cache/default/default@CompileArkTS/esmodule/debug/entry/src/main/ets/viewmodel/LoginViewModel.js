import { Log, PreferencesUtil, ToastUtil, UserInfo } from '@bundle:com.example.rankdemo/entry@common_lib/index';
import http from '@ohos:net.http';
export class LoginViewModel {
    initData() {
    }
    login(phone, pwd, callback) {
        let httpRequest = http.createHttp();
        httpRequest.on('headersReceive', (header) => {
            Log.debug('header: ' + JSON.stringify(header));
        });
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
            expectDataType: http.HttpDataType.STRING,
            usingCache: true,
            priority: 1,
            connectTimeout: 60000,
            readTimeout: 60000,
            usingProtocol: http.HttpProtocol.HTTP1_1, // 可选，协议类型默认值由系统自动指定
        }, (err, data) => {
            if (!err) {
                // data.result为HTTP响应内容，可根据业务需要进行解析
                Log.debug('Result:', JSON.stringify(data.result));
                // Obtains the returned data.
                let resultJson = JSON.parse(`${data.result}`);
                //{"status":-1,"msg":"请填写正确的手机号格式","data":null,"ok":false}
                if (resultJson.status === -1) {
                    ToastUtil.showToast(resultJson.msg);
                }
                else {
                    let userInfo = UserInfo.toUserBeanTransition(resultJson.data);
                    AppStorage.Set('cache_user_info_json', JSON.stringify(userInfo));
                    PreferencesUtil.getInstance().putString('cellphone', phone);
                    this.jumpToMainAbility();
                }
            }
            else {
                ToastUtil.showToast(JSON.stringify(err));
            }
            // 取消订阅HTTP响应头事件
            httpRequest.off('headersReceive');
            // 当该请求使用完毕时，调用destroy方法主动销毁
            httpRequest.destroy();
        });
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
        };
        //context为调用方UIAbility的AbilityContext
        let context = getContext(this);
        context.startAbility(wantInfo).then(() => {
            Log.debug('%{public}s' + 'startAbility');
        }).catch((err) => {
        });
        let handler = getContext(this);
        handler.terminateSelf();
    }
}
//# sourceMappingURL=LoginViewModel.js.map