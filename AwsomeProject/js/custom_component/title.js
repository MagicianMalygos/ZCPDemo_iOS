'use strict';

var React = require('react')
var ReactNative = require('react-native')
var {Component, PropTypes} = React
var {View, Text, StyleSheet} = ReactNative

let TitleView = React.createClass({
  propTypes : {
    title: PropTypes.string.isRequired,
    height: PropTypes.number.isRequired,
    textMarginLeft: PropTypes.number.isRequired,
    textMarginRight: PropTypes.number.isRequired,
    p: PropTypes.number.isRequired,
    backgroundColor: PropTypes.string.isRequired,
    fontColor: PropTypes.string.isRequired,
  },

  render() {
    console.log(this.props.height);
    return(
      <View style={[styles.container, {height: this.props.height}]}>
        <View style={{flex: 1, flexDirection: 'row', alignItems: 'center', backgroundColor: this.props.backgroundColor}}>
          <Text numberOfLines={1} style={{
            marginLeft: this.props.textMarginLeft,
            marginRight: this.props.textMarginRight,
            fontSize: 40 - (this.props.p * 5),
            backgroundColor: this.props.backgroundColor,
            color: this.props.fontColor,
          }}>
            {this.props.title}
          </Text>
        </View>
      </View>
    );
  },
});

const styles = StyleSheet.create({
  container: {
    flexDirection: 'row',
  },
});

module.exports = TitleView;
