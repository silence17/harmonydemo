import { BuiPage, BuiNavbar, Utils } from '@app/common_lib'

@Entry
@Component
struct BuiPageDescr {
  build() {
    Column() { //一个唯一的根节点
      BuiNavbar({
        titleStr: "BUiPage结构演示",
      })
      Text("我是页面上一个文本,我下面是BuiPage")
      BuiPage({
        include_loading: true,
        include_toast: false,
        slot: () => {
          this.buildContent();
        },
        slot_top: () => {
          this.slotTop(); //这里能不能直接写 Text()  ,有时候可以,有时候不可以...所以强制这里只能调用内部的 @Builder 方法吧
        },
        slot_bottom: () => {
          this.slotBottom();
        }
      })

      Column() {
        Text("我是页面底部一个文本,我上面是BuiPage-----")
      }.backgroundColor("#ccc")
    }
  }

  @Builder slotTop() {
    Text("我是BuiPage内部的顶部文本内容")
      .onClick(() => {
        Utils.showLoading({'99':909})
      })
  }

  @Builder slotBottom() {
    Text("我是BuiPage内部的底部文本内容")
  }

  @Builder buildContent() {
    Text("我是BuiPage内部的文本内容")
    Column() {
      Text("我是BuiPage内部的占位内容")
    }.backgroundColor("#ccc").height(1000);
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