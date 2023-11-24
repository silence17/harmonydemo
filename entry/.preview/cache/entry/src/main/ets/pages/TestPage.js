import { TitleComponent } from '@bundle:com.example.rankdemo/entry/ets/view/TitleComponent';
import { TITLE, WEIGHT } from '@bundle:com.example.rankdemo/entry/ets/common/constants/Constants';
import hilog from '@ohos:hilog';
import router from '@ohos:router';
class TestPage extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.__isSwitchDataSource = new ObservedPropertySimplePU(false, this, "isSwitchDataSource");
        this.__message = new ObservedPropertySimplePU('Hello World', this, "message");
        this.context = getContext(this);
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
        if (params.isSwitchDataSource !== undefined) {
            this.isSwitchDataSource = params.isSwitchDataSource;
        }
        if (params.message !== undefined) {
            this.message = params.message;
        }
        if (params.context !== undefined) {
            this.context = params.context;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__isSwitchDataSource.purgeDependencyOnElmtId(rmElmtId);
        this.__message.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__isSwitchDataSource.aboutToBeDeleted();
        this.__message.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get isSwitchDataSource() {
        return this.__isSwitchDataSource.get();
    }
    set isSwitchDataSource(newValue) {
        this.__isSwitchDataSource.set(newValue);
    }
    get message() {
        return this.__message.get();
    }
    set message(newValue) {
        this.__message.set(newValue);
    }
    onPageShow() {
        var _a;
        hilog.info(0x0000, 'testTag', '%{public}s', 'RankPage onPageShow');
        var tag = (_a = router.getParams()) === null || _a === void 0 ? void 0 : _a['src'];
        hilog.debug(0x000, 'testTag', '%{public}s', tag);
    }
    /**
     * 组件的声明周期 @Component
     * 组件即将出现时回调该接口，具体时机为在创建自定义组件的新实例后，在执行其build()函数之前执行
     */
    aboutToAppear() {
    }
    /**
     * 组件的声明周期 @Component
     * 在自定义组件即将销毁时执行
     */
    aboutToDisappear() {
    }
    initialRender() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.debugLine("pages/TestPage.ets(66:5)");
            Column.backgroundColor({ "id": 33554472, "type": 10001, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" });
            Column.height(WEIGHT);
            Column.width(WEIGHT);
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
                    // Title component in the top.
                    TitleComponent(this, { isRefreshData: this.__isSwitchDataSource, title: TITLE }, undefined, elmtId));
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {});
                }
                ViewStackProcessor.StopGetAccessRecording();
            });
        }
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(this.message);
            Text.debugLine("pages/TestPage.ets(69:7)");
            Text.fontSize(20);
            Text.fontWeight(FontWeight.Bold);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Button.createWithLabel('点击信息');
            Button.debugLine("pages/TestPage.ets(72:7)");
            Button.width(100);
            Button.height(50);
            Button.onClick((event) => {
                this.message = 'Click Point:' + '\n  screenX:' + event.screenX + '\n  screenY:' + event.screenY
                    + '\n  x:' + event.x + '\n  y:' + event.y + '\ntarget:' + '\n  component globalPos:('
                    + event.target.area.globalPosition.x + ',' + event.target.area.globalPosition.y + ')\n  width:'
                    + event.target.area.width + '\n  height:' + event.target.area.height + '\ntimestamp' + event.timestamp;
            });
            if (!isInitialRender) {
                Button.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Button.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            //线性布局；Row构造方法，间距20
            Row.create({ space: 20 });
            Row.debugLine("pages/TestPage.ets(81:7)");
            //线性布局；Row构造方法，间距20
            Row.align(Alignment.Center);
            //线性布局；Row构造方法，间距20
            Row.aspectRatio(4);
            //线性布局；Row构造方法，间距20
            Row.alignItems(VerticalAlign.Bottom);
            //线性布局；Row构造方法，间距20
            Row.backgroundColor(0x989A9C);
            if (!isInitialRender) {
                //线性布局；Row构造方法，间距20
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create('layoutWeight(1)');
            Text.debugLine("pages/TestPage.ets(82:9)");
            Text.size({ width: '30%', height: 60 });
            Text.backgroundColor(0xFFEFF5);
            Text.textAlign(TextAlign.Center);
            Text.layoutWeight(1);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create('layoutWeight(2)');
            Text.debugLine("pages/TestPage.ets(87:9)");
            Text.size({ width: '30%', height: 60 });
            Text.backgroundColor(0xF5DEB3);
            Text.textAlign(TextAlign.Center);
            Text.layoutWeight(2);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create('layoutWeight(3)');
            Text.debugLine("pages/TestPage.ets(92:9)");
            Text.size({ width: '30%', height: 60 });
            Text.backgroundColor(0xD2B48C);
            Text.textAlign(TextAlign.Center);
            Text.layoutWeight(3);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        //线性布局；Row构造方法，间距20
        Row.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            //层叠布局（Stack）
            Stack.create({ alignContent: Alignment.BottomEnd });
            Stack.debugLine("pages/TestPage.ets(105:7)");
            //层叠布局（Stack）
            Stack.backgroundColor(0xff9A9C);
            //层叠布局（Stack）
            Stack.width('100%');
            //层叠布局（Stack）
            Stack.height(100);
            if (!isInitialRender) {
                //层叠布局（Stack）
                Stack.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create('Text1');
            Text.debugLine("pages/TestPage.ets(106:9)");
            Text.size({ width: 120, height: 80 });
            Text.align(Alignment.TopStart);
            Text.backgroundColor(0xF3F4F5);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create('Text2');
            Text.debugLine("pages/TestPage.ets(109:9)");
            Text.size({ width: 80, height: 50 });
            Text.backgroundColor(0xF30000);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        //层叠布局（Stack）
        Stack.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            //弹性布局（Flex）
            Flex.create({
                direction: FlexDirection.Row,
                //换行，每一行子组件按照主轴方向排列。
                //wrap: FlexWrap.Wrap,
                justifyContent: FlexAlign.SpaceBetween,
                //交叉轴对齐方式
                alignItems: ItemAlign.Center
            });
            Flex.debugLine("pages/TestPage.ets(116:7)");
            //弹性布局（Flex）
            Flex.padding(5);
            if (!isInitialRender) {
                //弹性布局（Flex）
                Flex.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create('Text3');
            Text.debugLine("pages/TestPage.ets(123:9)");
            Text.size({ width: 120, height: 30 });
            Text.backgroundColor(0xF9F9F9);
            Text.alignSelf(ItemAlign.End);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create('Text4');
            Text.debugLine("pages/TestPage.ets(129:9)");
            Text.size({ width: 80, height: 80 });
            Text.backgroundColor(0xF30000);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create('Text5');
            Text.debugLine("pages/TestPage.ets(130:9)");
            Text.size({ width: 80, height: 50 });
            Text.backgroundColor(0x00F300);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        //弹性布局（Flex）
        Flex.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            //相对布局
            RelativeContainer.create();
            RelativeContainer.debugLine("pages/TestPage.ets(139:7)");
            //相对布局
            RelativeContainer.width('100%');
            //相对布局
            RelativeContainer.height(250);
            if (!isInitialRender) {
                //相对布局
                RelativeContainer.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create('Text11');
            Text.debugLine("pages/TestPage.ets(141:9)");
            Text.size({ width: 100, height: 100 });
            Text.backgroundColor(0xFF0000);
            Text.alignRules({
                top: { anchor: '__container__', align: VerticalAlign.Top },
                left: { anchor: '__container__', align: HorizontalAlign.Start }
            });
            Text.id("row1");
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create('Text11');
            Text.debugLine("pages/TestPage.ets(149:9)");
            Text.size({ width: 100, height: 100 });
            Text.backgroundColor(0x0000FF);
            Text.alignRules({
                //上面，以row1为锚点，row2的顶部在row1的底部
                top: { anchor: 'row1', align: VerticalAlign.Bottom },
                right: { anchor: '__container__', align: HorizontalAlign.End }
            });
            Text.id("row2");
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        //相对布局
        RelativeContainer.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
ViewStackProcessor.StartGetAccessRecordingFor(ViewStackProcessor.AllocateNewElmetIdForNextComponent());
loadDocument(new TestPage(undefined, {}));
ViewStackProcessor.StopGetAccessRecording();
//# sourceMappingURL=TestPage.js.map