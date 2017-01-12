'use strict'

import React, {Component, PropsType} from 'react'
import {
  View,
  Text,
  ScrollView,
  TouchableOpacity,
  Image,
  StyleSheet,
  AsyncStorage,
} from 'react-native'

var Model = [
  {
    id: '1',
    title: '猕猴桃',
    desc: '12个装',
    price: 99,
    url: 'http://vczero.github.io/ctrip/guo_1.jpg'
  },
  {
    id: '2',
    title: '牛油果',
    desc: '6个装',
    price: 92,
    url: 'http://vczero.github.io/ctrip/guo_2.jpg'
  },
  {
    id: '3',
    title: '车厘子',
    desc: '1000g',
    price: 91.5,
    url: 'http://vczero.github.io/ctrip/guo_3.jpg'
  },
  {
    id: '4',
    title: '西梅',
    desc: '14个装',
    price: 69,
    url: 'http://vczero.github.io/ctrip/guo_4.jpg'
  },
  {
    id: '5',
    title: '冬枣',
    desc: '2000g',
    price: 59.9,
    url: 'http://vczero.github.io/ctrip/guo_5.jpg'
  },
  {
    id: '6',
    title: '红心西柚',
    desc: '2500g',
    price: 29.9,
    url: 'http://vczero.github.io/ctrip/guo_6.jpg'
  },
];

var Item = React.createClass({
  // props: press、url、title
  render() {
    return(
      <View style={itemStyles.container}>
        <TouchableOpacity style={{flex: 1}}
           onPress={this.props.press}>
          <Image style={itemStyles.image}
            source={{uri: this.props.url}}
            resizeMode={'contain'}>
            <Text style={itemStyles.text}
              numberOfLine={1}>{this.props.title}</Text>
          </Image>
        </TouchableOpacity>
      </View>
    );
  },
});

var List = React.createClass({
  getInitialState() {
    return {
      count: 0,
    };
  },
  componentDidMount() {
    AsyncStorage.getAllKeys((err, keys)=>{
      if (err) {
        // 存储数据出错
      }
      this.setState({
        count: keys.length,
      });
    });
  },
  _goGouWu() {
    this.props.navigator.push({
      component: GouWu,
      title: '购物车',
    });
  },
  _press() {
    var count = this.state.count;
    count ++;
    // 改变数字状态
    this.setState({
      count: count,
    });
    // AsyncStorage存储
    AsyncStorage.setItem('SP-' + this._genId() + '-SP', JSON.stringify(data), function(err){
      if(err) {
        // 存储出错
      }
    });
  },
  _genId() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
      var r = Math.random() * 16 | 0,
      v = c == 'x' ? r : (r & 0x3 | 0x8);
      return v.toString(16);
    }).toUpperCase();
  },
  render() {
    var list = [];
    for (var i in Model) {
      if (i % 2 == 0) {
        var row = (
          <View style={listStyles.row} key={i}>
            <Item url={Model[i].url}
              title={Model[i].title}
              press={()=>this._press(Model[i])}/>
            <Item url={Model[i].url}
              title={Model[i].title}
              press={()=>this._press(Model[parseInt(i) + 1])}/>
          </View>
        );
        list.push(row);
      }
    }

    var count = this.state.count;
    var str = null;
    if (count) {
      str = '，共' + count + '件商品';
    }
    return (
      <ScrollView style={{marginTop: 10}}>
        {list}
        <Text style={listStyles.btn}
          onPress={this._goGouWu}>去结算{str}</Text>
      </ScrollView>
    );
  },
});

var GouWu = React.createClass({
  getInitialState() {
    return({
      data: [],
      price: 0,
    });
  },
  render() {
    var data = this.state.data;
    var price = this.state.price;
    var list = [];
    for (var i in data) {
    }
  },
});

var AsyncStorageDemo = React.createClass({
  render() {
    return(
      <List />
    );
  },
});

var listStyles = StyleSheet.create({
  row: {
    flexDirection: 'row',
    marginBottom: 10,
  },
  btn: {
    backgroundColor: '#ff7200',
    height: 33,
    textAlign: 'center',
    color: '#fff',
    marginLeft: 10,
    marginRight: 10,
    lineHeight: 24,
    marginTop: 40,
    fontSize: 18,
  },
});

var itemStyles = StyleSheet.create({
  container: {
    flex: 1,
    marginLeft: 5,
    marginRight: 5,
    borderWidth: 1,
    borderColor: '#ddd',
    height: 100,
  },
  image: {
    flex: 1,
    backgroundColor: 'transparent',
  },
  text: {
    backgroundColor: '#000',
    opacity: 0.7,
    color: '#fff',
    height: 25,
    lineHeight: 18,
    textAlign: 'center',
    marginTop: 74,
  },
});

module.exports = AsyncStorageDemo;
