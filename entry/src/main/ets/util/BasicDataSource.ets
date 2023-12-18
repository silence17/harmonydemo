import { Log } from '@app/common_lib/src/main/ets/utils/Log/Log';

export class BasicDataSource implements IDataSource {
  private listeners: DataChangeListener[] = []


  /**
   * 获得数据总数
   * @returns
   */
  totalCount(): number {
    return 0;
  }

  /**
   * 获取索引值对应的数据
   * @param index
   */
  getData(index: number) {
    throw undefined;
  }

  /**
   * 注销数据改变的监听器
   * @param listener
   *
   * interface DataChangeListener {
   * onDataReloaded(): void; // 重新加载数据时调用
   * onDataAdded(index: number): void; // 添加数据时调用
   * onDataMoved(from: number, to: number): void; // 数据移动起始位置与数据移动目标位置交换时调用
   * onDataDeleted(index: number): void; // 删除数据时调用
   * onDataChanged(index: number): void; // 改变数据时调用
   * onDataAdd(index: number): void; // 添加数据时调用
   * onDataMove(from: number, to: number): void; // 数据移动起始位置与数据移动目标位置交换时调用
   * onDataDelete(index: number): void; // 删除数据时调用
   * onDataChange(index: number): void; // 改变数据时调用
   * }
   */
  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      Log.info('add listener')
      this.listeners.push(listener)
    }
  }

  /**
   * 注册数据改变的监听器
   * @param listener
   */
  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener)
    if (pos >= 0) {
      Log.info('add listener')
      //移除元素
      this.listeners.splice(pos, 1)
    }
  }


  // 通知LazyForEach组件需要重载所有子组件
  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded();
    })
  }

  // 通知LazyForEach组件需要在index对应索引处添加子组件
  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index);
    })
  }

  // 通知LazyForEach组件在index对应索引处数据有变化，需要重建该子组件
  notifyDataChange(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataChange(index);
    })
  }

  // 通知LazyForEach组件需要在index对应索引处删除该子组件
  notifyDataDelete(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataDelete(index);
    })
  }
}