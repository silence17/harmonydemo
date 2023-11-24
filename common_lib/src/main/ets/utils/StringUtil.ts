export class StringUtil {
  static isEmpty(content: string): boolean {
    return content === undefined || content === null || content.length === 0 || content === 'null'
  }
}