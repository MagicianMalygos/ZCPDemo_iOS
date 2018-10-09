'use strict'

import React, {Component, PropTypes} from 'react'
import {StyleSheet, View, Text, TextInput, ScrollView, Dimensions, PixelRatio} from 'react-native'

import PropsShow from '../custom_component/PropsShow.js'

export default class TextInputDemo extends Component {
  render() {
    var texts = [
      {item: 'autoCapitalize: \nenum(\'none\'、 \'sentences\'、 \'words\'、 \'characters\') 控制TextInput是否要自动将特定字符切换为大写'},
      {item: 'placeholder: string 占位符，在输入前显示的文本内容'},
      {item: 'value: string 文本输入框的默认值'},
      {item: 'placeholderTextColor: string 占位符文本颜色'},
      {item: 'password: bool 如果为true，则是密码输入框，文本显示为\'*\''},
      {item: 'multiline: bool 如果为true，则是多行输入'},
      {item: 'editable: bool 如果为false，文本框不可输入。其默认值是true'},
      {item: 'autoFocus: bool 如果为true，将自动聚焦'},
      {item: 'clearButtonMode: enum 可选值有\'never\'、 \'while-editing\'、 \'unless-editing\'、 \'always\'。用于显示清除按钮'},
      {item: 'maxLength: int 能够输入的最长字符数'},
      {item: 'enablesReturnKeyAutomatically: bool 如果值为true，表示没有文本时键盘是不能有返回键的。其默认值为false'},
      {item: 'returnKeyType: enum 可选值有\'default\'、 \'go\'、 \'google\'、 \'join\'、 \'next\'、 \'route\'、 \'search\'、 \'send\'、 \'yahoo\'、 \'done\'、 \'emergency-call\'。表示软键盘返回键显示的字符串'},
      {item: 'secureTextEntry: bool 如果为true，则像密码框一样隐藏输入内容。默认为false'},
      {item: 'onChangeText: function 当文本输入框的内容发生变化时，调用改函数。onChangeText接受一个文本的参数对象'},
      {item: 'onChange: function 当文本变化时，调用该函数'},
      {item: 'onEndEditing: function 当文本发生变化时，调用该函数'},
      {item: 'onBlur: function 失去焦点触发事件'},
      {item: 'onFocus: function 获得焦点触发事件'},
      {item: 'onSubmitEditing: function 当结束编辑后，点击键盘的提交按钮触发该事件'},
    ];
    return(
      <ScrollView style={styles.container}>
        <View style={{flex: 1}}>
          <SearchView style={styles.searchView}/>
          <TextInput style={styles.textInput}
          autoCapitalize='none'
          placeholder={'请输入内容'}
          secureTextEntry={true}
          autoFocus={false}/>
          <PropsShow texts={texts}/>
        </View>
      </ScrollView>
    );
  }
}

var SearchView = React.createClass({
  // 初始化state
  getInitialState: function() {
    return {
      show: false,
      value: '',
    };
  },

  // method
  _getValue: function(text) {
    var value = text;
    this.setState({
      show: true,
      value: value,
    });
  },
  _hide: function(value) {
    this.setState({
      show: false,
      value: value,
    });
  },

  // 渲染
  render() {
    return(
      <View style={{flex: 1, flexDirection: 'column'}}>
        <View style={styles.searchView}>
          <View style={styles.searchInputView}>
            <TextInput style={styles.searchInput}
              autoFocus={true}
              returnKeyType="search"
              placeholder="请输入关键字"
              multiline={true}
              value={this.state.value}
              onFocus={()=>{
                this.setState({
                  show: true,
                  value: this.state.value,
                });
              }}
              onEndEditing={()=>this._hide(this.state.value)}
              onChangeText={(text)=> this._getValue(text)}/>
          </View>
          <View style={styles.searchButtonView}>
            <Text style={styles.searchButton}
              onPress={()=>this._hide(this.state.value)}>
              搜索
            </Text>
          </View>
        </View>
        {this.state.show?
          <View style={styles.resultView}>
            <Text style={styles.resultItem}
              onPress={()=>this._hide(this.state.value + '庄')}
              numberOfLines={1}>{this.state.value}庄</Text>
            <Text style={styles.resultItem}
              onPress={()=>this._hide(this.state.value + '园街')}
              numberOfLines={1}>{this.state.value}园街</Text>
            <Text style={styles.resultItem}
              onPress={()=>this._hide(this, '80' + this.state.value + '综合商店')}
              numberOfLines={1}>80{this.state.value}综合商店</Text>
            <Text style={styles.resultItem}
              onPress={()=>this._hide(this, this.state.value + '桃')}
              numberOfLines={1}>{this.state.value}桃</Text>
            <Text style={styles.resultItem}
              onPress={()=>this._hide(this, '杨林' + this.state.value) + '园'}
              numberOfLines={1}>杨林{this.state.value}园</Text>
          </View>
          : null
        }
      </View>
    );
  }
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
    marginBottom: 64,
  },
  textInput: {
    height: 100,
    marginLeft: 15,
    marginRight: 15,
    borderWidth: 1 / PixelRatio.get(),
  },
  searchView: {
    height: 45,
    flex: 1,
    flexDirection: 'row',
  },
  searchInputView: {
    width: Dimensions.get('window').width - 90,
    height: 45,
    marginLeft: 15,
  },
  searchInput: {
    flex: 1,
    borderWidth: 1,
    paddingLeft: 5,
    borderColor: '#ccc',
    borderRadius: 4,
  },
  searchButtonView: {
    width: 55,
    height: 45,
    marginLeft: 5,
    backgroundColor: '#23beff',
    justifyContent: 'center',
    alignItems: 'center',
  },
  searchButton: {
    color: '#fff',
    fontSize: 15,
    fontWeight: 'bold',
  },
  resultView: {
    marginTop: 1 / PixelRatio.get(),
    marginLeft: 15,
    marginBottom: 10,
    marginRight: 15,
    borderColor: '#000',
    borderWidth: 1 / PixelRatio.get(),
  },
  resultItem: {
    fontSize: 16,
    marginTop: 5,
    marginBottom: 5,
    paddingTop: 5,
    paddingBottom: 5,
    borderColor: 'red',
    borderWidth: 1 / PixelRatio.get(),
  },
});
