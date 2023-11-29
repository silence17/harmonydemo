import { UserInfoBean } from '@app/common_lib';
import { ItemBean } from '../bean/ItemBean'

export class MineViewModel {
  listSource: Array<ItemBean>
  userInfo: UserInfoBean;

  public initData() {
    this.getMenusList()
    this.getUserInfo()
  }


  private getMenusList() {
    this.listSource = [
      {
        id: 1,
        type: 1,
        icon: null,
        title: '自定义应用配置',
      },
      {
        id: 2,
        type: 2,
        icon: $r('app.media.icon_call_server'),
        title: '联系客服',
        rightIcon: $r('app.media.icon_right_arrow')
      },
      {
        id: 3,
        type: 1,
        icon: null,
        title: '退出登陆',
      }
    ]
  }

  private getUserInfo() {
    //this.userInfo = globalThis.userInfo
    //this.userInfo = new UserInfo("1001", "xiaojie", "15600006833", null);
  }
}