import promptAction from '@ohos:promptAction';
export class ToastUtil {
    static showToast(content) {
        promptAction.showToast({
            message: content,
            duration: 2000
        });
    }
}
//# sourceMappingURL=ToastUtil.js.map