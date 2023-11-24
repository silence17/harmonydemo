export class UserInfo {
  id: string
  nickName?: string
  username?: string
  token?: string
  cellPhone?: string

  constructor(id?: string, nickName?: string, userName?: string, cellPhone?: string, token?: string) {
    this.id = id
    this.username = userName
    this.nickName = nickName
    this.token = token
    this.cellPhone = cellPhone
  }

  /**
   * 接口返回对象转换
   */
  static toUserBeanTransition(obj: any): UserInfo {
    let userInfo = new UserInfo()
    userInfo.id = obj?.id
    userInfo.nickName = obj?.nickName
    userInfo.username = obj?.username
    userInfo.token = obj?.token
    userInfo.cellPhone = obj?.cellphone
    return userInfo
  }
}