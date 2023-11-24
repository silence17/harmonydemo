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

import { TitleComponent } from '../view/TitleComponent';
import { TITLE, WEIGHT } from '../common/constants/Constants';
import hilog from '@ohos.hilog';
import router from '@ohos.router';
import common from '@ohos.app.ability.common';

/**
 * @Entry装饰的自定义组件为页面的入口组件，即页面的根节点。只有被@Entry装饰的组件才能调用页面的生命周期
 * @Component装饰的自定义组件，称为UI组件。
 *
 * 被entry装饰的component作为页面的主入口
 *
 * 创建Page时，需要在main_pages.json中进行注册
 */
@Entry
@Component
struct TestPage {
  @State isSwitchDataSource: boolean = false;
  @State message: string = 'Hello World'
  private context = getContext(this) as common.UIAbilityContext;

  onPageShow() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'RankPage onPageShow');

    var tag: String = router.getParams()?.['src'];
    hilog.debug(0x000, 'testTag', '%{public}s', tag)
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

  build() {
    Column() {
      // Title component in the top.
      TitleComponent({ isRefreshData: $isSwitchDataSource, title: TITLE })
      Text(this.message)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
      Button('点击信息').width(100).height(50).onClick((event ?: ClickEvent) => {

        this.message = 'Click Point:' + '\n  screenX:' + event.screenX + '\n  screenY:' + event.screenY
        + '\n  x:' + event.x + '\n  y:' + event.y + '\ntarget:' + '\n  component globalPos:('
        + event.target.area.globalPosition.x + ',' + event.target.area.globalPosition.y + ')\n  width:'
        + event.target.area.width + '\n  height:' + event.target.area.height + '\ntimestamp' + event.timestamp;

      });
      //线性布局；Row构造方法，间距20
      Row({ space: 20 }) {
        Text('layoutWeight(1)')
          .size({ width: '30%', height: 60 })
          .backgroundColor(0xFFEFF5)
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
        Text('layoutWeight(2)')
          .size({ width: '30%', height: 60 })
          .backgroundColor(0xF5DEB3)
          .textAlign(TextAlign.Center)
          .layoutWeight(2)
        Text('layoutWeight(3)')
          .size({ width: '30%', height: 60 })
          .backgroundColor(0xD2B48C)
          .textAlign(TextAlign.Center)
          .layoutWeight(3)
      }
      //.size({ width: '90%', height: 140 })
      .align(Alignment.Center)
      .aspectRatio(4)
      .alignItems(VerticalAlign.Bottom)
      .backgroundColor(0x989A9C);

      //层叠布局（Stack）
      Stack({ alignContent: Alignment.BottomEnd }) {
        Text('Text1').size({ width: 120, height: 80 })
          .align(Alignment.TopStart)
          .backgroundColor(0xF3F4F5)
        Text('Text2').size({ width: 80, height: 50 }).backgroundColor(0xF30000)
      }
      .backgroundColor(0xff9A9C)
      .width('100%')
      .height(100)

      //弹性布局（Flex）
      Flex({
        direction: FlexDirection.Row,
        //换行，每一行子组件按照主轴方向排列。
        //wrap: FlexWrap.Wrap,
        justifyContent: FlexAlign.SpaceBetween,
        //交叉轴对齐方式
        alignItems: ItemAlign.Center }) {
        Text('Text3').size({ width: 120, height: 30 })
          //文案居中
          //.align(Alignment.TopStart)
          .backgroundColor(0xF9F9F9)
            //子组件的alignSelf属性也可以设置子组件在父容器交叉轴的对齐格式,与wrap属性冲突
          .alignSelf(ItemAlign.End)
        Text('Text4').size({ width: 80, height: 80 }).backgroundColor(0xF30000)
        Text('Text5').size({ width: 80, height: 50 }).backgroundColor(0x00F300)
        // Text('Text6').size({ width: 80, height: 50 }).backgroundColor(0xF300F3)
        // Text('Text7').size({ width: 80, height: 50 }).backgroundColor(0x330000)
        // Text('Text8').size({ width: 80, height: 50 }).backgroundColor(0x33FF00)
        // Text('Text9').size({ width: 80, height: 50 }).backgroundColor(0x33FF33)
        // Text('Text10').size({ width: 80, height: 50 }).backgroundColor(0xF30000)
      }.padding(5)

      //相对布局
      RelativeContainer() {

        Text('Text11').size({ width: 100, height: 100 }).backgroundColor(0xFF0000)
          // 添加其他属性
          .alignRules({
            top: { anchor: '__container__', align: VerticalAlign.Top },
            left: { anchor: '__container__', align: HorizontalAlign.Start }
          })
          .id("row1")

        Text('Text11').size({ width: 100, height: 100 }).backgroundColor(0x0000FF)
          .alignRules({
            //上面，以row1为锚点，row2的顶部在row1的底部
            top: { anchor: 'row1', align: VerticalAlign.Bottom },
            right: { anchor: '__container__', align: HorizontalAlign.End }
          })
          .id("row2")
      }.width('100%').height(250)


      //FlexExampleComponent()
    }
    .backgroundColor($r('app.color.background'))
    .height(WEIGHT)
    .width(WEIGHT)
  }
}

