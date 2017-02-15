'use strict'

import React, {Component, PropTypes} from 'react'
import {
  View,
  Text,
  StyleSheet,
  PixelRatio,
} from 'react-native'

/*

get:
PixelRatio.get() === 1
  mdpi Android devices (160 dpi)
PixelRatio.get() === 1.5
  hdpi Android devices (240 dpi)
PixelRatio.get() === 2
  iPhone 4, 4S
  iPhone 5, 5c, 5s
  iPhone 6
  xhdpi Android devices (320 dpi)
PixelRatio.get() === 3
  iPhone 6 plus
  xxhdpi Android devices (480 dpi)
PixelRatio.get() === 3.5
  Nexus 6

getPixelSizeForLayoutSize(number):
将一个布局尺寸(dp)转换为像素尺寸(px)。

getFontScale()
字体大小缩放比例
*/

var PixelRatioDemo = React.createClass({
  render() {
    return(
      <View style={styles.container}>
        <View style={styles.subView1}></View>
        <View style={styles.subView2}></View>
      </View>
    );
  },
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
    marginTop: 10,
  },
  subView1: {
    borderWidth: 1,
    borderColor: 'red',
    height: 40,
    marginBottom: 20,
    marginLeft: 10,
    marginRight: 10,
  },
  subView2: {
    borderWidth: 1 / PixelRatio.get(),
    borderColor: 'red',
    width: PixelRatio.getPixelSizeForLayoutSize(30),
    height: PixelRatio.getPixelSizeForLayoutSize(20),
    marginLeft: 10,
    marginRight: 10,
  },
});

module.exports = PixelRatioDemo;
