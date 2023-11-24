export class UserInfo {
    constructor(id, nickName, userName, cellPhone, token) {
        this.id = id;
        this.username = userName;
        this.nickName = nickName;
        this.token = token;
        this.cellPhone = cellPhone;
    }
    /**
     * 接口返回对象转换
     */
    static toUserBeanTransition(obj) {
        let userInfo = new UserInfo();
        userInfo.id = obj === null || obj === void 0 ? void 0 : obj.id;
        userInfo.nickName = obj === null || obj === void 0 ? void 0 : obj.nickName;
        userInfo.username = obj === null || obj === void 0 ? void 0 : obj.username;
        userInfo.token = obj === null || obj === void 0 ? void 0 : obj.token;
        userInfo.cellPhone = obj === null || obj === void 0 ? void 0 : obj.cellphone;
        return userInfo;
    }
}
//# sourceMappingURL=UserInfo.js.map