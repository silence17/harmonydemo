"use strict";
class NavigationExamplePage extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.arr = [1, 2, 3];
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
        if (params.arr !== undefined) {
            this.arr = params.arr;
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
            Column.create();
            Column.debugLine("pages/NavigationExamplePage.ets(7:5)");
            Column.height('100%');
            Column.width('100%');
            Column.backgroundColor('#F1F3F5');
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Navigation.create();
            Navigation.debugLine("pages/NavigationExamplePage.ets(8:7)");
            Navigation.title("主标题");
            Navigation.mode(NavigationMode.Split);
            Navigation.menus([
                { value: "", icon: "../resources/base/media/close.svg", action: () => {
                    } },
                { value: "", icon: "../resources/base/media/ic_public_back.svg", action: () => {
                    } },
                { value: "", icon: "../resources/base/media/close.svg", action: () => {
                    } },
                { value: "", icon: "../resources/base/media/loading.png", action: () => {
                    } },
                { value: "", icon: "../resources/base/media/close.svg", action: () => {
                    } }
            ]);
            Navigation.toolBar({ items: [
                    { value: "func", icon: "../resources/base/media/icon.png", action: () => {
                        } },
                    { value: "func", icon: "../resources/base/media/icon.png", action: () => {
                        } },
                    { value: "func", icon: "../resources/base/media/icon.png", action: () => {
                        } }
                ] });
            if (!isInitialRender) {
                Navigation.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            TextInput.create({ placeholder: 'search...' });
            TextInput.debugLine("pages/NavigationExamplePage.ets(9:9)");
            TextInput.width("90%");
            TextInput.height(40);
            TextInput.backgroundColor('#FFFFFF');
            if (!isInitialRender) {
                TextInput.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            List.create({ space: 12 });
            List.debugLine("pages/NavigationExamplePage.ets(14:9)");
            List.width("90%");
            List.margin({ top: 12 });
            if (!isInitialRender) {
                List.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            ForEach.create();
            const forEachItemGenFunction = _item => {
                const item = _item;
                {
                    const isLazyCreate = true;
                    const itemCreation = (elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        ListItem.create(deepRenderFunction, isLazyCreate);
                        ListItem.debugLine("pages/NavigationExamplePage.ets(16:13)");
                        if (!isInitialRender) {
                            ListItem.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    };
                    const observedShallowRender = () => {
                        this.observeComponentCreation(itemCreation);
                        ListItem.pop();
                    };
                    const observedDeepRender = () => {
                        this.observeComponentCreation(itemCreation);
                        this.observeComponentCreation((elmtId, isInitialRender) => {
                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                            NavRouter.create();
                            NavRouter.debugLine("pages/NavigationExamplePage.ets(17:15)");
                            if (!isInitialRender) {
                                NavRouter.pop();
                            }
                            ViewStackProcessor.StopGetAccessRecording();
                        });
                        this.observeComponentCreation((elmtId, isInitialRender) => {
                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                            Text.create("NavRouter" + item);
                            Text.debugLine("pages/NavigationExamplePage.ets(18:17)");
                            Text.width("100%");
                            Text.height(72);
                            Text.backgroundColor('#FFFFFF');
                            Text.borderRadius(24);
                            Text.fontSize(16);
                            Text.fontWeight(500);
                            Text.textAlign(TextAlign.Center);
                            if (!isInitialRender) {
                                Text.pop();
                            }
                            ViewStackProcessor.StopGetAccessRecording();
                        });
                        Text.pop();
                        this.observeComponentCreation((elmtId, isInitialRender) => {
                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                            NavDestination.create(() => {
                                this.observeComponentCreation((elmtId, isInitialRender) => {
                                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                    Text.create("NavDestinationContent" + item);
                                    Text.debugLine("pages/NavigationExamplePage.ets(27:19)");
                                    if (!isInitialRender) {
                                        Text.pop();
                                    }
                                    ViewStackProcessor.StopGetAccessRecording();
                                });
                                Text.pop();
                            });
                            NavDestination.title("NavDestinationTitle" + item);
                            NavDestination.debugLine("pages/NavigationExamplePage.ets(26:17)");
                            if (!isInitialRender) {
                                NavDestination.pop();
                            }
                            ViewStackProcessor.StopGetAccessRecording();
                        });
                        NavDestination.pop();
                        NavRouter.pop();
                        ListItem.pop();
                    };
                    const deepRenderFunction = (elmtId, isInitialRender) => {
                        itemCreation(elmtId, isInitialRender);
                        this.updateFuncByElmtId.set(elmtId, itemCreation);
                        this.observeComponentCreation((elmtId, isInitialRender) => {
                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                            NavRouter.create();
                            NavRouter.debugLine("pages/NavigationExamplePage.ets(17:15)");
                            if (!isInitialRender) {
                                NavRouter.pop();
                            }
                            ViewStackProcessor.StopGetAccessRecording();
                        });
                        this.observeComponentCreation((elmtId, isInitialRender) => {
                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                            Text.create("NavRouter" + item);
                            Text.debugLine("pages/NavigationExamplePage.ets(18:17)");
                            Text.width("100%");
                            Text.height(72);
                            Text.backgroundColor('#FFFFFF');
                            Text.borderRadius(24);
                            Text.fontSize(16);
                            Text.fontWeight(500);
                            Text.textAlign(TextAlign.Center);
                            if (!isInitialRender) {
                                Text.pop();
                            }
                            ViewStackProcessor.StopGetAccessRecording();
                        });
                        Text.pop();
                        this.observeComponentCreation((elmtId, isInitialRender) => {
                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                            NavDestination.create(() => {
                                this.observeComponentCreation((elmtId, isInitialRender) => {
                                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                    Text.create("NavDestinationContent" + item);
                                    Text.debugLine("pages/NavigationExamplePage.ets(27:19)");
                                    if (!isInitialRender) {
                                        Text.pop();
                                    }
                                    ViewStackProcessor.StopGetAccessRecording();
                                });
                                Text.pop();
                            });
                            NavDestination.title("NavDestinationTitle" + item);
                            NavDestination.debugLine("pages/NavigationExamplePage.ets(26:17)");
                            if (!isInitialRender) {
                                NavDestination.pop();
                            }
                            ViewStackProcessor.StopGetAccessRecording();
                        });
                        NavDestination.pop();
                        NavRouter.pop();
                        ListItem.pop();
                    };
                    if (isLazyCreate) {
                        observedShallowRender();
                    }
                    else {
                        observedDeepRender();
                    }
                }
            };
            this.forEachUpdateFunction(elmtId, this.arr, forEachItemGenFunction, item => item, false, false);
            if (!isInitialRender) {
                ForEach.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        ForEach.pop();
        List.pop();
        Navigation.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
ViewStackProcessor.StartGetAccessRecordingFor(ViewStackProcessor.AllocateNewElmetIdForNextComponent());
loadDocument(new NavigationExamplePage(undefined, {}));
ViewStackProcessor.StopGetAccessRecording();
//# sourceMappingURL=NavigationExamplePage.js.map