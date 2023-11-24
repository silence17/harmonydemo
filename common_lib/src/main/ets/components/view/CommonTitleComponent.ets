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

import AppContext from '@ohos.app.ability.common';
import hilog from '@ohos.hilog';
import { Log } from '../../utils/Log/Log';


@Component
export struct CommonTitleComponent {
  title: Resource = $r('app.string.default_str');
  rightContent: string = ''
  //右侧菜单点击回调
  callback: Function

  onPageShow() {
    Log.debug('testTag  TitleComponent onPageShow');
  }

  build() {
    Flex({ justifyContent: FlexAlign.SpaceBetween, direction: FlexDirection.Row, alignItems: ItemAlign.Center }) {
      Image($r('app.media.ic_public_back'))
        .height(48)
        .width(48)
        .padding(14)
        .onClick(() => {
          let handler = getContext(this) as AppContext.UIAbilityContext;
          handler.terminateSelf();
        })
      Text(this.title)
        .fontSize(20)
        .fontColor('#333333')
        .margin({ left: 10, right: 10 })

      Text(this.rightContent)
        .width(48)
        .height(48)
        .onClick((event) => {
          if (this.callback != null) {
            this.callback(this)
          }
        })
    }
    .width('100%')
    .height(48)
  }
}