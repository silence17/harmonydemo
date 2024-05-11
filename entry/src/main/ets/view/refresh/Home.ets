import router from '@ohos.router'
import curves from '@ohos.curves'
import { FoodInfo, Category } from '../model/DataModels'
import { getFoods, getFoodCategories, getSortedFoodData } from '../model/DataUtil'
import { Records } from './DietRecord'
import { PersonalCenter } from './PersonalCenter'

import distributedUtil from '../../utils/distributedStrong'
import { BreakpointSystem, BreakPointType } from './BreakpointSystem'


interface FoodId {
  foodId: FoodInfo;
}

@Component
struct FoodListItem {
  private foodItem?: FoodInfo

  build() {
    Navigator({ target: 'pages/FoodDetail' }) {
      Row() {
        Image(this.foodItem!.image!)
          .objectFit(ImageFit.Contain)
          .autoResize(false)
          .height(40)
          .width(40)
          .backgroundColor('#FFf1f3f5')
          .margin({ right: 16 })
          .borderRadius(6)
          .sharedTransition(this.foodItem!.letter, {
            duration: 400,
            curve: curves.cubicBezier(0.2, 0.2, 0.1, 1.0),
            delay: 100
          })
        Text(this.foodItem?.name)
          .fontSize(14)
        Blank()
        Text($r('app.string.calorie_with_kcal_unit', this.foodItem?.calories.toString()))
          .fontSize(14)
      }
      .height(64)
      .width('100%')
    }
    .params({ foodId: this.foodItem } as FoodId)
    .margin({ right: 24, left: 32 })
  }
}

@Component
struct ListModeFoods {
  private foodItems: Array<FoodInfo | string> = getSortedFoodData()
  private currentOffsetY: number = 0;
  private timer: number = 0;
  @State refreshStatus: boolean = false;
  @State upRefreshStatus: boolean = false;

  aboutToDisappear() {
    this.timer = null
  }

  putDownRefresh(event?: TouchEvent): void {
    if (event === undefined) {
      return;
    }
    switch (event.type) {
      case TouchType.Down:
        this.currentOffsetY = event.touches[0].y;
        break;
      case TouchType.Move:
        if(this.scroller.currentOffset().yOffset < 50) {
          this.refreshStatus = event.touches[0].y - this.currentOffsetY > 50;
        }
        this.upRefreshStatus = event.touches[0].y - this.currentOffsetY < -50;
        break;
      case TouchType.Cancel:
        break;
      case TouchType.Up:
        // Only simulation effect, no data request
        this.timer = setTimeout(() => {
          if (this.upRefreshStatus) {
            this.scroller.scrollTo({           // 调用scrollTo滚动到具体位置
              xOffset: 0,                    // 竖直方向滚动，该值不起作用
              yOffset: 680,    // 滚动到底部
              animation: {                     // 滚动动画
                duration: 1500,
                curve: Curve.EaseOut
              }
            })
          }
          this.refreshStatus = false;
          this.upRefreshStatus = false;
        }, 1500);
        break;
    }
  }

  @Builder DownRefreshBuilder(text: string, state: string) {
    Row() {
      Image($r('app.media.refreshing'))
        .width(32)
        .height(32)
      Text(text).fontSize(16)
    }
    .justifyContent(FlexAlign.Center)
    .position({
      y: state === 'down' ? 20 : -20
    })
    .zIndex(999)
    .width('94%')
    .height('8%')
  }

  private scroller: Scroller = new Scroller(); // 创建一个滚动控制器

  build() {
    Column() {
      Text($r("app.string.title_food_list"))
        .width('100%')
        .height(56)
        .padding({ left: 20 })
        .backgroundColor('#FF1f3f5')
        .fontSize(20)

      Scroll(this.scroller) {
        if(this.refreshStatus) {
          this.DownRefreshBuilder('正在刷新', 'down')
        }
        List() {
          ForEach(this.foodItems, (item: FoodInfo) => {
            ListItem() {
              if (item.letter !== undefined) {
                FoodListItem({ foodItem: item })
              } else {
                if (typeof (item) === 'string') {
                  Text(item)
                    .fontSize(14)
                    .height(48)
                    .margin({ left: 24 })
                    .width('100%')
                }
              }
            }
          })
          if(this.upRefreshStatus) {
            ListItem(){
              this.DownRefreshBuilder('正在加载', 'up')
            }
          }
        }
        .layoutWeight(1)
      }
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
      .width('100%')
      .height('100%')
      .margin({
        bottom: 52
      })
      .onTouch((event?: TouchEvent) => {
        this.putDownRefresh(event);
      })
    }
  }
}

