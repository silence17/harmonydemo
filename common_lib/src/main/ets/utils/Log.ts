import hilog from '@ohos.hilog';
const maxSize = 1024
class Log{

  domain:number;
  tag:string

  constructor(domain=0x005fbe,tag="xg-app") {
    this.domain = domain
    this.tag = tag
  }
  
  info(format="",...args){
    if (format.length <= maxSize) {
      // 长度小于等于限制直接打印
    }else {
      while (format.length > maxSize){
        //循环分段打印
        let logContent = format.substring(0,maxSize)
        format = format.replace(logContent,"")
        hilog.error(0x00FFFF,this.tag,'%{private}s %{public}s',logContent)
        // 打印剩余日志
      }
    }
    hilog.info(0x00FFFF,this.tag,'%{private}s %{public}s',format,args);
  }

  debug(format="",...args){
    if (format.length <= maxSize) {
      // 长度小于等于限制直接打印
    }else {
      while (format.length > maxSize){
        //循环分段打印
        let logContent = format.substring(0,maxSize)
        format = format.replace(logContent,"")
        hilog.error(0x00FFFF,this.tag,'%{private}s %{public}s',logContent)
        // 打印剩余日志
      }
    }
    hilog.debug(this.domain,this.tag,'%{private}s %{public}s',format,args);
  }

  error(format="",...args){
    if (format.length <= maxSize) {
      // 长度小于等于限制直接打印
    }else {
      while (format.length > maxSize){
        //循环分段打印
        let logContent = format.substring(0,maxSize)
        format = format.replace(logContent,"")
        hilog.error(0x00FFFF,this.tag,'%{private}s %{public}s',logContent)
        // 打印剩余日志
      }
    }
    hilog.error(0xFFFF00 ,this.tag,'%{private}s %{public}s',format,args);
  }

}

export default new Log();