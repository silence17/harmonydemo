import { UserInfoBean } from '@app/common_lib';
import { ItemBean } from '../bean/ItemBean'
import { IconBean } from '../bean/IconBean';

export class MineViewModel {
  userInfo: UserInfoBean = new UserInfoBean()
  orderStatusList: Array<IconBean> = []

  public initData() {
    this.getUserInfo()
    this.getOrderStatusList()
  }

  getOrderStatusList() {
    this.orderStatusList = [
      {
        id: '1',
        iconUrl: $r('app.media.order_1'),
        content: '待付款'
      },
      {
        id: '2',
        iconUrl: $r('app.media.order_2'),
        content: '待发货'
      },
      {
        id: '3',
        iconUrl: $r('app.media.order_3'),
        content: '待收货'
      },
      {
        id: '4',
        iconUrl: $r('app.media.order_4'),
        content: '已完成'
      }
    ]
  }

  getMenusList(): Array<ItemBean> {
    return [
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