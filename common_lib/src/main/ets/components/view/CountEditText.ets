import { ToastUtil } from '../../utils/ToastUtil'

/**
 * Input控件：默认有padding，设置未0后可以正常显示
 */
@Preview
@Component
export struct CountEditText {
  @State content: number = 1
  @State btnCutColor: string = '#333333'
  @State btnAddColor: string = '#333333'
  maxValue: number = 63335
  minValue: number = 1
  callback: Function = (value: number) => {
  }

  build() {
    Row() {
      Text('-')
        .layoutWeight(1)
        .height('100%')
        .textAlign(TextAlign.Center)
        .fontColor(this.btnCutColor)
        .onClick((event) => {
          this.calValue(--this.content)
        })

      TextInput({ text: this.content.toString() })
        .layoutWeight(1)
        .height('100%')
        .type(InputType.Number)
        .textAlign(TextAlign.Center)
        .fontColor('#333333')
        .fontSize(13)
        .id('input')
        .border({ radius: 0, color: '#ffc8c8c8',
          width: { left: 1, right: 1 }
        })
        .padding(0)
        .backgroundColor(Color.White)
        .onChange((value: string) => {
          //文本发生变化
          this.calValue(Number.parseInt(value))
        })
        .onFocus(() => {
          //获取焦点
        })
        .onBlur(() => {
          // 失去焦点
        })

      Text('+')
        .height('100%')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
        .fontColor(this.btnAddColor)
        .onClick(() => {
          this.calValue(++this.content)
        })
    }
    .border({ radius: 50, color: '#ffc8c8c8', width: 1, })
    .width('100%')
    .height('100%')
    .constraintSize({ minWidth: 90, minHeight: 22 })
    .backgroundColor(Color.White)
  }

  private calValue(targetValue: number): number {
    if (targetValue < this.minValue) {
      ToastUtil.showToast('已经是最小值了，不能在少了')
      this.btnCutColor = '#C8C8C8'
      return this.minValue
    } else if (targetValue > this.maxValue) {
      ToastUtil.showToast('已经是最大值了，不能在多了')
      this.btnAddColor = '#C8C8C8'
      return this.maxValue
    } else {
      this.btnCutColor = '#333333'
      this.btnAddColor = '#333333'
      this.content = targetValue
      this.callback(this.content)
      return this.content
    }
  }
}