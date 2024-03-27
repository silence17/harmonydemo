///网络请求状态码

export default {
  //======================= http代码 ========================

  STATUS_200: 200,

  STATUS_ACCESS_DENIED: 302,
  STATUS_UNAUTHORIZED: 401,
  STATUS_FORBIDDEN: 403,
  STATUS_NOT_FOUND: 404,
  STATUS_REQUEST_TIMEOUT: 408,
  STATUS_HANDEL_ERROR: 417,
  STATUS_INTERNAL_SERVER_ERROR: 500,
  STATUS_BAD_GATEWAY: 502,
  STATUS_SERVICE_UNAVAILABLE: 503,
  STATUS_GATEWAY_TIMEOUT: 504,

  //网络请求被取消
  STATUS_ERR_CANCELED: 'ERR_CANCELED',


  //======================= 业务代码 ========================

  //业务请求成功
  STATUS_SUCCESS: 1,

  //业务请求失败
  STATUS_FAIL: 0,

  //业务请求失败
  STATUS_FAIL2: -1,

  //未知原因请求失败
  STATUS_FAIL3: 5000,

  //token失效
  STATUS_TOKEN_INVALID: 2003,
}


