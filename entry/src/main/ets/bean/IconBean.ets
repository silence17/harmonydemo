/**
 * 推荐icon
 */
export class IconBean {
  iconUrl: string | Resource;
  content: string;
  id: string;

  constructor(id: string, iconUrl: string | Resource, content: string) {
    this.id = id
    this.iconUrl = iconUrl
    this.content = content
  }
}