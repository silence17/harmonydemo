import { StringUtil } from '../utils/StringUtil'

export class UserInfoBean {
  id: string
  nickName: string = ''
  username: string = ''
  token: string = ''
  cellPhone: string = ''

  constructor(id?: string, nickName?: string, userName?: string, cellPhone?: string, token?: string) {
    this.id = StringUtil.isEmpty(id) ? '' : id
    this.username = StringUtil.isEmpty(userName) ? '' : userName
    this.nickName = StringUtil.isEmpty(nickName) ? '' : nickName
    this.token = StringUtil.isEmpty(token) ? '' : token
    this.cellPhone = StringUtil.isEmpty(cellPhone) ? '' : cellPhone
  }

  /**
   * 接口返回对象转换
   */
  static toUserBeanTransition(obj: any): UserInfoBean {
    let userInfo = new UserInfoBean()
    userInfo.id = obj?.id
    userInfo.nickName = obj?.nickName
    userInfo.username = obj?.username
    userInfo.token = obj?.token
    userInfo.cellPhone = obj?.cellphone
    return userInfo
  }
}