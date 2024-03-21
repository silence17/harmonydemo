import config from "../app/Configs"
import RequestTask from "./RequestTask.js"
import Utils from "./Utils"

interface RequestParam {
  url?: string
  data?: Object
  success?: (data, responseData) => void
  fail?: (err) => void
  serviceErrorHandler?: (data) => void,
  showLoading?: boolean
  config?: Object
  mock?: boolean

}

interface ResponseData {
  resultCode?: string | number
  message?: string | number
  data?: Object
  success?: boolean
}

/**
 *
 args 定义:
 1个参数
 字符串 :  url 即 get("url")  ,参数2是post参数  参数3是 设置

 //推荐对象方式
 对象:  {
 url :"",
 data: {},
 //以下参数可选 , 如果你熟悉 Promise,可以不用这个,直接用  client.post().then.catch
 success(data,responseData){ // 请求成功 即 服务端http status code 200 并且 ResponseJSON {code:'0000'}  , responseData 是未处理的响应值{code,message,data}
 },
 fail(err){ //除去success外所有状态一律fail
 },
 complete(){ //请求完成后, 不管是成功还是失败. 一般做点 hideloading 之类的事情
 },
 serviceErrorHandler(data){ // 业务结果非正常结果时的处理钩子, 将代替内置  __processServiceError 处理 code异常的行为
 // 可以抛出异常终止后续 fail 和reject处理
 }
 // 以下是 配置参数,逐步迭代
 showLoading:false , //请求开始的时候,不展示Loading.
 config:null , //个性化的headers , 将覆盖默认header,优先级最高,



 }

 调用方式
 client.post({
 url:"",
 success(data,responseData){

 },
 fail(fail){

 },

 showLoading:false
 config:null
 ...
 });
 或 client.post({url:"",data:{}}).then().catch();


 */

let globalData = null;
let retryCount = 0;

