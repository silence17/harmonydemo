export class NavItem {
    constructor(id, text, icon, icon_select) {
        this.text_color_normal = { "id": 33554492, "type": 10001, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" };
        this.text_color_select = { "id": 33554493, "type": 10001, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" };
        this.count = 0;
        this.id = id;
        this.text = text;
        this.icon = icon;
        this.icon_selected = icon_select;
    }
}
export var TabId;
(function (TabId) {
    TabId[TabId["HOME"] = 0] = "HOME";
    TabId[TabId["ACHIEVEMENT"] = 1] = "ACHIEVEMENT";
    TabId[TabId["MINE"] = 2] = "MINE";
})(TabId || (TabId = {}));
export const NavList = [
    new NavItem(TabId.HOME, '首页', { "id": 33554447, "type": 20000, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" }, { "id": 33554440, "type": 20000, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" }),
    new NavItem(TabId.ACHIEVEMENT, '发现', { "id": 33554495, "type": 20000, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" }, { "id": 33554438, "type": 20000, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" }),
    new NavItem(TabId.MINE, '我的', { "id": 33554439, "type": 20000, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" }, { "id": 33554441, "type": 20000, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" }),
];
//# sourceMappingURL=NavDataModel.js.map