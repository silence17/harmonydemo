var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
import { StringUtil } from '@bundle:com.example.rankdemo/entry@common_lib/ets/utils/StringUtil';
export class UserUtil {
    constructor() {
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
__decorate([
    StorageLink('cache_user_info_json')
], UserUtil.prototype, "userInfo", void 0);
//# sourceMappingURL=UserUtil.js.map