import axios, { AxiosRequestConfig, AxiosResponse, } from "@ohos/axios"
import GlobalConstant from '../../app/GlobalConstant'
import Log from '../Log';
import { UserUtil } from '../UserUtil'
import HttpStore from './HttpStore';


//无需取消的白名单
const noCancelList = [];


// @link https://ohpm.openharmony.cn/#/cn/detail/@ohos%2Faxios
const service = axios.create({
  // API from the environment variable
  baseURL: GlobalConstant.getBaseUrl(),
  timeout: GlobalConstant.HTTP_READ_TIMEOUT,
  method: "POST",
  headers: {
    'Content-Type': 'application/json',
  },
  // responseType: ResponseType
  //响应数据的编码规则，默认utf-8
  responseEncoding: 'utf8',
})

//axios请求Map添加值
const addPendingRequest = (config) => {
  const pendingRequest = HttpStore.getInstance().httpsMap;
  if (noCancelList.indexOf(config.url.split('?')[0]) >= 0) {
    return;
  }

  //生成key的策略
  const requestKey = config.url;
  config.cancelToken = config.cancelToken || new axios.CancelToken(cancel => {
    if (!pendingRequest.has(requestKey)) {
      pendingRequest.set(requestKey, cancel);

      console.debug("request queue：" + pendingRequest.size)
      for (let key in pendingRequest.keys()) {
        console.debug("request key：" + pendingRequest.get(key))
      }
    }
  });
};

//axios请求Map删除值
const removePendingRequest = (config: AxiosRequestConfig) => {
  const pendingRequest = HttpStore.getInstance().httpsMap;
  const requestKey = config.url;
  if (noCancelList.indexOf(requestKey) >= 0) {
    return;
  }
  if (pendingRequest.has(requestKey)) {
    const cancelToken = pendingRequest.get(requestKey);
    cancelToken(requestKey);
    pendingRequest.delete(requestKey);
  }
};

/**
 * request拦截器
 */
service.interceptors.request.use((config) => {
  // 检查是否存在重复请求，若存在则取消已发的请求
  removePendingRequest(config);
  // 把当前请求信息添加到pendingRequest对象中
  addPendingRequest(config);

  let token = UserUtil.getInstance().getUserInfo() == null ? '' : UserUtil.getInstance().getUserInfo().token
  config.headers['content-type'] = 'application/json;charset=UTF-8';
  config.headers['token'] = token;
  config.headers['Authorization'] = token;
  config.headers['platform'] = '2';
  config.headers['applicationCode'] = '3';
  config.headers['fromSource'] = GlobalConstant.getVersionCode();
  config.headers['businessType'] = '1';

  //打印日志
  console.info('start================================')
  console.info("request headers=>", config.headers)
  let urlLog = config.method + '= ' + config.baseURL + config.url
  console.info("request url=> ", urlLog.toString())
  //打印日志
  switch (config.method) {
    case 'post':
      console.info("request params=> ", JSON.stringify(config.data))
      break
    case 'get':
      break
  }
  console.info('end==================================')

  return config;
}, error => {
  return Promise.reject(error)
}
)

/**
 * response拦截器
 */
service.interceptors.response.use((response: AxiosResponse) => {
  const data = response.data

  console.debug('start==================================')
  console.debug("response => ", JSON.stringify(data))
  console.debug('end====================================')
  return data
}, error => {
  console.error("网络请求失败")
  return {
    // 调用cancelToken(requestKey);
    // error.code ERR_CANCELED
    status: error?.response?.status || error?.code || "5000",
    statusText: error?.name || "网络请求错误",
    errorMessage: error.message,
    stack: error.stack
  }
})


/**
 * 网络请求工具方法占位 , 底层方法,谨慎修改.
 * 占位只为了可能的修改. 业务请求见 HttpClient.js
 *
 * 范型D == null 时为任意类型
 */
export class RequestTask {
  static post<T = any, D = any>(url, data, config?: AxiosRequestConfig<D>) {
    if (data === undefined) {
      data = {}
    }
    return service.post<T, AxiosResponse<T>, D>(url, data, config);
  }

  static get<T = any, D = any>(url, config: AxiosRequestConfig<D>) {
    return service.get<T, AxiosResponse<T>, D>(url, config);
  }
}