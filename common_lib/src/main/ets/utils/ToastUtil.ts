import promptAction from '@ohos.promptAction'

export class ToastUtil {
  static showToast(content: string) {
    promptAction.showToast({
      message: content,
      duration: 2000
    })
  }
}