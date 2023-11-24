import { MineMenusComponents } from '@bundle:com.example.rankdemo/entry/ets/view/MineMenusComponent';
import { UserInfoComponent } from '@bundle:com.example.rankdemo/entry/ets/view/UserInfoComponent';
import { MineViewModel } from '@bundle:com.example.rankdemo/entry/ets/viewmodel/MineViewModel';
export class MinePage extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.__viewModel = new ObservedPropertyObjectPU(new MineViewModel(), this, "viewModel");
        this.addProvidedVar("viewModel", this.__viewModel);
        this.__userInfo = this.createStorageLink('cache_user_info_json', ''
        /**
         * 仅首次创建的时候执行
         */
        , "userInfo");
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
        if (params.viewModel !== undefined) {
            this.viewModel = params.viewModel;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
    }
    aboutToBeDeleted() {
        this.__viewModel.aboutToBeDeleted();
        this.__userInfo.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get viewModel() {
        return this.__viewModel.get();
    }
    set viewModel(newValue) {
        this.__viewModel.set(newValue);
    }
    get userInfo() {
        return this.__userInfo.get();
    }
    set userInfo(newValue) {
        this.__userInfo.set(newValue);
    }
    /**
     * 仅首次创建的时候执行
     */
    aboutToAppear() {
        this.viewModel.initData();
    }
    initialRender() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.width('100%');
            Column.height('100%');
            Column.align(Alignment.Top);
            Column.backgroundColor({ "id": 33554460, "type": 10001, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" });
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        {
            this.observeComponentCreation((elmtId, isInitialRender) => {
                ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                if (isInitialRender) {
                    ViewPU.create(new 
                    //用户信息
                    UserInfoComponent(this, { userInfo: this.__userInfo }, undefined, elmtId));
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {});
                }
                ViewStackProcessor.StopGetAccessRecording();
            });
        }
        {
            this.observeComponentCreation((elmtId, isInitialRender) => {
                ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                if (isInitialRender) {
                    ViewPU.create(new 
                    //菜单
                    MineMenusComponents(this, {}, undefined, elmtId));
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {});
                }
                ViewStackProcessor.StopGetAccessRecording();
            });
        }
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
//# sourceMappingURL=MinePage.js.map