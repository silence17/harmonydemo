import { ClearEditText, CommonTitleComponent, PreferencesUtil, StringUtil, ToastUtil } from '@bundle:com.example.rankdemo/entry@common_lib/index';
import promptAction from '@ohos:promptAction';
import display from '@ohos:display';
import { LoginViewModel } from '@bundle:com.example.rankdemo/entry/ets/viewmodel/LoginViewModel';
class LoginPage extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.__isRefreshData = new ObservedPropertySimplePU(false, this, "isRefreshData");
        this.__btnColor = new ObservedPropertySimplePU('#991890FF', this, "btnColor");
        this.__phone = new ObservedPropertySimplePU('15204697356', this, "phone");
        this.__pwd = new ObservedPropertySimplePU(''
        //获取屏幕的宽度
        , this, "pwd");
        this.screenWidth = px2vp(display.getDefaultDisplaySync().width);
        this.__viewModel = new ObservedPropertyObjectPU(new LoginViewModel()
        /**
         * 每次可见时回调
         */
        , this, "viewModel");
        this.addProvidedVar("viewModel", this.__viewModel);
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
        if (params.isRefreshData !== undefined) {
            this.isRefreshData = params.isRefreshData;
        }
        if (params.btnColor !== undefined) {
            this.btnColor = params.btnColor;
        }
        if (params.phone !== undefined) {
            this.phone = params.phone;
        }
        if (params.pwd !== undefined) {
            this.pwd = params.pwd;
        }
        if (params.screenWidth !== undefined) {
            this.screenWidth = params.screenWidth;
        }
        if (params.viewModel !== undefined) {
            this.viewModel = params.viewModel;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__isRefreshData.purgeDependencyOnElmtId(rmElmtId);
        this.__btnColor.purgeDependencyOnElmtId(rmElmtId);
        this.__phone.purgeDependencyOnElmtId(rmElmtId);
        this.__pwd.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__isRefreshData.aboutToBeDeleted();
        this.__btnColor.aboutToBeDeleted();
        this.__phone.aboutToBeDeleted();
        this.__pwd.aboutToBeDeleted();
        this.__viewModel.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get isRefreshData() {
        return this.__isRefreshData.get();
    }
    set isRefreshData(newValue) {
        this.__isRefreshData.set(newValue);
    }
    get btnColor() {
        return this.__btnColor.get();
    }
    set btnColor(newValue) {
        this.__btnColor.set(newValue);
    }
    get phone() {
        return this.__phone.get();
    }
    set phone(newValue) {
        this.__phone.set(newValue);
    }
    get pwd() {
        return this.__pwd.get();
    }
    set pwd(newValue) {
        this.__pwd.set(newValue);
    }
    get viewModel() {
        return this.__viewModel.get();
    }
    set viewModel(newValue) {
        this.__viewModel.set(newValue);
    }
    /**
     * 每次可见时回调
     */
    onPageShow() {
        PreferencesUtil.getInstance().getString("cellphone").then((result) => {
            this.phone = result;
        });
    }
    initialRender() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.height('100%');
            Column.justifyContent(FlexAlign.Start);
            Column.alignItems(HorizontalAlign.Start);
            Column.width('100%');
            Column.padding({ left: 15, right: 15 });
            Column.justifyContent(FlexAlign.Start);
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
                    //title
                    CommonTitleComponent(this, { title: { "id": 33554452, "type": 10003, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" }, callback: () => {
                            //todo
                        } }, undefined, elmtId));
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {});
                }
                ViewStackProcessor.StopGetAccessRecording();
            });
        }
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Image.create({ "id": 33554490, "type": 20000, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" });
            Image.objectFit(ImageFit.Contain);
            Image.height(60);
            Image.width(60);
            if (!isInitialRender) {
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create('欢迎使用蜂采优选');
            Text.fontColor('#333333');
            Text.fontSize(22);
            Text.margin({ top: 10 });
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            Row.margin({ top: 5 });
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create('没有账号?');
            Text.fontColor('#333333');
            Text.fontSize(13);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create('立即注册');
            Text.fontColor('#1890FF');
            Text.fontSize(13);
            Text.margin({ left: 5 });
            Text.onClick(() => {
                promptAction.showToast({
                    message: '立即注册',
                    duration: 2000
                });
            });
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        Row.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            __Common__.create();
            __Common__.height(45);
            __Common__.width('100%');
            __Common__.margin({ top: 30 });
            if (!isInitialRender) {
                __Common__.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        {
            this.observeComponentCreation((elmtId, isInitialRender) => {
                ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                if (isInitialRender) {
                    ViewPU.create(new ClearEditText(this, {
                        content: this.__phone,
                        inputType: InputType.PhoneNumber,
                        maxLength: 11,
                        hintText: '请输入手机号码',
                        onChange: (value) => {
                            this.phone = value;
                            this.getBtnBackground();
                        }
                    }, undefined, elmtId));
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {});
                }
                ViewStackProcessor.StopGetAccessRecording();
            });
        }
        __Common__.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Line.create();
            Line.height(0.5);
            Line.stroke('#D1D1D1');
            Line.startPoint([0, 0]);
            Line.endPoint([Math.round((this.screenWidth) - 30), 0]);
            if (!isInitialRender) {
                Line.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            __Common__.create();
            __Common__.height(45);
            __Common__.width('100%');
            if (!isInitialRender) {
                __Common__.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        {
            this.observeComponentCreation((elmtId, isInitialRender) => {
                ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                if (isInitialRender) {
                    ViewPU.create(new ClearEditText(this, { content: this.__pwd, inputType: InputType.Password, hintText: '请输入密码', onChange: (value) => {
                            this.pwd = value;
                            this.getBtnBackground();
                        } }, undefined, elmtId));
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {});
                }
                ViewStackProcessor.StopGetAccessRecording();
            });
        }
        __Common__.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Line.create();
            Line.height(0.5);
            Line.stroke('#D1D1D1');
            Line.startPoint([0, 0]);
            Line.endPoint([Math.round((this.screenWidth) - 30), 0]);
            if (!isInitialRender) {
                Line.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Button.createWithLabel('登陆');
            Button.width(this.screenWidth - 30);
            Button.height(44);
            Button.margin({ top: 15 });
            Button.backgroundColor(this.btnColor);
            Button.id('login');
            Button.onClick((event) => {
                this.viewModel.login(this.phone, this.pwd);
            });
            if (!isInitialRender) {
                Button.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Button.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create('忘记密码');
            Text.fontColor('#999999');
            Text.fontSize(13);
            Text.padding({ top: 5, bottom: 5 });
            Text.margin({ top: 5, bottom: 10 });
            Text.onClick(() => {
                ToastUtil.showToast('忘记密码');
            });
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Image.create({ "id": 33554436, "type": 20000, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" });
            Image.width(23);
            Image.height(23);
            if (!isInitialRender) {
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create('我已阅读并同意');
            Text.fontSize(13);
            Text.fontColor('#999999');
            Text.margin({ left: 5 });
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create('服务协议、');
            Text.fontSize(13);
            Text.fontColor('#1890FF');
            Text.onClick(() => {
                promptAction.showToast({
                    message: '服务协议',
                    duration: 2000
                });
            });
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create('隐私权政策');
            Text.fontSize(13);
            Text.fontColor('#1890FF');
            Text.onClick(() => {
                promptAction.showToast({
                    message: '隐私权政策',
                    duration: 2000
                });
            });
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        Row.pop();
        Column.pop();
    }
    getBtnBackground() {
        this.btnColor =
            (StringUtil.isEmpty(this.phone) || StringUtil.isEmpty(this.pwd)) ? '#991890FF' : '#1890FF';
    }
    rerender() {
        this.updateDirtyElements();
    }
}
ViewStackProcessor.StartGetAccessRecordingFor(ViewStackProcessor.AllocateNewElmetIdForNextComponent());
loadDocument(new LoginPage(undefined, {}));
ViewStackProcessor.StopGetAccessRecording();
//# sourceMappingURL=LoginPage.js.map