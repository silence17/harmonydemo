/**
 * 一个展示360度图片的组件
 * 本质就是展示36张图片,拖拽切换
 */
@Component
export default struct Bui360Image {
  /**
   * 需要展示的图片,按照顺序传入
   * 这里不考虑本地图片,没人会把这种展示场景用本地图片吧
   */
  images: string[]=[]
  /**
   * 灵敏度 数字越大,越不灵敏 最小1
   */
  sensitivity: number = 2;
  @State currentIndex: number = 0;
  @State startX: number = 0;
  @State moveX: number = 0;

  build() {
    Column() {
      //体验要好,需要等所有图片加载完毕 , 这之前 显示 loading 之类
      ForEach(this.images, (item: string, index: number) => {
        Image(item)
          .objectFit(ImageFit.Auto)
          .width('100%')
          .interpolation(ImageInterpolation.Low)
          .visibility(index == this.currentIndex ? Visibility.Visible : Visibility.None)
          .opacity(index == this.currentIndex ? 1 : 0)

      }, (item: string, index: number) => {
        return item + index
      })
    }.width("100%").alignItems(HorizontalAlign.Center)
    .onTouch((e: TouchEvent) => {
      let tch = e.touches[0];
      if (e.type == TouchType.Down) {
        this.startX = tch.x;
      } else if (e.type == TouchType.Move) {
        this.moveX = tch.x;
        if (Math.abs(this.moveX - this.startX) > this.sensitivity) { //可以改变
          this.changeIndex(this.moveX - this.startX > 0);
          this.startX = this.moveX;
        }
      } else if (e.type == TouchType.Up) {
        this.startX = 0;
      }
    })

  }

  changeIndex(left: boolean) {
    if (left) {
      if (this.currentIndex < this.images.length - 1) {
        this.currentIndex++;
      } else {
        this.currentIndex = 0;
      }
    } else {
      if (this.currentIndex > 0) {
        this.currentIndex--;
      } else {
        this.currentIndex = this.images.length - 1;
      }
    }
  }
}
