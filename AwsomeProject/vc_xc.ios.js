/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

// require：用来引入其他模块，类似与import或者include
var React = require('react-native');
var xcContent = require('./pages/xc');

// 批量定义组件(语法糖)：等同于
/*
var AppRegistry = React.AppRegistry;
var StyleSheet = React.StyleSheet;
var Text = React.Text;
var View = React.View;
*/
var {
  AppRegistry,
  StyleSheet,
  NavigatorIOS,
} = React;

// 使用createClass创建入口类，
var XC = React.createClass({

  // render：渲染视图，返回视图的模板代码 JSX的模板语言
  render: function() {
    // 最外层只能有一个View
    return (
      // Navigator
      <NavigatorIOS style={[{flex:1}, ]} initialRoute={{title: '首页', component: xcContent}}/>
    );
  }
});

// 创建样式
var styles = StyleSheet.create({
});

// 注册应用入口
AppRegistry.registerComponent('AwsomeProject', () => XC);
