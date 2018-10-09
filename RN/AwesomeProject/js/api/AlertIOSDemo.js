'use strict'

import React, {Component, PropTypes} from 'react'
import {
  View,
  Text,
  AlertIOS,
  ScrollView,
  StyleSheet,
} from 'react-native'

var AlertIOSDemo = React.createClass({
  _tip() {
    AlertIOS.alert('提示', '选择学习React Native', [
      {
        text: '取消',
      },
      {
        text: '确认',
        onPress: ()=>{
          alert('你点击了确认按钮');
        }
      },
    ]);
  },
  _input () {
    AlertIOS.prompt('提示', '使用React Native开发App', [
      {
        text: '取消',
      },
      {
        text: '确认',
        onPress: (msg)=>{
          alert(msg);
        }
      }
    ]);
  },
  render() {
    return(
      <View style={styles.container}>
        <Text style={{}} onPress={this._tip}>提示对话框</Text>
        <Text style={{}} onPress={this._input}>输入对话框</Text>
      </View>
    );
  },
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
    marginTop: 10,
  },
});

module.exports = AlertIOSDemo;
