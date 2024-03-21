import { BuiNavbar, BuiPage } from '@app/common_lib';
import router from '@ohos.router';
import ToastDemo from '../demos/ToastDemo';
import Bui360ImageDemo from '../demos/Bui360ImageDemo';
import BuiHScrollDemo from '../demos/BuiHScrollDemo';

interface DemoParams {
  demo?: string | undefined
  demoDesc?: string | undefined
}


@Entry
@Component
struct Page1 {
  @State demo: string | undefined = "";
  @State demoDesc: string | undefined = "";

  aboutToAppear() {
    let params = (router.getParams() || {}) as DemoParams
    if (params.demo) {
      this.demo = params.demo;
      this.demoDesc = params.demoDesc;
    }

  }

  build() {
    Column() {
      this.buildNavbar()
      //BuiPage 调用开始
      if (this.demo == 'BuiPage') {
        this.buildPageFrameContent()
      } else {
        BuiPage({
          defaultPadding: false,
          slot: () => { //一定要注意,这里的this..
            this.buildPageFrameContent()
          }
        })
      }

    }

  }

  @Builder buildNavbar() {
    BuiNavbar({
      titleStr: this.demoDesc.toString(),
    })
  }

  @Builder buildPageFrameContent() {
    if (this.demo == 'BuiPage') {

    }
    else if (this.demo == 'loading') {
      //LoadingDemo()
    }
    else if (this.demo == 'toast') {
      ToastDemo()
    } else if (this.demo == 'togglePanel') {
      // TogglePanelDemo()
    } else if (this.demo == 'BuiPaging') {
      // BuiPagingDemo();
    } else if (this.demo == 'BuiHScroll') {
      BuiHScrollDemo();
    } else if (this.demo == 'BuiButtonGroup') {
      // BuiButtonGroupDemo();
    }
    else if (this.demo == 'Bui360Image') {
      Bui360ImageDemo();
    } else if (this.demo == 'BuiSkyBox') {
      // BuiSkyBoxDemo();
    } else if (this.demo == 'BuiMakePoster') {
      // BuiMakePosterDemo();
    } else if (this.demo == 'BuiTabSwiperDemo') {
      // BuiTabSwiperDemo();
    } else if (this.demo == 'BuiPopupDemo') {
      // BuiPopupDemo();
    } else if (this.demo == 'BuiSwiperDemo') {
      // BuiSwiperDemo();
    } else if (this.demo == 'BuiSplitScrollDemo') {
      // BuiSplitScrollDemo();
    }
    else if (this.demo == 'BuiTableDemo') {
      // BuiTableDemo();
    } else if (this.demo == 'BuiWebviewDemo') {
      // BuiWebviewDemo();
    } else if (this.demo == 'BuiimageVerifyDemo') {
      // BuiimageVerifyDemo();
    }


    else {
      Text("请增加演示组件并完成此处逻辑")
    }
  }
}

function LoadingDemo() {
  throw new Error('Function not implemented.');
}
