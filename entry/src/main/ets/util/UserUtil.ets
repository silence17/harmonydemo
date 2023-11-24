import { StringUtil, UserInfo } from '@app/common_lib';

export class UserUtil {
  private static instance: UserUtil

 /* @StorageLink('cache_user_info_json')*/
  private  userInfo: string = ''

  private constructor() {
  }

  public static getInstance() {
    if (UserUtil.instance == null) {
      UserUtil.instance = new UserUtil();
    }
    return UserUtil.instance
  }


  public isLogin(): boolean {
    let userBean = JSON.parse(this.userInfo) as UserInfo
    return userBean != null && !StringUtil.isEmpty(userBean.token)
  }

  public getUserInfo(): UserInfo {
    return JSON.parse(this.userInfo) as UserInfo
  }
}