import { Log } from '@bundle:com.example.rankdemo/entry@common_lib/ets/utils/log/Log';
import { UserUtil } from '@bundle:com.example.rankdemo/entry/ets/util/UserUtil';
export class UserInfoComponent extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.__userInfo = new SynchedPropertySimpleTwoWayPU(params.userInfo, this, "userInfo");
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__userInfo.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__userInfo.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get userInfo() {
        return this.__userInfo.get();
    }
    set userInfo(newValue) {
        this.__userInfo.set(newValue);
    }
    initialRender() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            //用户信息
            Row.create();
            //用户信息
            Row.size({ width: '100%', height: 150 });
            //用户信息
            Row.backgroundImage({ "id": 33554496, "type": 20000, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" });
            //用户信息
            Row.backgroundBlurStyle(BlurStyle.Thin);
            //用户信息
            Row.backgroundImageSize({ width: '100%', height: 150 });
            //用户信息
            Row.alignItems(VerticalAlign.Top);
            if (!isInitialRender) {
                //用户信息
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Image.create({ "id": 33554490, "type": 20000, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" });
            Image.objectFit(ImageFit.Contain);
            Image.height('100%');
            Image.margin({ left: 10 });
            Image.width(66);
            if (!isInitialRender) {
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(UserUtil.getInstance().isLogin() ? this.userInfo : '登陆/注册');
            Text.fontSize(18);
            Text.fontColor('#000000');
            Text.margin({ left: 12 });
            Text.backgroundColor('0x0000ff');
            Text.height('100%');
            Text.align(Alignment.Center);
            Text.onClick((event) => {
                this.jumpToLoginAbility();
            });
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Blank.create();
            Blank.layoutWeight(1);
            if (!isInitialRender) {
                Blank.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Blank.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Image.create({ "id": 33554494, "type": 20000, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" });
            Image.size({ width: 53, height: 53 });
            Image.padding(15);
            if (!isInitialRender) {
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        //用户信息
        Row.pop();
    }
    jumpToLoginAbility() {
        let wantInfo = {
            bundleName: 'com.example.rankdemo',
            //待启动的UIAbility
            abilityName: 'LoginAbility',
            //moduleName在待启动的UIAbility属于不同的Module时添加
            parameters: {
                info: '来自EntryAbility Index页面'
            },
        };
        //context为调用方UIAbility的AbilityContext
        let context = getContext(this);
        context.startAbility(wantInfo).then(() => {
            Log.debug('%{public}s' + 'startAbility');
        }).catch((err) => {
        });
    }
    rerender() {
        this.updateDirtyElements();
    }
}
//# sourceMappingURL=UserInfoComponent.js.map