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

// 商品列表项
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

// 商品列表
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
  _press(data) {
    var count = this.state.count;
    count ++;
    // 改变数字状态
    this.setState({
      count: count,
    });
    // AsyncStorage存储
    // key，value，回调方法
    AsyncStorage.setItem('SP-' + this._genId() + '-SP', JSON.stringify(data), function(err){
      if(err) {
        // 存储出错
      }
    });
  },
  // 生成唯一ID
  _genId() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
      var r = Math.random() * 16 | 0,
      v = c == 'x' ? r : (r & 0x3 | 0x8);
      return v.toString(16);
    }).toUpperCase();
  },
  render() {
    var list = [];
    for (var i = 0; i < Model.length; i++) {
      if (i % 2 == 0) {
        // Q:此处如果说用var的话会出现异常情况，
        // A:问题是由于var定义的变量生命周期长导致的
        // var为全局变量 let为局部变量 const为常量
        let data1 = Model[i];
        let data2 = Model[parseInt(i) + 1];
        var row = (
          <View style={listStyles.row} key={i}>
            <Item url={data1.url}
              title={data1.title}
              press={()=>this._press(data1)}/>
            <Item url={data2.url}
              title={data2.title}
              press={()=>this._press(data2)}/>
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
      <ScrollView style={{marginTop: 10, marginBottom: 64,}}>
        {list}
        <View style={listStyles.btn_container}>
          <Text style={listStyles.btn}
            onPress={this._goGouWu}>去结算{str}</Text>
        </View>
      </ScrollView>
    );
  },
});

// 结算页
var GouWu = React.createClass({
  getInitialState() {
    return({
      data: [],
      price: 0,
    });
  },
  componentDidMount() {
    AsyncStorage.getAllKeys((err, keys)=>{
      if(err) {
        // 存储数据出错
      }
      AsyncStorage.multiGet(keys, (err, result)=>{
        if (err) {
          // 错误处理
        }
        // result是二位数组，result[i][0]为key，result[i][1]为value
        var arr = [];
        for (var i in result) {
          arr.push(JSON.parse(result[i][1]));
        }
        this.setState({
          data: arr,
        });
      });
    });
  },
  _clearGoShop() {
    AsyncStorage.clear((err)=>{
      if (!err) {
        this.setState({
          data:[],
          price: 0,
        });
        alert('购物车已经清空');
      }
    });
  },
  render() {
    var data = this.state.data;
    var price = this.state.price;
    var list = [];
    for (var i in data) {
      price += parseFloat(data[i].price);
      list.push(
        <View style={[gouwuStyles.row, gouwuStyles.list_item]} key={i}>
          <Text style={gouwuStyles.list_item_desc}>{data[i].title}{data[i].desc}</Text>
          <Text style={gouwuStyles.list_item_price}>￥{data[i].price}</Text>
        </View>
      );
    }
    var str = null;
    if (price) {
      str = '，共' + price.toFixed(1) + '元';
    }
    return(
      <ScrollView style={gouwuStyles.container}>
        {list}
        <Text style={gouwuStyles.pay}>支付</Text>
        <Text style={gouwuStyles.clear}
          onPress={this._clearGoShop}>清空购物车</Text>
      </ScrollView>
    );
  },
});

// Demo
var AsyncStorageDemo = React.createClass({
  render() {
    return(
      <List navigator={this.props.navigator}/>
    );
  },
});

var listStyles = StyleSheet.create({
  row: {
    flexDirection: 'row',
    marginBottom: 10,
  },
  btn_container: {
    height: 50,
    backgroundColor: '#ff7200',
    justifyContent: 'center',
    marginLeft: 10,
    marginRight: 10,
    marginTop: 40,
  },
  btn: {
    backgroundColor: '#ff7200',
    textAlign: 'center',
    textAlignVertical: 'center',
    color: '#fff',
    lineHeight: 24,
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

var gouwuStyles = StyleSheet.create({
  container: {
    flex: 1,
    marginTop: 10,
  },
  row: {
    flexDirection: 'row',
    marginBottom: 10,
  },
  list_item: {
    height: 30,
    marginLeft: 5,
    marginRight: 5,
    padding: 5,
    borderWidth: 1,
    borderRadius: 3,
    borderColor: '#ddd',
  },
  list_item_desc: {
    flex: 2,
    fontSize: 15,
  },
  list_item_price: {
    flex: 1,
    textAlign: 'right',
    fontSize: 15,
  },
  pay: {
    flex: 1,
    height: 35,
    marginTop: 10,
    marginBottom: 10,
    paddingTop: 10,
    paddingBottom: 10,
    backgroundColor: '#ff8447',
    textAlign: 'center',
    fontSize: 14,
    color: '#fff',
  },
  clear: {
    flex: 1,
    height: 35,
    marginTop: 10,
    marginBottom: 10,
    paddingTop: 10,
    paddingBottom: 10,
    backgroundColor: '#ff8447',
    textAlign: 'center',
    fontSize: 14,
    color: '#fff',
  },
});

module.exports = AsyncStorageDemo;
