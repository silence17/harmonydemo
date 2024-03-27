// 存储当前请求
import { Canceler, InternalAxiosRequestConfig } from '@ohos/axios';

export default class HttpStore {
  private static instance: HttpStore

  //正在发送的请求集合key:url   value:axios cancelToken
  httpsMap = new Map<string, Canceler>();


  private constructor() {
  }

  public static getInstance() {
    if (HttpStore.instance == null) {
      HttpStore.instance = new HttpStore();
    }
    return HttpStore.instance
  }




}