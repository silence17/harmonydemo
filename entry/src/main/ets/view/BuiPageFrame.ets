import { BuiNavbar } from '@app/common_lib';
import BuiPage from './BuiPage';

/**
 * 为了演示功能,需要写一个 类似 listItem , 点击后,展示一个假页面用于展示 功能
 * 需要监听后退事件, 后退则隐藏
 */
@Component
export default struct BuiPageFrame{

  @Link @Watch("visibleChange") visible:boolean ;

  @Link text:string ;

  @BuilderParam slot:()=>void;

  onToggle?:(visible:boolean)=>void


  visibleChange(){
    console.log("visibleChange",this.visible)
  }

  build(){
      Column(){ //假页面区域
        if(this.visible) {
          BuiNavbar({
            titleStr: this.text.toString(),
            onBeforeLeft: () => {
              this.visible = false;
              return false;
            }
          })
        }

        if(this.visible) {
          BuiPage({
            defaultPadding: true,
            include_loading: false,
            include_toast: false,
            slot: () => {
              if (this.slot) this.slot();
            }
          })
        }
      }
      //.visibility(this.visible?Visibility.Visible:Visibility.None)
      .opacity(this.visible?1:0)
      .translate({x:this.visible?0:'100%'})
      .backgroundColor(Color.White)
      .animation({duration:200,curve:Curve.FastOutSlowIn}).zIndex(999).width('100%').height('100%').position({x:0,y:0})


  }


}