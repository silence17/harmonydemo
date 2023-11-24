import hilog from '@ohos:hilog';
import { FontSize, TitleBarStyle, WEIGHT } from '@bundle:com.example.rankdemo/entry/ets/common/constants/Constants';
export class CommonTitleComponent extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.__title = new ObservedPropertyObjectPU({ "id": 33554466, "type": 10003, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" }, this, "title");
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
        if (params.title !== undefined) {
            this.title = params.title;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__title.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__title.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get title() {
        return this.__title.get();
    }
    set title(newValue) {
        this.__title.set(newValue);
    }
    onPageShow() {
        hilog.info(0x0000, 'testTag', '%{public}s', 'TitleComponent onPageShow');
    }
    initialRender() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            Row.debugLine("view/CommonTitleComponent.ets(29:5)");
            Row.width(WEIGHT);
            Row.padding({ left: TitleBarStyle.BAR_MARGIN_HORIZONTAL,
                right: TitleBarStyle.BAR_MARGIN_HORIZONTAL });
            Row.margin({ top: TitleBarStyle.BAR_MARGIN_TOP });
            Row.height(TitleBarStyle.BAR_HEIGHT);
            Row.justifyContent(FlexAlign.SpaceBetween);
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Image.create({ "id": 33554493, "type": 20000, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" });
            Image.debugLine("view/CommonTitleComponent.ets(30:7)");
            Image.height(TitleBarStyle.IMAGE_BACK_SIZE);
            Image.width(TitleBarStyle.IMAGE_BACK_SIZE);
            Image.margin({ right: TitleBarStyle.IMAGE_BACK_MARGIN_RIGHT });
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
            Text.debugLine("view/CommonTitleComponent.ets(38:7)");
            Text.fontSize(FontSize.LARGE);
            Text.fontColor('#333333');
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create({ "id": 33554491, "type": 20000, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" });
            Text.debugLine("view/CommonTitleComponent.ets(43:7)");
            Text.height(TitleBarStyle.IMAGE_LOADING_SIZE);
            Text.width(TitleBarStyle.IMAGE_LOADING_SIZE);
            Text.onClick(() => {
            });
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        Row.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
//# sourceMappingURL=CommonTitleComponent.js.map