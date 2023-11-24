export class NavItem {
  icon: Resource;
  icon_selected: Resource;
  text_color_normal: Resource = $r('app.color.text_normal')
  text_color_select: Resource = $r('app.color.text_select')
  text: string;
  id: TabId;
  count: number = 0;

  constructor(id: TabId, text: string, icon: Resource, icon_select: Resource) {
    this.id = id;
    this.text = text;
    this.icon = icon;
    this.icon_selected = icon_select;
  }
}

export enum TabId {
  HOME,
  ACHIEVEMENT,
  MINE
}


export const NavList: NavItem[] = [

  new NavItem(TabId.HOME,
    '首页',
    $r('app.media.ic_tabs_home_normal'),
    $r('app.media.ic_tabs_home_sel')),

  new NavItem(
    TabId.ACHIEVEMENT,
    '发现',
    $r('app.media.ic_tabs_achievement_normal'),
    $r('app.media.ic_tabs_achievement_sel')
  ),

  new NavItem(
    TabId.MINE,
    '我的',
    $r('app.media.ic_tabs_mine_normal'),
    $r('app.media.ic_tabs_mine_sel'),
  ),
]