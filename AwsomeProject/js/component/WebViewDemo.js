'use strict'

import React,{Component, PropTypes} from 'react'
import {
  View,
  ScrollView,
  Text,
  WebView,
  StyleSheet,
} from 'react-native'

import PropsShow from '../custom_component/PropsShow'

var WebViewDemo = React.createClass({
  getInitialState() {
    return({
      msgs: '',
    });
  },
  _show(msg) {
    this.setState({
      msgs: this.state.msgs + '\n' + msg,
    });
  },
  render() {
    return(
      <View style={styles.container}>
        <WebView style={styles.webView}
          automaticallyAdjustContentInsets={true}
          bounces={true}
          // source={{uri: 'https://github.com/', method: 'GET'}}
          source={{uri: 'https://www.baidu.com/', method: 'GET'}}
          onLoadStart={()=>this._show('加载开始')}
          onLoadEnd={()=>this._show('加载结束')}
          onLoad={()=>this._show('加载成功')}
          onError={()=>this._show('加载出错')}
          startInLoadingState={true}
          scalesPageToFit={true}
          renderLoading={()=>{
            return (
              <View style={{flex: 1, alignItems: 'center', justifyContent: 'center'}}>
                <View style={{width: 100, height: 100, backgroundColor: 'green'}}></View>
              </View>
            );
          }}
          renderError={(event)=> {
            return (
              <View style={{flex: 1, alignItems: 'center', justifyContent: 'center'}}>
                <Text style={{width: 100, height: 100, backgroundColor: 'red'}}>{event}</Text>
              </View>
            );
          }}
          injectedJavaScript="alert('Zcp大官人')"/>
        <ScrollView style={styles.introduce}>
          <Text style={styles.msg}>{this.state.msgs}</Text>
          <PropsShow texts={[
            {item: 'onLoadStart 加载开始',},
            {item: 'onLoadEnd 加载结束',},
            {item: 'onLoad 加载成功',},
            {item: 'onError 加载出错',},
            {item: 'onMessage',},
            {item: 'startInLoadingState'},
            {item: 'renderLoading 渲染页面时触发'},
            {item: 'renderError 渲染错误视图',},
            {item: 'source {uri: string, method: string, headers: object, body: string}, {html: string, baseUrl: string}',},      //
            {item: 'scalesPageToFit',},
          ]}/>
        </ScrollView>
      </View>
    );
  },
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'column',
    marginBottom: 64,
  },
  webView: {
    flex: 1,
    height: 400,
    backgroundColor: 'red',
  },
  msg: {
    marginLeft: 15,
  },
  introduce: {
    flex: 1,
  },
});

module.exports = WebViewDemo;
