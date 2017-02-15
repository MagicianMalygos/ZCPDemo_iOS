'use strict';

import MyScene from '../MyScene.js'
import Demo1 from './1/demo1.js'
import Case1 from './case/case1.js'
import Case2 from './case/case2.js'

import NavigatorIOSDemo from './component/NavigatorIOSDemo.js'
import TextInputDemo from './component/TextInputDemo.js'
import TouchableDemo from './component/TouchableDemo'
import ImageDemo from './component/ImageDemo'
import TabBarIOSDemo from './component/TabBarIOSDemo'
import WebViewDemo from './component/WebViewDemo'
import AsyncStorageDemo from './api/AsyncStorageDemo'
import AlertIOSDemo from './api/AlertIOSDemo'
import ActionSheetIOSDemo from './api/ActionSheetIOSDemo'
import PixelRatioDemo from './api/PixelRatioDemo'
import AppStateDemo from './api/AppStateDemo'
import StatusBarDemo from './api/StatusBarDemo'

module.exports = {
  组件: [
    {
      index: 0,
      title: 'NavigatorIOS',
      component: NavigatorIOSDemo,
      hideNav: false,
    },
    {
      index: 1,
      title: 'TextInput',
      component: TextInputDemo,
      hideNav: false,
    },
    {
      index: 2,
      title: 'TouchableDemo',
      component: TouchableDemo,
      hideNav: false,
    },
    {
      index: 3,
      title: 'ImageDemo',
      component: ImageDemo,
      hideNav: false,
    },
    {
      index: 4,
      title: 'TabBarIOSDemo',
      component: TabBarIOSDemo,
      hideNav: false,
    },
    {
      index: 5,
      title: 'WebViewDemo',
      component: WebViewDemo,
      hideNav: false,
    },
  ],
  API: [
    {
      index: 1,
      title: 'AsyncStorage',
      component: AsyncStorageDemo,
      hideNav: false,
    },
    {
      index: 2,
      title: 'AlertIOSDemo',
      component: AlertIOSDemo,
      hideNav: false,
    },
    {
      index: 3,
      title: 'ActionSheetIOSDemo',
      component: ActionSheetIOSDemo,
      hideNav: false,
    },
    {
      index: 4,
      title: 'PixelRatioDemo',
      component: PixelRatioDemo,
      hideNav: false,
    },
    {
      index: 5,
      title: 'AppStateDemo',
      component: AppStateDemo,
      hideNav: false,
    },
    {
      index: 6,
      title: 'StatusBarDemo',
      component: StatusBarDemo,
      hideNav: false,
    },
  ],
  案例: [
    {
      index: 0,
      title: '携程',
      component: Case1,
      hideNav: false,
    },
    {
      index: 1,
      title: '网易',
      component: Case2,
      hideNav: false,
    },
  ],
  入门基础: [
    {
      index: 0,
      title: '搭建开发环境',
      component: MyScene,
      hideNav: false,
    },
    {
      index: 1,
      title: '编写Hello World',
      component: Demo1,
      hideNav: false,
    },
    {
      index: 2,
      title: 'Props（属性）',
      component: MyScene,
      hideNav: false,
    },
    {
      index: 3,
      title: 'State（状态）',
      component: MyScene,
      hideNav: false,
    },
    {
      index: 4,
      title: '样式',
      component: MyScene,
      hideNav: false,
    },
    {
      index: 5,
      title: '高度域宽度',
      component: MyScene,
      hideNav: false,
    },
    {
      index: 6,
      title: '使用Flexbox布局',
      component: MyScene,
      hideNav: false,
    },
    {
      index: 7,
      title: '处理文本输入',
      component: MyScene,
      hideNav: false,
    },
    {
      index: 8,
      title: '如何使用ScrollView',
      component: MyScene,
      hideNav: false,
    },
    {
      index: 9,
      title: '如何使用ListView',
      component: MyScene,
      hideNav: false,
    },
    {
      index: 10,
      title: '网络',
      component: MyScene,
      hideNav: false,
    },
    {
      index: 11,
      title: '使用导航器跳转页面',
      component: MyScene,
      hideNav: false,
    },
    {
      index: 12,
      title: '其他参考资源',
      component: MyScene,
      hideNav: false,
    }
  ],
  进阶指南: [
    {
      index: 0,
      title: '嵌入到现有原生应用',
      component: MyScene,
      hideNav: false,
    },
    {
      index: 1,
      title: '颜色',
      component: MyScene,
      hideNav: false,
    },
    {
      index: 2,
      title: '图片',
      component: MyScene,
      hideNav: false,
    },
    {
      index: 3,
      title: '处理触摸事件',
      component: MyScene,
      hideNav: false,
    },
    {
      index: 4,
      title: '动画',
      component: MyScene,
      hideNav: false,
    },
    {
      index: 5,
      title: '无障碍功能',
      component: MyScene,
      hideNav: false,
    },
    {
      index: 6,
      title: '定时器',
      component: MyScene,
      hideNav: false,
    },
    {
      index: 7,
      title: '直接操作',
      component: MyScene,
      hideNav: false,
    },
    {
      index: 8,
      title: '调试',
      component: MyScene,
      hideNav: false,
    },
    {
      index: 9,
      title: '自动化测试',
      component: MyScene,
      hideNav: false,
    },
    {
      index: 10,
      title: 'JavaScript环境',
      component: MyScene,
      hideNav: false,
    },
    {
      index: 11,
      title: '导航器对比',
      component: MyScene,
      hideNav: false,
    },
    {
      index: 12,
      title: '性能',
      component: MyScene,
      hideNav: false,
    },
    {
      index: 13,
      title: '升级',
      component: MyScene,
      hideNav: false,
    },
    {
      index: 14,
      title: '特定平台代码',
      component: MyScene,
      hideNav: false,
    },
    {
      index: 15,
      title: '手势响应系统',
      component: MyScene,
      hideNav: false,
    }
  ],
}
