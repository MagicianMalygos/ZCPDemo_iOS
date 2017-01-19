'use strict'

import React, {Component, PropTypes} from 'react'
import {
  View,
  Text,
  ActionSheetIOS,
  StyleSheet,
} from 'react-native'

var ActionSheetIOSDemo = React.createClass({
  _tip() {
    ActionSheetIOS.showActionSheetWithOptions({
      options: [
        '拨打电话',
        '发送邮件',
        '发送短信',
        '取消',
      ],
      cancelButtonIndex: 3,
      destructiveButtonIndex: 0,
    }, (index)=>{
      alert(index);
    });
  },
  _share() {
    ActionSheetIOS.showShareActionSheetWithOptions({
      url: 'https://code.facebook.com',
    }, (err)=>{
      alert('err: ' + err);
    }, (msg)=>{
      alert('msg: ' + msg);
    });
  },
  render() {
    return(
      <View style={styles.container}>
        <Text style={styles.item} onPress={this._tip}></Text>
        <Text style={styles.item} onPress={this._share}></Text>
      </View>
    );
  },
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
    margin: 10,
  },
  item: {
    marginTop: 10,
    marginLeft: 5,
    marginRight: 5,
    height: 30,
    borderWidth: 1,
    padding: 6,
    borderColor: '#ddd',
  },
});

module.exports = ActionSheetIOSDemo;
