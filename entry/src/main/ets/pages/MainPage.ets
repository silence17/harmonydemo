import { HomeComponent } from './HomeComponent';
import { APP_EXIT_INTERVAL, TIME } from '../common/constants/Constants';
import promptAction from '@ohos.promptAction';
import { MinePage } from './MinePage';
import { NavList, TabId } from '../model/NavDataModel';
import { CACHE_USER_INFO } from '@app/common_lib/src/main/ets/app/GlobalConstant';
import { ShopCartPage } from './ShopCartPage';

PersistentStorage.PersistProp<string>(CACHE_USER_INFO, '')


@Entry
@Component
struct MainPage {
  private tabsController: TabsController = new TabsController();
  @State currentIndex: number = 0
  //上一次点击退出的时间戳
  private lastPressedBack: number = 0

  @Builder TabBuilder(index: number) {
    Column() {
      Image(this.currentIndex === index ? NavList[index].icon_selected : NavList[index].icon)
        .size({ width: 20, height: 20 })

      Text(NavList[index].text)
        .fontColor(this.currentIndex === NavList[index].id ? '#1698CE' : '#6B6B6B')
        .fontSize(10)
        .margin({ top: 3 })
    }
    .height(44)
    .justifyContent(FlexAlign.Center)
    .onClick((event) => {
      this.currentIndex = index;
      this.tabsController.changeIndex(this.currentIndex)
    })
  }

  onBackPress() {
    let currentMil = new Date().getTime()
    if (currentMil - this.lastPressedBack > APP_EXIT_INTERVAL) {
      promptAction.showToast({
        message: $r('app.string.prompt_text'),
        duration: TIME
      });
      this.lastPressedBack = currentMil;
      return true;
    }
    return false;
  }

  onPageShow() {
  }

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.tabsController }) {
      TabContent() {
        HomeComponent()
          .size({ width: '100%', height: '100%' })
      }.tabBar(this.TabBuilder(TabId.HOME))

      TabContent() {
        ShopCartPage()
          .size({ width: '100%', height: '100%' })
      }.tabBar(this.TabBuilder(TabId.ACHIEVEMENT))

      TabContent() {
        MinePage()
      }.tabBar(this.TabBuilder(TabId.MINE))
    }
    //禁止滑动切换
    .scrollable(true)
    //Tabs的属性barMode是控制导航栏是否可以滚动，默认值为Fixed。
    .barMode(BarMode.Fixed)
    .vertical(false)
    .onChange((index) => {
      this.currentIndex = index
    })
  }
}