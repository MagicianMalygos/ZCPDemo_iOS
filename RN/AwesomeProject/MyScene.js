import React, {Component, PropTypes} from 'react';
import {View, Text, TouchableHighlight} from 'react-native';

// 跳转至的页面
export default class MyScene extends Component {

  static propTypes = {
    navigator: PropTypes.object.isRequired,
    info: PropTypes.string.isRequired,
    index: PropTypes.number.isRequired,
  }

  render() {
    return(
      <View style={{flex: 1, marginTop: 64}}>
      </View>
    )
  }
}
