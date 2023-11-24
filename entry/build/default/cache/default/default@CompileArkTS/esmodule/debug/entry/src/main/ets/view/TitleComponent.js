import hilog from '@ohos:hilog';
import { FontSize, TitleBarStyle, WEIGHT } from '@bundle:com.example.rankdemo/entry/ets/common/constants/Constants';
export class TitleComponent extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.__isRefreshData = new SynchedPropertySimpleTwoWayPU(params.isRefreshData, this, "isRefreshData");
        this.__title = new ObservedPropertyObjectPU({ "id": 33554433, "type": 10003, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" }, this, "title");
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
        this.__isRefreshData.purgeDependencyOnElmtId(rmElmtId);
        this.__title.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__isRefreshData.aboutToBeDeleted();
        this.__title.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get isRefreshData() {
        return this.__isRefreshData.get();
    }
    set isRefreshData(newValue) {
        this.__isRefreshData.set(newValue);
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
            Row.width(WEIGHT);
            Row.padding({ left: TitleBarStyle.BAR_MARGIN_HORIZONTAL,
                right: TitleBarStyle.BAR_MARGIN_HORIZONTAL });
            Row.margin({ top: TitleBarStyle.BAR_MARGIN_TOP });
            Row.height(TitleBarStyle.BAR_HEIGHT);
            Row.justifyContent(FlexAlign.SpaceAround);
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            Row.width(TitleBarStyle.WEIGHT);
            Row.height(WEIGHT);
            Row.justifyContent(FlexAlign.Start);
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Image.create({ "id": 33554435, "type": 20000, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" });
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
            Text.fontSize(FontSize.LARGE);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        Row.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            Row.width(TitleBarStyle.WEIGHT);
            Row.height(WEIGHT);
            Row.justifyContent(FlexAlign.End);
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Image.create({ "id": 33554495, "type": 20000, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" });
            Image.height(TitleBarStyle.IMAGE_LOADING_SIZE);
            Image.width(TitleBarStyle.IMAGE_LOADING_SIZE);
            Image.onClick(() => {
                this.isRefreshData = !this.isRefreshData;
            });
            if (!isInitialRender) {
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Row.pop();
        Row.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
//# sourceMappingURL=TitleComponent.js.map