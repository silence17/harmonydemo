import router from '@ohos.router';

///实现右侧布局样式自定义
///@BuildParam装饰的方法只能被自定义构建函数（@Builder装饰的方法）初始化。
@Component
export struct Navbar {
  title: string = "";

  //默认样式
  @Builder rightAreaBuilder() {
  };

  ///@BuilderParam用来装饰指向@Builder方法的变量
  ///无参
  @BuilderParam rightArea: () => void = this.rightAreaBuilder;

  build() {
    Column() {
      Row() {
        Column() {
          if (parseInt(router.getLength()) > 1){
            Image($r("app.media.ic_public_back")).width(30).height(30).onClick(() => {
              router.back();
            }).alignSelf(ItemAlign.Start)
          }

        }.layoutWeight(1)

        Text(this.title).fontSize(16).height(50)

        Column() {//右侧区域
          this.rightArea();
        }.layoutWeight(1)

      }.width('100%').justifyContent(FlexAlign.SpaceBetween).padding({ left: 10, right: 10 })
    }.width('100%').backgroundColor("#f5f5f5")
  }
}
