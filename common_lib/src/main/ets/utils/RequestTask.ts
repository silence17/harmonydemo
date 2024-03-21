import axios, { AxiosResponse, InternalAxiosRequestConfig } from "@ohos/axios"

// @link https://ohpm.openharmony.cn/#/cn/detail/@ohos%2Faxios
const service = axios.create({
  // API from the environment variable
  baseURL: "",
  timeout: 65000,
  method: "POST",
  headers: {
    'Content-Type': 'application/json',
  },
})


// request拦截器
service.interceptors.request.use((config: InternalAxiosRequestConfig) => {

    if (config.method === 'get') {
      //  给data赋值以绕过if判断
      config.data = true
    }
    config.headers['content-type'] = 'application/json;charset=UTF-8';
    return config;
  },
  error => {
    return Promise.reject(error)
  }
)

// respone拦截器
service.interceptors.response.use((response: AxiosResponse) => {
  const data = response.data

  return data
},
  error => {
    console.error("网络请求失败")
    return {
      resultCode: error.response?.status || "5000",
      message: "网络请求错误",
      errorMessage: error.message,
      stack: error.stack
    }
  }
)


/**
 * 网络请求工具方法占位 , 底层方法,谨慎修改.
 * 占位只为了可能的修改. 业务请求见 HttpClient.js
 */
export default {
  post(url, data, config) {
    if (data === undefined) {
      data = {}
    }
    return service.post(url, data, config);
  },
  get(url, config) {
    return service.get(url, config);
  },
}