'use strict';

var React = require('react');
var ReactNative = require('react-native');
var {Component, PropTypes} = React;
var {StyleSheet, View, Dimensions} = ReactNative;

import TitleView from '../custom_component/title';

export default class Demo1 extends Component {

  static propTypes = {
    info: PropTypes.string.isRequired,
    index: PropTypes.number.isRequired,
  }

  render() {
    return(
      <View style={{flex: 1, backgroundColor: 'black', marginBottom: 64}}>
        <TitleView
          title={'编写Hello Worldasdfasdf'}
          height={50}
          textMarginLeft={15}
          textMarginRight={15}
          p={8}
          backgroundColor={'#abcdef'}
          fontColor={'red'}/>
        <MarginBox />
      </View>
    );
  }
}

class MarginBox extends Component {
  render() {
    return(
      <View style={{
        width: Dimensions.get('window').width,
        height: Dimensions.get('window').width,
        backgroundColor: 'red',
      }}>
        <View style={{
          flex: 1,
          marginTop: 50,
          marginLeft: 50,
          marginBottom: 50,
          marginRight: 50,
          backgroundColor: 'green',
        }}>
        </View>
      </View>
    );
  }
}
