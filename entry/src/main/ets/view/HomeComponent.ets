import { Log } from '@app/common_lib/src/main/ets/utils/Log/Log';
/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import http from '@ohos.net.http';
import promptAction from '@ohos.promptAction';

/**
 * home
 */
@Component
export struct HomeComponent {
  onPageShow() {
  }

  build() {

    Column() {
      Button('get request').onClick((event) => {

        this.requestPost();
      })
    }
  }

  private requestPost() {
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

        const obj = JSON.parse(data.result.toString());
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