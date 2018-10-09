'use strict'

var React = require('react');
var ReactNative = require('react-native');
var {Component, PropTypes} = React;
var {StyleSheet, View, ScrollView, Text} = ReactNative;

import PropsShow from '../custom_component/PropsShow.js'

export default class NavigatorIOSDemo extends Component {
  render() {
    this.props.navigator.barTintColor = '#ff8447';
    var texts = [
      {item: 'barTintColor: 导航条的背景颜色'},
      {
        item: 'initialRoute: 初始化路由。路由对象如下：',
        subItems: [
          {title: 'componet',type: 'function',content: '加载视图的组件',},
          {title: 'title',type: 'string',content: '当前视图的标题',},
          {title: 'passProps',type: 'object',content: '传递的数据',},
          {title: 'backButtonIcon',type: 'Image.propTypes.source',content: '后退按钮图标',},
          {title: 'backButtonTitle',type: 'string',content: '后退按钮标题',},
          {title: 'leftButtonIcon',type: 'Image.propTypes.source',content: '左边按钮图标',},
          {title: 'leftButtonTitle',type: 'string',content: '左边按钮标题',},
          {title: 'onLeftButtonPress',type: 'function',content: '左边按钮点击事件',},
          {title: 'rightButtonIcon',type: 'Image.propTypes.source',content: '右边按钮图标',},
          {title: 'rightButtonTitle',type: 'string',content: '右边按钮标题',},
          {title: 'onRightButtonPress',type: 'function',content: '右边按钮点击事件',},
          {title: 'wrapperStyle',type: '[object Object]',content: '包裹样式',},
        ]
      },
      {item: 'itemWrapperStyle: 为每一项定制样式，例如设置每个页面的背景颜色'},
      {item: 'navigationBarHidden: 当其值为true时，隐藏导航栏'},
      {item: 'shadowHidden: 是否隐藏阴影，其值为true或false'},
      {item: 'tintColor: 导航栏上按钮的颜色设置'},
      {item: 'translucent: 导航栏是否是半透明的'},
    ];
    return(
      <ScrollView style={styles.container}>
        <PropsShow texts={texts}/>
      </ScrollView>
    );
  }
}

var styles = StyleSheet.create({
  container: {
    marginBottom: 64,
    flex: 1,
  },
});
