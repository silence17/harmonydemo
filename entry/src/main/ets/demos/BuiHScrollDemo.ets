import { BuiPage } from '@app/common_lib';

import BuiHScroll from '../view/BuiHScroll';
@Component
export default struct BuiHScrollDemo {


  /**
   * 子项
   */
  @Builder buildContent(){
    Column(){
      Image($r("app.media.demo")).width("100").height(100);
      Text("描述1")
    }
    Column(){
      Image($r("app.media.demo")).width("100").height(100);
      Text("描述2")
    }
    Column(){
      Image($r("app.media.demo")).width("100").height(100);
      Text("描述3")
    }
    Column(){
      Image($r("app.media.demo")).width("100").height(100);
      Text("描述4")
    }
    Column(){
      Image($r("app.media.demo")).width("100").height(100);
      Text("描述5")
    }
    Column(){
      Image($r("app.media.demo")).width("100").height(100);
      Text("描述6")
    }
  }

  @Builder buildPageSlot(){
    BuiHScroll({
      slot:()=>{
        this.buildContent()
      }
    });
    Column(){
      Text(`

           BuiHScroll({
              slot:()=>{
                this.buildContent()
              }
            });

            @Builder buildContent(){
              Column(){
                Image($r("app.media.demo")).width("100").height(100);
                Text("描述1")
              }
              Column(){
                Image($r("app.media.demo")).width("100").height(100);
                Text("描述2")
              }


            }

      ` )
    }.width('100%').height(500).backgroundColor("#f5f5f5").margin({top:10})
  }


  build(){
    Column() {


      BuiPage({
        slot:()=>{
          this.buildPageSlot()
        }
      });


    }
  }


}