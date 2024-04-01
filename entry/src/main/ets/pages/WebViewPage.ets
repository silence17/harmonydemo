import { BuiNavbar } from '@app/common_lib';
import web_webview from '@ohos.web.webview';
import router from '@ohos.router';

@Entry
@Component
struct WebViewPage {
  webViewController: web_webview.WebviewController = new web_webview.WebviewController
  @State title: string = ''
  @State link: string = ''

  onPageShow() {
    const params = router.getParams()
    this.title = params['title']
    this.link = params['link']

    this.webViewController.loadUrl(this.link)
  }

  build() {
    Column() {
      BuiNavbar({
        titleStr: this.title,
        onBeforeLeft: () => {
          if (this.webViewController.accessBackward()) {
            this.webViewController.backward();
            return false;
          }
          return true
        }
      })
      Web({ src: '', controller: this.webViewController })
    }
  }
}