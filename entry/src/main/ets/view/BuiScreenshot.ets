import image from '@ohos.multimedia.image'
/**
 * 可自定义截屏区域的功能
 */
@Component
export default struct BuiScreenshot {

  @State  image: image.PixelMap | undefined = undefined
  @State imageShow:boolean=false;

  @Builder buildPoster(){
    Column() {
      Text("我是海报内容")
      Column() {

      }.backgroundColor("#F5DC62").height(300)
      Text("我是海报内容")
    }
  }


  build() {
    Column() {

    }
  }
}