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
import { JumpAbility } from '@app/common_lib/src/main/ets/utils/JumpAbility';
import { PageState } from '@app/common_lib/src/main/ets/app/GlobalConstant';
import { RefreshFailLayout } from '@app/common_lib/src/main/ets/components/view/RefreshFailLayout';
import { FailLayoutBean } from '@app/common_lib/src/main/ets/bean/FailLayoutBean';
import { IconBean } from '../bean/IconBean';
import { StringUtil } from '@app/common_lib/src/main/ets/utils/StringUtil';
import { CountEditText } from '@app/common_lib/src/main/ets/components/view/CountEditText';
import { UserUtil } from '../util/UserUtil';

/**
 * home
 *
 * 特点：
 * 1.使用LazyForEach 懒加载
 *
 * 遗留问题：
 * 1.Grid 刷新问题
 * 2.Scroll嵌套Grid，解决滑动冲突
 */
@Preview
@Component
export struct HomeComponent {
  private displayWidth: number = px2vp(display.getDefaultDisplaySync().width)
  //状态切换
  @State pageState: PageState = PageState.Loading
  @State iconList: Array<IconBean> = new Array()
  @Provide viewModel: HomeViewModel = new HomeViewModel()
  private scrollerListener: Scroller = new Scroller()

  aboutToAppear() {
    this.viewModel.getRecommendProducts((list?: Array<RecommendBean>) => {
      //请求成功
      if (list == null || list.length == 0) {
        this.pageState = PageState.Fail
      } else {
        this.pageState = PageState.Normal
      }
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
      .margin({ top: 55 })
    }.alignContent(Alignment.TopStart)
    .size({ width: '100%', height: '100%' })
    .backgroundColor('#F6F6F6')
  }

  @Builder normalDraw() {
    Stack() {
      Grid(this.scrollerListener) {
        //icon位
        GridItem() {
          this.IconLayout()
        }.columnStart(1)
        .columnEnd(2)

        //轮播图
        GridItem() {
          Banner().height(100)
        }.columnStart(1)
        .columnEnd(2)

        //商品推荐
        GridItem() {
          Column() {
            Text('精选')
              .width('100%')
              .fontSize(15)
              .fontColor('#333333')
              .textAlign(TextAlign.Center)
            Text('为您推荐')
              .width('100%')
              .fontSize(13)
              .fontColor('#999999')
              .textAlign(TextAlign.Center)
          }
        }.columnStart(1)
        .columnEnd(2)

        //Grid ForEach 循环加载
        LazyForEach(this.viewModel, (item: RecommendBean) => {
          GridItem() {
            this.itemDraw(item)
          }.backgroundColor('#F6F6F6')
        })
      }
      .cachedCount(2)
      .layoutWeight(1)
      .columnsTemplate('1fr 1fr')
      .columnsGap(10)
      .rowsGap(10)
      .width('100%')
      .height('100%')
      .padding(10)
      .backgroundColor('#F3F4F5')
      .onScrollIndex((first: number) => {
        ToastUtil.showToast("==== " + first)
      })

      //返回顶部
      Image($r('app.media.icon_go_top'))
        .width(30)
        .height(30)
        .margin({ bottom: 50, right: 25 })
        .onClick(() => {
          //向上滚动100个单位
          // this.scrollerListener.scrollTo(100)
          this.scrollerListener.scrollEdge(0)
        })
    }.width('100%')
    .height('100%')
    .alignContent(Alignment.BottomEnd)
  }

  @Builder IconLayout() {
    Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap }) {
      ForEach(this.viewModel.getIcons(), (item: IconBean) => {
        Column() {
          Image(item.iconUrl)
            .width('100%')
            .height(44)
            .objectFit(ImageFit.Contain)
          Text(item.content)
            .fontColor('#333333')
            .width('100%')
            .margin({ top: 5 })
            .textAlign(TextAlign.Center)
        }
        .width('25%')
      })
    }
    .backgroundColor('#ffffff')
    .padding({ top: 10, bottom: 10 })
    .border({ radius: 10 })
    .width('100%')
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
        .border({ radius: { topLeft: 10, topRight: 10 } })

      Stack() {
        Text(item.productname)
          .fontSize(17)
          .fontColor('#333333')
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')
          .maxLines(2)
          .textAlign(TextAlign.Start)
      }.align(Alignment.TopStart)
      .height(36)
      .margin({ top: 10 })
      .padding({ left: 10, right: 10 })

      Row() {
        Text(`¥` + item.salePrice.priceDesc)
          .fontSize(14)
          .fontColor('#FF5C00')

        if (!StringUtil.isEmpty(item.saleCountDesc)) {
          Text(`销量` + item.saleCountDesc)
            .fontSize(12)
            .fontColor('#333333')
        }
      }.justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .margin({ top: 5 })
      .padding({ left: 10, right: 10 })

      Row() {
        CountEditText({
          content: 1,
          callback: (value: number) => {
            item.quantity = value
          }
        })
          .width(90)
          .height(22)
          .margin({ top: 8, right: 10 })

        Image($r('app.media.icon_shopcart'))
          .width(22)
          .height(22)
          .margin({ right: 10 })
          .onClick(() => {

            if (UserUtil.getInstance().isLogin()) {
              this.viewModel.addCart(item.productid, item.quantity, item.selectSkuDTO.skuId)
            } else {
              JumpAbility.jumpToLoginAbility()
            }
          })
      }
    }
    .width('100%')
    .alignItems(HorizontalAlign.End)
    .backgroundColor(Color.White)
    .padding({ bottom: 10 })
    .border({ radius: 10 })
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
            ToastUtil.showToast("==== " + list.length)
          })
        })
    })

  }
}

@Extend(Text) function commonText() {
  .fontSize(20)
}