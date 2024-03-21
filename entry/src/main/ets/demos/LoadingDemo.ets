import Utils from '../../common/Utils';
import BuiDivider from '../bui/BuiDivider';
import BuiLoading from '../bui/BuiLoading';

@Component
export default struct LoadingDemo {
  @State visible:boolean=false;

  build() {
    Column() {

      Button("loading 默认2秒关闭,预览器不支持事件,请在真机查看").onClick(() => {
        Utils.showLoading();
        this.visible = true;
        // Utils.showLoading();
        setTimeout(()=>{
          this.visible = false;
        },2000)
      })

      // Button("loading 2秒关闭").onClick(() => {
      //   Utils.showLoading({
      //     duration: 2000,
      //     text: "我是自定义文本"
      //   })
      // })
      //
      // Button("loading 无文字,自选图").onClick(() => {
      //   Utils.showLoading({
      //     duration: 2000,
      //     icon: "https://s2.51cto.com/images/blog/202203/24170451_623c343336c7c19280.gif",
      //     text: ""
      //   })
      // })


      BuiDivider()

      Text(`
        Button("loading 默认6秒关闭").onClick(()=>{
        Utils.showLoading();
      })

      Button("loading 2秒关闭").onClick(()=>{
        Utils.showLoading({
          duration:2000,
          text:"我是自定义文本"
        })
      })

      Button("loading 无文字,自选图").onClick(()=>{
        Utils.showLoading({
          duration:2000,
          icon:"https://s2.51cto.com/images/blog/202203/24170451_623c343336c7c19280.gif",
          text:""
        })
      })
        `)
      if(this.visible) {
        BuiLoading({
          show:this.visible,
          text: "慢慢等待",
        })
      }

    }
  }
}