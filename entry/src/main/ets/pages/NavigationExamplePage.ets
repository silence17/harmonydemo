@Entry
@Component
struct NavigationExamplePage {
  private arr: number[] = [1, 2, 3];

  build() {
    Column() {
      Navigation() {
        TextInput({ placeholder: 'search...' })
          .width("90%")
          .height(40)
          .backgroundColor('#FFFFFF')

        List({ space: 12 }) {
          ForEach(this.arr, (item) => {
            ListItem() {
              NavRouter() {
                Text("NavRouter" + item)
                  .width("100%")
                  .height(72)
                  .backgroundColor('#FFFFFF')
                  .borderRadius(24)
                  .fontSize(16)
                  .fontWeight(500)
                  .textAlign(TextAlign.Center)
                NavDestination() {
                  Text("NavDestinationContent" + item)
                }
                .title("NavDestinationTitle" + item)
              }
            }
          }, item => item)
        }
        .width("90%")
        .margin({ top: 12 })
      }
      .title("主标题")
      .mode(NavigationMode.Split)
      .menus([
        { value: "", icon: "../resources/base/media/close.svg", action: () => {
        } },
        { value: "", icon: "../resources/base/media/ic_public_back.svg", action: () => {
        } },
        { value: "", icon: "../resources/base/media/close.svg", action: () => {
        } },
        { value: "", icon: "../resources/base/media/loading.png", action: () => {
        } },
        { value: "", icon: "../resources/base/media/close.svg", action: () => {
        } }
      ])
      .toolBar({ items: [
        { value: "func", icon: "../resources/base/media/icon.png", action: () => {
        } },
        { value: "func", icon: "../resources/base/media/icon.png", action: () => {
        } },
        { value: "func", icon: "../resources/base/media/icon.png", action: () => {
        } }
      ] })
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#F1F3F5')
  }
}