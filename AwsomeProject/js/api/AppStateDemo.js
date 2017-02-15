'use strict'

import React, {Component, PropTypes} from 'react'
import {
  StyleSheet,
  View,
  Text,
  TouchableHighlight,
  AppState,
} from 'react-native'

var AppStateIOSDemo = React.createClass({
  render() {
    AppState.addEventListener('change', ()=>{
      alert('状态发生改变');
    });
    AppState.addEventListener('memoryWarning', ()=>{
      alert('内存报警事件');
    });
    return(
      <View style={{flex: 1}}>
        <TouchableHighlight style={{flex: 1}} onPress={()=>{
          alert(AppState.currentState);
        }}>
          <View style={{flex: 1}}>
          </View>
        </TouchableHighlight>
      </View>
    );
  },
});

module.exports = AppStateIOSDemo;
