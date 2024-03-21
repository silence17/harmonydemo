
function __px2vp(px:number): number {
  return  px  * (360/375);// Math.round(px *  target_scaledDensity/target_density )  //此逻辑未验证
}

let PX={};

/**
 * 一些常量
 */
export default class Constants {

  /**
   * 100%
   */
  public static readonly FULL_PERCENT: string = '100%';

  /**
   * font weight  普通文本
   */
  public static readonly Font_Weight_normal: number = 450;
  /**
   * 粗体文本
   */
  public static readonly Font_Weight_bold: number = 600;



  /**
   * 系统颜色
   * key : 设计图的颜色值 _下划线开头 去掉#号 可以是rgba 就rgba开头,数值用_分开,这样方便查看调用 或单色
   */
  public static readonly Color = {
    /**浅色(灰色) 一般用于副标题 非重要信息  */
    _85919c: '#85919c',
    /**白色 用于深色背景 按钮等*/
    white:"#ffffff",
    /**大体黑色的 又不是全黑的 用于全部黑色字 */
    _292e33:"#292e33",
    /**蓝色 #005fbe 用于链接类*/
    _005fbe:"#005fbe",
    /** 浅黑色 用于文字 次重要信息  */
    _94949c:"#94949c",
    /**分割线*/
    _d7d7d7:"#d7d7d7",
    /**
     * loadng 加载中背景mask颜色
     */
    "rgba_249_252_255_0_1":"rgba(249,252,255,0.1)",
    /**
     * hr 线shadow颜色
     */
    "rgba_204_210_215_0_10":"rgba(204,210,215,0.10)"

  }

  /**
   * 待定 系统自带的 看起来好像小了一号  统一封装,避免后续 到处修改
   * @param px
   * @returns
   */
  public  static  px2vp(px:number): number {
    if(PX[px]){
      return  PX[px]
    }
    PX[px] = __px2vp(px)
    return PX[px]
  }


}