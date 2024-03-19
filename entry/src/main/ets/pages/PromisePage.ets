import { Log, ToastUtil } from '@app/common_lib';
import taskpool from '@ohos.taskpool';

///校验并发函数, 将@Concurrent修饰的函数放在组件外部
// @ts-ignore
@Concurrent
async function imageProcessing(dataSlice: ArrayBuffer) {
  Log.error("task....0 " + dataSlice.toString())
  // 步骤1: 具体的图像处理操作及其他耗时操作
  return dataSlice;
}

function histogramStatistic(pixelBuffer: ArrayBuffer): Promise<unknown> {
  // 步骤2: 分成三段并发调度
  let number = pixelBuffer.byteLength / 3;
  let buffer1 = pixelBuffer.slice(0, number);

  let task1 = new taskpool.Task(imageProcessing, buffer1);
  return taskpool.execute(task1)
}

@Entry
@Component
struct PromisePage {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            let data: ArrayBuffer = new ArrayBuffer(123);
            histogramStatistic(data).then((value) => {
              // 步骤3: 结果处理
              ToastUtil.showToast('====:' + value)
              Log.error("task....1 ")
            });
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}
