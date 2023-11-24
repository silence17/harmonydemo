/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import { FontSize, ListHeaderStyle } from '@bundle:com.example.rankdemo/entry/ets/common/constants/Constants';
export class ListHeaderComponent extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.paddingValue = 0;
        this.widthValue = 0;
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
        if (params.paddingValue !== undefined) {
            this.paddingValue = params.paddingValue;
        }
        if (params.widthValue !== undefined) {
            this.widthValue = params.widthValue;
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
    initialRender() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            Row.width(this.widthValue);
            Row.padding(this.paddingValue);
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create({ "id": 33554454, "type": 10003, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" });
            Text.fontSize(FontSize.SMALL);
            Text.width(ListHeaderStyle.LAYOUT_WEIGHT_LEFT);
            Text.fontWeight(ListHeaderStyle.FONT_WEIGHT);
            Text.fontColor({ "id": 33554462, "type": 10001, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" });
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create({ "id": 33554455, "type": 10003, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" });
            Text.fontSize(FontSize.SMALL);
            Text.width(ListHeaderStyle.LAYOUT_WEIGHT_CENTER);
            Text.fontWeight(ListHeaderStyle.FONT_WEIGHT);
            Text.fontColor({ "id": 33554462, "type": 10001, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" });
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create({ "id": 33554456, "type": 10003, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" });
            Text.fontSize(FontSize.SMALL);
            Text.width(ListHeaderStyle.LAYOUT_WEIGHT_RIGHT);
            Text.fontWeight(ListHeaderStyle.FONT_WEIGHT);
            Text.fontColor({ "id": 33554462, "type": 10001, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" });
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
//# sourceMappingURL=ListHeaderComponent.js.map