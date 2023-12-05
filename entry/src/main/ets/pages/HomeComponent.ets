import { Log } from '@app/common_lib/src/main/ets/utils/Log/Log';
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
import { HomeViewModel } from '../viewmodel/HomeViewModel';
import display from '@ohos.display';
import { ToastUtil } from '@app/common_lib/src/main/ets/utils/ToastUtil';
import List from '@ohos.util.List';
import { RecommendBean } from '../bean/RecommendBean';
import ArrayList from '@ohos.util.ArrayList';
import { Banner } from '../view/banner/Banner';


/**
 * home
 */
@Preview
@Component
export struct HomeComponent {
  private displayWidth: number = px2vp(display.getDefaultDisplaySync().width)
  @State list: Array<RecommendBean> = new Array()
  @Provide viewModel: HomeViewModel = new HomeViewModel()
  scrollerListener: Scroller = new Scroller()

  aboutToAppear() {
    this.viewModel.getRecommendProducts((list: Array<RecommendBean>) => {
      this.list = list
      ToastUtil.showToast("==== " + list.length)
    })
  }

  build() {
    Stack() {
      Image($r('app.media.bg_home_top_enterprise'))
        .width('100%')

      /*搜索*/
      Row() {
        Text("搜索商品/规格/分类/店铺/企业")
          .fontSize(12)
          .fontColor('#999999')
          .layoutWeight(1)

        Image($r('app.media.icon_search'))
          .height(17)
          .width(17)
      }
      .borderWidth(1)
      .borderColor('#999999')
      .borderRadius(15)
      .backgroundColor(Color.White)
      .width(this.displayWidth - 20)
      .height(30)
      .margin({ left: 10, right: 10, top: 15 })
      .padding({ left: 10, right: 10 })
      .align(Alignment.Start)

      Column() {
        Grid(this.scrollerListener) {

          GridItem() {
            Banner()
          }.columnStart(1)
          .columnEnd(2)

          ForEach(this.list, (item: RecommendBean) => {
            GridItem() {
              Column() {
                Image(item.searchImgUrl)
                  .width('100%')
                  .height((this.displayWidth - 30) / 2)

                Text(item.productname)
                  .fontSize(17)
                  .fontColor('#333333')
                  .margin({ top: 10 })
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .width('100%')
                  .maxLines(2)
                  .textAlign(TextAlign.Start)
                  .padding({ left: 10, right: 10 })

                Row() {
                  Text(`¥` + item.salePrice.priceDesc)
                    .fontSize(14)
                    .fontColor('#FF5C00')

                  Text(`销量` + item.saleCountDesc)
                    .fontSize(12)
                    .fontColor('#333333')
                }.justifyContent(FlexAlign.SpaceBetween)
                .width('100%')
                .margin({ top: 2 })
                .padding({ left: 10, right: 10 })
              }
              .width('100%')
              .padding({ bottom: 10 })
              .borderRadius(10)
              .backgroundColor(Color.White)
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(10)
        .rowsGap(10)
        .width('100%')
        .padding(10)
        .onScrollIndex((first: number) => {
          console.info(first.toString())
        })
      }
      .margin({ top: 45 })
    }.alignContent(Alignment.TopStart)
    .size({ width: '100%', height: '100%' })
    .backgroundColor('#F6F6F6')
  }
}

@Extend(Text) function commonText() {
  .fontSize(20)
}