export default {
  getGlobalData() {
    if (!globalData) {
      globalData = new Object();
    }
    return globalData;
  },
  /**
   * @param {Object} param 接口调用方传递的参数
   *
   args 定义

   */
  __processParam(args, method = "get") {
    let ret: RequestParam = {};
    if (!args || !args.length) {
      throw new Error("API 请求最起码要一个url字符串")
    }
    //底层方法总是处理一个参数
    let p = args[0];
    if (!p) throw new Error("API 请求最起码要一个url字符串");

    if (typeof p == 'string') { // 一个参数,认为是url参数
      ret.url = p;
      if (args.length > 1) { //第个参数 认为是传输的数据结构
        ret.data = args[1];
      }
      if (args.length > 2) { //第三个参数认为是 config
        ret.config = args[2];
      }

    } else if (typeof p == 'object') { //第一个参数是对象的时候,认为是整个config参数
      ret = Object.assign({}, ret, p);
    }


    if (!ret.url) throw new Error("API 请求最起码要一个url参数");
    let mock = mockApi.isMock(ret.mock, ret.url);
    if (!mock) {
      if (ret.url.indexOf("https://") < 0 && ret.url.indexOf("http://") < 0) { //如果自己不传递完整url,这里就使用默认的API接口前缀
        ret.url = config.api_url + ret.url;
      }
    }
    // 默认的参数结构外层包裹.

    //默认不显示loading
    // if(!ret.showLoading && ret.showLoading!==false){
    // 	ret.showLoading = true
    // }


    return ret;
  },

  /** 生成默认参数, 或者对个性参数做处理.
   比如 axios header , loading 定义 等
   * @param {Object} param
   */
  __generateRequestConfig(param) {
    let ret = {
      headers: {
        ...Utils.getUserInfoForRequestHeader(),
        ...config.apiHeaderInfo,
        ...param.headers,
        ...param.config?.headers,
        'Content-Type': 'application/json;charset=UTF-8',
      }
    };
    if (param.config) {
      ret = Object.assign({}, ret, param.config);
    }
    return ret;
  },


  /** 对http类进行包装
   * @param {Object} err
   * @returns {code:"",message:""}
   */
  __processHttpError(param, err) {
    if (param.httpErrorHandler) { //自定义钩子
      return param.httpErrorHandler(err);
    }
    if (err.code == "401") { //需要刷accessToken
      err.resultCode = "401"
      err.message = "token过期"
    }
    let ret = Object.assign({
      resultCode: "5000",
      message: "服务器开小差了"
    }, err);

    return ret;
  },

  /** 对业务异常进行包装 提供钩子函数  serviceErrorHandler
   比如特定错误处理
   * @param {Object} err
   * @returns {code:"",message:""}
   */
  __processServiceError(param, respData) {
    if (param.serviceErrorHandler) { //自定义钩子, 返回标准结构,以 给 success 或 fail 去处理
      return param.serviceErrorHandler(respData);
    }
    let ret: ResponseData = {
      success: true
    }
    if (respData) { //
      if (typeof respData == 'object') {
        // respData.resultCode='5004'
        if (respData.resultCode != '0000') {
          ret.success = false
          ret.resultCode = respData.resultCode;
          ret.data = respData.data;
          ret.message = respData.message
        } else {
          ret = respData;
          ret.success = true
        }
      } else {
        ret.resultCode = "0000";
        ret.data = respData;
      }
    } else {
      ret.resultCode = "5000";
      ret.success = false
      ret.message = "服务器无返回"
    }
    return ret;
  },

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
  },

  /**
   * 刷新token 并重新发起请求
   * @param fn
   */
  refreshTokenAndResend(fn) {
    let self = this;
    if (self.retryCount >= 30) return;
    this.getGlobalData().refreshToken(fn, null);
  },

  __doPost(param) {
    let self = this;
    let succ = param.success;
    let fail = param.fail;
    let complete = param.complete;
    let cfg = this.__generateRequestConfig(param);
    if (param.showLoading) {
      Utils.showLoading()
    }
    let ps = new Promise((resolve, reject) => {
      RequestTask.post(param.url, param.data, cfg).then(ret => {
        try {
          console.log("请求", param.url, JSON.stringify(param), JSON.stringify(ret))
          let d = this.__processServiceError(param, ret);
          if (d.success) {
            self.retryCount = 0;
            succ && succ(d.data, ret);
            resolve(d.data);
          } else {
            if (d.resultCode == '5004' || d.resultCode == '401') {
              self.refreshTokenAndResend(() => {
                self.retryCount++;
                ps = self.__doPost(param);
              });
            } else {
              self.retryCount = 0;
              let ret = {
                resultCode: "500", message: d.message
              };
              fail && fail(ret);
              reject(ret);
            }
          }
        } catch (err) {
          self.retryCount = 0;
          fail && fail(ret);
          reject(err);
        }
      }).catch(err => {
        console.error("post请求异常", err);
        err = this.__processHttpError(param, err);
        if (err.resultCode == '5004' || err.resultCode == '401') {
          self.refreshTokenAndResend(() => {
            self.retryCount++;
            ps = self.__doPost(param);
          });
        } else {
          self.retryCount = 0;
          let ret = {
            resultCode: "500", message: err.message
          };
          fail && fail(ret);
          reject(ret);
        }
      }).finally(() => {
        complete && complete();
        if (param.showLoading) {
          Utils.hideLoading()
        }
      });
    });

    if (succ) {
      ps.then(() => {
      }).catch(() => {
      });
    }
    return ps;
  },


  /** POST请求
   * @param {Object} 3个参数  url data config 或对象参数
   * @param {Object} success
   * @param {Object} fail
   */
  post(postParam: RequestParam) {
    let self = this;

    let param = this.__processParam(arguments, "post");
    let mock = mockApi.isMock(param.mock, param.url)
    if (mock) {
      let ps = mockApi.mockResult(param);
      ps.then((ret) => {
        if (param.success) {
          param.success(ret);
        }
      }).catch(() => {
      });
      if (param.success) {
        ps.then(() => {
        }).catch(() => {
        });
      }
      return ps;
    }
    return this.__doPost(param)


    // if(this.getGlobalData().isRefreshTokenNow()){
    //   return new Promise((res,rej)=>{
    //     setTimeout(()=>{
    //       this.__doPost(param).then(res).catch(rej);
    //     },200); //这里意思一下吧,不然就直接post 递归...意义不大
    //   })
    // }

  },


  __doGet(param) {
    let self = this;
    let succ = param.success;
    let fail = param.fail;
    if (param.showLoading) {
      Utils.showLoading()
    }
    let ps = new Promise((resolve, reject) => {

      let complete = param.complete;
      let cfg = this.__generateRequestConfig(param);
      RequestTask.get(param.url, cfg).then(ret => {
        try {
          console.log("get请求", param.url, JSON.stringify(param), JSON.stringify(ret))
          let d = this.__processServiceError(param, ret);
          if (d.success) {
            self.retryCount = 0;
            succ && succ(d.data, ret);
            resolve(d.data);
          } else {
            if (d.resultCode == '5004' || d.resultCode == '401') {
              self.refreshTokenAndResend(() => {
                self.retryCount++;
                ps = self.__doGet(param).then(resolve);
              });
            } else {
              self.retryCount = 0;
              let ret = {
                resultCode: "5000", message: d.message
              };
              fail && fail(d);
              reject(d);
            }
          }
        } catch (err) {
          console.error("get请求处理异常", err);
          self.retryCount = 0;
          let ret = {
            resultCode: "500", message: err.message
          };
          fail && fail(ret);
          reject(ret);
        }
      }).catch(err => {
        console.error("get请求异常", err);
        err = this.__processHttpError(param, err);
        if (err.resultCode == '5004' || err.resultCode == '401') {
          self.refreshTokenAndResend(() => {
            self.retryCount++;
            ps = self.__doGet(param).then(resolve);
          });
        } else {
          self.retryCount = 0;
          let ret = {
            resultCode: "500", message: err.message
          };
          fail && fail(ret);
          reject(ret);
        }
      }).finally(() => {
        complete && complete();
        if (param.showLoading) {
          Utils.hideLoading()
        }
      });
    });
    if (succ) {
      ps.then(() => {
      }).catch(() => {
      });
    }
    return ps;
  },

  /** GET请求 一个参数 url 或者 对象参数
   {
   url,
   success,
   fail,
   httpErrorHandler
   ...
   }
   * @param {Object} param
   * @param {Object} success
   * @param {Object} fail
   */
  get(getParam: RequestParam) {
    let param = this.__processParam(arguments);
    let mock = mockApi.isMock(param.mock, param.url);
    if (mock) {
      return mockApi.mockResult(param);
    }
    // if(this.getGlobalData().isRefreshTokenNow()){
    //   return new Promise((res,rej)=>{
    //     setTimeout(()=>{
    //       this.__doGet(param).then(res).catch(rej);
    //     },200);
    //   })
    // }
    return this.__doGet(param);
  }
}