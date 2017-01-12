'use strict'

import React, {Component, PropTypes} from 'react'
import {
  View,
  ScrollView,
  Text,
  Image,
  StyleSheet,
  Dimensions,
} from 'react-native'

import PropsShow from '../custom_component/PropsShow'

var ImageDemo = React.createClass({
  getInitialState: function() {
    return({
      imageState: '',
    });
  },

  _show(text) {
    this.setState({
      imageState: this.state.imageState + '\n' + text,
    });
  },
  _onLayout(event) {
    const layout = event.nativeEvent.layout;
    const frame = 'x : '+layout.x+', y : '+layout.y+', width : '+layout.width+', height : '+layout.height;
    this._show(frame);
  },
  _onProgress(event) {
    const info = 'loaded : '+event.nativeEvent.loaded+' total : '+event.nativeEvent.total;
    this._show(info);
  },
  _onError(event) {
    const error = event.nativeEvent.error;
    this._show(error);
  },
  render() {
    return(
      <ScrollView style={styles.container}>
        {/* 要注意此处，如果项目的ATSS设置了AAL为yes，则只能加载https的图片 */}
        <Image style={styles.image}
          onLayout={(event)=>this._onLayout(event)}
          onLoadStart={()=>this._show('加载开始')}
          onProgress={(event)=>this._onProgress(event)}
          onLoadEnd={()=>this._show('加载结束')}
          onLoad={()=>this._show('加载完成')}
          onError={(event)=>this._onError(event)}
          source={{uri: 'https://raw.githubusercontent.com/ccgn/rust-image/master/examples/fractal.png'}}
          // defaultSource={require('../../source/default.jpeg')}
          defaultSource={require('image!default')}
          resizeMode='cover'
        />
        <Text style={styles.imageStateText}>{this.state.imageState}</Text>
        <PropsShow
          texts={[
            {
              item: 'resizeMode: 枚举类型，表示图片适应的模式。',
              subItems: [
                {title: 'cover', content: '保持图片宽高比缩放，直到填满视图容器'},
                {title: 'contain', content: '保持图片宽高比缩放，直到有一个方向刚好填满视图容器'},
                {title: 'stretch', content: '拉伸图片，直到填满视图容器'},
                {title: 'repeat', content: '图片维持原尺寸重复平铺直到填满视图（iOS）'},
                {title: 'center', content: '居中不拉伸'},
              ],
            },
            {item: 'source: 图片的引用地址。其值为{uri: string}，本地路径使用require(相对路径)引用',},
            {item: 'defaultSource: 默认图片地址（iOS）。使用同source',},
            {item: 'onLayout: 元素挂载或布局改变时调用。参数{nativeEvent: {layout: {x, y, width, height}}}',},
            {item: 'onLoadStart: 加载开始。',},
            {item: 'onProgress: 加载进度。参数{nativeEvent: {loaded, total}}'},
            {item: 'onLoadEnd: 加载结束。',},
            {item: 'onLoad: 加载成功',},
            {item: 'onError: 加载失败。参数{nativeEvent: {error}}'},
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
  image: {
    width: Dimensions.get('window').width,
    height: Dimensions.get('window').width * 0.7,
  },
  imageStateText: {
    marginLeft: 15,
    marginTop: 5,
    marginBottom: 5,
  },
});

module.exports = ImageDemo;
