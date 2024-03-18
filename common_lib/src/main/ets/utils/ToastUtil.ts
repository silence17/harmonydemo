import promptAction from '@ohos.promptAction'

export class ToastUtil {
  static showToast(content: string) {
    promptAction.showToast({
      message: content,
      //持续时间
      duration: 2000,
      bottom: '60vp'
    })
  }
}