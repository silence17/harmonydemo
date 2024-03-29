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
import { GlobalConstant } from '../../app/GlobalConstant';
import { ContentType } from './ContentType';
import { ResponseResult } from './ResponseResult';

/**
 * Initiates an HTTP request to a given URL.
 *
 * @param url URL for initiating an HTTP request.
 * @param params Params for initiating an HTTP request.
 */
export function httpRequestGet(url: string): Promise<ResponseResult> {
  //创建一个http请求对象
  let httpRequest = http.createHttp();
  //发送网络请求
  let responseResult = httpRequest.request(url, {
    method: http.RequestMethod.GET,
    readTimeout: GlobalConstant.HTTP_READ_TIMEOUT,
    header: {
      'Content-Type': ContentType.JSON
    },
    connectTimeout: GlobalConstant.HTTP_READ_TIMEOUT,
    extraData: {}
  });
  let serverData: ResponseResult = new ResponseResult();
  // Processes the data and returns.
  //处理相应结果
  return responseResult.then((value: http.HttpResponse) => {
    if (value.responseCode === GlobalConstant.HTTP_CODE_200) {
      // Obtains the returned data.
      let result = `${value.result}`;
      let resultJson: ResponseResult = JSON.parse(result);
      if (resultJson.status === GlobalConstant.SERVER_CODE_SUCCESS) {
        serverData.data = resultJson.data;
      }
      serverData.status = resultJson.status;
      serverData.msg = resultJson.msg;
    } else {
      serverData.msg = `${$r('app.string.http_error_message')}&${value.responseCode}`;
    }
    return serverData;
  }).catch(() => {
       serverData.msg = `${$r('app.string.http_error_message')}`;
    return serverData;
  })
}