'use strict';

var React = require('react');
var ReactNative = require('react-native');
var {Component, PropTypes} = React;
var {StyleSheet, View, Text, PixelRatio, Dimensions} = ReactNative;

export default class Case1 extends Component {
    render() {
      return(
        <View style={styles.container}>
          <View style={[styles.item, styles.center]}>
            <Text>酒店</Text>
          </View>
          <View style={[styles.item, styles.lineLeftRight]}>
            <View style={[styles.center, styles.flex, styles.lineCenter]}>
              <Text>海外酒店</Text>
            </View>
            <View style={[styles.center, styles.flex]}>
              <Text>特惠酒店</Text>
            </View>
          </View>
          <View style={styles.item}>
            <View style={[styles.center, styles.flex, styles.lineCenter]}>
              <Text>团购</Text>
            </View>
            <View style={[styles.center, styles.flex]}>
              <Text>客栈.公寓</Text>
            </View>
          </View>
        </View>
      );
    }
}

var styles = StyleSheet.create({
    container: {
      height: 84,
      flexDirection: 'row',
      marginBottom: 64,
      marginLeft: 5,
      marginRight: 5,
      borderRadius: 5,
      padding: 2,
      backgroundColor: '#ff0067',
    },
    item: {
      flex: 1,
      height: 80,
    },
    center: {
      justifyContent: 'center', /*按照主轴方向居中*/
      alignItems: 'center', /*按照交叉轴方向居中*/
    },
    flex: {
      flex: 1,
    },
    font: {
      color: 'white',
      fontSize: 16,
      fontWeight: 'bold',
    },
    lineLeftRight: {
      borderLeftWidth: 1 / PixelRatio.get(), /*这里也可以用表达式？*/
      borderRightWidth: 1 / PixelRatio.get(),
      borderColor: 'white',
    },
    lineCenter: {
      borderBottomWidth: 1 / PixelRatio.get(),
      borderColor: 'white',
    },
});
