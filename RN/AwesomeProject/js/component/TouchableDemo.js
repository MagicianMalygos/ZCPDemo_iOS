'use strict'

import React, {Component, PropTypes} from 'react'
import {
  View,
  Text,
  ScrollView,
  TouchableHighlight,
  TouchableOpacity,
  TouchableWithoutFeedback,
  StyleSheet,
  PixelRatio,
} from 'react-native'

import PropsShow from '../custom_component/PropsShow.js'

var TouchableDemo = React.createClass({
  getInitialState: function() {
    return({
    });
  },
  _show(text) {
    alert(text);
  },
  render() {
    return(
      <ScrollView style={styles.container}>
        <TouchableHighlight style={styles.touchable}
          activeOpacity={0.5}
          onPress={()=>this._show('TouchableHIghlight: onPress')}
          // onShowUnderlay={()=>this._show('TouchableHighlight: onShowUnderlay')}
          // onHideUnderlay={()=>this._show('TouchableHighlight: onHideUnderlay')}
          underlayColor='#e1f6ff'>
          <Text style={styles.touchableText}>TouchableHighlight</Text>
        </TouchableHighlight>

        <TouchableOpacity style={styles.touchable}
          activeOpacity={0.1}
          onPress={()=>this._show('TouchableOpacity: onPress')}>
          <Text style={styles.touchableText}>TouchableOpacity</Text>
        </TouchableOpacity>

        <TouchableWithoutFeedback style={{height: 100}}
          onLongPress={()=>this._show('TouchableWithoutFeedback: onLongPress')}
          onPressIn={()=>this._show('TouchableWithoutFeedback: onPressIn')}
          onPressOut={()=>this._show('TouchableWithoutFeedback: onPressOut')}>
          <View>
            <Text style={styles.touchableText}>TouchableWithoutFeedback</Text>
          </View>
        </TouchableWithoutFeedback>

        <PropsShow style={{marginTop: 5,}}
          texts={[
          {
            item: 'TouchableWithoutFeedback: （不建议使用）反馈性触摸。用户点击时，点击的组件不会出现任何视觉变化。',
            subItems: [
              {title: 'onLongPress', type: 'function', content: '长按事件',},
              {title: 'onPressIn', type: 'function', content: '触摸开始事件',},
              {title: 'onPressOut', type: 'function', content: '触摸结束事件',}
            ],
          },
          {
            item: 'TouchableOpacity: 透明触摸。用户点击时会出现（控件整体）透明过渡效果。',
            subItems: [
              {title: 'activeOpacity', type: 'number', content: '被触摸激活时的不透明度0~1',}
            ],
          },
          {
            item: 'TouchableHighlight: 高亮触摸。用户点击时，会产生高亮效果。',
            subItems:[
              {title: 'activeOpacity', type: 'number', content: '被触摸激活时的不透明度0~1',},
              {title: 'onHideUnderlay', type: 'function', content: '当底层的颜色被隐藏时调用',},
              {title: 'onShowUnderlay', type: 'function', content: '当底层的颜色被显示的时候调用',},
              {title: 'underlayColor', type: 'string', content: '有触摸操作时显示出来的底层的颜色',},
            ]
          },
        ]}/>
      </ScrollView>
    );
  }
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
    marginBottom: 64,
  },
  touchable: {
    flex: 1,
    flexDirection: 'row',
    height: 30,
    marginTop: 5,
    alignItems: 'center',
    justifyContent: 'center',
    borderWidth: 1 / PixelRatio.get(),
    borderColor: '#abcdef',
  },
  touchableText: {
    fontSize: 16,
    color: '#abcdef',
    textAlign: 'center',
  },
});

module.exports = TouchableDemo;