@Component
struct FoodGridItem {
  private foodItem?: FoodInfo

  build() {
    Column() {
      Image(this.foodItem!.image!)
        .objectFit(ImageFit.Contain)
        .backgroundColor('#f1f3f5')
        .width('100%')
        .height(152)
        .sharedTransition(this.foodItem!.letter, {
          duration: 400,
          curve: curves.cubicBezier(0.2, 0.2, 0.1, 1.0),
          delay: 100
        })
      Row() {
        Text(this.foodItem?.name)
          .fontSize(14)
        Blank()
        Text($r('app.string.calorie_with_kcal_unit', this.foodItem?.calories.toString()))
          .fontSize(14)
          .fontColor(0x99000000)
      }
      .padding({ left: 12, right: 12 })
      .width('100%')
      .height(32)
      .backgroundColor('#E5E5E5')
    }
    .height(184)
    .clip(new Rect({ width: '100%', height: '100%', radius: 12 }))
    .onClick(() => {
      router.pushUrl({ url: 'pages/FoodDetail', params: { foodId: this.foodItem } })
    })
  }
}

@Component
struct FoodGrid {
  @StorageProp('currentBreakpoint') currentBreakpoint: string = 'sm'
  private foodItems?: FoodInfo[]

  build() {
    Grid() {
      ForEach(this.foodItems!, (item: FoodInfo) => {
        GridItem() {
          FoodGridItem({ foodItem: item })
        }
      })
    }
    .columnsTemplate(new BreakPointType({
      sm: '1fr 1fr',
      md: '1fr 1fr 1fr',
      lg: '1fr 1fr 1fr 1fr'
    }).getValue(this.currentBreakpoint) as string)
    .columnsGap(8)
    .rowsGap(8)
    .padding({ left: 16, right: 16 })
  }
}

@Component
struct CategoryModeFoods {
  @State currentTabIndex: number = 0
  private foodItems: FoodInfo[] = getFoods()
  private foodCategories: Category[] = getFoodCategories()

  /* *
   * 头部分类导航栏
   *
   * */
  @Builder
  tabBarItemBuilder(value: Resource, index: number) {
    Text(value)
      .fontColor(this.currentTabIndex === index ? Color.Green : 'rgba(0,0,0,0.6)')
      .fontSize(this.currentTabIndex === index ? 20 : 18)
      .fontWeight(this.currentTabIndex === index ? FontWeight.Bold : FontWeight.Normal)
      .margin({ top: 2 })
      .height(56)
  }

  build() {
    Tabs() {
      TabContent() {
        FoodGrid({ foodItems: this.foodItems })
      }.tabBar(this.tabBarItemBuilder($r('app.string.category_all'), 0))

      ForEach(this.foodCategories, (foodCategory: Category, index?: number) => {
        TabContent() {
          FoodGrid({ foodItems: this.foodItems.filter(item => (item.categoryId === foodCategory.id)) })
        }.tabBar(this.tabBarItemBuilder(foodCategory.name!,
          index! + 1))
      })
    }
    .animationDuration(0)
    .barWidth('95%')
    .onChange((index) => {
      this.currentTabIndex = index
    })
  }
}

@Component
struct FoodsDisplay {
  @State isCategoryMode: boolean = true
  @State isMoreIconOnClick: boolean = false
  @State isMoreIconOnHover: boolean = false
  @State isMoreIconOnFocus: boolean = false

