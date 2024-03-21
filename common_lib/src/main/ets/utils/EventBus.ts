import emitter from '@ohos.events.emitter'
import Log from './Log';

//APP级事件ID,仅用此一个代码
const EVENT_ID=95274;

//可传递的事件对象结构
export interface MyEventData{
  //事件名称
  eventName:string;
  [key:string]:any
  //要发送的数据
  data?:object
  // 响应事件时的回调, on 必传
  callback?:(eventData:emitter.EventData)=>void
  //谁来响应 谁on就写谁的this
  target?:any
}

class EventBus{
  private static instance:EventBus;
  private subscribes:Map<string,Map<object,MyEventData>> = new Map();


  private constructor(){
     this.__registerEventListener();
  }

  private __registerEventListener() {
    emitter.on({eventId:EVENT_ID},(data: emitter.EventData)=>{
        this.onEvent(data?.data as MyEventData);
    });
  }

  public static getInstance(){
    if(!EventBus.instance){
      EventBus.instance = new EventBus();
    }
    return EventBus.instance;
  }

  /**
   * 接收到事件,并处理
   * @param eventData
   */
  private onEvent(eventData:emitter.EventData){
    Log.error("EventBus.onEvent()"+"触发事件 eventData "+ JSON.stringify(eventData));

    let eventName = eventData?.["eventName"];
    if(!eventName || !this.subscribes.has(eventName)){
      return;
    }
    let subs = this.subscribes.get(eventName);
    for(let [key,value] of subs){
      try {
        Log.error("EventBus.onEvent()","触发事件 "+ key);
        value.callback && value.callback(eventData);
      } catch (e) {
        Log.error("EventBus.onEvent()","触发事件时出错",e);
      }
    }
  }

  /**
   * 外部调用注册事件EventBus.on({eventName:"loading",()=>{})
   *
   */
  public on(eventData:MyEventData){
     try {
        let eventName = eventData?.eventName;
        if(!this.subscribes.has(eventName)){
          this.subscribes.set(eventName,new Map());
        }
        let eventTarget = eventData?.target;
        if(!eventTarget){
          Log.error("EventBus.on()","注册事件时 eventData.target 必须填写,一般是 this ");
        }
        let subs = this.subscribes.get(eventName);
        if(!subs.has(eventTarget)){
          subs.set(eventTarget,eventData);
        }
     }catch (e) {
       Log.error("EventBus.on()",e);
     }
  }
  //外部触发  EventBus.emit({eventName:"loading",{},()=>{
  //
  // }})
    public emit(eventData:{ [key:string]:any }){
      try {
        emitter.emit({ eventId: EVENT_ID }, { data: eventData });
      }catch (e) {
        Log.error("EventBus.emit()","触发事件时出错",e);
      }
    }

  /**
   * 取消注册事件
   * @param eventData
   */
  public off(eventData:{ [key:string]:any }){
    let eventName = eventData.eventName;
    let eventTarget = eventData.target;
    if(!this.subscribes.has(eventName)){
      return;
    }
    let subs = this.subscribes.get(eventName);
    if(subs.has(eventTarget)){
      subs.delete(eventTarget);
    }
  }


}
export default EventBus.getInstance();