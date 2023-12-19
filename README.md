# ArkTS基础知识（ArkTS）

### 简介

使用声明式语法和组件化基础知识，搭建一个可刷新的排行榜页面。效果图如下：

### 项目目录结构：

1. AppScope：中存放应用全局所需要的资源文件
2. entry：时应用的主模块，存放HarmonyOS应用的代码、资源；
3. oh_modules：是工程的依赖包，存放哦那过程依赖的资源文件；
4. build-profile.json5：是工程级配置信息，包括签名、产品、创建的module信息；
5. hvigorfile.ts：是工程级编译构建任务脚本，hvigor是基于任务管理机制实现的一款全新的自动化构建工具，主要提供任务注册编排，工程模型管理、配置管理等核心能力。
6. oh-package.json5：工程级依赖配置文件，用于记录引入包的配置信息；

![](screenshots/device/screenshots.gif)

### 相关概念

#### 渲染控制语法

- [条件渲染](https://developer.harmonyos.com/cn/docs/documentation/doc-guides-V3/arkts-rendering-control-ifelse-0000001524177637-V3)
  ：使用if/else进行条件渲染。
- [循环渲染](https://developer.harmonyos.com/cn/docs/documentation/doc-guides-V3/arkts-rendering-control-foreach-0000001524537153-V3)
  ：开发框架提供循环渲染（ForEach组件）来迭代数组，并为每个数组项创建相应的组件。

#### [组件化装饰器@Builder](https://developer.harmonyos.com/cn/docs/documentation/doc-guides-V3/arkts-builder-0000001524176981-V3)

- @Builder 装饰的方法用于定义组件的声明式UI描述，在一个自定义组件内快速生成多个布局内容。@Builder装饰方法的功能和语法规范与build函数相同。

#### 组件状态管理器

- [@State](https://developer.harmonyos.com/cn/docs/documentation/doc-guides-V3/arkts-state-0000001474017162-V3)
  装饰的变量是组件内部的状态数据，当这些状态数据被修改时，将会调用所在组件的build方法进行UI刷新。
- [@Prop](https://developer.harmonyos.com/cn/docs/documentation/doc-guides-V3/arkts-prop-0000001473537702-V3)
  与@State有相同的语义，但初始化方式不同。@Prop装饰的变量必须使用其父组件提供的@State变量进行初始化，允许组件内部修改@Prop变量，但更改不会通知给父组件，即@Prop属于单向数据绑定。
- [@Link](https://developer.harmonyos.com/cn/docs/documentation/doc-guides-V3/arkts-link-0000001524297305-V3)
  装饰的变量可以和父组件的@State变量建立双向数据绑定。

#### [组件生命周期函数](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/arkts-custom-component-lifecycle-0000001482395076-V3)

- 自定义组件的生命周期回调函数用于通知用户该自定义组件的生命周期，这些回调函数是私有的，在运行时由开发框架在特定的时间进行调用，不能从应用程序中手动调用这些回调函数。

### 相关权限

不涉及

### 使用说明

1. 点击标题栏返回按钮，退出应用。
2. 点击标题栏刷新按钮，刷新列表数据。
3. 点击排行榜列表中的某一项，列表中的子组件文本颜色会发生变化。
4. 点击系统导航返回按钮，满足退出条件则直接退出，否则，提示再按一次退出程序。

### 约束与限制

1. 本示例仅支持标准系统上运行，支持设备：华为手机或运行在DevEco Studio上的华为手机设备模拟器。
2. 本示例为Stage模型，支持API version 9。
3. 本示例需要使用DevEco Studio 3.1 Release版本进行编译运行。

-----------------

### 上传github

1. github 创建仓库 new repository
   切换到本地项目目录：
2. git init (快捷键Command + Shift + . 查看生成的.git文件)
3. git add . (将本地项目中的全部文件添加至git中，命令中.的含义就是“全部文件”。)
4. git commit -m "description" （添加项目的描述文字，命令中description就是自定义的描述文字。）
5. git remote add origin
   pj_ssh_path，其中pj_ssh_path可通过下下图的方式进行复制粘贴，比如我这里的pj_ssh_path为git@github.com:
   silence17/harmonydemo.git
6. git push -f origin master，将本地项目的文件上传至Github官网中

### 注意事项：
导致预览失败的几个原因：
1. 在包含@Link注解的组件中，使用@Preview会导致项目预览失败
2. 使用@Provide注释夸组件传递变量时，配对注解@Consume必须与@Provide在同一个文件中


布局中注意事项：
1. RelativeContainer中不声明id属性，会不显示view



