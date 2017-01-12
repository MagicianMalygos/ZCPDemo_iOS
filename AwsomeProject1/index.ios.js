/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

// require：用来引入其他模块，类似与import或者include
var React = require('react-native');

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
  Text,
  View,
  Image,
} = React;

// 使用createClass创建入口类，
var AwsomeProject = React.createClass({

  // render：渲染视图，返回视图的模板代码 JSX的模板语言
  render: function() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Welcome to React Native!
        </Text>
        <Text style={styles.instructions}>
          To get started, edit index.ios.js
        </Text>
        <Text style={styles.instructions}>
          Press Cmd+R to reload,{'\n'}
          Cmd+D or shake for dev menu
        </Text>
        <Image style={styles.photo} source={{uri: 'http://img3.imgtn.bdimg.com/it/u=3297908201,1649339516&fm=21&gp=0.jpg'}}>
        </Image>
      </View>
    );
  }
});

// 创建样式
var styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
  photo: {
    width: 100,
    height: 100,
    backgroundColor: '#abcdef'
  },
});

// 注册应用入口
AppRegistry.registerComponent('AwsomeProject', () => AwsomeProject);
