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
import router from '@ohos.router';
import common from '@ohos.app.ability.common';

import { FontSize, FontWeight, ItemStyle, WEIGHT } from '../common/constants/Constants';
import hilog from '@ohos.hilog';
import { Log } from '@app/common_lib/src/main/ets/utils/Log/Log';

@Component
export struct ListItemComponent {
  index?: number;
  private name?: Resource;
  //@Prop与@State有相同的语义，但初始化方式不同。@Prop装饰的变量必须使用其父组件提供的@State变量进行初始化
  //@Prop属于单向数据绑定
  @Prop vote: string = '';
  @Prop isSwitchDataSource: boolean = false;
  // The state is related to the font color of ListItemComponent.
  @State isChange: boolean = false;

  build() {
    Row() {
      Column() {
        if (this.isRenderCircleText()) {
          if (this.index !== undefined) {
            this.CircleText(this.index);
          }
        } else {
          Text(this.index?.toString())
            .lineHeight(ItemStyle.TEXT_LAYOUT_SIZE)
            .textAlign(TextAlign.Center)
            .width(ItemStyle.TEXT_LAYOUT_SIZE)
            .fontWeight(FontWeight.BOLD)
            .fontSize(FontSize.SMALL)
        }
      }
      .width(ItemStyle.LAYOUT_WEIGHT_LEFT)
      .alignItems(HorizontalAlign.Start)

      Text(this.name)
        .width(ItemStyle.LAYOUT_WEIGHT_CENTER)
        .fontWeight(FontWeight.BOLDER)
        .fontSize(FontSize.MIDDLE)
        .fontColor(this.isChange ? ItemStyle.COLOR_BLUE : ItemStyle.COLOR_BLACK)
      Text(this.vote)
        .width(ItemStyle.LAYOUT_WEIGHT_RIGHT)
        .fontWeight(FontWeight.BOLD)
        .fontSize(FontSize.SMALL)
        .fontColor(this.isChange ? ItemStyle.COLOR_BLUE : ItemStyle.COLOR_BLACK)
    }
    .height(ItemStyle.BAR_HEIGHT)
    .width(WEIGHT)
    .onClick((event?: ClickEvent) => {
      this.isSwitchDataSource = !this.isSwitchDataSource;
      this.isChange = !this.isChange;

      //调用 router.push () 方法，跳转到 Ability 内的指定页面
      // router.pushUrl({
      //   url: 'pages/TestPage',
      //   params: {
      //     src: 'From Rank List'
      //   }
      // }, router.RouterMode.Single)

      //触发指定事件
      (getContext(this) as common.UIAbilityContext).eventHub.emit('myEvent');

      Log.debug("ListItemComponent", "item click")
    })
  }

  @Builder CircleText(index: number) {
    Row() {
      Text(this.index?.toString())
        .fontWeight(FontWeight.BOLD)
        .fontSize(FontSize.SMALL)
        .fontColor(Color.White);
    }
    .justifyContent(FlexAlign.Center)
    .borderRadius(ItemStyle.CIRCLE_TEXT_BORDER_RADIUS)
    .size({ width: ItemStyle.CIRCLE_TEXT_SIZE,
      height: ItemStyle.CIRCLE_TEXT_SIZE })
    .backgroundColor($r('app.color.circle_text_background'))
  }

  isRenderCircleText(): boolean {


    // Just render the element before the fourth in the list.
    return this.index === 1 || this.index === 2 || this.index === 3;
  }
}