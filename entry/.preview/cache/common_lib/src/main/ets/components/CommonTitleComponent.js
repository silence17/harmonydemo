import hilog from '@ohos:hilog';
export class CommonTitleComponent extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.title = { "id": 33554433, "type": 10003, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" };
        this.rightContent = '';
        this.callback = undefined;
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
        if (params.title !== undefined) {
            this.title = params.title;
        }
        if (params.rightContent !== undefined) {
            this.rightContent = params.rightContent;
        }
        if (params.callback !== undefined) {
            this.callback = params.callback;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
    }
    aboutToBeDeleted() {
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    onPageShow() {
        hilog.info(0x0000, 'testTag', '%{public}s', 'TitleComponent onPageShow');
    }
    initialRender() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Flex.create({ justifyContent: FlexAlign.SpaceBetween, direction: FlexDirection.Row, alignItems: ItemAlign.Center });
            Flex.debugLine("../../../../common_lib/src/main/ets/components/CommonTitleComponent.ets(32:5)");
            Flex.width('100%');
            Flex.height(48);
            if (!isInitialRender) {
                Flex.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Image.create({ "id": 33554434, "type": 20000, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" });
            Image.debugLine("../../../../common_lib/src/main/ets/components/CommonTitleComponent.ets(33:7)");
            Image.height(48);
            Image.width(48);
            Image.padding(14);
            Image.onClick(() => {
                let handler = getContext(this);
                handler.terminateSelf();
            });
            if (!isInitialRender) {
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(this.title);
            Text.debugLine("../../../../common_lib/src/main/ets/components/CommonTitleComponent.ets(41:7)");
            Text.fontSize(20);
            Text.fontColor('#333333');
            Text.margin({ left: 10, right: 10 });
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(this.rightContent);
            Text.debugLine("../../../../common_lib/src/main/ets/components/CommonTitleComponent.ets(46:7)");
            Text.width(48);
            Text.height(48);
            Text.onClick((event) => {
                if (this.callback != null) {
                    this.callback(this);
                }
            });
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        Flex.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
//# sourceMappingURL=CommonTitleComponent.js.map