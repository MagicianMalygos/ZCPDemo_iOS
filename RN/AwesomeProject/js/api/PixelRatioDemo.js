'use strict'

import React, {Component, PropTypes} from 'react'
import {
  View,
  Text,
  StyleSheet,
  PixelRatio,
} from 'react-native'

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
    height: 40,
    marginLeft: 10,
    marginRight: 10,
  },
});

module.exports = PixelRatioDemo;
