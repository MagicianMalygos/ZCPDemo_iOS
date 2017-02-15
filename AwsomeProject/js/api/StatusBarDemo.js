'use strict'

import React, {Component, PropTypes} from 'react'
import {
  StyleSheet,
  View,
  Text,
  StatusBar,
} from 'react-native'

var StatusBarDemo = React.createClass({
  render() {
    return(
      <View style={{flex: 1}}>
        <StatusBar
          backgroundColor='blue'
          translucent={true}
          barStyle='default'
          networkActivityIndicatorVisible={true}>
        </StatusBar>
      </View>
    );
  },
});

module.exports = StatusBarDemo;
