import hilog from '@ohos:hilog';
/**
 * AUTHOR:AbnerMing
 * DATE:2023/9/5
 * INTRODUCE:日志打印工具类
 * */
export class Log {
    /*
     * 日志输出级别
     * */
    static setDomain(domain) {
        this.mDomain = domain;
    }
    /*
     * 初始化tag、domain等属性
     * */
    static init(object) {
        const tag = object.tag; //日志输出Tag
        const domain = object.domain; //日志输出级别
        const close = object.close; //是否关闭日志
        const isHilog = object.isHilog; //是否是hilog打印
        const showLogLocation = object.showLogLocation; //是否展示日志位置
        const logSize = object.logSize; //日志输出大小
        if (tag != undefined) {
            this.mTag = tag;
        }
        if (domain != undefined) {
            this.mDomain = domain;
        }
        if (close != undefined) {
            this.mClose = close;
        }
        if (isHilog != undefined) {
            this.mHilog = isHilog;
        }
        if (showLogLocation != undefined) {
            this.mShowLogLocation = showLogLocation;
        }
        if (logSize != undefined) {
            this.mLogSize = logSize;
        }
    }
    //需要先调用isLoggable确认某个domain、tag和日志级别是否被禁止打印日志
    static isLoggable(level) {
        return hilog.isLoggable(this.mDomain, this.mTag, level);
    }
    /*
   * console形式打印log日志,只支持console
   * */
    static log(message, tag) {
        console.log(this.getMessage(hilog.LogLevel.INFO, tag == undefined ? this.mTag : tag, message));
    }
    /*
  * info日志
  * */
    static info(message, tag) {
        this.logLevel(hilog.LogLevel.INFO, tag, message);
    }
    /*
  * debug日志
  * */
    static debug(message, tag) {
        this.logLevel(hilog.LogLevel.DEBUG, tag, message);
    }
    /*
  * error日志,不带标签
  * */
    static error(message, tag) {
        this.logLevel(hilog.LogLevel.ERROR, tag, message);
    }
    /*
  * warn日志
  * */
    static warn(message, tag) {
        this.logLevel(hilog.LogLevel.WARN, tag, message);
    }
    /*
  * fatal日志
  * */
    static fatal(message, tag) {
        this.logLevel(hilog.LogLevel.FATAL, tag, message);
    }
    /*
     *统一输出日志
     * */
    static logLevel(level, tag, message) {
        //如果关闭状态，则不打印日志
        if (this.mClose) {
            return;
        }
        //未传递时
        if (tag == undefined) {
            tag = this.mTag;
        }
        const content = this.getMessage(level, tag, message); //最终的内容展示
        const len = content.length / this.mLogSize;
        for (var i = 0; i < len; i++) {
            var con = content.substring(i * this.mLogSize, (i + 1) * this.mLogSize);
            if (i != 0) {
                con = "|" + con;
            }
            //打印日志
            if (this.mHilog) {
                //使用hilog
                switch (level) {
                    case hilog.LogLevel.INFO: //info
                        hilog.info(this.mDomain, tag, con);
                        break;
                    case hilog.LogLevel.WARN: //WARN
                        hilog.warn(this.mDomain, tag, con);
                        break;
                    case hilog.LogLevel.DEBUG: //DEBUG
                        hilog.debug(this.mDomain, tag, con);
                        break;
                    case hilog.LogLevel.ERROR: //ERROR
                        hilog.error(this.mDomain, tag, con);
                        break;
                    case hilog.LogLevel.FATAL: //FATAL
                        hilog.fatal(this.mDomain, tag, con);
                        break;
                }
            }
            else {
                //使用console
                switch (level) {
                    case hilog.LogLevel.INFO: //info
                        console.info(con);
                        break;
                    case hilog.LogLevel.WARN: //WARN
                        console.warn(con);
                        break;
                    case hilog.LogLevel.DEBUG: //DEBUG
                        console.debug(con);
                        break;
                    case hilog.LogLevel.ERROR: //ERROR
                        console.error(con);
                        break;
                    case hilog.LogLevel.FATAL: //FATAL
                        console.log(con);
                        break;
                }
            }
        }
    }
    /**
     * 获取输出位置
     * */
    static getMessage(level, tag, message) {
        var log = "┌───────" + tag + "────────────────────────────────────────────────────────────────────────────────";
        log = log.substring(0, log.length - tag.length) + "\n";
        try {
            if (this.mShowLogLocation && level == hilog.LogLevel.ERROR) {
                //展示位置
                const stackTrace = new Error().stack;
                const traceArray = stackTrace.split('\n');
                const trace = traceArray[traceArray.length - 2];
                log = log + "|" + trace;
            }
            var type = typeof message;
            if (type == "object") {
                //是对象
                message = this.getObjectToJson(message);
            }
            else if (type == "string") {
                //判断是否包含大括号
                const content = message + "";
                if (content.startsWith("{") && content.endsWith("}")) {
                    //对象
                    const obj = JSON.parse(message);
                    message = this.getObjectToJson(obj);
                }
                else {
                    message = content;
                }
            }
            log = log + "\n|    " + message;
        }
        catch (e) {
        }
        log = log + "\n└───────────────────────────────────────────────────────────────────────────────────────";
        return log;
    }
    /*
     *对象转Json
     * */
    static getObjectToJson(message) {
        const json = JSON.stringify(message, null, 2);
        const endMessage = json.replace(/\n/g, "\n|    ");
        return endMessage;
    }
}
Log.mTag = "HarmonyOSLog";
Log.mDomain = 0x0000;
Log.mClose = false;
Log.mHilog = true; //默认是用hilog进行打印
Log.mShowLogLocation = true; //展示点击的位置
Log.mLogSize = 1000; //打印的最大长度，默认是800
//# sourceMappingURL=Log.js.map