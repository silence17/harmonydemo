import BuiToast from '@app/common_lib/src/main/ets/utils/BuiToast';

import BuiDivider from '../view/BuiDivider';

@Component
export default struct ToastDemo {

  @State visible:boolean=false;

  build(){
    Column() {
      Button("Toast").onClick(() => {
        this.visible = true;
        // Utils.toast({
        //   text: "我是很长的toast,我就是要看看换行效果,你猜猜看,换行是啥样"
        // })
        setTimeout(()=>{
          this.visible = false;
        },2000)
      })

      BuiDivider();

      Text(`
        Button("Toast").onClick(()=>{
          Utils.toast({
            text:"我是很长的toast,我就是要看看换行效果,你猜猜看,换行是啥样,预览器不支持事件,请在真机上预览"
          })
        })
      `)
      if(this.visible) {
        BuiToast({
          visible:this.visible.valueOf(),
          text: "我是很长的toast,我就是要看看换行效果,你猜猜看,换行是啥样",
        })
      }
    }

  }
}