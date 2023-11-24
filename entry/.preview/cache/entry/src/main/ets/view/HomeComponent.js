import { Log } from '@bundle:com.example.rankdemo/entry@common_lib/ets/utils/log/Log';
import http from '@ohos:net.http';
import promptAction from '@ohos:promptAction';
export class HomeComponent extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
    }
    aboutToBeDeleted() {
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    onPageShow() {
    }
    initialRender() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.debugLine("view/HomeComponent.ets(34:5)");
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Button.createWithLabel('get request');
            Button.debugLine("view/HomeComponent.ets(35:7)");
            Button.onClick((event) => {
                this.requestPost();
            });
            if (!isInitialRender) {
                Button.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Button.pop();
        Column.pop();
    }
    requestPost() {
        let httpRequest = http.createHttp();
        httpRequest.on('headersReceive', (header) => {
            Log.debug('header: ' + JSON.stringify(header));
        });
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
            expectDataType: http.HttpDataType.STRING,
            usingCache: true,
            priority: 1,
            connectTimeout: 60000,
            readTimeout: 60000,
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
                const obj = JSON.parse(data.result.toString());
                Log.debug("=========" + obj.data.list[0].productname);
            }
            else {
                Log.info('error:' + JSON.stringify(err));
                promptAction.showToast({
                    message: JSON.stringify(err),
                    duration: 2000
                });
            }
            // 取消订阅HTTP响应头事件
            httpRequest.off('headersReceive');
            // 当该请求使用完毕时，调用destroy方法主动销毁
            httpRequest.destroy();
        });
    }
    rerender() {
        this.updateDirtyElements();
    }
}
//# sourceMappingURL=HomeComponent.js.map