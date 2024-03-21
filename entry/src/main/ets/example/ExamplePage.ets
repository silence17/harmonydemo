import { BuiNavbar, ContainerPage, Utils } from '@app/common_lib'

@Entry
@Component
struct ExamplePage {
  build() {
    Column() { //一个唯一的根节点
      ContainerPage({
        titleStr: "Container Page",
        include_loading: true,
        include_toast: false,
        slot: () => {
          this.buildContent();
        },
      })
    }
  }

  @Builder buildContent() {
    Text("我是BuiPage内部的文本内容")
    Column() {
      Text("我是BuiPage内部的占位内容")
    }.backgroundColor("#ccc")
    .width('100%')

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