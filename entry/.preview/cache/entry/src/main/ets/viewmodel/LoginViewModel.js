import { Log, PreferencesUtil, ToastUtil } from '@bundle:com.example.rankdemo/entry@common_lib/index';
import http from '@ohos:net.http';
export class LoginViewModel {
    initData() {
    }
    login(phone, pwd) {
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
                Log.info('Result:' + JSON.stringify(data.result));
                const obj = JSON.parse(data.result.toString());
                this.userInfo = obj.data;
                globalThis.userInfo = this.userInfo;
                PreferencesUtil.getInstance().putString("cellphone", phone);
                PreferencesUtil.getInstance().putString("userinfo", JSON.stringify(obj.data));
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
}
//# sourceMappingURL=LoginViewModel.js.map