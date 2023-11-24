export class ClearEditText extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.__content = new SynchedPropertySimpleTwoWayPU(params.content, this, "content");
        this.__isEmpty = new ObservedPropertySimplePU(true
        //键盘类型
        , this, "isEmpty");
        this.inputType = InputType.Normal;
        this.maxLength = 65535;
        this.hintText = '';
        this.onChange = (value) => {
        };
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
        if (params.isEmpty !== undefined) {
            this.isEmpty = params.isEmpty;
        }
        if (params.inputType !== undefined) {
            this.inputType = params.inputType;
        }
        if (params.maxLength !== undefined) {
            this.maxLength = params.maxLength;
        }
        if (params.hintText !== undefined) {
            this.hintText = params.hintText;
        }
        if (params.onChange !== undefined) {
            this.onChange = params.onChange;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__content.purgeDependencyOnElmtId(rmElmtId);
        this.__isEmpty.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__content.aboutToBeDeleted();
        this.__isEmpty.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get content() {
        return this.__content.get();
    }
    set content(newValue) {
        this.__content.set(newValue);
    }
    get isEmpty() {
        return this.__isEmpty.get();
    }
    set isEmpty(newValue) {
        this.__isEmpty.set(newValue);
    }
    initialRender() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            Row.debugLine("../../../../common_lib/src/main/ets/components/view/ClearEditText.ets(17:5)");
            Row.height(45);
            Row.width('100%');
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            TextInput.create({ text: this.content, placeholder: this.hintText });
            TextInput.debugLine("../../../../common_lib/src/main/ets/components/view/ClearEditText.ets(18:7)");
            TextInput.height('100%');
            TextInput.placeholderColor('#CBCBCB');
            TextInput.fontSize(16);
            TextInput.type(this.inputType);
            TextInput.maxLength(this.maxLength);
            TextInput.showPasswordIcon(true);
            TextInput.backgroundColor(Color.Transparent);
            TextInput.layoutWeight(1);
            TextInput.padding({ left: 0, right: 10 });
            TextInput.onChange((value) => {
                this.isEmpty = (value === null || value.length === 0);
                if (this.onChange != null) {
                    this.onChange(value);
                }
            });
            if (!isInitialRender) {
                TextInput.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            If.create();
            if (!this.isEmpty) {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        Image.create({ "id": 33554437, "type": 20000, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" });
                        Image.debugLine("../../../../common_lib/src/main/ets/components/view/ClearEditText.ets(36:9)");
                        Image.height('100%');
                        Image.aspectRatio(1);
                        Image.padding(15);
                        Image.onClick(() => {
                            this.content = '';
                        });
                        if (!isInitialRender) {
                            Image.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                });
            }
            else {
                If.branchId(1);
            }
            if (!isInitialRender) {
                If.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        If.pop();
        Row.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
//# sourceMappingURL=ClearEditText.js.map