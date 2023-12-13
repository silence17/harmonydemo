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
import { RefreshLoadLayout } from '@app/common_lib/src/main/ets/components/view/RefreshLoadLayout';
import { RefreshLoadLayoutBean } from '@app/common_lib/src/main/ets/bean/RefreshLoadLayoutBean';
import { PageState } from '@app/common_lib/src/main/ets/app/GlobalConstant';
import { RefreshFailLayout } from '@app/common_lib/src/main/ets/components/view/RefreshFailLayout';
import { FailLayoutBean } from '@app/common_lib/src/main/ets/bean/FailLayoutBean';


/**
 * home
 */
@Preview
@Component
export struct HomeComponent {
  private displayWidth: number = px2vp(display.getDefaultDisplaySync().width)
  //状态切换
  @State pageState: PageState = PageState.Loading
  @State list: Array<RecommendBean> = new Array()
  @Provide viewModel: HomeViewModel = new HomeViewModel()
  scrollerListener: Scroller = new Scroller()

  aboutToAppear() {
    this.viewModel.getRecommendProducts((list: Array<RecommendBean>) => {
      this.pageState = PageState.Fail
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

        if (this.pageState == PageState.Loading) {
          this.LoadingLayout()
        } else if (this.pageState == PageState.Normal) {
          this.normalDraw()
        } else if (this.pageState == PageState.Fail) {
          this.FailLayout()
        }
      }
      .margin({ top: 45 })
    }.alignContent(Alignment.TopStart)
    .size({ width: '100%', height: '100%' })
    .backgroundColor('#F6F6F6')
  }

  @Builder normalDraw() {
    Grid(this.scrollerListener) {

      GridItem() {
        Banner()
      }.columnStart(1)
      .columnEnd(2)

      ForEach(this.list, (item: RecommendBean) => {
        GridItem() {
          this.itemDraw(item)
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


  /**
   * 推荐位item
   * @param item 推荐Bean
   */
  @Builder itemDraw(item: RecommendBean) {
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

  @Builder LoadingLayout() {
    RefreshLoadLayout({ loadBean: new RefreshLoadLayoutBean(true, $r('app.media.ic_pull_up_load'), '加载中...') })
  }

  @Builder FailLayout() {
    RefreshFailLayout({
      failBean: new FailLayoutBean(
        $r('app.media.fail_img_layout'),
        '您所在的机构还没有在蜂采平台开启商城采购哦，赶快联系平台管理员吧～',
        '点击刷新',
        (event: ClickEvent) => {
          ToastUtil.showToast("===== " + event.toString())

          this.viewModel.getRecommendProducts((list: Array<RecommendBean>) => {
            this.pageState = PageState.Normal
            this.list = list
            ToastUtil.showToast("==== " + list.length)
          })
        })
    })

  }
}

@Extend(Text) function commonText() {
  .fontSize(20)
}