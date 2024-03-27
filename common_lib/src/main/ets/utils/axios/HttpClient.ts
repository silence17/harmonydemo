import { AxiosResponse } from '@ohos/axios';
import { RequestTask } from './RequestTask';
import { StringUtil } from '../StringUtil';
import { Utils } from '../Utils';
import { Log } from '../Log/Log';
import ErrorCode from './ErrorCode';

/// 请求入参
export interface RequestParam<T> {
  url?: string
  params?: Map<string, any>
  //成功回调
  success?: (data: ResponseData<T>) => void
  //失败回调
  fail?: (err: ResponseData<T>) => void
  //是否展示loading
  showLoading?: boolean
}

///标准返回报文格式
export class ResponseData<T> {
  //200,404,ERR_CANCELED(请求被取消)
  status?: number | string
  msg?: string
  data?: T
}


export class HttpClient<T> {
  /**
   * @param {Object} param 接口调用方传递的参数
   *
   args 定义
   */
  _processParam(args: RequestParam<T>, method = "get") {
    if (!args.url) throw new Error("API 请求最起码要一个url参数");

    switch (method) {
      case "get":
        let paramStr = ""
        for (let key in args.params.keys()) {
          paramStr = paramStr + key + "=" + args.params[key] + "&"
        }
        if (!StringUtil.isEmpty(paramStr)) {
          args.url += "?"
          args.url = args.url + paramStr.substring(0, paramStr.length - 1)
        }
        break
      case "post":
        break
    }
  }

  /**
   * 特定错误处理,解析json
   * @param {Object} param
   * @param {Object} respData
   * @returns {code:"",message:""}
   */
  _processServiceCommon(param: RequestParam<T>, respData: AxiosResponse<ResponseData<T>>) {
    // Log.error("url", param.url)
    // Log.error("params", JSON.stringify(param.params))
    // Log.error("response", JSON.stringify(respData))

    let errorCode: string | number = respData.status
    if (errorCode === ErrorCode.STATUS_200) {
      errorCode = respData.data.status
    }

    switch (errorCode) {
    //请求业务成功
      case ErrorCode.STATUS_SUCCESS:
        param.success(respData.data)
        break
    //业务请求失败
      case ErrorCode.STATUS_FAIL:
      case ErrorCode.STATUS_FAIL2:
        param.fail(respData.data)
        break
    //登录态失效,前往登录
      case ErrorCode.STATUS_TOKEN_INVALID:
      //todo 前往登录
        param.fail(respData.data)
        break
      case ErrorCode.STATUS_ERR_CANCELED:
      //网络请求被取消了，不上报
        console.warn('网络请求被取消了' + respData.statusText)
        return;
      default:
      //{"resultCode":500,"message":"网络请求错误","errorMessage":"Request failed with status code 500","stack":"}
        let result = Object.assign({
          status: 5000,
          errorMessage: "服务器开小差了",
        }, respData);
        let response = new ResponseData<T>()
        response.status = result['status']
        response.msg = result['errorMessage']

        param.fail(response)
    }
  }

  /**
   * 批量请求, 一般用于页面内多个平行请求
   * 仅支持 promise方式调用 , 即各子请求内 不能带有success fail 等回调函数
   * showLoading 支持 Boolean 和 对象(loading参数)
   */
  batch(requests = [], showLoading = true) {
    if (showLoading) {
      Utils.showLoading()
    }
    let ps = new Promise((res, rej) => {
      Promise.all(requests).then((rss) => res(rss)).catch(rej).finally(() => {
        if (showLoading) {
          Utils.hideLoading()
        }
      });
    });
    return ps;
  }

  _doPost(param: RequestParam<T>) {
    if (param.showLoading) {
      Utils.showLoading()
    }
    RequestTask.post<ResponseData<T>, null>(param.url, param.params, null)
      .then(response => {

        this._processServiceCommon(param, response);
      }).catch(err => {
      Log.error("post请求异常", err);
      //TypeError: Cannot convert a UNDEFINED value to a JSObject
      let ret = new ResponseData<T>();
      ret.status = 5000
      ret.msg = err
      param.fail(ret)
    }).finally(() => {
      if (param.showLoading) {
        Utils.hideLoading()
      }
    });
  }

  _doGet(param: RequestParam<T>) {
    if (param.showLoading) {
      Utils.showLoading()
    }
    RequestTask.get<T, null>(param.url, null)
      .then(response => {

        this._processServiceCommon(param, response);
      }).catch(err => {
      Log.error("get请求异常", err);
      //TypeError: Cannot convert a UNDEFINED value to a JSObject
      let ret = new ResponseData<T>();
      ret.status = 5000
      ret.msg = err
      param.fail(ret)
    }).finally(() => {
      if (param.showLoading) {
        Utils.hideLoading()
      }
    });
  }


  /**
   * POST请求
   */
  post(postParam: RequestParam<T>) {
    this._processParam(postParam, "post");
    return this._doPost(postParam)
  }

  /**
   * GET请求 一个参数 url 或者 对象参数
   * @param {Object} param
   */
  get(getParam: RequestParam<T>) {
    this._processParam(getParam);
    return this._doGet(getParam);
  }
}