import { UserInfo } from '@bundle:com.example.rankdemo/entry/ets/bean/UserInfo';
export class MineViewModel {
    initData() {
        this.getMenusList();
        this.getUserInfo();
    }
    getMenusList() {
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
                icon: { "id": 33554446, "type": 20000, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" },
                title: '联系客服',
                rightIcon: { "id": 33554445, "type": 20000, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" }
            }
        ];
    }
    getUserInfo() {
        this.userInfo = new UserInfo("1001", "xiaojie", "15600006833", null);
    }
}
//# sourceMappingURL=MineViewModel.js.map