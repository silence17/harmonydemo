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
/**
 * The font size of application.
 */
export var FontSize;
(function (FontSize) {
    FontSize[FontSize["SMALL"] = 14] = "SMALL";
    FontSize[FontSize["MIDDLE"] = 16] = "MIDDLE";
    FontSize[FontSize["LARGE"] = 20] = "LARGE";
})(FontSize || (FontSize = {}));
;
/**
 * The font weight of application.
 */
export var FontWeight;
(function (FontWeight) {
    FontWeight["BOLD"] = "400";
    FontWeight["BOLDER"] = "500";
})(FontWeight || (FontWeight = {}));
;
/**
 * The weight is global default value for component size.
 */
export const WEIGHT = '100%';
/**
 * The duration of toast.
 */
export const TIME = 1000;
/**
 * The interval time of exit.
 */
export const APP_EXIT_INTERVAL = 4500;
/**
 * The tag is the page name,which is used to print.
 */
export const TAG = 'RankPage';
/**
 * The title of TitleComponent.
 */
export const TITLE = { "id": 33554469, "type": 10003, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" };
class style {
    constructor() {
        this.RANK_PADDING = 15;
        this.CONTENT_WIDTH = '90%';
        this.BORDER_RADIUS = 20;
        this.STROKE_WIDTH = 1;
        this.HEADER_MARGIN_TOP = 20;
        this.HEADER_MARGIN_BOTTOM = 15;
        this.LIST_HEIGHT = '65%';
    }
}
/**
 * The Style of RankPage.
 */
export const Style = {
    /**
     * The padding of ranking.
     */
    RANK_PADDING: 15,
    /**
     * The width of ranking content.
     */
    CONTENT_WIDTH: '90%',
    /**
     * The border radius.
     */
    BORDER_RADIUS: 20,
    /**
     * The stroke width of divider.
     */
    STROKE_WIDTH: 1,
    /**
     * The top margin of ranking header.
     */
    HEADER_MARGIN_TOP: 20,
    /**
     * The bottom margin of ranking header.
     */
    HEADER_MARGIN_BOTTOM: 15,
    /**
     * The height of list.
     */
    LIST_HEIGHT: '65%'
};
class listHeaderStyle {
    constructor() {
        this.FONT_WEIGHT = 400;
        this.LAYOUT_WEIGHT_LEFT = '30%';
        this.LAYOUT_WEIGHT_CENTER = '50%';
        this.LAYOUT_WEIGHT_RIGHT = '20%';
    }
}
/**
 * The Style of ListHeaderComponent.
 */
export const ListHeaderStyle = {
    /**
     * The weight of font.
     */
    FONT_WEIGHT: 400,
    /**
     * The layout weight of left.
     */
    LAYOUT_WEIGHT_LEFT: '30%',
    /**
     * The layout weight of center.
     */
    LAYOUT_WEIGHT_CENTER: '50%',
    /**
     * The layout weight of right.
     */
    LAYOUT_WEIGHT_RIGHT: '20%',
};
class itemStyle {
    constructor() {
        this.TEXT_LAYOUT_SIZE = 24;
        this.CIRCLE_TEXT_BORDER_RADIUS = 24;
        this.CIRCLE_TEXT_SIZE = 24;
        this.CIRCLE_TEXT_COLOR_STOP_1 = 0.5;
        this.CIRCLE_TEXT_COLOR_STOP_2 = 1.0;
        this.BAR_HEIGHT = 48;
        this.LAYOUT_WEIGHT_LEFT = '30%';
        this.LAYOUT_WEIGHT_CENTER = '50%';
        this.LAYOUT_WEIGHT_RIGHT = '20%';
        this.BORDER_WIDTH = 1;
        this.COLOR_BLUE = { "id": 33554476, "type": 10001, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" };
        this.COLOR_BLACK = { "id": 33554477, "type": 10001, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" };
    }
}
/**
 * The Style of ListItemComponent.
 */
export const ItemStyle = {
    /**
     * The line height of text.
     */
    TEXT_LAYOUT_SIZE: 24,
    /**
     * The border radius of circle text.
     */
    CIRCLE_TEXT_BORDER_RADIUS: 24,
    /**
     * The size of circle text.
     */
    CIRCLE_TEXT_SIZE: 24,
    /**
     * Gradient color proportion.
     */
    CIRCLE_TEXT_COLOR_STOP_1: 0.5,
    /**
     * Gradient color proportion.
     */
    CIRCLE_TEXT_COLOR_STOP_2: 1.0,
    /**
     * The height of item.
     */
    BAR_HEIGHT: 48,
    /**
     * The layout weight of left.
     */
    LAYOUT_WEIGHT_LEFT: '30%',
    /**
     * The layout weight of center.
     */
    LAYOUT_WEIGHT_CENTER: '50%',
    /**
     * The layout weight of right.
     */
    LAYOUT_WEIGHT_RIGHT: '20%',
    /**
     * The width of border.
     */
    BORDER_WIDTH: 1,
    /**
     * The blue color of item.
     */
    COLOR_BLUE: { "id": 33554476, "type": 10001, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" },
    /**
     * The black color of item.
     */
    COLOR_BLACK: { "id": 33554477, "type": 10001, params: [], "bundleName": "com.example.rankdemo", "moduleName": "entry" }
};
class titleBarStyle {
    constructor() {
        this.IMAGE_BACK_SIZE = 21;
        this.IMAGE_BACK_MARGIN_RIGHT = 18;
        this.IMAGE_LOADING_SIZE = 22;
        this.BAR_HEIGHT = 47;
        this.BAR_MARGIN_HORIZONTAL = 26;
        this.BAR_MARGIN_TOP = 10;
        this.WEIGHT = '50%';
    }
}
/**
 * The Style of TitleComponent.
 */
export const TitleBarStyle = {
    /**
     * The image size of back button.
     */
    IMAGE_BACK_SIZE: 21,
    /**
     * The right margin of back button.
     */
    IMAGE_BACK_MARGIN_RIGHT: 18,
    /**
     * The size of loading image.
     */
    IMAGE_LOADING_SIZE: 22,
    /**
     * The height of TitleComponent.
     */
    BAR_HEIGHT: 47,
    /**
     * The horizontal margin of TitleComponent.
     */
    BAR_MARGIN_HORIZONTAL: 26,
    /**
     * The top margin of TitleComponent.
     */
    BAR_MARGIN_TOP: 10,
    /**
     * The weight of Row layout.
     */
    WEIGHT: '50%',
};
//# sourceMappingURL=Constants.js.map