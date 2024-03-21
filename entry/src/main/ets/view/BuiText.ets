import Constants from '../../common/Constants';

interface TextStruct {
  fontFamily?: string;
  fontSize?: number;
  color?: string;
  bold?: boolean;
}

// 这2个 是一样的,只是不能同时设置Text和Span ,后续修改也要保持一致
@Extend(Text)
function textStyle(structObject: TextStruct) {
  .fontFamily(structObject.fontFamily as string)
  .fontSize(structObject.fontSize)
  .fontColor(structObject.color)
  .fontWeight(structObject.bold ? 500 : 450)
}

@Extend(Span)
function spanStyle(structObject: TextStruct) {
  .fontFamily(structObject.fontFamily)
  .fontSize(structObject.fontSize)
  .fontColor(structObject.color)
  .fontWeight(structObject.bold ? 500 : 450)
}

export class TextColor {
  /**
   * 白色字体 用于深色背景 按钮等
   */
  public static Color_white: string = Constants.Color.white;
  /**
   * 浅色(灰色) 一般用于副标题 非重要信息
   */
  public static Color_gray: string = Constants.Color._85919c;
  /**
   *  大体黑色的 又不是全黑的 用于全部黑色字
   */
  public static Color_black: string = Constants.Color._292e33;
  /**
   * 蓝色 #005fbe 用于链接类
   */
  public static Color_blue: string = Constants.Color._005fbe;
}

export interface SpanText extends TextStruct {
  text: string;
  color?: string;
  bold?: boolean;
  fontFamily?: string;
  fontSize?: number;
  click?: () => void;
}


/** 暂时没有找到全局设置字体的方法(API9无法得到font对象)
 * 也没有 类似全局css 的方式
 * 假设场景:  一个系统内最多2-3种字体 ,但却是自定义字体 , 每处都写实在是麻烦
 * , 所以只能在这里封装了
 * 文本字段的封装
 * 统一字体和粗体
 * import BuiText, { TextColor } from '../../components/bui/BuiText';
 */
@Component
export default struct BuiText {
  // 空方法   暂时没有发现全局 @Builder的写法,只能每个文件都写
  @Builder
  empty() {
  };

  /**
   * 文本
   */
  @State text: string = "";
  /**
   * 多段文本的写法 和 text字段 任选1 ,当 spans.length !=0 时 , text 字段失效
   */
  @State spans: Array<SpanText> | SpanText = [];
  @State fontFamily?: string = "n";
  @State fontSize?: number = Constants.px2vp(14);
  @State line_height: number | string = 0;
  /**
   * 字体颜色 默认 #292e33
   *  灰色 #85919c 一般用于副标题
   *  蓝色 #005fbe 用于链接类
   *  白色  #fff 用于深色背景 按钮等
   */
  @State color?: string = TextColor.Color_black;
  /**
   * 是否粗体
   */
  @State bold?: boolean = false;
  /**
   是否显示行数 不设置,就不显示, 3则显示3行,超出...
   *  超出 ...
   */
  @State ellipsis?: number = Number.MAX_VALUE
  /**
   * 是否渲染为 Span , 仅 适用 parent是BuiText 和 slot配合时候, 作为slot内容时才有效
   */
  @State span?: boolean = false;

  getSpans(): SpanText[] {
    if (this.text) {
      return [{
        text: this.text
      }];
    } else if (Array.isArray(this.spans)) {
      return this.spans;
    } else {
      return [this.spans];
    }
  }

  getSpanBold(span: SpanText): number {
    if (span.bold !== undefined) {
      return span.bold ? 500 : 450;
    }
    return this.bold ? 500 : 450;
  }

  build() {

    Text() {
      ForEach(this.getSpans(), (span: SpanText, index: number) => {
        Span(span.text)
          .spanStyle(span)
          .fontColor(span.color || this.color)
          .fontSize(span.fontSize || this.fontSize)
          .fontWeight(this.getSpanBold(span))
          .onClick(() => {
            if (span.click) {
              span.click();
            }
          })

      }, (index: number) => index + "")
    }
    .textStyle(this.textStyle())
    .lineHeight(this.line_height)
    .textOverflow(
      this.ellipsis != Number.MAX_VALUE ? { overflow: TextOverflow.Ellipsis } : { overflow: TextOverflow.Clip }
    )
    .textAlign(TextAlign.Start)
    .maxLines(this.ellipsis != Number.MAX_VALUE ? this.ellipsis : 30000);

  }

  textStyle(): TextStruct {

    let ts: TextStruct = {};
    if (this.fontFamily) {
      ts.fontFamily = this.fontFamily;
    }

    if (this.fontSize) {
      ts.fontSize = this.fontSize;
    }
    if (this.color) {
      ts.color = this.color;
    }
    if (this.bold) {
      ts.bold = this.bold;
    }
    return ts
  }
}