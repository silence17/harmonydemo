import BuiToast from '../../utils/BuiToast';
import BuiLoading from './BuiLoading';

@Builder
function empty() {
}

/**
 * 控制器 外部初始化传入
 */
export interface BuiPageController {
  /**
   * 返回顶部
   */
  backTop: () => void
}


/**作为演示的控件编写范式
 * 自定义 页面容器 ,满足大部分 常规场景,即 顶部导航,底部操作栏,以及中间内容可滚动区域
 * 分 top middle bottom 3个区域,其中  slot为必填即内容区域
 */
@Component
export struct BuiPage {
  scroller: Scroller = new Scroller();

  /**
   * 控制器 外部初始化传入 直接 controller= {} as BuiPageController 即可
   * 使用 controller.backTop() 即可返回顶部
   */
  controller?: BuiPageController;
  /**
   * 是否有全局默认的padding
   */
  @State defaultPadding: boolean = true;
  /**
   *  包含loading组件 默认true 只有在首页这种已经是页面容器切包含loading组件的情况下禁用
   */
  @State include_loading?: boolean = false;
  /**
   * 包含toast组件 默认true 只有在首页这种已经是页面容器切包含toast组件的情况下禁用
   */
  @State include_toast: boolean = false;
  /** 注意注意注意::: 传slot是函数定义,不是函数运行值 ,不要带括号,不要带括号 ,不要带括号
   *
   *  当有且只有一个BuilderParam 的时候,组件支持代码块方式的内嵌子组件

   * BuiPage({
   *    defaultPadding:false,
   *    slot: this.CustomBuilder , //这个是 @builder 注解的方法,由调用方书写, 内容为 内部排版,即 slot内容
   * })
   *
   */
  @BuilderParam slot: () => void = empty;
  @BuilderParam slot_top: () => void = empty
  @BuilderParam slot_bottom: () => void = empty;
  /**
   * 滚动事件
   */
  onScroll: (x: number, y: number) => void = () => {
  }
  contentHeightChange?: (h: number) => void = () => {
  }

  myPadding(): Padding {
    if (this.defaultPadding) {
      return {
        left: 16,
        right: 16,
        bottom: 16,
      }
    } else {
      return {}
    }
  }

  build() {
    Column() {
      //顶部slot
      Column() {
        this.slot_top()
      }.width('100%')
      //内容区域
      Scroll(this.scroller) {
        Column() {
          this.slot();
        }
        .constraintSize({
          minWidth: '100%',
          minHeight: '100%',
          maxWidth: "100%"
        })
        .padding(this.myPadding())
        .alignItems(HorizontalAlign.Start)
        .onAreaChange((e, n) => {
          if (this.contentHeightChange) { //滚动可见内容区域高度变更
            this.contentHeightChange(n.height as number)
          }
        })
      }.onScroll((x: number, y: number) => { //滚动事件
        if (this.onScroll) {
          this.onScroll(x, y);
          console.log(this.scroller.currentOffset());

        }
      }).scrollBarWidth(1)
      .scrollBarColor("rgba(0,0,0,0.01)")


      //底部slot
      if (this.slot_bottom) {
        Column() {
          this.slot_bottom();
        }.constraintSize({
          minHeight: 0,
          maxHeight: 500
        })
      }
      if (this.include_loading) {
        BuiLoading();
      }
      if (this.include_toast) {
        BuiToast()
      }
    }
    .layoutWeight(1)

  }

  onPageShow() {
    console.log("自定义组件 onPageShow")
  }

  /**
   * 组件即将出现时回调该接口，具体时机为在创建自定义组件的新实例后，在执行其build()函数之前执行。
   * https://docs.openharmony.cn/pages/v4.0/zh-cn/application-dev/reference/arkui-ts/ts-custom-component-lifecycle.md/#abouttoappear
   */
  aboutToAppear() {
    if (this.controller) {
      this.controller.backTop = () => {
        this.scroller.scrollTo({ xOffset: 0, yOffset: -10000 });
      }
    }

  }

  /**在自定义组件即将析构销毁时执行。
   * https://docs.openharmony.cn/pages/v4.0/zh-cn/application-dev/reference/arkui-ts/ts-custom-component-lifecycle.md/#abouttodisappear
   */
  aboutToDisappear() {

  }
}