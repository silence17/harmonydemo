import { StringUtil, UserInfoBean } from '@app/common_lib';

export class UserUtil {
  private static instance: UserUtil
  private userInfo?: UserInfoBean = null

  private constructor() {
  }

  public static getInstance() {
    if (UserUtil.instance == null) {
      UserUtil.instance = new UserUtil();
    }
    return UserUtil.instance
  }

  public setUserInfo(bean: UserInfoBean) {
    this.userInfo = bean
  }


  public isLogin(): boolean {
    return this.userInfo != null && !StringUtil.isEmpty(this.userInfo.token)
  }

  public getUserInfo(): UserInfoBean {
    return this.userInfo
  }
}