  getMoreIconBgColor() {
    if (this.isMoreIconOnClick) {
      return $r('sys.color.ohos_id_color_click_effect')
    } else if (this.isMoreIconOnHover) {
      return $r('sys.color.ohos_id_color_hover')
    } else {
      return this.isCategoryMode ? Color.White : '#F1F3F5' || Color.Transparent
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopEnd }) {
      if (this.isCategoryMode) {
        CategoryModeFoods()
      } else {
        ListModeFoods()
      }
      Row() {
        Image($r("app.media.ic_switch"))
          .height(24)
          .width(24)
          .margin({ left: 24, right: 24 })
          .focusable(true)
      }
      .height(56)
      .backgroundColor(this.getMoreIconBgColor())
      .stateStyles({
        focused: {
          .border({
            radius: $r('sys.float.ohos_id_corner_radius_clicked'),
            color: $r('sys.color.ohos_id_color_focused_outline'),
            style: BorderStyle.Solid
          })
        },
        normal: {
          .border({
            radius: $r('sys.float.ohos_id_corner_radius_clicked'),
            width: 0
          })
        }
      })
      .onFocus(() => this.isMoreIconOnFocus = true)
      .onBlur(() => this.isMoreIconOnFocus = false)
      .onHover((isOn) => this.isMoreIconOnHover = isOn)
      .onClick(() => {
        this.isCategoryMode = !this.isCategoryMode
      })
    }
  }
}

@Entry
@Component
struct Home {
  @State currentTabIndex: number = 0
  @StorageProp('currentBreakpoint') currentBreakpoint: string = 'sm'
  private breakpointSystem: BreakpointSystem = new BreakpointSystem()

  /* *
   * 主页和记录的tabs
   * */
  @Builder
  bottomBarItemBuilder(name: Resource, icon: Resource, index: number) {
    Flex({
      direction: new BreakPointType({
        sm: FlexDirection.Column,
        md: FlexDirection.Row,
        lg: FlexDirection.Column
      }).getValue(this.currentBreakpoint),
      justifyContent: FlexAlign.Center,
      alignItems: ItemAlign.Center
    }) {
      Image(icon)
        .height(24)
        .width(24)
        .fillColor(this.getTabBarColor(index))
      Text(name)
        .margin(new BreakPointType<Padding>({
          sm: { top: 4 },
          md: { left: 8 },
          lg: { top: 4 }
        }).getValue(this.currentBreakpoint) as Padding)
        .fontSize(11)
        .fontColor(this.getTabBarColor(index))
    }
  }

  aboutToAppear() {
    this.breakpointSystem.register()

    // 预览器中不生效
    setTimeout(() => {
      distributedUtil.putStoreData('test00111', JSON.stringify({
        name: 666,
        age: 32,
        date: '2023.06.26'
      }))

      distributedUtil.getStoreData('test00111').then(res => {
        console.log('===获取数据库中的数据==== ', JSON.stringify(res))
      })
    }, 2000)
  }

  aboutToDisappear() {
    this.breakpointSystem.unregister()
  }

  build() {
    Tabs({
      barPosition: new BreakPointType({
        sm: BarPosition.End,
        md: BarPosition.End,
        lg: BarPosition.Start
      }).getValue(this.currentBreakpoint)
    }) {
      TabContent() {
        FoodsDisplay()
      }.tabBar(this.bottomBarItemBuilder($r("app.string.tab_bar_home"), $r("app.media.ic_bottom_home"), 0))

      TabContent() {
        Records()
      }.tabBar(this.bottomBarItemBuilder($r("app.string.tab_bar_record"), $r("app.media.ic_bottom_record"), 1))

      TabContent() {
        PersonalCenter()
      }.tabBar(this.bottomBarItemBuilder($r("app.string.tab_bar_me"), $r("app.media.ic_public_me"), 2))
    }
    .vertical(new BreakPointType({ sm: false, md: false, lg: true }).getValue(this.currentBreakpoint) as boolean)
    .barWidth(new BreakPointType({ sm: '100%', md: '100%', lg: '56vp' }).getValue(this.currentBreakpoint) as string)
    .barHeight(new BreakPointType({ sm: '56vp', md: '56vp', lg: '60%' }).getValue(this.currentBreakpoint) as string)
    .animationDuration(0)
    .onChange((index) => {
      this.currentTabIndex = index
    })
  }

  private getTabBarColor(index: number) {
    return this.currentTabIndex == index ? $r('app.color.tab_bar_select_color') : $r('app.color.tab_bar_normal_color')
  }
}