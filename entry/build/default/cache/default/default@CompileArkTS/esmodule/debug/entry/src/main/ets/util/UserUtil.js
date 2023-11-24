import { StringUtil } from '@bundle:com.example.rankdemo/entry@common_lib/index';
export class UserUtil {
    constructor() {
        /* @StorageLink('cache_user_info_json')*/
        this.userInfo = '';
    }
    static getInstance() {
        if (UserUtil.instance == null) {
            UserUtil.instance = new UserUtil();
        }
        return UserUtil.instance;
    }
    isLogin() {
        let userBean = JSON.parse(this.userInfo);
        return userBean != null && !StringUtil.isEmpty(userBean.token);
    }
    getUserInfo() {
        return JSON.parse(this.userInfo);
    }
}
//# sourceMappingURL=UserUtil.js.map