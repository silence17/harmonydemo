import display from '@ohos.display';
import Configs from '../app/Configs';

let __init:boolean = false;
let height = 0;
/**
 * 如果隐藏了系统bar 并且是沉浸式体验,那么顶部刘海挖孔,就要避开
 * 这里只简单 垫一个空的Column作为占位
 */
@Component
export default struct BuiTopPlaceHolder {

  @State h:number=0


  build(){
    if(Configs.fullScreen){
      Column().height(this.h+"px")
    }
  }

  aboutToAppear(){
    if(__init){
      this.h = height;
      return;
    }
//https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/js-apis-display-0000001427585076-V3#ZH-CN_TOPIC_0000001523648926__waterfalldisplayarearects9
    display.getDefaultDisplaySync().getCutoutInfo().then((data)=>{
      //挖孔屏、刘海屏、瀑布屏等不可用屏幕区域信息。  这里的数组的意思应该是 left top right bottom
      let rects = data.boundingRects;
      //瀑布屏曲面部分显示区域。
      let waterfallDisplayAreaRects =  data.waterfallDisplayAreaRects;
      let h=0
      //单位是像素像素像素  1 是顶部
        let rect = rects?.[1]
         if(h<rect?.height){
           h=rect.height
         }
      __init = true;
      height = h;
      this.h = h;
    })
  }



}