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
} = React;

// 使用createClass创建入口类，
var AwsomeProject = React.createClass({

  // render：渲染视图，返回视图的模板代码 JSX的模板语言
  render: function() {
    // 最外层只能有一个View
    return (
      <View style={styles.v1}>
        <View style={styles.v2}>
          <Text style={{marginTop:40, fontSize:25}}>1/4 height</Text>
          <Text style={{marginTop:40, fontSize:25}}>1/4 height</Text>
        </View>
        <View style={[styles.v2, {flexDirection: 'column'}]}>
          <Text style={{marginTop:40, fontSize:25}}>1/4 height</Text>
          <Text style={{marginTop:40, fontSize:25}}>1/4 height</Text>
        </View>
        <View style={{flex:10, borderWidth:1, borderColor:'red',}}>
          <Text style={{marginTop:40, fontSize:25}}>1/2 height</Text>
        </View>

        <View style={{flex:20}}>
          <View style={[styles.v, ]}><Text>自由摆放</Text></View>
          <View style={[styles.v, styles.center]}><Text>居中摆放</Text></View>
          <View style={[styles.v, styles.left]}><Text>居左摆放</Text></View>
          <View style={[styles.v, styles.right]}><Text>居右摆放</Text></View>
        </View>

        <View style={{flex:20, borderColor: 'red', borderWidth: 0.5, justifyContent: 'center', alignItems: 'center'}}>
          <View style={{borderWidth:3, height:50, borderColor: 'blue'}}><Text>方块居中</Text></View>
        </View>
      </View>
    );
  }
});

// 创建样式
var styles = StyleSheet.create({
    v1: {
      flex: 1,
    },
    v2: {
      flex: 5,
      flexDirection: 'row',
      height: 40,
      borderWidth: 1,
      borderColor: 'red',
    },
    v: {
      borderWidth: 5,
      borderColor: 'blue',
      width: 100,
      height: 40,
    },
    center: {
      alignSelf: 'center',
    },
    left: {
      alignSelf: 'flex-start',
    },
    right: {
      alignSelf: 'flex-end'
    },
});

// 注册应用入口
AppRegistry.registerComponent('AwsomeProject', () => AwsomeProject);
