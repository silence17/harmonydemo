import { BuiNavbar, ContainerPage, ToastUtil, Utils } from '@app/common_lib'
import call from '@ohos.telephony.call';

@Entry
@Component
struct ExamplePage {
  private index: number = 0;

  build() {
    Stack() {
      ContainerPage({
        titleStr: "Container Page",
        include_loading: true,
        include_error: true,
        contentLayout: () => {
          this.buildContent();
        },
      })
    }
  }

  @Builder buildContent() {
    Column() {
      Text("我是BuiPage内部的文本内容")
      Column() {
        Text("我是BuiPage内部的占位内容")
      }.backgroundColor("#ccc")
      .width('100%')
      .onClick(() => {
        ToastUtil.showToast('======: ' + this.index++)

        let callback = () => {
          ToastUtil.showToast("刷新数据")
        }

        let params = {
          "textValue": "数据异常，请稍后再试",
          "btnStr": "重新加载",
          "listener": callback
        }
        Utils.showError(params)
      })

      Text("我是BuiPage内部的内容的最底部")
      Text(`
             Column(){
      Text("我是页面上一个文本,我下面是BuiPage")
      BuiPage({
        slot:()=>{
          this.buildContent();
        },
        slot_top:()=>{
          Text("我是BuiPage内部的顶部文本内容")
        },
        slot_bottom:()=>{
          Text("我是BuiPage内部的底部文本内容")
        }
      })
      Text("我是页面底部一个文本,我上面是BuiPage-----")

    }.layoutWeight(1)
`)
    }
  }
}